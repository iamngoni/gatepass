// Gatepass — toast_scope.dart. Created 2026-10-18.
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
