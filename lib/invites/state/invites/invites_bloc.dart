//
//  Gatepass
//  invites_bloc.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart' show Unit, unit;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/models/data/account_session.dart';
import '../../../core/models/data/request_status.dart';
import '../../../core/utils/invite_merge.dart';
import '../../models/data/delivery_service.dart';
import '../../models/data/delivery_services.dart';
import '../../models/data/invite.dart';
import '../../models/data/invite_draft.dart';
import '../../models/data/invite_status.dart';
import '../../models/repos/abs/invite_archive_repository.dart';
import '../../models/repos/abs/invite_repository.dart';

part 'invites_bloc.freezed.dart';
part 'invites_event.dart';
part 'invites_state.dart';

/// The signed-in account's invites: ATG's list merged into the archive on
/// the phone, which keeps what ATG forgets.
@lazySingleton
class InvitesBloc extends Bloc<InvitesEvent, InvitesState> {
  InvitesBloc(this.invites, this.archive) : super(const InvitesState()) {
    on<InvitesStartedEvent>(_onStarted, transformer: restartable());
    on<InvitesClearedEvent>((event, emit) => emit(const InvitesState()));
    on<InvitesRefreshRequestedEvent>(_onRefresh, transformer: droppable());
    on<InvitesCreateRequestedEvent>(_onCreate);
    on<InvitesRevokeRequestedEvent>(_onRevoke);
    on<InvitesBackupAdoptedEvent>(_onBackupAdopted);
  }

  final InviteRepository invites;
  final InviteArchiveRepository archive;

  /// What this account had last time shows straight away, offline
  /// included, then ATG's list is fetched.
  Future<void> _onStarted(
    InvitesStartedEvent event,
    Emitter<InvitesState> emit,
  ) async {
    final accountId = event.account.resident.id;
    emit(InvitesState(accountId: accountId, siteId: event.account.site.id));
    final saved = await archive.load(accountId);
    emit(
      state.copyWith(
        invites: saved.fold((error) {
          debugPrint('[Gatepass] invite archive not loaded: $error');
          return const [];
        }, (invites) => invites),
        loaded: true,
      ),
    );
    add(const InvitesEvent.refreshRequested());
  }

  Future<void> _onRefresh(
    InvitesRefreshRequestedEvent event,
    Emitter<InvitesState> emit,
  ) async {
    final siteId = state.siteId;
    if (siteId == null) return;
    emit(state.copyWith(refresh: const RequestStatus.pending()));
    final result = await invites.fetchInvites(siteId);
    if (state.siteId != siteId) return;
    await result.fold(
      (error) async =>
          emit(state.copyWith(refresh: RequestStatus.failed(error))),
      (fetched) async {
        emit(
          state.copyWith(
            invites: mergeInvites(
              state.invites,
              fetched,
              fetchedIsComplete: fetched.length < invitePageLimit,
              now: DateTime.now(),
            ),
            refresh: const RequestStatus.succeeded(unit),
          ),
        );
        await _save(emit);
      },
    );
  }

  Future<void> _onCreate(
    InvitesCreateRequestedEvent event,
    Emitter<InvitesState> emit,
  ) async {
    final siteId = state.siteId;
    if (siteId == null) return;
    _setRequest(emit, event.requestId, const RequestStatus.pending());
    final result = await invites.createInvite(siteId, event.draft);
    if (state.siteId != siteId) return;
    await result.fold(
      (error) async =>
          _setRequest(emit, event.requestId, RequestStatus.failed(error)),
      (invite) async {
        emit(
          state.copyWith(
            invites: [...state.invites, invite],
            requests: {
              ...state.requests,
              event.requestId: RequestStatus.succeeded(invite),
            },
          ),
        );
        await _save(emit);
      },
    );
  }

  /// ATG deletes the profile, so the invite keeps its details here and only
  /// its status changes.
  Future<void> _onRevoke(
    InvitesRevokeRequestedEvent event,
    Emitter<InvitesState> emit,
  ) async {
    final siteId = state.siteId;
    if (siteId == null) return;
    _setRevoke(emit, event.requestId, const RequestStatus.pending());
    final result = await invites.revokeInvite(event.inviteId);
    if (state.siteId != siteId) return;
    await result.fold(
      (error) async =>
          _setRevoke(emit, event.requestId, RequestStatus.failed(error)),
      (_) async {
        emit(
          state.copyWith(
            invites: [
              for (final invite in state.invites)
                invite.id == event.inviteId
                    ? invite.copyWith(status: InviteStatus.revoked)
                    : invite,
            ],
            revokes: {
              ...state.revokes,
              event.requestId: const RequestStatus.succeeded(unit),
            },
          ),
        );
        await _save(emit);
      },
    );
  }

  /// The backup's merge of this phone's and other phones' archives,
  /// joined with anything that changed here while it ran. Saved without
  /// counting as a change, so it doesn't back up again.
  Future<void> _onBackupAdopted(
    InvitesBackupAdoptedEvent event,
    Emitter<InvitesState> emit,
  ) async {
    if (state.accountId != event.accountId) return;
    emit(state.copyWith(invites: unionInvites(state.invites, event.invites)));
    await _save(emit, backUp: false);
  }

  void _setRequest(
    Emitter<InvitesState> emit,
    String requestId,
    RequestStatus<Invite> status,
  ) => emit(state.copyWith(requests: {...state.requests, requestId: status}));

  void _setRevoke(
    Emitter<InvitesState> emit,
    String requestId,
    RequestStatus<Unit> status,
  ) => emit(state.copyWith(revokes: {...state.revokes, requestId: status}));

  Future<void> _save(Emitter<InvitesState> emit, {bool backUp = true}) async {
    final accountId = state.accountId;
    if (accountId == null) return;
    final saved = await archive.save(accountId, state.invites);
    saved.fold(
      (error) => debugPrint('[Gatepass] invite archive not saved: $error'),
      (_) {},
    );
    if (backUp && state.accountId == accountId) {
      emit(state.copyWith(changeRevision: state.changeRevision + 1));
    }
  }
}
