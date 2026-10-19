// Gatepass — invites_bloc_extensions.dart. Created 2026-10-19.
import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../invites/models/data/invite.dart';
import '../../../invites/models/data/invite_draft.dart';
import '../../../invites/state/invites/invites_bloc.dart';
import '../../../notifications/state/notifications/notifications_bloc.dart';
import '../../models/data/application_error.dart';
import '../../models/data/request_status.dart';

/// Dispatches a request and waits for its outcome in the BLoC's state, for
/// screens that act on the result (show the new code, close a sheet).
extension InvitesRequests on InvitesBloc {
  static var _next = 0;

  /// A request id unique for this run of the app.
  static String newRequestId() => 'r${++_next}';

  /// Starts a create and returns its request id; watch
  /// [InvitesState.requests] for the outcome.
  String create(InviteDraft draft) {
    final requestId = newRequestId();
    add(InvitesEvent.createRequested(requestId: requestId, draft: draft));
    return requestId;
  }

  Future<Either<ApplicationError, Invite>> createAndWait(InviteDraft draft) =>
      _outcome(create(draft), (state, id) => state.requests[id]);

  Future<Either<ApplicationError, Unit>> revoke(String inviteId) {
    final requestId = newRequestId();
    add(
      InvitesEvent.revokeRequested(requestId: requestId, inviteId: inviteId),
    );
    return _outcome(requestId, (state, id) => state.revokes[id]);
  }

  Future<Either<ApplicationError, T>> _outcome<T>(
    String requestId,
    RequestStatus<T>? Function(InvitesState state, String id) read,
  ) async {
    bool done(InvitesState state) => switch (read(state, requestId)) {
      RequestSucceeded() || RequestFailed() => true,
      _ => false,
    };
    final state = done(this.state) ? this.state : await stream.firstWhere(done);
    return switch (read(state, requestId)) {
      RequestSucceeded(:final value) => Right(value),
      RequestFailed(:final error) => Left(error),
      _ => const Left(ApplicationError(code: ApplicationErrorCode.unknown)),
    };
  }
}

/// Pull-to-refresh across invites and notifications.
abstract final class GateRefresh {
  /// Refreshes both and returns the first failure, if any. A stalled
  /// request must not hold the pull open forever, so it gives up after
  /// [timeout].
  static Future<ApplicationError?> run(
    InvitesBloc invites,
    NotificationsBloc notifications, {
    Duration timeout = const Duration(seconds: 20),
  }) async {
    invites.add(const InvitesEvent.refreshRequested());
    notifications.add(const NotificationsEvent.refreshRequested());
    bool settled(RequestStatus<Unit>? status) => status is! RequestPending;
    try {
      // Let both handlers mark themselves pending first.
      await Future<void>.delayed(Duration.zero);
      final results = await Future.wait([
        if (settled(invites.state.refresh))
          Future.value(invites.state.refresh)
        else
          invites.stream.map((s) => s.refresh).firstWhere(settled),
        if (settled(notifications.state.refresh))
          Future.value(notifications.state.refresh)
        else
          notifications.stream.map((s) => s.refresh).firstWhere(settled),
      ]).timeout(timeout);
      for (final result in results) {
        if (result case RequestFailed(:final error)) return error;
      }
      return null;
    } on TimeoutException {
      return const ApplicationError(code: ApplicationErrorCode.timeout);
    }
  }
}
