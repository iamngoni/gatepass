//
//  Gatepass
//  atg_log_interceptor.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../configs/atg_config.dart';
import '../atg_redactor.dart';

/// Logs ATG and Firebase traffic for schema discovery, redacted: credential
/// fields, phone numbers, JWTs and long opaque tokens never reach the console.
class AtgLogInterceptor extends Interceptor {
  const AtgLogInterceptor();

  /// The short name a request is logged under, e.g. `invites`.
  static const contextKey = 'atgContext';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final uri = options.uri;
    final shown = uri.hasQuery ? '${uri.path}?${uri.query}' : uri.path;
    final auth = options.headers.containsKey(AtgConfig.authHeader)
        ? ' (${AtgConfig.authHeader}: «redacted»)'
        : '';
    _log(options, '→ ${options.method} $shown$auth', _payload(options.data));
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _log(
      response.requestOptions,
      '← ${response.statusCode}',
      _payload(response.data),
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      _log(
        err.requestOptions,
        '← ${response.statusCode}',
        _payload(response.data),
      );
    }
    handler.next(err);
  }

  static void _log(RequestOptions options, String line, String? payload) {
    if (!AtgConfig.debugLog) return;
    final context = options.extra[contextKey] as String? ?? '';
    final tag = context.isEmpty ? '[ATG]' : '[ATG $context]';
    debugPrint('$tag $line');
    if (payload != null && payload.isNotEmpty) {
      debugPrint(AtgRedactor.redact(payload));
    }
  }

  static String? _payload(Object? data) => switch (data) {
    null => null,
    final String text => text,
    final Map<dynamic, dynamic> map => jsonEncode(map),
    final List<dynamic> list => jsonEncode(list),
    _ => data.toString(),
  };
}
