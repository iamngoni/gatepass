// Gatepass — atg_harness.dart. Created 2026-10-19.
import 'package:dio/dio.dart';
import 'package:gatepass/auth/models/data/atg_session.dart';
import 'package:gatepass/core/configs/atg_config.dart';
import 'package:gatepass/core/services/atg_account_service.dart';
import 'package:gatepass/core/services/atg_session_service.dart';
import 'package:gatepass/core/utils/interceptors/atg_auth_interceptor.dart';
import 'package:gatepass/core/utils/interceptors/atg_envelope_interceptor.dart';

import 'route_adapter.dart';

/// The ATG and Firebase clients wired as in `injection.dart`, over one
/// [RouteAdapter].
class AtgHarness {
  AtgHarness(Map<String, FakeReply Function(SeenRequest)> routes)
    : adapter = RouteAdapter(routes) {
    firebase = _dio('')..interceptors.add(const AtgEnvelopeInterceptor());
    sessions = AtgSessionService(storage, firebase);
    atg = _dio(AtgConfig.apiBase)
      ..interceptors.addAll([
        AtgAuthInterceptor(sessions),
        const AtgEnvelopeInterceptor(),
      ]);
    accounts = AtgAccountService(atg, sessions);
  }

  final RouteAdapter adapter;
  final storage = MemorySecureStorageService();
  late final Dio firebase;
  late final Dio atg;
  late final AtgSessionService sessions;
  late final AtgAccountService accounts;

  /// Signs in without the OTP flow.
  void signIn({String uid = 'firebase-uid', String token = 'id-token'}) {
    sessions.session = AtgSession(
      idToken: token,
      refreshToken: 'refresh-token',
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
      uid: uid,
      phone: '+27820000000',
    );
  }

  Dio _dio(String baseUrl) => Dio(
    BaseOptions(baseUrl: baseUrl, responseType: ResponseType.plain),
  )..httpClientAdapter = adapter;
}
