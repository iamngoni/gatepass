// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atg_visitor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AtgVisitorDTO _$AtgVisitorDTOFromJson(
  Map<String, dynamic> json,
) => _AtgVisitorDTO(
  id: _readId(json, 'id') as String?,
  fullName: _readFullName(json, 'fullName') as String?,
  firstName: _readFirstName(json, 'firstName') as String?,
  lastName: _readLastName(json, 'lastName') as String?,
  phone: _readPhone(json, 'phone') as String?,
  vehicleReg: _readVehicle(json, 'vehicleReg') as String?,
  validFrom: const AtgDateConverter().fromJson(_readFrom(json, 'validFrom')),
  validTill: const AtgDateConverter().fromJson(_readUntil(json, 'validTill')),
  rememberTill: const AtgDateConverter().fromJson(json['rememberTill']),
  createdAt: const AtgDateConverter().fromJson(_readCreated(json, 'createdAt')),
  validFromDateText: json['validFromDateText'] as String?,
  validTillDateText: json['validTillDateText'] as String?,
  status: _readStatus(json, 'status') as String?,
  deleted: _readDeleted(json, 'deleted') as bool?,
  code: _readCode(json, 'code') as String?,
  link: _readLink(json, 'link') as String?,
);

Map<String, dynamic> _$AtgVisitorDTOToJson(_AtgVisitorDTO instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'fullName': ?instance.fullName,
      'firstName': ?instance.firstName,
      'lastName': ?instance.lastName,
      'phone': ?instance.phone,
      'vehicleReg': ?instance.vehicleReg,
      'validFrom': ?const AtgDateConverter().toJson(instance.validFrom),
      'validTill': ?const AtgDateConverter().toJson(instance.validTill),
      'rememberTill': ?const AtgDateConverter().toJson(instance.rememberTill),
      'createdAt': ?const AtgDateConverter().toJson(instance.createdAt),
      'validFromDateText': ?instance.validFromDateText,
      'validTillDateText': ?instance.validTillDateText,
      'status': ?instance.status,
      'deleted': ?instance.deleted,
      'code': ?instance.code,
      'link': ?instance.link,
    };
