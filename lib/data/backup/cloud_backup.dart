// The resident's invite archive, backed up to the Gatepass Worker on
// Cloudflare. Everything is sealed on the phone (see backup_crypto.dart); the
// Worker only checks the ATG sign-in token and stores the sealed blob.
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../gate_repository.dart';
import '../invite_archive.dart';
import '../models.dart';
import 'backup_crypto.dart';

typedef RemoteBackup = ({int version, String blob, DateTime updatedAt});

class BackupConflict implements Exception {
  const BackupConflict();
}

abstract interface class BackupStore {
  Future<RemoteBackup?> fetch(String idToken);

  /// Returns the new version. Throws [BackupConflict] when another device
  /// wrote since [expectedVersion].
  Future<int> put(String idToken, int expectedVersion, String blob);
  Future<void> delete(String idToken);
}

class WorkerBackupStore implements BackupStore {
  WorkerBackupStore([Uri? endpoint])
    : _endpoint =
          endpoint ??
          Uri.parse('https://gatepass-backup.imngonii.workers.dev/v1/backup');

  final Uri _endpoint;
  final _client = HttpClient()..connectionTimeout = const Duration(seconds: 15);

  Future<(int, String)> _send(
    String method,
    String idToken, [
    Object? body,
  ]) async {
    final req = await _client.openUrl(method, _endpoint);
    req.headers.set(HttpHeaders.authorizationHeader, 'Bearer $idToken');
    if (body != null) {
      req.headers.contentType = ContentType.json;
      req.write(jsonEncode(body));
    }
    final res = await req.close().timeout(const Duration(seconds: 30));
    return (res.statusCode, await res.transform(utf8.decoder).join());
  }

  @override
  Future<RemoteBackup?> fetch(String idToken) async {
    final (status, text) = await _send('GET', idToken);
    if (status == 404) return null;
    if (status != 200) throw HttpException('Backup unavailable ($status)');
    final j = jsonDecode(text) as Map;
    return (
      version: j['version'] as int,
      blob: j['blob'] as String,
      updatedAt: DateTime.parse(j['updatedAt'] as String),
    );
  }

  @override
  Future<int> put(String idToken, int expectedVersion, String blob) async {
    final (status, text) = await _send('PUT', idToken, {
      'expectedVersion': expectedVersion,
      'blob': blob,
    });
    if (status == 409) throw const BackupConflict();
    if (status != 200) throw HttpException('Backup not saved ($status)');
    return (jsonDecode(text) as Map)['version'] as int;
  }

  @override
  Future<void> delete(String idToken) async {
    final (status, _) = await _send('DELETE', idToken);
    if (status != 204) throw HttpException('Backup not deleted ($status)');
  }
}

class MemoryBackupStore implements BackupStore {
  final _byToken = <String, RemoteBackup>{};

  @override
  Future<RemoteBackup?> fetch(String idToken) async => _byToken[idToken];

  @override
  Future<int> put(String idToken, int expectedVersion, String blob) async {
    final version = _byToken[idToken]?.version ?? 0;
    if (version != expectedVersion) throw const BackupConflict();
    _byToken[idToken] = (
      version: version + 1,
      blob: blob,
      updatedAt: DateTime.now(),
    );
    return version + 1;
  }

  @override
  Future<void> delete(String idToken) async => _byToken.remove(idToken);
}

class CloudBackup {
  CloudBackup({
    required this.identity,
    BackupStore? store,
    FlutterSecureStorage? storage,
    this.kdf = const KdfParams(),
  }) : _store = store ?? WorkerBackupStore(),
       _storage = storage ?? const FlutterSecureStorage();

  /// The signed-in resident's Firebase uid and a fresh ID token.
  final Future<CloudIdentity> Function() identity;
  final KdfParams kdf;
  final BackupStore _store;
  final FlutterSecureStorage _storage;

  DateTime? lastBackup;

  static String _keyName(String uid) =>
      'backup.key.${sha256.convert(utf8.encode(uid)).toString().substring(0, 32)}';

  Future<BackupKey?> _key(String uid) async {
    final raw = await _storage.read(key: _keyName(uid));
    return raw == null
        ? null
        : BackupKey.fromJson((jsonDecode(raw) as Map).cast<String, Object?>());
  }

  Future<bool> isOn() async => await _key((await identity()).uid) != null;

  /// Whether this account already has a backup, from this or another phone.
  Future<bool> hasRemote() async =>
      await _store.fetch((await identity()).idToken) != null;

  /// Starts a backup under a new phrase, replacing any copy on the server.
  Future<List<Invite>> turnOn(List<String> phrase, List<Invite> local) async {
    final key = await deriveBackupKey(phrase, params: kdf);
    final who = await identity();
    final remote = await _store.fetch(who.idToken);
    await _put(who, key, remote?.version ?? 0, local);
    await _storage.write(key: _keyName(who.uid), value: jsonEncode(key));
    return local;
  }

  /// Unlocks this account's backup on this phone. Throws
  /// [BackupDecryptException] for the wrong phrase.
  Future<List<Invite>> restore(List<String> phrase, List<Invite> local) async {
    final who = await identity();
    final remote = await _store.fetch(who.idToken);
    if (remote == null) return turnOn(phrase, local);
    final (salt, params) = backupKdf(remote.blob);
    final key = await deriveBackupKey(phrase, salt: salt, params: params);
    final saved = await _open(key, who.uid, remote.blob);
    await _storage.write(key: _keyName(who.uid), value: jsonEncode(key));
    final merged = unionInvites(local, saved);
    await _put(who, key, remote.version, merged);
    return merged;
  }

  /// Pulls, merges and pushes. Returns the merged invites, or null when the
  /// backup is off.
  Future<List<Invite>?> sync(List<Invite> local) async {
    final who = await identity();
    final key = await _key(who.uid);
    if (key == null) return null;
    for (var attempt = 0; ; attempt++) {
      final remote = await _store.fetch(who.idToken);
      final merged = remote == null
          ? local
          : unionInvites(local, await _open(key, who.uid, remote.blob));
      try {
        await _put(who, key, remote?.version ?? 0, merged);
        return merged;
      } on BackupConflict {
        if (attempt >= 2) rethrow;
      }
    }
  }

  /// Deletes the server copy and forgets the key on this phone.
  Future<void> turnOff() async {
    final who = await identity();
    await _store.delete(who.idToken);
    await _storage.delete(key: _keyName(who.uid));
    lastBackup = null;
  }

  Future<void> _put(
    CloudIdentity who,
    BackupKey key,
    int version,
    List<Invite> invites,
  ) async {
    final plain = jsonEncode({
      'invites': [for (final i in invites) i.toJson()],
    });
    await _store.put(
      who.idToken,
      version,
      await sealBackup(key, who.uid, plain),
    );
    lastBackup = DateTime.now();
  }

  Future<List<Invite>> _open(BackupKey key, String uid, String blob) async {
    final j = jsonDecode(await openBackup(key, uid, blob)) as Map;
    return [
      for (final item in j['invites'] as List)
        Invite.fromJson((item as Map).cast<String, Object?>()),
    ];
  }
}

/// Logs and swallows a background backup failure; the local archive is
/// still intact and the next save retries.
void reportBackupError(Object e) =>
    debugPrint('[Gatepass] cloud backup failed: $e');
