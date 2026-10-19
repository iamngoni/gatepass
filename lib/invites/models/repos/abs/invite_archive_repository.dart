// Gatepass — invite_archive_repository.dart. Created 2026-10-19.
import 'package:dartz/dartz.dart';

import '../../../../core/models/data/application_error.dart';
import '../../data/invite.dart';

/// Every invite the app has seen, kept on the device per ATG account. ATG
/// deletes a visitor profile on revoke and lists only the latest 50, so
/// without this a revoked or older visitor's details are gone for good.
abstract interface class InviteArchiveRepository {
  Future<Either<ApplicationError, List<Invite>>> load(String accountId);

  Future<Either<ApplicationError, Unit>> save(
    String accountId,
    List<Invite> invites,
  );
}
