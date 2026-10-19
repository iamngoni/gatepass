// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_check_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginCheckDTO _$LoginCheckDTOFromJson(Map<String, dynamic> json) =>
    _LoginCheckDTO(
      contact: json['contact'] as String,
      code: json['code'] as String,
      deviceId: json['deviceId'] as String,
      appVersion: json['appVersion'] as String,
      appBuildNumber: json['appBuildNumber'] as String,
      platform: json['platform'] as String,
    );

Map<String, dynamic> _$LoginCheckDTOToJson(_LoginCheckDTO instance) =>
    <String, dynamic>{
      'contact': instance.contact,
      'code': instance.code,
      'deviceId': instance.deviceId,
      'appVersion': instance.appVersion,
      'appBuildNumber': instance.appBuildNumber,
      'platform': instance.platform,
    };
