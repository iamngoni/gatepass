// Gatepass — notifications_state.dart. Created 2026-10-19.
part of 'notifications_bloc.dart';

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    String? siteId,
    @Default([]) List<AppNotification> notifications,

    /// The latest fetch from ATG.
    RequestStatus<Unit>? refresh,
  }) = _NotificationsState;

  const NotificationsState._();

  int get unreadCount => notifications.where((n) => !n.read).length;
}
