// Gatepass — notifications_bloc.dart. Created 2026-10-19.
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart' show Unit, unit;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/data/request_status.dart';
import '../../models/data/app_notification.dart';
import '../../models/repos/abs/notification_repository.dart';

part 'notifications_bloc.freezed.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

@lazySingleton
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(this.notifications) : super(const NotificationsState()) {
    on<NotificationsStartedEvent>((event, emit) {
      emit(NotificationsState(siteId: event.siteId));
      add(const NotificationsEvent.refreshRequested());
    });
    on<NotificationsClearedEvent>(
      (event, emit) => emit(const NotificationsState()),
    );
    on<NotificationsRefreshRequestedEvent>(
      _onRefresh,
      transformer: droppable(),
    );
    on<NotificationsMarkReadRequestedEvent>(
      (event, emit) => _markRead(emit, event.ids.toSet()),
    );
    on<NotificationsMarkAllReadRequestedEvent>(
      (event, emit) => _markRead(
        emit,
        state.notifications.where((n) => !n.read).map((n) => n.id).toSet(),
      ),
    );
  }

  final NotificationRepository notifications;

  Future<void> _onRefresh(
    NotificationsRefreshRequestedEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    final siteId = state.siteId;
    if (siteId == null) return;
    emit(state.copyWith(refresh: const RequestStatus.pending()));
    final result = await notifications.fetchNotifications(siteId);
    if (state.siteId != siteId) return;
    emit(
      result.fold(
        (error) => state.copyWith(refresh: RequestStatus.failed(error)),
        (list) => state.copyWith(
          notifications: list,
          refresh: const RequestStatus.succeeded(unit),
        ),
      ),
    );
  }

  Future<void> _markRead(
    Emitter<NotificationsState> emit,
    Set<String> ids,
  ) async {
    if (ids.isEmpty) return;
    emit(
      state.copyWith(
        notifications: [
          for (final n in state.notifications)
            ids.contains(n.id) ? n.copyWith(read: true) : n,
        ],
      ),
    );
    final saved = await notifications.markRead(ids);
    saved.fold(
      (error) => debugPrint('[Gatepass] read state not saved: $error'),
      (_) {},
    );
  }
}
