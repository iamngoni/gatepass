// Gatepass — notification_repository.dart. Created 2026-10-19.
import 'package:dartz/dartz.dart';

import '../../../../core/models/data/application_error.dart';
import '../../data/app_notification.dart';

/// Gate events and estate notices, with which ones the resident has seen.
abstract interface class NotificationRepository {
  Future<Either<ApplicationError, List<AppNotification>>> fetchNotifications(
    String siteId,
  );

  Future<Either<ApplicationError, Unit>> markRead(Iterable<String> ids);
}
