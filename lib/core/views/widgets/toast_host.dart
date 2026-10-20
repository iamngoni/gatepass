//
//  Gatepass
//  toast_host.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_motion.dart';
import '../../configs/gp_spacing.dart';
import 'toast_controller.dart';
import 'toast_scope.dart';
import 'toast_view.dart';

class ToastHost extends StatefulWidget {
  const ToastHost({required this.child, super.key});

  final Widget child;

  @override
  State<ToastHost> createState() => _ToastHostState();
}

class _ToastHostState extends State<ToastHost> {
  final controller = ToastController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ToastScope(
    controller: controller,
    child: Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final message = controller.current;
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
                      : ToastView(
                          message: message,
                          onTap: controller.hide,
                          key: ValueKey(message),
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
