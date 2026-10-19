// Gatepass — secure_invite_archive_repository.dart. Created 2026-10-19.
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/data/application_error.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../data/invite.dart';
import '../abs/invite_archive_repository.dart';

/// Kept in secure storage, so the records are encrypted at rest and never
/// leave the device unless backup is on.
@LazySingleton(as: InviteArchiveRepository)
class SecureInviteArchiveRepository implements InviteArchiveRepository {
  SecureInviteArchiveRepository(this.storage);

  final SecureStorageService storage;

  /// Oldest invites are dropped past this, to keep one entry a sensible
  /// size.
  static const limit = 1000;

  /// The account id is hashed so the key names don't expose it.
  @visibleForTesting
  static String keyFor(String accountId) {
    final digest = sha256.convert(utf8.encode(accountId)).toString();
    return 'invites.${digest.substring(0, 32)}';
  }

  @override
  Future<Either<ApplicationError, List<Invite>>> load(String accountId) async {
    try {
      final raw = await storage.read(keyFor(accountId));
      if (raw == null) return const Right([]);
      final items = jsonDecode(raw) as List<Object?>;
      return Right([
        for (final item in items)
          Invite.fromJson((item! as Map).cast<String, dynamic>()),
      ]);
    } on Object catch (e) {
      debugPrint('[Gatepass] invite archive unreadable: $e');
      return const Left(ApplicationError(code: ApplicationErrorCode.storage));
    }
  }

  @override
  Future<Either<ApplicationError, Unit>> save(
    String accountId,
    List<Invite> invites,
  ) async {
    final kept = [...invites]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    try {
      await storage.write(
        keyFor(accountId),
        jsonEncode([for (final invite in kept.take(limit)) invite.toJson()]),
      );
      return const Right(unit);
    } on Object catch (e) {
      debugPrint('[Gatepass] invite archive not saved: $e');
      return const Left(ApplicationError(code: ApplicationErrorCode.storage));
    }
  }
}
