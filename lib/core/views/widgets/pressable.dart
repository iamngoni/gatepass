// Gatepass — pressable.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

/// The one tap response, used instead of ink: a quick fade to 55% and a 3%
/// shrink over 150ms, then back. No ripple, no highlight, no splash.
class Pressable extends StatefulWidget {
  const Pressable({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.semanticLabel,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? semanticLabel;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  final pressed = ValueNotifier(false);

  bool get enabled => widget.onTap != null || widget.onLongPress != null;

  void setPressed({required bool value}) {
    if (!enabled || pressed.value == value) return;
    pressed.value = value;
  }

  @override
  void dispose() {
    pressed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: enabled,
    label: widget.semanticLabel,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: (_) => setPressed(value: true),
      onTapUp: (_) => setPressed(value: false),
      onTapCancel: () => setPressed(value: false),
      onLongPressEnd: (_) => setPressed(value: false),
      child: ValueListenableBuilder(
        valueListenable: pressed,
        builder: (context, pressed, child) => AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          opacity: pressed ? .55 : 1,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            scale: pressed ? .97 : 1,
            child: child,
          ),
        ),
        child: widget.child,
      ),
    ),
  );
}
