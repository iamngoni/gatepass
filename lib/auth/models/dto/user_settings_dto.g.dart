// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSettingsDTO _$UserSettingsDTOFromJson(Map<String, dynamic> json) =>
    _UserSettingsDTO(
      estateName: _readBrand(json, 'estateName') as String?,
      unit: _readUnit(json, 'unit') as String?,
      firstName: _readFirstName(json, 'firstName') as String?,
      lastName: _readLastName(json, 'lastName') as String?,
      email: _readEmail(json, 'email') as String?,
      inviteHorizonDays: (_readHorizon(json, 'inviteHorizonDays') as num?)
          ?.toInt(),
    );

Map<String, dynamic> _$UserSettingsDTOToJson(_UserSettingsDTO instance) =>
    <String, dynamic>{
      'estateName': ?instance.estateName,
      'unit': ?instance.unit,
      'firstName': ?instance.firstName,
      'lastName': ?instance.lastName,
      'email': ?instance.email,
      'inviteHorizonDays': ?instance.inviteHorizonDays,
    };
