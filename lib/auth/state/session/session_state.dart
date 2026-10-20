//
//  Gatepass
//  session_state.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

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
