// Gatepass — remote_backup_dto.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_backup_dto.freezed.dart';
part 'remote_backup_dto.g.dart';

/// The Worker's `GET /v1/backup` body: the sealed blob and its version.
@freezed
abstract class RemoteBackupDTO with _$RemoteBackupDTO {
  const factory RemoteBackupDTO({
    required int version,

    /// ISO 8601.
    required DateTime updatedAt,
    required String blob,
  }) = _RemoteBackupDTO;

  factory RemoteBackupDTO.fromJson(Map<String, dynamic> json) =>
      _$RemoteBackupDTOFromJson(json);
}
