//
//  Gatepass
//  backup_event.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

part of 'backup_bloc.dart';

@freezed
sealed class BackupEvent with _$BackupEvent {
  /// Signed in: find out whether backup is on for this phone and account.
  const factory BackupEvent.started({required String accountId}) =
      BackupStartedEvent;

  const factory BackupEvent.cleared() = BackupClearedEvent;

  /// The archive on the phone changed to [invites].
  const factory BackupEvent.changed({required List<Invite> invites}) =
      BackupChangedEvent;

  /// Whether this account has a backup from any phone.
  const factory BackupEvent.remoteCheckRequested() =
      BackupRemoteCheckRequestedEvent;

  const factory BackupEvent.newPhraseRequested() =
      BackupNewPhraseRequestedEvent;

  /// Starts a backup under [BackupState.phrase].
  const factory BackupEvent.turnOnRequested() = BackupTurnOnRequestedEvent;

  /// Unlocks this account's backup with the [phrase] the resident typed.
  const factory BackupEvent.restoreRequested({required String phrase}) =
      BackupRestoreRequestedEvent;

  const factory BackupEvent.backUpNowRequested() =
      BackupBackUpNowRequestedEvent;

  const factory BackupEvent.turnOffRequested() = BackupTurnOffRequestedEvent;
}
