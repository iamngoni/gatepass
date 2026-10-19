// Gatepass — session_state.dart. Created 2026-10-19.
part of 'session_bloc.dart';

@freezed
sealed class SessionState with _$SessionState {
  /// A stored session is being checked.
  const factory SessionState.restoring() = SessionRestoringState;

  const factory SessionState.signedOut() = SessionSignedOutState;

  const factory SessionState.signedIn({required AccountSession account}) =
      SessionSignedInState;

  const SessionState._();

  /// The signed-in account, or null.
  AccountSession? get signedInAccount => switch (this) {
    SessionSignedInState(:final account) => account,
    _ => null,
  };
}
