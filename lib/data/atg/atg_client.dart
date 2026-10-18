import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'atg_config.dart';

/// Any failure from the ATG backend or the Firebase token exchange.
class AtgException implements Exception {
  AtgException(this.message, {this.statusCode, this.body});

  final String message;
  final int? statusCode;
  final String? body;

  @override
  String toString() =>
      'AtgException(${statusCode ?? '-'}): $message'
      '${body == null ? '' : '\n$body'}';
}

/// Thin JSON-over-HTTP helper on `dart:io`, so the app needs no new package.
/// Logs are redacted before they reach the console: credential fields, phone
/// numbers, JWTs and long opaque tokens are masked while the response's shape
/// (its key names and non-sensitive values) stays readable.
class AtgHttp {
  AtgHttp({HttpClient? client}) : _client = client ?? HttpClient();

  final HttpClient _client;

  static final _jwt = RegExp(
    r'[A-Za-z0-9_-]{16,}\.[A-Za-z0-9_-]{16,}\.[A-Za-z0-9_-]{8,}',
  );
  static final _opaqueCredential = RegExp(r'[A-Za-z0-9_-]{80,}');
  // No lookbehind: ATG builds account ids by appending the phone number to the
  // uid (`<uid>+27831234567`), so a digit often precedes the `+`.
  static final _e164Phone = RegExp(r'\+[1-9][0-9]{7,14}(?![0-9])');
  static final _credentialKeyFallback = RegExp(
    r'("(?:refreshToken|refresh_token|idToken|id_token|access_token|token|customToken|custom_token)"\s*:\s*")[^"]*(")',
    caseSensitive: false,
  );

  Future<dynamic> send(
    String method,
    Uri url, {
    Map<String, String> headers = const {},
    Object? jsonBody,
    Map<String, String>? formBody,
    String context = '',
  }) async {
    final req = await _client.openUrl(method, url);
    req.headers.set(HttpHeaders.acceptHeader, 'application/json');
    headers.forEach(req.headers.set);

    String? sent;
    if (formBody != null) {
      // application/x-www-form-urlencoded. encodeQueryComponent escapes '+' as
      // %2B, so an E.164 number survives (a raw '+' would be read as a space).
      sent = formBody.entries
          .map(
            (e) =>
                '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}',
          )
          .join('&');
      req.headers.contentType = ContentType(
        'application',
        'x-www-form-urlencoded',
        charset: 'utf-8',
      );
      req.write(sent);
    } else if (jsonBody != null) {
      sent = jsonEncode(jsonBody);
      req.headers.contentType = ContentType.json;
      req.write(sent);
    }
    final shown = url.hasQuery ? '${url.path}?${url.query}' : url.path;
    _log(
      '→ $method ${shown.isEmpty ? url : shown}',
      context,
      sent,
      headers: headers,
    );

    final res = await req.close();
    final text = await res.transform(utf8.decoder).join();
    _log('← ${res.statusCode}', context, text);

    final ok = res.statusCode >= 200 && res.statusCode < 300;
    if (!ok) {
      throw AtgException(
        'HTTP ${res.statusCode} on ${context.isEmpty ? url.path : context}',
        statusCode: res.statusCode,
        body: _redact(text),
      );
    }
    if (text.isEmpty) return null;
    dynamic decoded;
    try {
      decoded = jsonDecode(text);
    } catch (_) {
      return text; // non-JSON body; the caller can decide what to do
    }
    // ATG returns some failures as HTTP 200 with an {"error": "..."} body.
    if (decoded is Map &&
        decoded['error'] is String &&
        (decoded['error'] as String).isNotEmpty) {
      throw AtgException(
        decoded['error'] as String,
        statusCode: res.statusCode,
        body: _redact(text),
      );
    }
    return decoded;
  }

  void close() => _client.close(force: true);

  // --- logging / redaction ---

