//
//  Gatepass
//  secure_storage_service.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// The Keychain (iOS) or Keystore-backed storage (Android), for credentials
/// and the resident's records. Uses the plugin's default options: existing
/// installs stored their data under them, so they must not change.
@lazySingleton
class SecureStorageService {
  SecureStorageService(this.storage);

  final FlutterSecureStorage storage;

  Future<String?> read(String key) => storage.read(key: key);

  Future<void> write(String key, String value) =>
      storage.write(key: key, value: value);

  Future<void> delete(String key) => storage.delete(key: key);
}
