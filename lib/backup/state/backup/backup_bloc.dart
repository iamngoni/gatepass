//
//  Gatepass
//  backup_bloc.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart' show Either, Unit, unit;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/models/data/application_error.dart';
import '../../../core/models/data/request_status.dart';
import '../../../invites/models/data/invite.dart';
import '../../models/data/backup_action.dart';
import '../../models/repos/abs/backup_repository.dart';
import '../../models/repos/abs/recovery_phrase_repository.dart';

part 'backup_bloc.freezed.dart';
part 'backup_event.dart';
part 'backup_state.dart';

/// The end-to-end encrypted cloud copy of the invite archive. Local changes
/// back up two seconds after the last one; a merge with other phones'
/// copies comes back in [BackupState.merged] for the invites to adopt.
@lazySingleton
class BackupBloc extends Bloc<BackupEvent, BackupState> {
  BackupBloc(this.backup, this.phrases) : super(const BackupState()) {
    on<BackupStartedEvent>(_onStarted, transformer: restartable());
    on<BackupClearedEvent>((event, emit) => emit(const BackupState()));
    on<BackupChangedEvent>(_onChanged, transformer: restartable());
    on<BackupRemoteCheckRequestedEvent>(
      _onRemoteCheck,
      transformer: droppable(),
    );
    on<BackupNewPhraseRequestedEvent>(_onNewPhrase, transformer: droppable());
    on<BackupTurnOnRequestedEvent>(_onTurnOn, transformer: droppable());
    on<BackupRestoreRequestedEvent>(_onRestore, transformer: droppable());
    on<BackupBackUpNowRequestedEvent>(_onBackUpNow, transformer: droppable());
    on<BackupTurnOffRequestedEvent>(_onTurnOff, transformer: droppable());
  }

  final BackupRepository backup;
  final RecoveryPhraseRepository phrases;

  static const debounce = Duration(seconds: 2);

  Future<void> _onStarted(
    BackupStartedEvent event,
    Emitter<BackupState> emit,
  ) async {
    emit(
      BackupState(
        accountId: event.accountId,
        local: state.local,
        hasLocal: state.hasLocal,
      ),
    );
    final on = await backup.isOn();
    if (state.accountId != event.accountId) return;
    await on.fold(
      (error) async => debugPrint('[Gatepass] backup state unknown: $error'),
      (on) async {
        emit(state.copyWith(on: on));
        if (on) await _sync(emit);
      },
    );
  }

  Future<void> _onChanged(
    BackupChangedEvent event,
    Emitter<BackupState> emit,
  ) async {
    // The first archive the phone reports syncs straight away, as at
    // launch; later changes wait for the resident to pause.
    final first = !state.hasLocal;
    emit(state.copyWith(local: event.invites, hasLocal: true));
    if (!state.on) return;
    if (!first) {
      await Future<void>.delayed(debounce);
      if (emit.isDone) return;
    }
    await _sync(emit);
  }

  Future<void> _onRemoteCheck(
    BackupRemoteCheckRequestedEvent event,
    Emitter<BackupState> emit,
  ) async {
    emit(state.copyWith(remoteCheck: const RequestStatus.pending()));
    final result = await backup.hasRemote();
    emit(
      state.copyWith(
        remoteCheck: result.fold(RequestStatus.failed, RequestStatus.succeeded),
      ),
    );
  }

  Future<void> _onNewPhrase(
    BackupNewPhraseRequestedEvent event,
    Emitter<BackupState> emit,
  ) async {
    _setAction(emit, BackupAction.newPhrase, const RequestStatus.pending());
    final result = await phrases.generate();
    result.fold(
      (error) =>
          _setAction(emit, BackupAction.newPhrase, RequestStatus.failed(error)),
      (words) {
        emit(state.copyWith(phrase: words));
        _setAction(
          emit,
          BackupAction.newPhrase,
          const RequestStatus.succeeded(unit),
        );
      },
    );
  }

