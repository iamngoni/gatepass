// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_payload_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupPayloadDTO _$BackupPayloadDTOFromJson(Map<String, dynamic> json) =>
    _BackupPayloadDTO(
      invites: (json['invites'] as List<dynamic>)
          .map((e) => Invite.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BackupPayloadDTOToJson(_BackupPayloadDTO instance) =>
    <String, dynamic>{
      'invites': instance.invites.map((e) => e.toJson()).toList(),
    };