  void _log(
    String line,
    String context,
    String? payload, {
    Map<String, String> headers = const {},
  }) {
    if (!AtgConfig.debugLog) return;
    final tag = context.isEmpty ? '[ATG]' : '[ATG $context]';
    final hdr = headers.containsKey(AtgConfig.authHeader)
        ? ' (${AtgConfig.authHeader}: «redacted»)'
        : '';
    debugPrint('$tag $line$hdr');
    if (payload != null && payload.isNotEmpty) {
      debugPrint(_redact(payload));
    }
  }

  String _redact(String s) {
    final trimmed = s.trim();
    if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
      try {
        return jsonEncode(_redactValue(jsonDecode(trimmed)));
      } on FormatException {
        // Fall through to text/form redaction for malformed JSON.
      }
    }

    // Form bodies and query strings: mask by field name.
    if (s.contains('=') && !s.contains(' ')) {
      final parts = s.split('&');
      if (parts.every((part) => part.contains('='))) {
        return parts
            .map((part) {
              final i = part.indexOf('=');
              if (i < 0) return _redactText(part);
              final key = part.substring(0, i);
              if (_isCredentialKey(key)) return '$key=«redacted»';
              if (_isPhoneKey(key)) return '$key=«phone»';
              return '$key=${_redactText(part.substring(i + 1))}';
            })
            .join('&');
      }
    }

    return _redactText(s).replaceAllMapped(
      _credentialKeyFallback,
      (m) => '${m[1]}«redacted»${m[2]}',
    );
  }

  dynamic _redactValue(dynamic node) {
    if (node is Map) {
      return {
        for (final entry in node.entries)
          entry.key.toString(): _isCredentialKey(entry.key.toString())
              ? '«redacted»'
              : _isPhoneKey(entry.key.toString())
              ? '«phone»'
              : _redactValue(entry.value),
      };
    }
    if (node is List) return node.map(_redactValue).toList();
    if (node is String) return _redactText(node);
    return node;
  }

  String _redactText(String value) => value
      .replaceAll(_jwt, '«jwt»')
      .replaceAll(_opaqueCredential, '«token»')
      .replaceAll(_e164Phone, '«phone»');

  static bool _isCredentialKey(String key) {
    const names = {
      'authorization',
      'cookie',
      'setcookie',
      'token',
      'customtoken',
      'authtoken',
      'firebasetoken',
      'idtoken',
      'accesstoken',
      'refreshtoken',
      'bearertoken',
      'sessiontoken',
      'securitytoken',
      'xidtoken',
      'apikey',
      'hostsharedkey',
      'sharedkey',
    };
    return names.contains(_normalizeKey(key));
  }

  static bool _isPhoneKey(String key) {
    const names = {
      'loginstring',
      'contact',
      'mobile',
      'phone',
      'phonenumber',
      'msisdn',
    };
    return names.contains(_normalizeKey(key));
  }

  static String _normalizeKey(String key) =>
      key.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toLowerCase();
}

/// A signed-in session: the Firebase ID token the ATG API wants, plus the
/// refresh token to renew it.
class AtgSession {
  AtgSession({
    required this.idToken,
    required this.refreshToken,
    required this.expiresAt,
    this.uid,
    this.phone,
  });

  String idToken;
  String refreshToken;
  DateTime expiresAt;
  String? uid;
  String? phone;

  bool get isExpired =>
      DateTime.now().isAfter(expiresAt.subtract(const Duration(seconds: 30)));
}

/// The two-step OTP sign-in and the Firebase custom-token → ID-token exchange.
///
/// Flow (recovered verbatim from ATG's web client):
///  1. POST /open/login/start  {loginString, channel, deviceId, …} → SMS code
///  2. POST /open/login/check  {contact, code, deviceId, …}       → custom token
///  3. identitytoolkit signInWithCustomToken              → idToken + refreshToken
///  4. securetoken /v1/token (refresh_token grant)        → renew idToken
class AtgAuth {
  AtgAuth(this._http) {
    _restore();
  }

