// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PutBackupDTO _$PutBackupDTOFromJson(Map<String, dynamic> json) =>
    _PutBackupDTO(
      expectedVersion: (json['expectedVersion'] as num).toInt(),
      blob: json['blob'] as String,
    );

Map<String, dynamic> _$PutBackupDTOToJson(_PutBackupDTO instance) =>
    <String, dynamic>{
      'expectedVersion': instance.expectedVersion,
      'blob': instance.blob,
    };
