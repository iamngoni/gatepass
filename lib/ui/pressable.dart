import 'package:flutter/widgets.dart';

/// The one tap response, used instead of ink: a quick fade to 55% and a 3%
/// shrink over 150ms, then back. No ripple, no highlight, no splash.
class Pressable extends StatefulWidget {
  const Pressable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? semanticLabel;

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  final _pressed = ValueNotifier(false);

  bool get _enabled => widget.onTap != null || widget.onLongPress != null;

  @override
  void dispose() {
    _pressed.dispose();
    super.dispose();
  }

  void _set(bool value) {
    if (!_enabled || _pressed.value == value) return;
    _pressed.value = value;
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: _enabled,
    label: widget.semanticLabel,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: (_) => _set(true),
      onTapUp: (_) => _set(false),
      onTapCancel: () => _set(false),
      onLongPressEnd: (_) => _set(false),
      child: ValueListenableBuilder(
        valueListenable: _pressed,
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
