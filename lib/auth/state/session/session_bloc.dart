// Gatepass — session_bloc.dart. Created 2026-10-19.
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/data/account_session.dart';
import '../../models/repos/abs/auth_repository.dart';

part 'session_bloc.freezed.dart';
part 'session_event.dart';
part 'session_state.dart';

/// Who is signed in. Restores a stored session on launch, so the app shows
/// a loader rather than flashing the sign-in screen.
@lazySingleton
class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc(this.auth) : super(const SessionState.restoring()) {
    on<SessionStartedEvent>(_onStarted, transformer: droppable());
    on<SessionSignedInEvent>(
      (event, emit) => emit(SessionState.signedIn(account: event.account)),
    );
    on<SessionSignOutRequestedEvent>(_onSignOut);
  }

  final AuthRepository auth;

  /// A network failure keeps the stored token for the next launch and
  /// leaves the sign-in screen available.
  Future<void> _onStarted(
    SessionStartedEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const SessionState.restoring());
    final result = await auth.restoreSession();
    result.fold(
      (error) {
        debugPrint('[Gatepass] session restore failed: $error');
        emit(const SessionState.signedOut());
      },
      (account) => emit(
        account == null
            ? const SessionState.signedOut()
            : SessionState.signedIn(account: account),
      ),
    );
  }

  /// The invite archive stays on the device for the next sign-in.
  Future<void> _onSignOut(
    SessionSignOutRequestedEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(const SessionState.signedOut());
    await auth.signOut();
  }
}
