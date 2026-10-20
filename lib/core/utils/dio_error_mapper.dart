//
//  Gatepass
//  dio_error_mapper.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/data/application_error.dart';

/// Turns a failed request into an [ApplicationError], logging the technical
/// cause so it never has to be shown to the resident.
abstract final class DioErrorMapper {
  static ApplicationError map(
    Object error,
    StackTrace stackTrace, {
    String context = '',
  }) {
    if (error is DioException) {
      final inner = error.error;
      if (inner is ApplicationError) return inner;
      debugPrint('[Gatepass] $context failed: ${error.type} ${error.message}');
      return switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.transformTimeout => const ApplicationError(
          code: ApplicationErrorCode.timeout,
        ),
        DioExceptionType.connectionError => const ApplicationError(
          code: ApplicationErrorCode.connection,
        ),
        DioExceptionType.badResponse => _badResponse(error.response),
        DioExceptionType.badCertificate ||
        DioExceptionType.cancel ||
        DioExceptionType.unknown => const ApplicationError(
          code: ApplicationErrorCode.connection,
        ),
      };
    }
    if (error is ApplicationError) return error;
    debugPrint('[Gatepass] $context failed: $error\n$stackTrace');
    return const ApplicationError(code: ApplicationErrorCode.unknown);
  }

  static ApplicationError _badResponse(Response<Object?>? response) {
    final status = response?.statusCode ?? 0;
    if (status == 401 || status == 403) {
      return const ApplicationError(code: ApplicationErrorCode.notSignedIn);
    }
    return const ApplicationError(code: ApplicationErrorCode.server);
  }
}
