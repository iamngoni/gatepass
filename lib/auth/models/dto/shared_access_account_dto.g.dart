// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_access_account_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SharedAccessAccountDTO _$SharedAccessAccountDTOFromJson(
  Map<String, dynamic> json,
) => _SharedAccessAccountDTO(
  hostUid: _readHostUid(json, 'hostUid') as String?,
  estateName: _readEstate(json, 'estateName') as String?,
  unit: _readUnit(json, 'unit') as String?,
  residentName: _readName(json, 'residentName') as String?,
  email: _readEmail(json, 'email') as String?,
);

Map<String, dynamic> _$SharedAccessAccountDTOToJson(
  _SharedAccessAccountDTO instance,
) => <String, dynamic>{
  'hostUid': ?instance.hostUid,
  'estateName': ?instance.estateName,
  'unit': ?instance.unit,
  'residentName': ?instance.residentName,
  'email': ?instance.email,
};