  final AtgHttp _http;
  AtgSession? session;

  /// The Firebase refresh token is kept in the app sandbox so a relaunch (or a
  /// debug hot restart) doesn't force another SMS. It is a credential: the
  /// directory is private to the app, and nothing here is ever logged.
  static final String _sessionPath =
      '${Directory.systemTemp.path}/gatepass_session.json';

  /// Stable per-install id. The OTP flow pairs start/check through this and the
  /// backend records the device; persisting it in the app's temp directory
  /// keeps it across relaunches without adding a storage plugin.
  static final String _deviceId = _loadDeviceId();

  bool get isSignedIn => session != null;

  /// Sends the OTP. The body is ATG's own web-client shape: `loginString` and
  /// `channel` carry the identity, with device/app metadata alongside.
  Future<void> startLogin(String phoneE164) async {
    await _http.send(
      'POST',
      Uri.parse('${AtgConfig.apiBase}${AtgConfig.loginStartPath}'),
      jsonBody: {
        AtgConfig.fLoginString: phoneE164,
        AtgConfig.fChannel: AtgConfig.loginChannelSms,
        AtgConfig.fDeviceId: _deviceId,
        AtgConfig.fAppVersion: AtgConfig.appVersion,
        AtgConfig.fAppBuildNumber: AtgConfig.appBuildNumber,
        AtgConfig.fPlatform: AtgConfig.platform,
      },
      context: 'login/start',
    );
  }

  /// Verifies the OTP and exchanges the returned Firebase custom token for an
  /// ID token. The check body is the web client's exact shape
  /// `{contact, code, deviceId, appVersion, appBuildNumber, platform}`.
  /// Confirmed live: it gets past "Phone number or code missing".
  Future<void> verifyAndExchange(String phoneE164, String code) async {
    final res = await _http.send(
      'POST',
      Uri.parse('${AtgConfig.apiBase}${AtgConfig.loginCheckPath}'),
      jsonBody: {
        AtgConfig.fContact: phoneE164,
        AtgConfig.fCode: code,
        AtgConfig.fDeviceId: _deviceId,
        AtgConfig.fAppVersion: AtgConfig.appVersion,
        AtgConfig.fAppBuildNumber: AtgConfig.appBuildNumber,
        AtgConfig.fPlatform: AtgConfig.platform,
      },
      context: 'login/check',
    );
    final customToken =
        (res is Map ? res[AtgConfig.customTokenKeys.first] : null) as String? ??
        _findCustomToken(res);
    if (customToken == null) {
      throw AtgException(
        'No custom token found in the login response. Read the logged JSON '
        'and add its token key to AtgConfig.customTokenKeys.',
      );
    }
    await _exchangeCustomToken(customToken);
    session?.phone = phoneE164;
    _persist();
  }

  /// Renews [session] with the refresh token. Called automatically before an
  /// authed request when the ID token is near expiry.
  Future<void> refresh() async {
    final s = session;
    if (s == null) throw AtgException('Not signed in');
    final res = await _http.send(
      'POST',
      Uri.parse(AtgConfig.secureTokenUrl),
      jsonBody: {
        'grant_type': 'refresh_token',
        'refresh_token': s.refreshToken,
      },
      context: 'firebase/token',
    );
    final map = _asMap(res);
    s.idToken =
        (map['id_token'] ?? map['access_token']) as String? ?? s.idToken;
    s.refreshToken = map['refresh_token'] as String? ?? s.refreshToken;
    s.expiresAt = _expiry(map['expires_in']);
    s.uid = map['user_id'] as String? ?? s.uid;
    _persist();
  }

  void signOut() {
    session = null;
    try {
      final f = File(_sessionPath);
      if (f.existsSync()) f.deleteSync();
    } on Object {
      // Nothing to clean up.
    }
  }

