// Gatepass — invite_repository.dart. Created 2026-10-19.
import 'package:dartz/dartz.dart';

import '../../../../core/models/data/application_error.dart';
import '../../data/invite.dart';
import '../../data/invite_draft.dart';

/// The most invites [InviteRepository.fetchInvites] returns. A shorter list
/// is everything the backend has.
const invitePageLimit = 50;

/// The resident's invitations in ATG.
abstract interface class InviteRepository {
  Future<Either<ApplicationError, List<Invite>>> fetchInvites(String siteId);

  Future<Either<ApplicationError, Invite>> createInvite(
    String siteId,
    InviteDraft draft,
  );

  /// Stops a live invite's link and code working straight away.
  Future<Either<ApplicationError, Unit>> revokeInvite(String inviteId);
}
