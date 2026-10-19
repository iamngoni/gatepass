// Gatepass — toast.dart. Created 2026-10-18.
// One host for transient messages, in place of SnackBar: one visible message
// at a time, repeats coalesce, and it sits at the top, clear of the tab bar,
// the keyboard and any Save button.
import 'package:flutter/widgets.dart';

import 'toast_scope.dart';

enum ToastTone { success, info, error }

/// One message as the host shows it. Compared by identity, so each show of
/// a new message animates in afresh.
@immutable
class ToastMessage {
  const ToastMessage(this.text, this.tone);

  final String text;
  final ToastTone tone;
}

abstract final class Toast {
  /// The host lives above the navigator, so a message outlives the page or
  /// sheet that raised it.
  static void show(
    BuildContext context,
    String text, {
    ToastTone tone = ToastTone.success,
  }) => context.getInheritedWidgetOfExactType<ToastScope>()?.controller.show(
    ToastMessage(text, tone),
  );
}
