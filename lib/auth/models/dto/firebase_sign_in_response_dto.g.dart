// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_sign_in_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FirebaseSignInResponseDTO _$FirebaseSignInResponseDTOFromJson(
  Map<String, dynamic> json,
) => _FirebaseSignInResponseDTO(
  idToken: json['idToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  expiresIn: json['expiresIn'] as String?,
  localId: json['localId'] as String?,
);

Map<String, dynamic> _$FirebaseSignInResponseDTOToJson(
  _FirebaseSignInResponseDTO instance,
) => <String, dynamic>{
  'idToken': ?instance.idToken,
  'refreshToken': ?instance.refreshToken,
  'expiresIn': ?instance.expiresIn,
  'localId': ?instance.localId,
};
