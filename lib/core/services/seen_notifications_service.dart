//
//  Gatepass
//  seen_notifications_service.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Which notifications the resident has seen. ATG keeps no read state the
/// app can write, so the ids live in a file in the app's temp directory,
/// where earlier builds kept them.
@lazySingleton
class SeenNotificationsService {
  SeenNotificationsService()
    : file = File(
        '${Directory.systemTemp.path}/gatepass_notifications_seen.json',
      );

  @visibleForTesting
  SeenNotificationsService.at(this.file);

  final File file;

  /// The archive can grow forever; the most recent ids kept.
  static const limit = 1000;

  Set<String>? _seen;
  bool _seeded = false;

  /// False until the first save, so the first fetch can treat ATG's existing
  /// archive as history instead of fifty new notifications.
  bool get hasBaseline => _seeded || file.existsSync();

  Set<String> load() {
    final cached = _seen;
    if (cached != null) return cached;
    final seen = <String>{};
    try {
      if (file.existsSync()) {
        final decoded = jsonDecode(file.readAsStringSync());
        if (decoded is List) seen.addAll(decoded.whereType<String>());
      }
    } on Object catch (e) {
      debugPrint('[ATG] could not read notification state: $e');
    }
    return _seen = seen;
  }

  void add(Iterable<String> ids) {
    _seeded = true;
    load().addAll(ids);
    try {
      final all = load().toList();
      final kept = all.length > limit ? all.sublist(all.length - limit) : all;
      file.writeAsStringSync(jsonEncode(kept));
    } on Object catch (e) {
      debugPrint('[ATG] could not save notification state: $e');
    }
  }
}
