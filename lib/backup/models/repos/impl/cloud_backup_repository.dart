//
//  Gatepass
//  cloud_backup_repository.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../auth/models/data/cloud_identity.dart';
import '../../../../auth/models/repos/abs/auth_repository.dart';
import '../../../../core/models/data/application_error.dart';
import '../../../../core/services/backup_cipher_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/utils/invite_merge.dart';
import '../../../../invites/models/data/invite.dart';
import '../../data/backup_key.dart';
import '../../data/kdf_params.dart';
import '../../dto/backup_payload_dto.dart';
import '../../dto/stored_backup_key_dto.dart';
import '../abs/backup_repository.dart';
import '../abs/backup_store_repository.dart';

/// Seals the archive on the phone and keeps it in the backup store. The
/// derived key is kept in secure storage per account, so the phrase is only
/// needed once per phone.
@LazySingleton(as: BackupRepository)
class CloudBackupRepository implements BackupRepository {
  CloudBackupRepository(
    this.auth,
    this.store,
    this.cipher,
    this.storage,
    this.kdf,
  );

  final AuthRepository auth;
  final BackupStoreRepository store;
  final BackupCipherService cipher;
  final SecureStorageService storage;
  final KdfParams kdf;

  @visibleForTesting
  static String keyNameFor(String uid) {
    final digest = sha256.convert(utf8.encode(uid)).toString();
    return 'backup.key.${digest.substring(0, 32)}';
  }

  @override
  Future<Either<ApplicationError, bool>> isOn() => _guard(() async {
    final who = await _identity();
    return await _storedKey(who.uid) != null;
  });

  @override
  Future<Either<ApplicationError, bool>> hasRemote() => _guard(() async {
    final who = await _identity();
    return await _value(store.fetch(who.idToken)) != null;
  });

  @override
  Future<Either<ApplicationError, List<Invite>>> turnOn(
    List<String> phrase,
    List<Invite> local,
  ) => _guard(() => _turnOn(phrase, local));

  @override
  Future<Either<ApplicationError, List<Invite>>> restore(
    List<String> phrase,
    List<Invite> local,
  ) => _guard(() async {
    final who = await _identity();
    final remote = await _value(store.fetch(who.idToken));
    if (remote == null) return _turnOn(phrase, local);
    final (salt, params) = cipher.kdfOf(remote.blob);
    final key = await cipher.deriveKey(phrase, salt: salt, params: params);
    final saved = await _open(key, who.uid, remote.blob);
    await _storeKey(who.uid, key);
    final merged = unionInvites(local, saved);
    await _put(who, key, remote.version, merged);
    return merged;
  });

  @override
  Future<Either<ApplicationError, List<Invite>?>> sync(List<Invite> local) =>
      _guard(() async {
        final who = await _identity();
        final key = await _storedKey(who.uid);
        if (key == null) return null;
        for (var attempt = 0; ; attempt++) {
          final remote = await _value(store.fetch(who.idToken));
          final merged = remote == null
              ? local
              : unionInvites(local, await _open(key, who.uid, remote.blob));
          try {
            await _put(who, key, remote?.version ?? 0, merged);
            return merged;
          } on ApplicationError catch (e) {
            if (e.code != ApplicationErrorCode.backupConflict || attempt >= 2) {
              rethrow;
            }
          }
        }
      });

  @override
  Future<Either<ApplicationError, Unit>> turnOff() => _guard(() async {
    final who = await _identity();
    await _value(store.delete(who.idToken));
    await storage.delete(keyNameFor(who.uid));
    return unit;
  });

  Future<List<Invite>> _turnOn(List<String> phrase, List<Invite> local) async {
    final key = await cipher.deriveKey(phrase, params: kdf);
    final who = await _identity();
    final remote = await _value(store.fetch(who.idToken));
    await _put(who, key, remote?.version ?? 0, local);
    await _storeKey(who.uid, key);
    return local;
  }

  Future<void> _put(
    CloudIdentity who,
    BackupKey key,
    int version,
    List<Invite> invites,
  ) async {
    final plain = jsonEncode(BackupPayloadDTO(invites: invites).toJson());
    final sealed = await cipher.seal(key, who.uid, plain);
    await _value(store.put(who.idToken, version, sealed));
  }

  Future<List<Invite>> _open(BackupKey key, String uid, String blob) async {
    final plain = await cipher.open(key, uid, blob);
    try {
      final json = (jsonDecode(plain) as Map).cast<String, dynamic>();
      return BackupPayloadDTO.fromJson(json).invites;
    } on Object {
      throw const ApplicationError(code: ApplicationErrorCode.backupDecrypt);
    }
  }

  Future<BackupKey?> _storedKey(String uid) async {
    final String? raw;
    try {
      raw = await storage.read(keyNameFor(uid));
    } on Object catch (e) {
      debugPrint('[Gatepass] backup key unreadable: $e');
      throw const ApplicationError(code: ApplicationErrorCode.storage);
    }
    if (raw == null) return null;
    final dto = StoredBackupKeyDTO.fromJson(
      (jsonDecode(raw) as Map).cast<String, dynamic>(),
    );
    return BackupKey(
      bytes: base64.decode(dto.key),
      salt: base64.decode(dto.salt),
      params: KdfParams(memoryKib: dto.m, iterations: dto.t),
    );
  }

  Future<void> _storeKey(String uid, BackupKey key) async {
    final dto = StoredBackupKeyDTO(
      key: base64.encode(key.bytes),
      salt: base64.encode(key.salt),
      m: key.params.memoryKib,
      t: key.params.iterations,
    );
    try {
      await storage.write(keyNameFor(uid), jsonEncode(dto.toJson()));
    } on Object catch (e) {
      debugPrint('[Gatepass] backup key not saved: $e');
      throw const ApplicationError(code: ApplicationErrorCode.storage);
    }
  }

  Future<CloudIdentity> _identity() => _value(auth.cloudIdentity());

  /// Unwraps a repository result, throwing its error for [_guard] to
  /// return.
  static Future<T> _value<T>(
    Future<Either<ApplicationError, T>> result,
  ) async => (await result).fold((error) => throw error, (value) => value);

  static Future<Either<ApplicationError, T>> _guard<T>(
    Future<T> Function() body,
  ) async {
    try {
      return Right(await body());
    } on ApplicationError catch (e) {
      return Left(e);
    } on Object catch (e, s) {
      debugPrint('[Gatepass] cloud backup failed: $e\n$s');
      return const Left(ApplicationError(code: ApplicationErrorCode.unknown));
    }
  }
}
