// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atg_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AtgSession _$AtgSessionFromJson(Map<String, dynamic> json) => _AtgSession(
  idToken: json['idToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresAt: const EpochMillisConverter().fromJson(
    (json['expiresAt'] as num).toInt(),
  ),
  uid: json['uid'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$AtgSessionToJson(_AtgSession instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
      'expiresAt': const EpochMillisConverter().toJson(instance.expiresAt),
      'uid': ?instance.uid,
      'phone': ?instance.phone,
    };
