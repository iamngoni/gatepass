//
//  Gatepass
//  atg_notification_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/atg_json.dart';
import '../../../core/utils/json_converters.dart';
import '../data/app_notification.dart';
import '../data/notification_kind.dart';

part 'atg_notification_dto.freezed.dart';
part 'atg_notification_dto.g.dart';

/// One entry from `/api/notifications/getList`.
@freezed
abstract class AtgNotificationDTO with _$AtgNotificationDTO {
  const factory AtgNotificationDTO({
    @JsonKey(readValue: _readId) String? id,
    @JsonKey(readValue: _readTitle) String? title,
    @JsonKey(readValue: _readBody) String? body,

    /// ATG's own spelling of "date added".
    @AtgDateConverter() @JsonKey(readValue: _readTime) DateTime? time,

    /// Kept raw for the fallback id, which earlier builds derived from it.
    Object? dataAdded,
    @JsonKey(readValue: _readRead) bool? read,
  }) = _AtgNotificationDTO;

  const AtgNotificationDTO._();

  factory AtgNotificationDTO.fromJson(Map<String, dynamic> json) =>
      _$AtgNotificationDTOFromJson(json);

  AppNotification toNotification({
    required String siteId,
    required DateTime now,
  }) {
    final heading = title ?? 'Estate update';
    final lower = heading.toLowerCase();
    final kind = lower.contains('enter') || lower.contains('arriv')
        ? NotificationKind.arrival
        : lower.contains('exit') ||
              lower.contains('left') ||
              lower.contains('depart')
        ? NotificationKind.departure
        : NotificationKind.notice;
    return AppNotification(
      id: id ?? 'atg-${dataAdded ?? now.millisecondsSinceEpoch}',
      siteId: siteId,
      kind: kind,
      title: heading,
      body: body ?? '',
      time: time ?? now,
      read: read ?? false,
    );
  }
}

Object? _readId(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['id', 'notificationId', 'uid']);

Object? _readTitle(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['title', 'message', 'body']);

Object? _readBody(Map<dynamic, dynamic> json, String _) {
  final customFields = json['customFields'];
  if (customFields is List) {
    return customFields
        .whereType<String>()
        .where((s) => s.isNotEmpty)
        .join(' · ');
  }
  return firstString(json, const ['message', 'body', 'description']);
}

Object? _readTime(Map<dynamic, dynamic> json, String _) =>
    firstValue(json, const ['dataAdded', 'dateCreated', 'createdAt']);

Object? _readRead(Map<dynamic, dynamic> json, String _) =>
    asBool(json['read'] ?? json['isRead']);
