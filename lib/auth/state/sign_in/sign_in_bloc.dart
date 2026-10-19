// Gatepass — sign_in_bloc.dart. Created 2026-10-19.
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/data/application_error.dart';
import '../../models/data/account_session.dart';
import '../../models/data/otp_channel.dart';
import '../../models/repos/abs/auth_repository.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// The two sign-in steps: send a code to the number, then verify it.
@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this.auth) : super(const SignInState()) {
    on<SignInCodeRequestedEvent>(_onCodeRequested, transformer: droppable());
    on<SignInCodeSubmittedEvent>(_onCodeSubmitted, transformer: droppable());
    on<SignInNumberChangeRequestedEvent>(
      (event, emit) => emit(
        state.copyWith(codeSent: false, sending: null, verifying: false),
      ),
    );
  }

  final AuthRepository auth;

  Future<void> _onCodeRequested(
    SignInCodeRequestedEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(sending: event.channel));
    final result = await auth.requestCode(event.phone, channel: event.channel);
    result.fold(
      (error) => emit(
        state.copyWith(
          sending: null,
          error: error,
          errorRevision: state.errorRevision + 1,
        ),
      ),
      (_) => emit(
        state.copyWith(sending: null, channel: event.channel, codeSent: true),
      ),
    );
  }

  Future<void> _onCodeSubmitted(
    SignInCodeSubmittedEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(verifying: true));
    final result = await auth.signIn(phone: event.phone, code: event.code);
    result.fold(
      (error) => emit(
        state.copyWith(
          verifying: false,
          error: error,
          errorRevision: state.errorRevision + 1,
        ),
      ),
      // Stays verifying: the app leaves this screen once the session
      // takes the account.
      (account) => emit(state.copyWith(account: account)),
    );
  }
}
