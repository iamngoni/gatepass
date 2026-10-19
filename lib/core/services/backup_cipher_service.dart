// Gatepass — backup_cipher_service.dart. Created 2026-10-19.
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:injectable/injectable.dart';

import '../../backup/models/data/backup_key.dart';
import '../../backup/models/data/kdf_params.dart';
import '../../backup/models/dto/sealed_backup_dto.dart';
import '../models/data/application_error.dart';

/// End-to-end encryption for the cloud backup. The key comes from the
/// recovery phrase through Argon2id, and each upload is sealed with
/// AES-256-GCM, bound to the account so one account's blob can't be
/// replayed as another's. The server only ever stores the sealed envelope.
@lazySingleton
class BackupCipherService {
  BackupCipherService();

  static final _aes = AesGcm.with256bits();

  /// Slow on purpose, so it runs off the UI isolate.
  Future<BackupKey> deriveKey(
    List<String> phrase, {
    Uint8List? salt,
    KdfParams params = const KdfParams(),
  }) async {
    final useSalt =
        salt ?? Uint8List.fromList(SecretKeyData.random(length: 16).bytes);
    final memory = params.memoryKib;
    final iterations = params.iterations;
    final bytes = await Isolate.run(() async {
      final argon = Argon2id(
        parallelism: 1,
        memory: memory,
        iterations: iterations,
        hashLength: 32,
      );
      final key = await argon.deriveKey(
        secretKey: SecretKey(utf8.encode(phrase.join(' '))),
        nonce: useSalt,
      );
      return Uint8List.fromList(await key.extractBytes());
    });
    return BackupKey(bytes: bytes, salt: useSalt, params: params);
  }

  Future<String> seal(BackupKey key, String accountId, String plain) async {
    final box = await _aes.encrypt(
      utf8.encode(plain),
      secretKey: SecretKey(key.bytes),
      aad: _aad(accountId),
    );
    return jsonEncode(
      SealedBackupDTO(
        v: 1,
        kdf: BackupKdfDTO(
          m: key.params.memoryKib,
          t: key.params.iterations,
          salt: base64.encode(key.salt),
        ),
        nonce: base64.encode(box.nonce),
        ct: base64.encode([...box.cipherText, ...box.mac.bytes]),
      ).toJson(),
    );
  }

  /// The salt and cost a blob was sealed with, to derive its key on
  /// restore.
  (Uint8List, KdfParams) kdfOf(String sealed) {
    try {
      final kdf = _envelope(sealed).kdf;
      return (
        base64.decode(kdf.salt),
        KdfParams(memoryKib: kdf.m, iterations: kdf.t),
      );
    } on Object {
      throw const ApplicationError(code: ApplicationErrorCode.backupDecrypt);
    }
  }

  /// Throws [ApplicationError] with [ApplicationErrorCode.backupDecrypt]
  /// for the wrong phrase or a blob that was tampered with.
  Future<String> open(BackupKey key, String accountId, String sealed) async {
    try {
      final envelope = _envelope(sealed);
      if (envelope.v != 1) throw const FormatException('Unknown version');
      final ct = base64.decode(envelope.ct);
      final box = SecretBox(
        ct.sublist(0, ct.length - 16),
        nonce: base64.decode(envelope.nonce),
        mac: Mac(ct.sublist(ct.length - 16)),
      );
      final plain = await _aes.decrypt(
        box,
        secretKey: SecretKey(key.bytes),
        aad: _aad(accountId),
      );
      return utf8.decode(plain);
    } on Object {
      throw const ApplicationError(code: ApplicationErrorCode.backupDecrypt);
    }
  }

  static SealedBackupDTO _envelope(String sealed) => SealedBackupDTO.fromJson(
    (jsonDecode(sealed) as Map).cast<String, dynamic>(),
  );

  static List<int> _aad(String accountId) =>
      utf8.encode('gatepass-backup-v1:$accountId');
}
