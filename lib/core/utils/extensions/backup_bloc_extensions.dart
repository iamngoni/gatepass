// Gatepass — backup_bloc_extensions.dart. Created 2026-10-19.
import 'package:dartz/dartz.dart';

import '../../../backup/models/data/backup_action.dart';
import '../../../backup/state/backup/backup_bloc.dart';
import '../../models/data/application_error.dart';
import '../../models/data/request_status.dart';

/// Dispatches a backup sheet action and waits for its outcome: the status
/// goes pending, then settles.
extension BackupRequests on BackupBloc {
  Future<Either<ApplicationError, Unit>> run(
    BackupAction action,
    BackupEvent event,
  ) async {
    final settled = _settle((s) => s.actions[action]);
    add(event);
    return switch (await settled) {
      RequestFailed(:final error) => Left(error),
      _ => const Right(unit),
    };
  }

  /// Whether this account has a backup from any phone.
  Future<Either<ApplicationError, bool>> checkRemote() async {
    final settled = _settle((s) => s.remoteCheck);
    add(const BackupEvent.remoteCheckRequested());
    return switch (await settled) {
      RequestSucceeded(:final value) => Right(value),
      RequestFailed(:final error) => Left(error),
      _ => const Right(false),
    };
  }

  Future<RequestStatus<T>?> _settle<T>(
    RequestStatus<T>? Function(BackupState state) read,
  ) => stream
      .map(read)
      .skipWhile((status) => status is! RequestPending)
      .firstWhere((status) => status is! RequestPending);
}
