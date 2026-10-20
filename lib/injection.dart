//
//  Gatepass
//  injection.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'backup/models/data/kdf_params.dart';
import 'core/configs/atg_config.dart';
import 'core/services/atg_session_service.dart';
import 'core/utils/interceptors/atg_auth_interceptor.dart';
import 'core/utils/interceptors/atg_envelope_interceptor.dart';
import 'core/utils/interceptors/atg_log_interceptor.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
void configureDependencies() => getIt.init();

@module
abstract class ServiceModule {
  /// Default options: existing installs stored their data under them.
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  AssetBundle get assetBundle => rootBundle;

  @lazySingleton
  KdfParams get kdfParams => const KdfParams();

  /// The ATG API. Bodies arrive as text so [AtgEnvelopeInterceptor] can
  /// decode them and surface ATG's `{"error": ...}` replies.
  @Named('atg')
  @lazySingleton
  Dio atgDio(AtgSessionService sessions) =>
      _textDio(AtgConfig.apiBase)
        ..interceptors.addAll([
          AtgAuthInterceptor(sessions),
          const AtgLogInterceptor(),
          const AtgEnvelopeInterceptor(),
        ]);

  /// Google's Identity Toolkit and Secure Token endpoints, by full URL.
  @Named('firebase')
  @lazySingleton
  Dio get firebaseDio => _textDio('')
    ..interceptors.addAll([
      const AtgLogInterceptor(),
      const AtgEnvelopeInterceptor(),
    ]);

  /// The Gatepass backup Worker. Its statuses are handled by the
  /// repository, so it never throws on non-2xx.
  @Named('backup')
  @lazySingleton
  Dio get backupDio => Dio(
    BaseOptions(
      baseUrl: 'https://gatepass.antonlabs.cc',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
    ),
  );

  static Dio _textDio(String baseUrl) => Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      responseType: ResponseType.plain,
      contentType: 'application/json; charset=utf-8',
      headers: {'accept': 'application/json'},
    ),
  );
}
