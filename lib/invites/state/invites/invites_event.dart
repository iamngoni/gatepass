//
//  Gatepass
//  invites_event.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

part of 'invites_bloc.dart';

@freezed
sealed class InvitesEvent with _$InvitesEvent {
  /// Signed in to [account]: load its archive, then ATG's list.
  const factory InvitesEvent.started({required AccountSession account}) =
      InvitesStartedEvent;

  /// Signed out. The archive stays on the phone.
  const factory InvitesEvent.cleared() = InvitesClearedEvent;

  const factory InvitesEvent.refreshRequested() = InvitesRefreshRequestedEvent;

  /// Its outcome lands in [InvitesState.requests] under [requestId].
  const factory InvitesEvent.createRequested({
    required String requestId,
    required InviteDraft draft,
  }) = InvitesCreateRequestedEvent;

  /// Its outcome lands in [InvitesState.revokes] under [requestId].
  const factory InvitesEvent.revokeRequested({
    required String requestId,
    required String inviteId,
  }) = InvitesRevokeRequestedEvent;

  const factory InvitesEvent.backupAdopted({
    required String accountId,
    required List<Invite> invites,
  }) = InvitesBackupAdoptedEvent;
}
