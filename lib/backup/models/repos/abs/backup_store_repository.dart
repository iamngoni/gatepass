//
//  Gatepass
//  backup_store_repository.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:dartz/dartz.dart';

import '../../../../core/models/data/application_error.dart';
import '../../data/remote_backup.dart';

/// Where sealed backups are kept: the Gatepass Worker on Cloudflare.
abstract interface class BackupStoreRepository {
  /// Right(null) when this account has no backup.
  Future<Either<ApplicationError, RemoteBackup?>> fetch(String idToken);

  /// Returns the new version. Left with
  /// [ApplicationErrorCode.backupConflict] when another phone wrote since
  /// [expectedVersion].
  Future<Either<ApplicationError, int>> put(
    String idToken,
    int expectedVersion,
    String blob,
  );

  Future<Either<ApplicationError, Unit>> delete(String idToken);
}
