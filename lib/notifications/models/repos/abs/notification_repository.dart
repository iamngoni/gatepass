//
//  Gatepass
//  notification_repository.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

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
