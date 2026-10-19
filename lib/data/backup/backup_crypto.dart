// End-to-end encryption for the cloud backup. The key comes from the
// recovery phrase through Argon2id, and each upload is sealed with
// AES-256-GCM, bound to the account so one account's blob can't be replayed
// as another's. The server only ever stores the sealed envelope.
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

class KdfParams {
  const KdfParams({this.memoryKib = 19456, this.iterations = 2});

  /// OWASP's Argon2id baseline: 19 MiB, 2 passes, 1 lane.
  final int memoryKib;
  final int iterations;
}

class BackupKey {
  const BackupKey(this.bytes, this.salt, this.params);

  final Uint8List bytes;
  final Uint8List salt;
  final KdfParams params;

  Map<String, Object> toJson() => {
    'key': base64.encode(bytes),
    'salt': base64.encode(salt),
    'm': params.memoryKib,
    't': params.iterations,
  };

  static BackupKey fromJson(Map<String, Object?> j) => BackupKey(
    base64.decode(j['key']! as String),
    base64.decode(j['salt']! as String),
    KdfParams(memoryKib: j['m']! as int, iterations: j['t']! as int),
  );
}

/// Wrong phrase, or a blob that was tampered with.
class BackupDecryptException implements Exception {
  const BackupDecryptException();
}

final _aes = AesGcm.with256bits();

/// Slow on purpose, so it runs off the UI isolate.
Future<BackupKey> deriveBackupKey(
  List<String> phrase, {
  Uint8List? salt,
  KdfParams params = const KdfParams(),
}) async {
  final useSalt =
      salt ?? Uint8List.fromList(SecretKeyData.random(length: 16).bytes);
  final bytes = await Isolate.run(() async {
    final argon = Argon2id(
      parallelism: 1,
      memory: params.memoryKib,
      iterations: params.iterations,
      hashLength: 32,
    );
    final key = await argon.deriveKey(
      secretKey: SecretKey(utf8.encode(phrase.join(' '))),
      nonce: useSalt,
    );
    return Uint8List.fromList(await key.extractBytes());
  });
  return BackupKey(bytes, useSalt, params);
}

Future<String> sealBackup(BackupKey key, String accountId, String plain) async {
  final box = await _aes.encrypt(
    utf8.encode(plain),
    secretKey: SecretKey(key.bytes),
    aad: _aad(accountId),
  );
  return jsonEncode({
    'v': 1,
    'kdf': {
      'alg': 'argon2id',
      'm': key.params.memoryKib,
      't': key.params.iterations,
      'p': 1,
      'salt': base64.encode(key.salt),
    },
    'nonce': base64.encode(box.nonce),
    'ct': base64.encode([...box.cipherText, ...box.mac.bytes]),
  });
}

/// The salt and cost a blob was sealed with, to derive its key on restore.
(Uint8List, KdfParams) backupKdf(String sealed) {
  final kdf = (jsonDecode(sealed) as Map)['kdf'] as Map;
  return (
    base64.decode(kdf['salt'] as String),
    KdfParams(memoryKib: kdf['m'] as int, iterations: kdf['t'] as int),
  );
}

Future<String> openBackup(
  BackupKey key,
  String accountId,
  String sealed,
) async {
  try {
    final env = jsonDecode(sealed) as Map;
    if (env['v'] != 1) throw const BackupDecryptException();
    final ct = base64.decode(env['ct'] as String);
    final box = SecretBox(
      ct.sublist(0, ct.length - 16),
      nonce: base64.decode(env['nonce'] as String),
      mac: Mac(ct.sublist(ct.length - 16)),
    );
    final plain = await _aes.decrypt(
      box,
      secretKey: SecretKey(key.bytes),
      aad: _aad(accountId),
    );
    return utf8.decode(plain);
  } on BackupDecryptException {
    rethrow;
  } on Object {
    throw const BackupDecryptException();
  }
}

List<int> _aad(String accountId) =>
    utf8.encode('gatepass-backup-v1:$accountId');