  Future<void> _onTurnOn(
    BackupTurnOnRequestedEvent event,
    Emitter<BackupState> emit,
  ) async {
    final phrase = state.phrase;
    if (phrase == null) {
      _setAction(emit, BackupAction.turnOn, const RequestStatus.pending());
      _setAction(
        emit,
        BackupAction.turnOn,
        const RequestStatus.failed(
          ApplicationError(code: ApplicationErrorCode.unknown),
        ),
      );
      return;
    }
    await _run(
      emit,
      BackupAction.turnOn,
      () => backup.turnOn(phrase, state.local),
    );
  }

  Future<void> _onRestore(
    BackupRestoreRequestedEvent event,
    Emitter<BackupState> emit,
  ) async {
    _setAction(emit, BackupAction.restore, const RequestStatus.pending());
    final words = await phrases.parse(event.phrase);
    await words.fold(
      (error) async =>
          _setAction(emit, BackupAction.restore, RequestStatus.failed(error)),
      (words) => _run(
        emit,
        BackupAction.restore,
        () => backup.restore(words, state.local),
      ),
    );
  }

  Future<void> _onBackUpNow(
    BackupBackUpNowRequestedEvent event,
    Emitter<BackupState> emit,
  ) async {
    _setAction(emit, BackupAction.backUpNow, const RequestStatus.pending());
    final error = await _sync(emit);
    _setAction(
      emit,
      BackupAction.backUpNow,
      error == null
          ? const RequestStatus.succeeded(unit)
          : RequestStatus.failed(error),
    );
  }

  /// Deletes the cloud copy. The invites stay on this phone.
  Future<void> _onTurnOff(
    BackupTurnOffRequestedEvent event,
    Emitter<BackupState> emit,
  ) async {
    _setAction(emit, BackupAction.turnOff, const RequestStatus.pending());
    final result = await backup.turnOff();
    result.fold(
      (error) =>
          _setAction(emit, BackupAction.turnOff, RequestStatus.failed(error)),
      (_) {
        emit(state.copyWith(on: false, lastBackup: null, phrase: null));
        _setAction(
          emit,
          BackupAction.turnOff,
          const RequestStatus.succeeded(unit),
        );
      },
    );
  }

  /// Runs a turn-on or restore and adopts the merged invites it returns.
  Future<void> _run(
    Emitter<BackupState> emit,
    BackupAction action,
    Future<Either<ApplicationError, List<Invite>>> Function() body,
  ) async {
    final accountId = state.accountId;
    _setAction(emit, action, const RequestStatus.pending());
    final result = await body();
    if (state.accountId != accountId) return;
    result.fold(
      (error) => _setAction(emit, action, RequestStatus.failed(error)),
      (
        merged,
      ) {
        _adopt(emit, merged);
        emit(state.copyWith(on: true, phrase: null));
        _setAction(emit, action, const RequestStatus.succeeded(unit));
      },
    );
  }

  /// Pulls, merges and pushes. Returns the failure, which a background
  /// sync only logs: the archive on the phone is intact and the next
  /// change retries.
  Future<ApplicationError?> _sync(Emitter<BackupState> emit) async {
    // Until the archive has loaded, a merge would drop invites only this
    // phone has.
    if (!state.on || !state.hasLocal) return null;
    final accountId = state.accountId;
    emit(state.copyWith(syncing: true));
    final result = await backup.sync(state.local);
    if (state.accountId != accountId) return null;
    emit(state.copyWith(syncing: false));
    return result.fold(
      (error) {
        debugPrint('[Gatepass] cloud backup failed: $error');
        return error;
      },
      (merged) {
        if (merged != null) _adopt(emit, merged);
        return null;
      },
    );
  }

  void _adopt(Emitter<BackupState> emit, List<Invite> merged) => emit(
    state.copyWith(
      local: merged,
      merged: merged,
      mergedRevision: state.mergedRevision + 1,
      lastBackup: DateTime.now(),
    ),
  );

  void _setAction(
    Emitter<BackupState> emit,
    BackupAction action,
    RequestStatus<Unit> status,
  ) => emit(state.copyWith(actions: {...state.actions, action: status}));
}
