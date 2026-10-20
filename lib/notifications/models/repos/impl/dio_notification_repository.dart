//
//  Gatepass
//  dio_notification_repository.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/configs/atg_config.dart';
import '../../../../core/models/data/application_error.dart';
import '../../../../core/services/seen_notifications_service.dart';
import '../../../../core/utils/atg_json.dart';
import '../../../../core/utils/dio_error_mapper.dart';
import '../../../../core/utils/interceptors/atg_auth_interceptor.dart';
import '../../data/app_notification.dart';
import '../../dto/atg_notification_dto.dart';
import '../abs/notification_repository.dart';

@LazySingleton(as: NotificationRepository)
class DioNotificationRepository implements NotificationRepository {
  DioNotificationRepository(@Named('atg') this.dio, this.seen);

  final Dio dio;
  final SeenNotificationsService seen;

  @override
  Future<Either<ApplicationError, List<AppNotification>>> fetchNotifications(
    String siteId,
  ) async {
    try {
      final response = await dio.get<Object?>(
        AtgConfig.notificationsListPath,
        options: AtgAuthInterceptor.authed('notifications'),
      );
      final now = DateTime.now();
      final fetched = [
        for (final json in objectsOf(response.data))
          AtgNotificationDTO.fromJson(
            json,
          ).toNotification(siteId: siteId, now: now),
      ];
      final hadBaseline = seen.hasBaseline;
      final ids = seen.load();
      if (!hadBaseline) {
        // First run sees the existing archive. Treat it as history instead
        // of showing fifty old notifications as new.
        seen.add(fetched.map((n) => n.id));
        return Right([for (final n in fetched) n.copyWith(read: true)]);
      }
      return Right([
        for (final n in fetched)
          ids.contains(n.id) ? n.copyWith(read: true) : n,
      ]);
    } on Object catch (e, s) {
      return Left(DioErrorMapper.map(e, s, context: 'notifications'));
    }
  }

  @override
  Future<Either<ApplicationError, Unit>> markRead(Iterable<String> ids) async {
    seen.add(ids);
    return const Right(unit);
  }
}
