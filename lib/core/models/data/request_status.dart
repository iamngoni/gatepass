// Gatepass — request_status.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

import 'application_error.dart';

part 'request_status.freezed.dart';

/// The outcome of one request a page started, tracked by a BLoC so the page
/// can show progress and react once, even if it was closed meanwhile.
@freezed
sealed class RequestStatus<T> with _$RequestStatus<T> {
  const factory RequestStatus.pending() = RequestPending<T>;
  const factory RequestStatus.succeeded(T value) = RequestSucceeded<T>;
  const factory RequestStatus.failed(ApplicationError error) = RequestFailed<T>;
}
