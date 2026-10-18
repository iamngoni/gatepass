import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
/// Logs are redacted: anything that looks like a JWT is masked, so the console
/// shows the shape of a response (the key names we need) without leaking the
/// user's live tokens.
class AtgHttp {
  AtgHttp({HttpClient? client}) : _client = client ?? HttpClient();

  final HttpClient _client;

  static final _jwt = RegExp(
    r'[A-Za-z0-9_-]{16,}\.[A-Za-z0-9_-]{16,}\.[A-Za-z0-9_-]{8,}',
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
          .map((e) =>
              '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}')
          .join('&');
      req.headers.contentType =
          ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8');
      req.write(sent);
    } else if (jsonBody != null) {
      sent = jsonEncode(jsonBody);
      req.headers.contentType = ContentType.json;
      req.write(sent);
    }
    _log('→ $method ${url.path.isEmpty ? url : url.path}', context, sent,
        headers: headers);

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

  String _redact(String s) => s.replaceAll(_jwt, '«jwt»');
}

/// A signed-in session: the Firebase ID token the ATG API wants, plus the
/// refresh token to renew it.
class AtgSession {
  AtgSession({
    required this.idToken,
    required this.refreshToken,
    required this.expiresAt,
    this.uid,
  });

  String idToken;
  String refreshToken;
  DateTime expiresAt;
  String? uid;

  bool get isExpired =>
      DateTime.now().isAfter(expiresAt.subtract(const Duration(seconds: 30)));
}

/// The two-step OTP sign-in and the Firebase custom-token → ID-token exchange.
///
/// Flow (recovered from the app):
///  1. POST /open/login/start  { mobile }                 → sends the SMS code
///  2. POST /open/login/check  { mobile, code }           → a Firebase custom token
///  3. identitytoolkit signInWithCustomToken              → idToken + refreshToken
///  4. securetoken /v1/token (refresh_token grant)        → renew idToken
class AtgAuth {
  AtgAuth(this._http);

  final AtgHttp _http;
  AtgSession? session;

  /// From /open/login/start: the attempt id and the server's normalised login
  /// type ('phone'), both sent back to /open/login/check.
  String? _loginAttempt;
  String? _serverLoginType;

  bool get isSignedIn => session != null;

  Future<void> startLogin(String phoneE164) async {
    final res = await _http.send(
      'POST',
      Uri.parse('${AtgConfig.apiBase}${AtgConfig.loginStartPath}'),
      jsonBody: {
        AtgConfig.fLoginString: phoneE164,
        AtgConfig.fLoginType: AtgConfig.loginTypeMobile,
        AtgConfig.fChannel: AtgConfig.loginChannelSms,
      },
      context: 'login/start',
    );
    if (res is Map) {
      _loginAttempt = res['loginAttempt'] as String?;
      _serverLoginType = res['loginType'] as String?;
    }
  }

  /// Verifies the OTP and, on success, signs in to Firebase so [session] holds
  /// a usable ID token.
  Future<void> verifyAndExchange(String phoneE164, String code) async {
    final loginType = _serverLoginType ?? AtgConfig.loginTypeMobile;
    // OPEN PROBLEM — /open/login/check body structure.
    // Confirmed by live responses: the server Gson-parses a JSON OBJECT body
    // (a form body throws "Expected BEGIN_OBJECT but was STRING"), but every
    // flat shape we tried — {loginString}, {phoneNumber}, with code/smsCode,
    // with loginAttempt, even all at once, and with query params — returns
    // {"error":"Phone number or code missing"}. So the phone+code sit under a
    // nesting or exact @SerializedName we can't recover by guessing.
    // Resolve from a Blutter decompile (needs an arm64 build of the APK) or a
    // real request capture, then correct this body. Guessing further just
    // spams OTPs and ATG's server, so we stop here.
    final res = await _http.send(
      'POST',
      Uri.parse('${AtgConfig.apiBase}${AtgConfig.loginCheckPath}'),
      jsonBody: {
        'phoneNumber': phoneE164,
        AtgConfig.fLoginString: phoneE164,
        AtgConfig.fLoginType: loginType,
        'code': code,
        AtgConfig.fSmsCode: code,
        AtgConfig.fLoginAttempt: ?_loginAttempt,
      },
      context: 'login/check',
    );
    final customToken = _findCustomToken(res);
    if (customToken == null) {
      throw AtgException(
        'No custom token found in the login response. Read the logged JSON '
        'and add its token key to AtgConfig.customTokenKeys.',
      );
    }
    await _exchangeCustomToken(customToken);
  }

  /// Renews [session] with the refresh token. Called automatically before an
  /// authed request when the ID token is near expiry.
  Future<void> refresh() async {
    final s = session;
    if (s == null) throw AtgException('Not signed in');
    final res = await _http.send(
      'POST',
      Uri.parse(AtgConfig.secureTokenUrl),
      jsonBody: {'grant_type': 'refresh_token', 'refresh_token': s.refreshToken},
      context: 'firebase/token',
    );
    final map = _asMap(res);
    s.idToken = (map['id_token'] ?? map['access_token']) as String? ?? s.idToken;
    s.refreshToken = map['refresh_token'] as String? ?? s.refreshToken;
    s.expiresAt = _expiry(map['expires_in']);
    s.uid = map['user_id'] as String? ?? s.uid;
  }

  void signOut() => session = null;

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
      uid: map['localId'] as String?,
    );
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
          final isTokenKey =
              AtgConfig.customTokenKeys.contains(key.toString());
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

  static Map<String, dynamic> _asMap(dynamic json) {
    if (json is Map<String, dynamic>) return json;
    throw AtgException('Expected a JSON object, got ${json.runtimeType}.');
  }

  static DateTime _expiry(Object? expiresIn) {
    final seconds = int.tryParse('${expiresIn ?? ''}') ?? 3600;
    return DateTime.now().add(Duration(seconds: seconds));
  }
}
