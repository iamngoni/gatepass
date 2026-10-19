// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter/services.dart' as _i281;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'auth/models/repos/abs/auth_repository.dart' as _i931;
import 'auth/models/repos/impl/dio_auth_repository.dart' as _i76;
import 'backup/models/data/kdf_params.dart' as _i79;
import 'backup/models/repos/abs/backup_repository.dart' as _i486;
import 'backup/models/repos/abs/backup_store_repository.dart' as _i878;
import 'backup/models/repos/abs/recovery_phrase_repository.dart' as _i296;
import 'backup/models/repos/impl/asset_recovery_phrase_repository.dart'
    as _i340;
import 'backup/models/repos/impl/cloud_backup_repository.dart' as _i382;
import 'backup/models/repos/impl/dio_backup_store_repository.dart' as _i461;
import 'core/services/atg_account_service.dart' as _i516;
import 'core/services/atg_session_service.dart' as _i584;
import 'core/services/backup_cipher_service.dart' as _i589;
import 'core/services/device_id_service.dart' as _i1064;
import 'core/services/secure_storage_service.dart' as _i493;
import 'core/services/seen_notifications_service.dart' as _i277;
import 'injection.dart' as _i464;
import 'invites/models/repos/abs/invite_archive_repository.dart' as _i888;
import 'invites/models/repos/abs/invite_repository.dart' as _i1002;
import 'invites/models/repos/impl/dio_invite_repository.dart' as _i520;
import 'invites/models/repos/impl/secure_invite_archive_repository.dart'
    as _i66;
import 'notifications/models/repos/abs/notification_repository.dart' as _i367;
import 'notifications/models/repos/impl/dio_notification_repository.dart'
    as _i716;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final serviceModule = _$ServiceModule();
    gh.lazySingleton<_i589.BackupCipherService>(
      () => _i589.BackupCipherService(),
    );
    gh.lazySingleton<_i1064.DeviceIdService>(() => _i1064.DeviceIdService());
    gh.lazySingleton<_i277.SeenNotificationsService>(
      () => _i277.SeenNotificationsService(),
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => serviceModule.secureStorage,
    );
    gh.lazySingleton<_i281.AssetBundle>(() => serviceModule.assetBundle);
    gh.lazySingleton<_i79.KdfParams>(() => serviceModule.kdfParams);
    gh.lazySingleton<_i361.Dio>(
      () => serviceModule.firebaseDio,
      instanceName: 'firebase',
    );
    gh.lazySingleton<_i361.Dio>(
      () => serviceModule.backupDio,
      instanceName: 'backup',
    );
    gh.lazySingleton<_i493.SecureStorageService>(
      () => _i493.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i296.RecoveryPhraseRepository>(
      () => _i340.AssetRecoveryPhraseRepository(gh<_i281.AssetBundle>()),
    );
    gh.lazySingleton<_i584.AtgSessionService>(
      () => _i584.AtgSessionService(
        gh<_i493.SecureStorageService>(),
        gh<_i361.Dio>(instanceName: 'firebase'),
      ),
    );
    gh.lazySingleton<_i878.BackupStoreRepository>(
      () =>
          _i461.DioBackupStoreRepository(gh<_i361.Dio>(instanceName: 'backup')),
    );
    gh.lazySingleton<_i888.InviteArchiveRepository>(
      () =>
          _i66.SecureInviteArchiveRepository(gh<_i493.SecureStorageService>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => serviceModule.atgDio(gh<_i584.AtgSessionService>()),
      instanceName: 'atg',
    );
    gh.lazySingleton<_i367.NotificationRepository>(
      () => _i716.DioNotificationRepository(
        gh<_i361.Dio>(instanceName: 'atg'),
        gh<_i277.SeenNotificationsService>(),
      ),
    );
    gh.lazySingleton<_i516.AtgAccountService>(
      () => _i516.AtgAccountService(
        gh<_i361.Dio>(instanceName: 'atg'),
        gh<_i584.AtgSessionService>(),
      ),
    );
    gh.lazySingleton<_i931.AuthRepository>(
      () => _i76.DioAuthRepository(
        gh<_i361.Dio>(instanceName: 'atg'),
        gh<_i584.AtgSessionService>(),
        gh<_i516.AtgAccountService>(),
        gh<_i1064.DeviceIdService>(),
      ),
    );
    gh.lazySingleton<_i486.BackupRepository>(
      () => _i382.CloudBackupRepository(
        gh<_i931.AuthRepository>(),
        gh<_i878.BackupStoreRepository>(),
        gh<_i589.BackupCipherService>(),
        gh<_i493.SecureStorageService>(),
        gh<_i79.KdfParams>(),
      ),
    );
    gh.lazySingleton<_i1002.InviteRepository>(
      () => _i520.DioInviteRepository(
        gh<_i361.Dio>(instanceName: 'atg'),
        gh<_i516.AtgAccountService>(),
      ),
    );
    return this;
  }
}

class _$ServiceModule extends _i464.ServiceModule {}
