// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VisitorCategoryDTO _$VisitorCategoryDTOFromJson(Map<String, dynamic> json) =>
    _VisitorCategoryDTO(
      id: (_readId(json, 'id') as num?)?.toInt(),
      name: _readName(json, 'name') as String?,
    );

Map<String, dynamic> _$VisitorCategoryDTOToJson(_VisitorCategoryDTO instance) =>
    <String, dynamic>{'id': ?instance.id, 'name': ?instance.name};
