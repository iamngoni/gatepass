// Gatepass — stored_backup_key_dto.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stored_backup_key_dto.freezed.dart';
part 'stored_backup_key_dto.g.dart';

/// The derived backup key as secure storage keeps it, so the phrase is only
/// needed once per phone.
@freezed
abstract class StoredBackupKeyDTO with _$StoredBackupKeyDTO {
  const factory StoredBackupKeyDTO({
    /// Base64.
    required String key,

    /// Base64.
    required String salt,
    required int m,
    required int t,
  }) = _StoredBackupKeyDTO;

  factory StoredBackupKeyDTO.fromJson(Map<String, dynamic> json) =>
      _$StoredBackupKeyDTOFromJson(json);
}
