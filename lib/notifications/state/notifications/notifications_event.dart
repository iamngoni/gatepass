// Gatepass — notifications_event.dart. Created 2026-10-19.
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
