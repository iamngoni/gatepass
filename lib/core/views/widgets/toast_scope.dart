//
//  Gatepass
//  toast_scope.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import 'toast_controller.dart';

/// Hands the host's controller to `Toast.show` anywhere below it.
class ToastScope extends InheritedWidget {
  const ToastScope({
    required this.controller,
    required super.child,
    super.key,
  });

  final ToastController controller;

  @override
  bool updateShouldNotify(ToastScope oldWidget) =>
      oldWidget.controller != controller;
}
