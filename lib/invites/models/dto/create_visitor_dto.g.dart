// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_visitor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateVisitorDTO _$CreateVisitorDTOFromJson(Map<String, dynamic> json) =>
    _CreateVisitorDTO(
      uid: json['uid'] as String?,
      name: json['name'] as String,
      validFrom: (json['validFrom'] as num).toInt(),
      validTill: (json['validTill'] as num).toInt(),
      surname: json['surname'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      carLic: json['carLic'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      visitsAllowed: (json['visitsAllowed'] as num?)?.toInt() ?? 1,
      notifyOn: json['notifyOn'] as String? ?? 'both',
    );

Map<String, dynamic> _$CreateVisitorDTOToJson(_CreateVisitorDTO instance) =>
    <String, dynamic>{
      'uid': ?instance.uid,
      'name': instance.name,
      'validFrom': instance.validFrom,
      'validTill': instance.validTill,
      'surname': ?instance.surname,
      'phoneNumber': ?instance.phoneNumber,
      'carLic': ?instance.carLic,
      'categoryId': ?instance.categoryId,
      'visitsAllowed': instance.visitsAllowed,
      'notifyOn': instance.notifyOn,
    };
