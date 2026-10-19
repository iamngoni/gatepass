// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atg_notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AtgNotificationDTO _$AtgNotificationDTOFromJson(Map<String, dynamic> json) =>
    _AtgNotificationDTO(
      id: _readId(json, 'id') as String?,
      title: _readTitle(json, 'title') as String?,
      body: _readBody(json, 'body') as String?,
      time: const AtgDateConverter().fromJson(_readTime(json, 'time')),
      dataAdded: json['dataAdded'],
      read: _readRead(json, 'read') as bool?,
    );

Map<String, dynamic> _$AtgNotificationDTOToJson(_AtgNotificationDTO instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'title': ?instance.title,
      'body': ?instance.body,
      'time': ?const AtgDateConverter().toJson(instance.time),
      'dataAdded': ?instance.dataAdded,
      'read': ?instance.read,
    };
