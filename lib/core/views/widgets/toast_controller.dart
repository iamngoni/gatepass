//
//  Gatepass
//  toast_controller.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'toast.dart';

/// Holds the visible message and the timer that hides it.
class ToastController extends ChangeNotifier {
  ToastMessage? _current;
  Timer? _timer;

  ToastMessage? get current => _current;

  void show(ToastMessage message) {
    final same =
        _current?.text == message.text && _current?.tone == message.tone;
    if (!same) {
      _current = message;
      notifyListeners();
    }
    _timer?.cancel();
    _timer = Timer(switch (message.tone) {
      ToastTone.success => const Duration(milliseconds: 2400),
      ToastTone.info => const Duration(milliseconds: 3200),
      ToastTone.error => const Duration(milliseconds: 5000),
    }, hide);
  }

  void hide() {
    _timer?.cancel();
    if (_current == null) return;
    _current = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
