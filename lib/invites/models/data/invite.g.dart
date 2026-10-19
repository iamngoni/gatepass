// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Invite _$InviteFromJson(Map<String, dynamic> json) => _Invite(
  id: json['id'] as String,
  siteId: json['siteId'] as String,
  visitorName: json['visitorName'] as String,
  from: const EpochMillisConverter().fromJson((json['from'] as num).toInt()),
  until: const EpochMillisConverter().fromJson((json['until'] as num).toInt()),
  status: $enumDecode(_$InviteStatusEnumMap, json['status']),
  code: json['code'] as String,
  link: json['link'] as String,
  createdAt: const EpochMillisConverter().fromJson(
    (json['createdAt'] as num).toInt(),
  ),
  serviceId: json['serviceId'] as String?,
  phone: json['phone'] as String?,
  vehicleReg: json['vehicleReg'] as String?,
  openEnded: json['openEnded'] as bool? ?? false,
  windowText: json['windowText'] as String?,
);

Map<String, dynamic> _$InviteToJson(_Invite instance) => <String, dynamic>{
  'id': instance.id,
  'siteId': instance.siteId,
  'visitorName': instance.visitorName,
  'from': const EpochMillisConverter().toJson(instance.from),
  'until': const EpochMillisConverter().toJson(instance.until),
  'status': _$InviteStatusEnumMap[instance.status]!,
  'code': instance.code,
  'link': instance.link,
  'createdAt': const EpochMillisConverter().toJson(instance.createdAt),
  'serviceId': ?instance.serviceId,
  'phone': ?instance.phone,
  'vehicleReg': ?instance.vehicleReg,
  'openEnded': instance.openEnded,
  'windowText': ?instance.windowText,
};

const _$InviteStatusEnumMap = {
  InviteStatus.active: 'active',
  InviteStatus.expired: 'expired',
  InviteStatus.revoked: 'revoked',
};
