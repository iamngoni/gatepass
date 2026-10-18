import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/data/atg/atg_client.dart';

void main() {
  test(
    'request and response logs never expose credentials or phone numbers',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final requestHandled = Completer<void>();
      server.listen((request) async {
        await request.drain<void>();
        request.response.headers.contentType = ContentType.json;
        request.response.write(
          jsonEncode({
            'access_token': 'access-token-value',
            'refresh_token': 'refresh-token-value',
            'contact': '+27831234567',
            'profile': {'name': 'Resident'},
          }),
        );
        await request.response.close();
        requestHandled.complete();
      });

      final logs = <String>[];
      final previousDebugPrint = debugPrint;
      debugPrint = (String? message, {int? wrapWidth}) {
        if (message != null) logs.add(message);
      };

      try {
        final http = AtgHttp();
        await http.send(
          'POST',
          Uri.parse('http://127.0.0.1:${server.port}/session'),
          jsonBody: {
            'refreshToken': 'refresh-token-value',
            'id_token': 'id-token-value',
            'contact': '+27831234567',
          },
          context: 'redaction-test',
        );
        http.close();
        await requestHandled.future;
      } finally {
        debugPrint = previousDebugPrint;
        await server.close(force: true);
      }

      final output = logs.join('\n');
      expect(output, contains('«redacted»'));
      expect(output, contains('«phone»'));
      for (final secret in [
        'refresh-token-value',
        'id-token-value',
        'access-token-value',
        '+27831234567',
      ]) {
        expect(output, isNot(contains(secret)));
      }
    },
  );
}
