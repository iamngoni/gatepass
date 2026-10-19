// Gatepass — backup_state.dart. Created 2026-10-19.
part of 'backup_bloc.dart';

@freezed
abstract class BackupState with _$BackupState {
  const factory BackupState({
    String? accountId,

    /// This phone holds the key for the signed-in account.
    @Default(false) bool on,
    @Default(false) bool syncing,
    DateTime? lastBackup,

    /// The latest archive on the phone, which a sync uploads.
    @Default([]) List<Invite> local,

    /// [local] has been reported since sign-in.
    @Default(false) bool hasLocal,

    /// The latest merge for the invites to adopt; [mergedRevision] changes
    /// with each one.
    List<Invite>? merged,
    @Default(0) int mergedRevision,

    /// Whether this account has a backup from any phone.
    RequestStatus<bool>? remoteCheck,

    /// A new phrase, shown until backup is on.
    List<String>? phrase,
    @Default({}) Map<BackupAction, RequestStatus<Unit>> actions,
  }) = _BackupState;
}
