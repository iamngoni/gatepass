// Gatepass — dio_auth_repository.dart. Created 2026-10-19.
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/configs/atg_config.dart';
import '../../../../core/models/data/application_error.dart';
import '../../../../core/services/atg_account_service.dart';
import '../../../../core/services/atg_session_service.dart';
import '../../../../core/services/device_id_service.dart';
import '../../../../core/utils/dio_error_mapper.dart';
import '../../../../core/utils/interceptors/atg_log_interceptor.dart';
import '../../../../core/utils/phone_numbers.dart';
import '../../data/account_session.dart';
import '../../data/cloud_identity.dart';
import '../../data/otp_channel.dart';
import '../../dto/login_check_dto.dart';
import '../../dto/login_check_response_dto.dart';
import '../../dto/login_start_dto.dart';
import '../abs/auth_repository.dart';

/// ATG's two-step OTP sign-in, recovered verbatim from its web client:
///  1. POST /open/login/start → SMS or WhatsApp code
///  2. POST /open/login/check → Firebase custom token
///  3. identitytoolkit signInWithCustomToken → ID and refresh tokens
@LazySingleton(as: AuthRepository)
class DioAuthRepository implements AuthRepository {
  DioAuthRepository(
    @Named('atg') this.dio,
    this.sessions,
    this.accounts,
    this.deviceIds,
  );

  final Dio dio;
  final AtgSessionService sessions;
  final AtgAccountService accounts;
  final DeviceIdService deviceIds;

  @override
  Future<Either<ApplicationError, Unit>> requestCode(
    String phone, {
    OtpChannel channel = OtpChannel.sms,
  }) async {
    try {
      await dio.post<Object?>(
        AtgConfig.loginStartPath,
        data: LoginStartDTO(
          loginString: normalizeSaMobile(phone),
          channel: switch (channel) {
            OtpChannel.sms => AtgConfig.loginChannelSms,
            OtpChannel.whatsapp => AtgConfig.loginChannelWhatsApp,
          },
          deviceId: deviceIds.deviceId,
          appVersion: AtgConfig.appVersion,
          appBuildNumber: AtgConfig.appBuildNumber,
          platform: AtgConfig.platform,
        ).toJson(),
        options: _context('login/start'),
      );
      return const Right(unit);
    } on Object catch (e, s) {
      return Left(DioErrorMapper.map(e, s, context: 'login/start'));
    }
  }

  @override
  Future<Either<ApplicationError, AccountSession>> signIn({
    required String phone,
    required String code,
  }) async {
    final contact = normalizeSaMobile(phone);
    try {
      final response = await dio.post<Object?>(
        AtgConfig.loginCheckPath,
        data: LoginCheckDTO(
          contact: contact,
          code: code,
          deviceId: deviceIds.deviceId,
          appVersion: AtgConfig.appVersion,
          appBuildNumber: AtgConfig.appBuildNumber,
          platform: AtgConfig.platform,
        ).toJson(),
        options: _context('login/check'),
      );
      final data = response.data;
      final customToken = data is Map
          ? LoginCheckResponseDTO.fromJson(
              data.cast<String, dynamic>(),
            ).customToken
          : null;
      if (customToken == null) {
        debugPrint(
          '[ATG] no custom token in the login reply. Read the logged JSON '
          'and add its token key to AtgConfig.customTokenKeys.',
        );
        return const Left(ApplicationError(code: ApplicationErrorCode.server));
      }
      await sessions.signInWithCustomToken(customToken, phone: contact);
    } on Object catch (e, s) {
      return Left(DioErrorMapper.map(e, s, context: 'login/check'));
    }
    return Right(await _loadAccount('sign-in'));
  }

  @override
  Future<Either<ApplicationError, AccountSession?>> restoreSession() async {
    await sessions.restore();
    if (!sessions.isSignedIn) return const Right(null);
    try {
      // Restored sessions deliberately start expired, so this both proves
      // the stored refresh token still works and recovers the Firebase uid.
      await sessions.refresh();
    } on Object catch (e) {
      debugPrint('[ATG] stored session could not be refreshed: $e');
      return const Right(null);
    }
    return Right(await _loadAccount('restore'));
  }

  @override
  Future<Either<ApplicationError, CloudIdentity>> cloudIdentity() async {
    try {
      final idToken = await sessions.freshIdToken();
      final uid = sessions.session?.uid;
      if (uid == null) {
        return const Left(
          ApplicationError(code: ApplicationErrorCode.notSignedIn),
        );
      }
      return Right(CloudIdentity(uid: uid, idToken: idToken));
    } on Object catch (e, s) {
      return Left(DioErrorMapper.map(e, s, context: 'cloud identity'));
    }
  }

  @override
  Future<Either<ApplicationError, Unit>> signOut() async {
    accounts.clear();
    await sessions.clear();
    return const Right(unit);
  }

  /// The estate account uid visitor endpoints use is not the Firebase uid,
  /// so it is loaded before entering the app. If ATG can't say, the app
  /// still enters with the login alone, as earlier builds did.
  Future<AccountSession> _loadAccount(String when) async {
    try {
      return await accounts.load();
    } on Object catch (e) {
      debugPrint('[ATG] account settings unavailable after $when: $e');
      return accounts.fallback();
    }
  }

  static Options _context(String context) =>
      Options(extra: {AtgLogInterceptor.contextKey: context});
}
