// Gatepass — sign_in_event.dart. Created 2026-10-19.
part of 'sign_in_bloc.dart';

@freezed
sealed class SignInEvent with _$SignInEvent {
  /// Send a code to [phone] (as typed, with or without +27) by [channel].
  const factory SignInEvent.codeRequested({
    required String phone,
    required OtpChannel channel,
  }) = SignInCodeRequestedEvent;

  const factory SignInEvent.codeSubmitted({
    required String phone,
    required String code,
  }) = SignInCodeSubmittedEvent;

  /// Back to the number step.
  const factory SignInEvent.numberChangeRequested() =
      SignInNumberChangeRequestedEvent;
}
