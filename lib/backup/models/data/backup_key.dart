// Gatepass — backup_key.dart. Created 2026-10-19.
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'kdf_params.dart';

part 'backup_key.freezed.dart';

/// The key derived from a recovery phrase, with the salt and cost that
/// derived it.
@freezed
abstract class BackupKey with _$BackupKey {
  const factory BackupKey({
    required Uint8List bytes,
    required Uint8List salt,
    required KdfParams params,
  }) = _BackupKey;
}
