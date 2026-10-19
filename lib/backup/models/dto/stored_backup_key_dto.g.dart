// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_backup_key_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoredBackupKeyDTO _$StoredBackupKeyDTOFromJson(Map<String, dynamic> json) =>
    _StoredBackupKeyDTO(
      key: json['key'] as String,
      salt: json['salt'] as String,
      m: (json['m'] as num).toInt(),
      t: (json['t'] as num).toInt(),
    );

Map<String, dynamic> _$StoredBackupKeyDTOToJson(_StoredBackupKeyDTO instance) =>
    <String, dynamic>{
      'key': instance.key,
      'salt': instance.salt,
      'm': instance.m,
      't': instance.t,
    };
