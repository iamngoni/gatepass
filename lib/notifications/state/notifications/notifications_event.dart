//
//  Gatepass
//  notifications_event.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

part of 'notifications_bloc.dart';

@freezed
sealed class NotificationsEvent with _$NotificationsEvent {
  const factory NotificationsEvent.started({required String siteId}) =
      NotificationsStartedEvent;

  const factory NotificationsEvent.cleared() = NotificationsClearedEvent;

  const factory NotificationsEvent.refreshRequested() =
      NotificationsRefreshRequestedEvent;

  const factory NotificationsEvent.markReadRequested({
    required List<String> ids,
  }) = NotificationsMarkReadRequestedEvent;

  const factory NotificationsEvent.markAllReadRequested() =
      NotificationsMarkAllReadRequestedEvent;
}
