// Gatepass — atg_redaction_test.dart. Created 2026-10-19.
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/core/configs/atg_config.dart';
import 'package:gatepass/core/utils/interceptors/atg_envelope_interceptor.dart';
import 'package:gatepass/core/utils/interceptors/atg_log_interceptor.dart';

import '../helpers/route_adapter.dart';

void main() {
  test(
    'request and response logs never expose credentials or phone numbers',
    () async {
      final dio = Dio(BaseOptions(responseType: ResponseType.plain))
        ..httpClientAdapter = RouteAdapter({
          'POST /session': (_) => (
            status: 200,
            body: {
              'access_token': 'access-token-value',
              'refresh_token': 'refresh-token-value',
              'hostSharedKey': 'host-shared-key-value',
              'id': 'uid1+27831234567',
              'contact': '+27831234567',
              'profile': {'name': 'Resident'},
            },
          ),
          'POST /form': (_) => (status: 200, body: ''),
        })
        ..interceptors.addAll([
          const AtgLogInterceptor(),
          const AtgEnvelopeInterceptor(),
        ]);

      final logs = <String>[];
      final previousDebugPrint = debugPrint;
      debugPrint = (String? message, {int? wrapWidth}) {
        if (message != null) logs.add(message);
      };
      try {
        await dio.post<Object?>(
          'http://atg.test/session',
          data: jsonEncode({
            'refreshToken': 'refresh-token-value',
            'id_token': 'id-token-value',
            'hostSharedKey': 'host-shared-key-value',
            'sharedKey': 'shared-key-value',
            'contact': '+27831234567',
          }),
          options: Options(
            headers: {AtgConfig.authHeader: 'id-token-value'},
            extra: {AtgLogInterceptor.contextKey: 'redaction-test'},
          ),
        );
        await dio.post<Object?>(
          'http://atg.test/form',
          data: 'loginString=%2B27831234567&token=refresh-token-value',
        );
      } finally {
        debugPrint = previousDebugPrint;
      }

      final output = logs.join('\n');
      expect(output, contains('[ATG redaction-test]'));
      expect(output, contains('«redacted»'));
      expect(output, contains('«phone»'));
      for (final secret in [
        'refresh-token-value',
        'id-token-value',
        'access-token-value',
        'host-shared-key-value',
        'shared-key-value',
        '+27831234567',
        '%2B27831234567',
      ]) {
        expect(output, isNot(contains(secret)));
      }
    },
  );
}
