// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_access_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SharedAccessRequestDTO _$SharedAccessRequestDTOFromJson(
  Map<String, dynamic> json,
) => _SharedAccessRequestDTO(
  deviceType: json['deviceType'] as String,
  deviceId: json['deviceId'] as String,
  appVersion: json['appVersion'] as String,
  appBuildNumber: json['appBuildNumber'] as String,
);

Map<String, dynamic> _$SharedAccessRequestDTOToJson(
  _SharedAccessRequestDTO instance,
) => <String, dynamic>{
  'deviceType': instance.deviceType,
  'deviceId': instance.deviceId,
  'appVersion': instance.appVersion,
  'appBuildNumber': instance.appBuildNumber,
};
