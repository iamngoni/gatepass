// Gatepass — device_id_service.dart. Created 2026-10-18.
import 'dart:io';
import 'dart:math';

import 'package:injectable/injectable.dart';

/// A stable per-install id. ATG's OTP flow pairs start and check through it
/// and records the device. Kept in the app's temp directory, where earlier
/// builds stored it, so an update keeps the same id.
@lazySingleton
class DeviceIdService {
  DeviceIdService() : deviceId = _load();

  final String deviceId;

  static String _load() {
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
    final r = Random.secure();
    final b = List<int>.generate(16, (_) => r.nextInt(256));
    b[6] = (b[6] & 0x0f) | 0x40;
    b[8] = (b[8] & 0x3f) | 0x80;
    String hex(int from, int to) => [
      for (var i = from; i < to; i++) b[i].toRadixString(16).padLeft(2, '0'),
    ].join();
    return '${hex(0, 4)}-${hex(4, 6)}-${hex(6, 8)}-${hex(8, 10)}-'
        '${hex(10, 16)}';
  }
}
