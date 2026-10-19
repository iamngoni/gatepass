// Gatepass — dio_backup_store_repository.dart. Created 2026-10-19.
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/data/application_error.dart';
import '../../data/remote_backup.dart';
import '../../dto/backup_receipt_dto.dart';
import '../../dto/put_backup_dto.dart';
import '../../dto/remote_backup_dto.dart';
import '../abs/backup_store_repository.dart';

/// The Gatepass Worker at `gatepass.antonlabs.cc/v1/backup`. It checks the
/// ATG sign-in token and stores the sealed blob; it never sees the key.
@LazySingleton(as: BackupStoreRepository)
class DioBackupStoreRepository implements BackupStoreRepository {
  DioBackupStoreRepository(@Named('backup') this.dio);

  final Dio dio;

  static const path = '/v1/backup';

  @override
  Future<Either<ApplicationError, RemoteBackup?>> fetch(String idToken) async {
    try {
      final response = await dio.get<Object?>(
        path,
        options: _auth(idToken),
      );
      if (response.statusCode == 404) return const Right(null);
      final data = response.data;
      if (response.statusCode != 200 || data is! Map<String, dynamic>) {
        return Left(_unavailable('fetch', response.statusCode));
      }
      final dto = RemoteBackupDTO.fromJson(data);
      return Right(
        RemoteBackup(
          version: dto.version,
          blob: dto.blob,
          updatedAt: dto.updatedAt,
        ),
      );
    } on Object catch (e) {
      debugPrint('[Gatepass] backup fetch failed: $e');
      return const Left(
        ApplicationError(code: ApplicationErrorCode.backupUnavailable),
      );
    }
  }

  @override
  Future<Either<ApplicationError, int>> put(
    String idToken,
    int expectedVersion,
    String blob,
  ) async {
    try {
      final response = await dio.put<Object?>(
        path,
        data: PutBackupDTO(
          expectedVersion: expectedVersion,
          blob: blob,
        ).toJson(),
        options: _auth(idToken),
      );
      if (response.statusCode == 409) {
        return const Left(
          ApplicationError(code: ApplicationErrorCode.backupConflict),
        );
      }
      final data = response.data;
      if (response.statusCode != 200 || data is! Map<String, dynamic>) {
        return Left(_unavailable('put', response.statusCode));
      }
      return Right(BackupReceiptDTO.fromJson(data).version);
    } on Object catch (e) {
      debugPrint('[Gatepass] backup put failed: $e');
      return const Left(
        ApplicationError(code: ApplicationErrorCode.backupUnavailable),
      );
    }
  }

  @override
  Future<Either<ApplicationError, Unit>> delete(String idToken) async {
    try {
      final response = await dio.delete<Object?>(path, options: _auth(idToken));
      if (response.statusCode != 204) {
        return Left(_unavailable('delete', response.statusCode));
      }
      return const Right(unit);
    } on Object catch (e) {
      debugPrint('[Gatepass] backup delete failed: $e');
      return const Left(
        ApplicationError(code: ApplicationErrorCode.backupUnavailable),
      );
    }
  }

  /// Every status is handled here, so Dio must not throw on non-2xx.
  static Options _auth(String idToken) => Options(
    headers: {'authorization': 'Bearer $idToken'},
    validateStatus: (_) => true,
  );

  static ApplicationError _unavailable(String what, int? status) {
    debugPrint('[Gatepass] backup $what answered ${status ?? '-'}');
    return const ApplicationError(code: ApplicationErrorCode.backupUnavailable);
  }
}
