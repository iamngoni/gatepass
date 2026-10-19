// Gatepass — sealed_backup_dto.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sealed_backup_dto.freezed.dart';
part 'sealed_backup_dto.g.dart';

/// The envelope the Worker stores: AES-256-GCM ciphertext and the Argon2id
/// salt and cost to rederive its key from the phrase. Other phones open
/// it, so the format must not change.
@freezed
abstract class SealedBackupDTO with _$SealedBackupDTO {
  const factory SealedBackupDTO({
    required int v,
    required BackupKdfDTO kdf,

    /// Base64.
    required String nonce,

    /// Base64 ciphertext with the 16-byte tag appended.
    required String ct,
  }) = _SealedBackupDTO;

  factory SealedBackupDTO.fromJson(Map<String, dynamic> json) =>
      _$SealedBackupDTOFromJson(json);
}

@freezed
abstract class BackupKdfDTO with _$BackupKdfDTO {
  const factory BackupKdfDTO({
    /// Memory, KiB.
    required int m,

    /// Iterations.
    required int t,

    /// Base64.
    required String salt,
    @Default('argon2id') String alg,

    /// Lanes.
    @Default(1) int p,
  }) = _BackupKdfDTO;

  factory BackupKdfDTO.fromJson(Map<String, dynamic> json) =>
      _$BackupKdfDTOFromJson(json);
}
