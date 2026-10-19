// Gatepass — atg_session_service.dart. Created 2026-10-19.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../auth/models/data/atg_session.dart';
import '../../auth/models/dto/custom_token_exchange_dto.dart';
import '../../auth/models/dto/firebase_sign_in_response_dto.dart';
import '../../auth/models/dto/token_refresh_dto.dart';
import '../../auth/models/dto/token_refresh_response_dto.dart';
import '../configs/atg_config.dart';
import '../models/data/application_error.dart';
import '../utils/interceptors/atg_log_interceptor.dart';
import 'secure_storage_service.dart';

/// Owns the Firebase session behind every ATG request: restores it at
/// launch, exchanges a custom token at sign-in, and renews the ID token
/// before it expires.
///
/// The refresh token is a credential, so it lives in secure storage and is
/// never logged. It survives a relaunch so the resident isn't asked for
/// another code.
@lazySingleton
class AtgSessionService {
  AtgSessionService(this.storage, @Named('firebase') this.dio);

  final SecureStorageService storage;
  final Dio dio;

  static const sessionKey = 'atg.session';

  /// Where earlier builds kept the session, in plain JSON. Moved on restore.
  static final String legacySessionPath =
      '${Directory.systemTemp.path}/gatepass_session.json';

  AtgSession? session;
  Future<void>? _restoring;
  Future<String>? _refreshing;

  bool get isSignedIn => session != null;

  /// Loads the stored session once; later calls wait for the same load.
  Future<void> restore() => _restoring ??= _restore();

  /// A valid ID token, renewed first when it is near expiry. Concurrent
  /// callers share one refresh.
  Future<String> freshIdToken() async {
    await restore();
    final current = session;
    if (current == null) {
      throw const ApplicationError(code: ApplicationErrorCode.notSignedIn);
    }
    if (!current.isExpiredAt(DateTime.now())) return current.idToken;
    return _refreshing ??= refresh().whenComplete(() => _refreshing = null);
  }

  /// Renews the ID token with the refresh token and returns it.
  Future<String> refresh() async {
    final current = session;
    if (current == null) {
      throw const ApplicationError(code: ApplicationErrorCode.notSignedIn);
    }
    final response = await dio.post<Object?>(
      AtgConfig.secureTokenUrl,
      data: TokenRefreshDTO(refreshToken: current.refreshToken).toJson(),
      options: Options(extra: {AtgLogInterceptor.contextKey: 'firebase/token'}),
    );
    final dto = TokenRefreshResponseDTO.fromJson(_object(response.data));
    final renewed = current.copyWith(
      idToken: dto.idToken ?? current.idToken,
      refreshToken: dto.refreshToken ?? current.refreshToken,
      expiresAt: _expiry(dto.expiresIn),
      uid: dto.userId ?? current.uid,
    );
    session = renewed;
    await _persist();
    return renewed.idToken;
  }

  /// Exchanges the custom token `/open/login/check` returned for an ID token
  /// and stores the new session.
  Future<AtgSession> signInWithCustomToken(
    String customToken, {
    required String phone,
  }) async {
    final response = await dio.post<Object?>(
      AtgConfig.signInWithCustomTokenUrl,
      data: CustomTokenExchangeDTO(token: customToken).toJson(),
      options: Options(
        extra: {AtgLogInterceptor.contextKey: 'firebase/signInWithCustomToken'},
      ),
    );
    final dto = FirebaseSignInResponseDTO.fromJson(_object(response.data));
    final idToken = dto.idToken;
    final refreshToken = dto.refreshToken;
    if (idToken == null || refreshToken == null) {
      throw const ApplicationError(code: ApplicationErrorCode.server);
    }
    final created = AtgSession(
      idToken: idToken,
      refreshToken: refreshToken,
      expiresAt: _expiry(dto.expiresIn),
      uid: dto.localId ?? jwtSubject(idToken),
      phone: phone,
    );
    session = created;
    _restoring = Future.value();
    await _persist();
    return created;
  }

  Future<void> clear() async {
    session = null;
    _restoring = Future.value();
    try {
      await storage.delete(sessionKey);
    } on Object catch (e) {
      debugPrint('[ATG] could not clear session: $e');
    }
  }

  Future<void> _restore() async {
    try {
      var raw = await storage.read(sessionKey);
      final legacy = File(legacySessionPath);
      if (legacy.existsSync()) {
        raw ??= legacy.readAsStringSync();
        await storage.write(sessionKey, raw);
        legacy.deleteSync();
      }
      if (raw == null) return;
      final json = jsonDecode(raw);
      if (json is! Map) return;
      final refreshToken = json['refreshToken'];
      if (refreshToken is! String || refreshToken.isEmpty) return;
      session = AtgSession(
        idToken: json['idToken'] as String? ?? '',
        refreshToken: refreshToken,
        // Force a refresh on first use; the stored ID token has expired.
        expiresAt: DateTime.fromMillisecondsSinceEpoch(0),
        uid: json['uid'] as String?,
        phone: json['phone'] as String?,
      );
    } on Object catch (e) {
      debugPrint('[ATG] could not restore session: $e');
    }
  }

  Future<void> _persist() async {
    final current = session;
    if (current == null) return;
    try {
      await storage.write(sessionKey, jsonEncode(current.toJson()));
    } on Object catch (e) {
      debugPrint('[ATG] could not persist session: $e');
    }
  }

  /// Firebase's REST reply does not always carry `localId`, so read the
  /// subject from the ID token itself. This is not a verification step: the
  /// token just came from Firebase over TLS and is only used as our own uid.
  @visibleForTesting
  static String? jwtSubject(String token) {
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

  static Map<String, dynamic> _object(Object? data) {
    if (data is Map) return data.cast<String, dynamic>();
    throw const ApplicationError(code: ApplicationErrorCode.server);
  }

  static DateTime _expiry(String? expiresIn) {
    final seconds = int.tryParse(expiresIn ?? '') ?? 3600;
    return DateTime.now().add(Duration(seconds: seconds));
  }
}
