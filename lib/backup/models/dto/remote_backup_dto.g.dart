// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemoteBackupDTO _$RemoteBackupDTOFromJson(Map<String, dynamic> json) =>
    _RemoteBackupDTO(
      version: (json['version'] as num).toInt(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      blob: json['blob'] as String,
    );

Map<String, dynamic> _$RemoteBackupDTOToJson(_RemoteBackupDTO instance) =>
    <String, dynamic>{
      'version': instance.version,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'blob': instance.blob,
    };
