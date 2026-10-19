// Gatepass — sign_in_state.dart. Created 2026-10-19.
part of 'sign_in_bloc.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    /// On the code step.
    @Default(false) bool codeSent,

    /// The way the last code went, so a resend goes the same way.
    @Default(OtpChannel.sms) OtpChannel channel,

    /// The way a code is being sent right now, for its button's spinner.
    OtpChannel? sending,
    @Default(false) bool verifying,

    /// Set once the code is accepted.
    AccountSession? account,

    /// The latest failure. [errorRevision] changes with each one, so the
    /// same error twice still shows twice.
    ApplicationError? error,
    @Default(0) int errorRevision,
  }) = _SignInState;

  const SignInState._();

  bool get busy => sending != null || verifying;
}
