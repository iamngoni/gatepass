// Gatepass — atg_account_service.dart. Created 2026-10-19.
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../auth/models/data/account_session.dart';
import '../../auth/models/data/resident.dart';
import '../../auth/models/data/site.dart';
import '../../auth/models/dto/shared_access_account_dto.dart';
import '../../auth/models/dto/shared_access_request_dto.dart';
import '../../auth/models/dto/user_settings_dto.dart';
import '../configs/atg_config.dart';
import '../models/data/application_error.dart';
import '../utils/atg_json.dart';
import '../utils/interceptors/atg_auth_interceptor.dart';
import 'atg_session_service.dart';

/// Resolves the estate account behind the Firebase login. The login uid is
/// not the `hostUid` visitor endpoints use, so this is the bridge between
/// signing in and the resident's data.
@lazySingleton
class AtgAccountService {
  AtgAccountService(@Named('atg') this.dio, this.sessions);

  final Dio dio;
  final AtgSessionService sessions;

  AccountSession? account;

  /// The uid visitor endpoints are scoped to.
  String? get hostUid => account?.resident.id ?? sessions.session?.uid;

  /// Loads the account and estate. Throws [ApplicationError] with
  /// [ApplicationErrorCode.noEstateAccount] when the login has none.
  Future<AccountSession> load() async {
    final shared = await dio.post<Object?>(
      AtgConfig.sharedAccessPath,
      data: const SharedAccessRequestDTO(
        deviceType: AtgConfig.platform,
        deviceId: 'gatepass',
        appVersion: AtgConfig.appVersion,
        appBuildNumber: AtgConfig.appBuildNumber,
      ).toJson(),
      options: AtgAuthInterceptor.authed('accounts'),
    );
    final rows = objectsOf(objectOrEmpty(shared.data)['sharedAccess']);
    if (rows.isEmpty) {
      throw const ApplicationError(code: ApplicationErrorCode.noEstateAccount);
    }
    final row = SharedAccessAccountDTO.fromJson(rows.first);

    // The settings read adds the estate branding and confirms the
    // permissions behind this hostUid. If it is unavailable, the
    // shared-access row is still enough to enter and load visitor data.
    UserSettingsDTO? settings;
    try {
      final response = await dio.get<Object?>(
        AtgConfig.userSettingsPath,
        queryParameters: {'uid': ?row.hostUid},
        options: AtgAuthInterceptor.authed('account'),
      );
      settings = UserSettingsDTO.fromJson(objectOrEmpty(response.data));
    } on Object catch (e) {
      debugPrint('[ATG] account settings unavailable: $e');
    }

    final session = sessions.session;
    final hostUid = row.hostUid;
    if (AtgConfig.debugLog) {
      debugPrint(
        '[ATG] account resolved: hostUid ${hostUid ?? 'missing'}, '
        'estate ${settings?.estateName ?? row.estateName ?? 'missing'}',
      );
    }
    final residentName = settings?.fullName ?? _nonEmpty(row.residentName);
    return account = AccountSession(
      resident: Resident(
        id: hostUid ?? session?.uid ?? 'me',
        name: residentName ?? 'Resident',
        phone: session?.phone ?? '',
        email: settings?.email ?? row.email ?? '',
      ),
      site: Site(
        id: hostUid ?? session?.uid ?? 'atg',
        name: settings?.estateName ?? row.estateName ?? 'My estate',
        unit: settings?.unit ?? row.unit ?? '',
        area: '',
        inviteHorizonDays: settings?.inviteHorizonDays ?? 30,
      ),
    );
  }

  /// The account to enter the app with when [load] failed for a reason
  /// other than a missing estate: the Firebase uid and stored phone.
  AccountSession fallback() {
    final session = sessions.session;
    return account = AccountSession(
      resident: Resident(
        id: session?.uid ?? 'me',
        name: 'Resident',
        phone: session?.phone ?? '',
        email: '',
      ),
      site: Site(
        id: session?.uid ?? 'atg',
        name: 'My estate',
        unit: '',
        area: '',
      ),
    );
  }

  void clear() => account = null;

  static String? _nonEmpty(String? value) =>
      value == null || value.isEmpty ? null : value;
}
