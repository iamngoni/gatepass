// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_token_exchange_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomTokenExchangeDTO _$CustomTokenExchangeDTOFromJson(
  Map<String, dynamic> json,
) => _CustomTokenExchangeDTO(
  token: json['token'] as String,
  returnSecureToken: json['returnSecureToken'] as bool? ?? true,
);

Map<String, dynamic> _$CustomTokenExchangeDTOToJson(
  _CustomTokenExchangeDTO instance,
) => <String, dynamic>{
  'token': instance.token,
  'returnSecureToken': instance.returnSecureToken,
};
