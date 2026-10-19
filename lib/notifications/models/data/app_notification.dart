// Gatepass — app_notification.dart. Created 2026-10-18.
import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_kind.dart';

part 'app_notification.freezed.dart';

/// A gate event or estate notice for the resident.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String siteId,
    required NotificationKind kind,
    required String title,
    required String body,
    required DateTime time,
    @Default(false) bool read,
  }) = _AppNotification;
}
