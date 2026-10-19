// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenRefreshDTO _$TokenRefreshDTOFromJson(Map<String, dynamic> json) =>
    _TokenRefreshDTO(
      refreshToken: json['refresh_token'] as String,
      grantType: json['grant_type'] as String? ?? 'refresh_token',
    );

Map<String, dynamic> _$TokenRefreshDTOToJson(_TokenRefreshDTO instance) =>
    <String, dynamic>{
      'refresh_token': instance.refreshToken,
      'grant_type': instance.grantType,
    };
