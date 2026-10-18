// One host for transient messages, in place of SnackBar: one visible message
// at a time, repeats coalesce, and it sits at the top, clear of the tab bar,
// the keyboard and any Save button.
import 'dart:async';

import 'package:flutter/widgets.dart';

import 'icons.dart';
import 'pressable.dart';
import 'theme.dart';

enum ToastTone { success, info, error }

@immutable
class _Message {
  const _Message(this.text, this.tone);

  final String text;
  final ToastTone tone;
}

class _ToastController extends ChangeNotifier {
  _Message? _current;
  Timer? _timer;

  void show(_Message message) {
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

class _ToastScope extends InheritedWidget {
  const _ToastScope({required this.controller, required super.child});

  final _ToastController controller;

  @override
  bool updateShouldNotify(_ToastScope old) => old.controller != controller;
}

abstract final class Toast {
  /// The host lives above the navigator, so a message outlives the page or
  /// sheet that raised it.
  static void show(
    BuildContext context,
    String text, {
    ToastTone tone = ToastTone.success,
  }) => context.getInheritedWidgetOfExactType<_ToastScope>()?.controller.show(
    _Message(text, tone),
  );
}

class ToastHost extends StatefulWidget {
  const ToastHost({super.key, required this.child});

  final Widget child;

  @override
  State<ToastHost> createState() => _ToastHostState();
}

class _ToastHostState extends State<ToastHost> {
  final _controller = _ToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ToastScope(
    controller: _controller,
    child: Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final message = _controller._current;
            return Positioned(
              left: GpSpace.xl,
              right: GpSpace.xl,
              top: 0,
              child: IgnorePointer(
                ignoring: message == null,
                child: AnimatedSwitcher(
                  duration: GpMotion.base,
                  reverseDuration: GpMotion.fast,
                  switchInCurve: GpMotion.curve,
                  switchOutCurve: GpMotion.curve,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween(
                        begin: const Offset(0, -.3),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: message == null
                      ? const SizedBox.shrink(key: ValueKey('none'))
                      : _Toast(
                          key: ValueKey(message),
                          message: message,
                          onTap: _controller.hide,
                        ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

class _Toast extends StatelessWidget {
  const _Toast({super.key, required this.message, required this.onTap});

  final _Message message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final icon = switch (message.tone) {
      ToastTone.success => GpIcons.checkCircle,
      ToastTone.info => GpIcons.info,
      ToastTone.error => GpIcons.error,
    };
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + GpSpace.sm,
      ),
      child: Center(
        child: Semantics(
          liveRegion: true,
          container: true,
          child: Pressable(
            onTap: onTap,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.ink,
                borderRadius: BorderRadius.circular(GpRadius.pill),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: GpSpace.lg,
                  vertical: 11,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 18, color: colors.onInk),
                    const SizedBox(width: GpSpace.sm),
                    Flexible(
                      child: Text(
                        message.text,
                        style: context.type.body.copyWith(color: colors.onInk),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
