// Every invite the app has seen, kept on the device per ATG account. ATG
// deletes a visitor profile on revoke and lists only the latest 50, so without
// this a revoked or older visitor's details are gone for good.
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'models.dart';

abstract interface class InviteArchive {
  Future<List<Invite>> load(String accountId);
  Future<void> save(String accountId, List<Invite> invites);
}

/// Stored in the Keychain (iOS) or Keystore-backed storage (Android), so the
/// records are encrypted at rest and never leave the device.
class SecureInviteArchive implements InviteArchive {
  SecureInviteArchive([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  /// Oldest invites are dropped past this, to keep one entry a sensible size.
  static const limit = 1000;

  // The account id is hashed so the key names don't expose it.
  static String _key(String accountId) =>
      'invites.${sha256.convert(utf8.encode(accountId)).toString().substring(0, 32)}';

  @override
  Future<List<Invite>> load(String accountId) async {
    try {
      final raw = await _storage.read(key: _key(accountId));
      if (raw == null) return const [];
      return [
        for (final item in jsonDecode(raw) as List)
          Invite.fromJson((item as Map).cast<String, Object?>()),
      ];
    } on Object catch (e) {
      debugPrint('[Gatepass] invite archive unreadable: $e');
      return const [];
    }
  }

  @override
  Future<void> save(String accountId, List<Invite> invites) async {
    final kept = [...invites]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    try {
      await _storage.write(
        key: _key(accountId),
        value: jsonEncode([for (final i in kept.take(limit)) i.toJson()]),
      );
    } on Object catch (e) {
      debugPrint('[Gatepass] invite archive not saved: $e');
    }
  }
}

/// For tests and previews: remembers nothing between runs.
class MemoryInviteArchive implements InviteArchive {
  final _byAccount = <String, List<Invite>>{};

  @override
  Future<List<Invite>> load(String accountId) async =>
      _byAccount[accountId] ?? const [];

  @override
  Future<void> save(String accountId, List<Invite> invites) async =>
      _byAccount[accountId] = [...invites];
}

/// ATG's current list wins for anything it still has, keeping details only
/// the app knew (service, phone, car). Anything ATG no longer lists stays,
/// and if ATG returned less than a full page, a missing invite that still
/// looked live was deleted there, so it shows as revoked.
List<Invite> mergeInvites(
  List<Invite> archived,
  List<Invite> fetched, {
  required bool fetchedIsComplete,
}) {
  final byId = {for (final i in archived) i.id: i};
  final merged = <String, Invite>{};
  for (final fresh in fetched) {
    final old = byId[fresh.id];
    merged[fresh.id] = old == null
        ? fresh
        : Invite(
            id: fresh.id,
            siteId: fresh.siteId,
            visitorName: fresh.visitorName,
            serviceId: fresh.serviceId ?? old.serviceId,
            phone: fresh.phone ?? old.phone,
            vehicleReg: fresh.vehicleReg ?? old.vehicleReg,
            from: fresh.from,
            until: fresh.until,
            status: old.status == InviteStatus.revoked
                ? InviteStatus.revoked
                : fresh.status,
            code: fresh.code.isEmpty ? old.code : fresh.code,
            link: fresh.link.isEmpty ? old.link : fresh.link,
            createdAt: fresh.createdAt,
            openEnded: fresh.openEnded,
            windowText: fresh.windowText ?? old.windowText,
          );
  }
  final now = DateTime.now();
  for (final old in archived) {
    if (merged.containsKey(old.id)) continue;
    var status = old.status;
    if (status == InviteStatus.active) {
      if (fetchedIsComplete) {
        status = InviteStatus.revoked;
      } else if (!old.openEnded && old.until.isBefore(now)) {
        status = InviteStatus.expired;
      }
    }
    merged[old.id] = old.copyWith(status: status);
  }
  return merged.values.toList();
}
