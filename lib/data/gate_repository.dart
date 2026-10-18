import 'models.dart';

/// Everything the UI needs from the access-control backend.
///
/// `AtgGateRepository` (lib/data/atg/) is the live implementation: it talks to
/// the real At The Gate API with the signed-in resident's own account.
abstract interface class GateRepository {
  Future<void> requestCode(String phone);
  Future<Resident> signIn({required String phone, required String code});

  /// Resumes a previously stored session, returning the resident when the
  /// persisted refresh token is still valid. Null means sign-in is required.
  Future<Resident?> restoreSession();

  Future<List<Site>> fetchSites();

  Future<List<Invite>> fetchInvites(String siteId);
  Future<Invite> createInvite(String siteId, InviteDraft draft);

  /// Stops a live invite's link and code working straight away.
  Future<Invite> revokeInvite(String inviteId);

  Future<List<AppNotification>> fetchNotifications(String siteId);
  Future<void> markNotificationsRead(Iterable<String> ids);
}
