// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenRefreshResponseDTO _$TokenRefreshResponseDTOFromJson(
  Map<String, dynamic> json,
) => _TokenRefreshResponseDTO(
  idToken: _readIdToken(json, 'idToken') as String?,
  refreshToken: json['refresh_token'] as String?,
  expiresIn: json['expires_in'] as String?,
  userId: json['user_id'] as String?,
);

Map<String, dynamic> _$TokenRefreshResponseDTOToJson(
  _TokenRefreshResponseDTO instance,
) => <String, dynamic>{
  'idToken': ?instance.idToken,
  'refresh_token': ?instance.refreshToken,
  'expires_in': ?instance.expiresIn,
  'user_id': ?instance.userId,
};
