// Gatepass — session_event.dart. Created 2026-10-19.
part of 'session_bloc.dart';

@freezed
sealed class SessionEvent with _$SessionEvent {
  /// Launch: resume the stored session, if any.
  const factory SessionEvent.started() = SessionStartedEvent;

  /// Sign-in finished with this account.
  const factory SessionEvent.signedIn({required AccountSession account}) =
      SessionSignedInEvent;

  const factory SessionEvent.signOutRequested() = SessionSignOutRequestedEvent;
}
