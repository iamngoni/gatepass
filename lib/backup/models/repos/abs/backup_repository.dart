//
//  Gatepass
//  backup_repository.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:dartz/dartz.dart';

import '../../../../core/models/data/application_error.dart';
import '../../../../invites/models/data/invite.dart';

/// The resident's invite archive, sealed on the phone and backed up to the
/// Worker. Only the phrase opens it.
abstract interface class BackupRepository {
  /// Whether this phone holds the key, i.e. backup is on here.
  Future<Either<ApplicationError, bool>> isOn();

  /// Whether this account has a backup, from this or another phone.
  Future<Either<ApplicationError, bool>> hasRemote();

  /// Starts a backup under a new phrase, replacing any copy on the server.
  Future<Either<ApplicationError, List<Invite>>> turnOn(
    List<String> phrase,
    List<Invite> local,
  );

  /// Unlocks this account's backup on this phone and merges it with
  /// [local]. Left with [ApplicationErrorCode.backupDecrypt] for the wrong
  /// phrase.
  Future<Either<ApplicationError, List<Invite>>> restore(
    List<String> phrase,
    List<Invite> local,
  );

  /// Pulls, merges and pushes. Right(null) when backup is off.
  Future<Either<ApplicationError, List<Invite>?>> sync(List<Invite> local);

  /// Deletes the server copy and forgets the key on this phone.
  Future<Either<ApplicationError, Unit>> turnOff();
}