  Future<void> _exchangeCustomToken(String customToken) async {
    final res = await _http.send(
      'POST',
      Uri.parse(AtgConfig.signInWithCustomTokenUrl),
      jsonBody: {'token': customToken, 'returnSecureToken': true},
      context: 'firebase/signInWithCustomToken',
    );
    final map = _asMap(res);
    final idToken = map['idToken'] as String?;
    final refreshToken = map['refreshToken'] as String?;
    if (idToken == null || refreshToken == null) {
      throw AtgException('Firebase did not return an ID token.');
    }
    session = AtgSession(
      idToken: idToken,
      refreshToken: refreshToken,
      expiresAt: _expiry(map['expiresIn']),
      uid: map['localId'] as String? ?? _jwtSubject(idToken),
    );
    _persist();
  }

  /// Deep-searches the login response for one of [AtgConfig.customTokenKeys]
  /// whose value looks like a JWT, so a nested or renamed envelope still works.
  String? _findCustomToken(dynamic json) {
    String? found;
    void walk(dynamic node) {
      if (found != null) return;
      if (node is Map) {
        node.forEach((key, value) {
          if (found != null) return;
          final isTokenKey = AtgConfig.customTokenKeys.contains(key.toString());
          if (isTokenKey && value is String && value.split('.').length >= 2) {
            found = value;
          } else {
            walk(value);
          }
        });
      } else if (node is List) {
        node.forEach(walk);
      }
    }

    walk(json);
    return found;
  }

  void _restore() {
    try {
      final f = File(_sessionPath);
      if (!f.existsSync()) return;
      final map = jsonDecode(f.readAsStringSync());
      if (map is! Map) return;
      final refreshToken = map['refreshToken'] as String?;
      if (refreshToken == null || refreshToken.isEmpty) return;
      session = AtgSession(
        idToken: map['idToken'] as String? ?? '',
        refreshToken: refreshToken,
        // Force a refresh on first use; the stored ID token has expired.
        expiresAt: DateTime.fromMillisecondsSinceEpoch(0),
        uid: map['uid'] as String?,
        phone: map['phone'] as String?,
      );
    } on Object catch (e) {
      debugPrint('[ATG] could not restore session: $e');
    }
  }

  void _persist() {
    final s = session;
    if (s == null) return;
    try {
      File(_sessionPath).writeAsStringSync(
        jsonEncode({
          'idToken': s.idToken,
          'refreshToken': s.refreshToken,
          'expiresAt': s.expiresAt.millisecondsSinceEpoch,
          'uid': s.uid,
          'phone': s.phone,
        }),
      );
    } on Object catch (e) {
      debugPrint('[ATG] could not persist session: $e');
    }
  }

  /// Firebase's REST response does not always carry `localId`, so read the
  /// subject from the ID token itself. This is not a verification step: the
  /// token just came from Firebase over TLS and is only used as our own uid.
  static String? _jwtSubject(String token) {
    try {
      final parts = token.split('.');
      if (parts.length < 2) return null;
      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final json = jsonDecode(payload);
      if (json is Map) {
        return (json['user_id'] ?? json['sub']) as String?;
      }
    } on Object {
      // Fall through to null.
    }
    return null;
  }

  static Map<String, dynamic> _asMap(dynamic json) {
    if (json is Map<String, dynamic>) return json;
    throw AtgException('Expected a JSON object, got ${json.runtimeType}.');
  }

  static DateTime _expiry(Object? expiresIn) {
    final seconds = int.tryParse('${expiresIn ?? ''}') ?? 3600;
    return DateTime.now().add(Duration(seconds: seconds));
  }

  static String _loadDeviceId() {
    final file = File('${Directory.systemTemp.path}/gatepass_device_id');
    try {
      if (file.existsSync()) {
        final saved = file.readAsStringSync().trim();
        if (saved.isNotEmpty) return saved;
      }
      final id = _uuid4();
      file.writeAsStringSync(id);
      return id;
    } on FileSystemException {
      return _uuid4();
    }
  }

  static String _uuid4() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40; // version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80; // RFC 4122 variant
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
