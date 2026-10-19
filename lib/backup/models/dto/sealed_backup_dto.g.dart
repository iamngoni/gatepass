// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sealed_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SealedBackupDTO _$SealedBackupDTOFromJson(Map<String, dynamic> json) =>
    _SealedBackupDTO(
      v: (json['v'] as num).toInt(),
      kdf: BackupKdfDTO.fromJson(json['kdf'] as Map<String, dynamic>),
      nonce: json['nonce'] as String,
      ct: json['ct'] as String,
    );

Map<String, dynamic> _$SealedBackupDTOToJson(_SealedBackupDTO instance) =>
    <String, dynamic>{
      'v': instance.v,
      'kdf': instance.kdf.toJson(),
      'nonce': instance.nonce,
      'ct': instance.ct,
    };

_BackupKdfDTO _$BackupKdfDTOFromJson(Map<String, dynamic> json) =>
    _BackupKdfDTO(
      m: (json['m'] as num).toInt(),
      t: (json['t'] as num).toInt(),
      salt: json['salt'] as String,
      alg: json['alg'] as String? ?? 'argon2id',
      p: (json['p'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$BackupKdfDTOToJson(_BackupKdfDTO instance) =>
    <String, dynamic>{
      'm': instance.m,
      't': instance.t,
      'salt': instance.salt,
      'alg': instance.alg,
      'p': instance.p,
    };
