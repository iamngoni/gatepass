// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_start_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginStartDTO _$LoginStartDTOFromJson(Map<String, dynamic> json) =>
    _LoginStartDTO(
      loginString: json['loginString'] as String,
      channel: json['channel'] as String,
      deviceId: json['deviceId'] as String,
      appVersion: json['appVersion'] as String,
      appBuildNumber: json['appBuildNumber'] as String,
      platform: json['platform'] as String,
    );

Map<String, dynamic> _$LoginStartDTOToJson(_LoginStartDTO instance) =>
    <String, dynamic>{
      'loginString': instance.loginString,
      'channel': instance.channel,
      'deviceId': instance.deviceId,
      'appVersion': instance.appVersion,
      'appBuildNumber': instance.appBuildNumber,
      'platform': instance.platform,
    };
