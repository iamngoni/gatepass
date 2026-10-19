// Gatepass — backup_payload_dto.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../invites/models/data/invite.dart';

part 'backup_payload_dto.freezed.dart';
part 'backup_payload_dto.g.dart';

/// What a backup seals: the resident's invite archive.
@freezed
abstract class BackupPayloadDTO with _$BackupPayloadDTO {
  @JsonSerializable(explicitToJson: true)
  const factory BackupPayloadDTO({required List<Invite> invites}) =
      _BackupPayloadDTO;

  factory BackupPayloadDTO.fromJson(Map<String, dynamic> json) =>
      _$BackupPayloadDTOFromJson(json);
}
