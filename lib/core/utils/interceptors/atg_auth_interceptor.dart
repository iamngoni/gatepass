// Gatepass — atg_auth_interceptor.dart. Created 2026-10-19.
import 'package:dio/dio.dart';

import '../../configs/atg_config.dart';
import '../../services/atg_session_service.dart';
import 'atg_log_interceptor.dart';

/// Adds the resident's Firebase ID token to ATG requests that need it,
/// renewing the token first when it is near expiry. Queued, so concurrent
/// requests wait for one refresh instead of each starting their own.
class AtgAuthInterceptor extends QueuedInterceptor {
  AtgAuthInterceptor(this.sessions);

  final AtgSessionService sessions;

  /// Set to `true` in a request's `extra` to send it signed in.
  static const authKey = 'atgAuth';

  /// Options for a signed-in ATG request, logged under [context].
  static Options authed(String context, {String? contentType}) => Options(
    contentType: contentType,
    extra: {authKey: true, AtgLogInterceptor.contextKey: context},
  );

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[authKey] != true) {
      handler.next(options);
      return;
    }
    try {
      options.headers[AtgConfig.authHeader] = await sessions.freshIdToken();
      handler.next(options);
    } on DioException catch (error) {
      // A failed refresh keeps its own cause, e.g. a revoked refresh token.
      handler.reject(error.copyWith(requestOptions: options));
    } on Object catch (error, stackTrace) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
