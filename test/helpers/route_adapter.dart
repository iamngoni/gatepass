//
//  Gatepass
//  route_adapter.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gatepass/core/services/secure_storage_service.dart';

/// A reply for one request: a status and a body (JSON-encoded unless it
/// is already a string).
typedef FakeReply = ({int status, Object? body});

/// One request as the adapter saw it.
typedef SeenRequest = ({
  String method,
  Uri uri,
  Map<String, dynamic> headers,
  String body,
});

/// Answers Dio requests from a table keyed `METHOD path`, recording each
/// request, so repositories run against the real interceptors without a
/// network.
class RouteAdapter implements HttpClientAdapter {
  RouteAdapter(this.routes);

  final Map<String, FakeReply Function(SeenRequest request)> routes;
  final requests = <SeenRequest>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final bytes = <int>[];
    if (requestStream != null) {
      await for (final chunk in requestStream) {
        bytes.addAll(chunk);
      }
    }
    final request = (
      method: options.method,
      uri: options.uri,
      headers: options.headers,
      body: utf8.decode(bytes),
    );
    requests.add(request);
    final route = routes['${options.method} ${options.uri.path}'];
    final reply = route == null
        ? (status: 404, body: 'no route')
        : route(request);
    final body = reply.body;
    final text = body is String ? body : jsonEncode(body);
    final isJson = body is! String || text.startsWith('{');
    return ResponseBody.fromString(
      text,
      reply.status,
      headers: {
        Headers.contentTypeHeader: [
          if (isJson) Headers.jsonContentType else Headers.textPlainContentType,
        ],
      },
    );
  }

  @override
  void close({bool force = false}) {}

  Iterable<SeenRequest> to(String path) =>
      requests.where((r) => r.uri.path == path);
}

/// In-memory secure storage.
class MemorySecureStorageService implements SecureStorageService {
  final values = <String, String>{};

  @override
  FlutterSecureStorage get storage => throw UnimplementedError();

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> delete(String key) async => values.remove(key);
}

/// A JWT-shaped token whose payload carries [sub].
String fakeJwt(String sub) {
  String part(Object json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  return '${part({'alg': 'none'})}.${part({'sub': sub})}.c2lnbmF0dXJlc2ln';
}
