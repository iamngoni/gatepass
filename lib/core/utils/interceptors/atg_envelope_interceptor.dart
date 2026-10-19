// Gatepass — atg_envelope_interceptor.dart. Created 2026-10-19.
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/data/application_error.dart';

/// Decodes ATG's text bodies and surfaces its own error replies.
///
/// ATG returns some failures as HTTP 200 with `{"error": "..."}`; those, and
/// non-2xx replies carrying the same envelope, become an [ApplicationError]
/// with ATG's text, which is written for the resident. Non-JSON bodies are
/// passed on as text.
class AtgEnvelopeInterceptor extends Interceptor {
  const AtgEnvelopeInterceptor();

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final decoded = _decode(response.data);
    final atgError = _atgError(decoded);
    if (atgError != null) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: atgError,
        ),
      );
      return;
    }
    handler.next(response..data = decoded);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final atgError = _atgError(_decode(err.response?.data));
    if (atgError != null && err.error is! ApplicationError) {
      handler.next(err.copyWith(error: atgError));
      return;
    }
    handler.next(err);
  }

  static Object? _decode(Object? data) {
    if (data is! String) return data;
    if (data.isEmpty) return null;
    try {
      return jsonDecode(data);
    } on FormatException {
      return data;
    }
  }

  static ApplicationError? _atgError(Object? decoded) {
    if (decoded is! Map) return null;
    final error = decoded['error'];
    if (error is! String || error.isEmpty) return null;
    return ApplicationError(code: ApplicationErrorCode.atg, message: error);
  }
}
