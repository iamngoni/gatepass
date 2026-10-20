//
//  Gatepass
//  toast_view.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_icons.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'pressable.dart';
import 'toast.dart';

/// The pill a message is drawn in; a tap dismisses it.
class ToastView extends StatelessWidget {
  const ToastView({required this.message, required this.onTap, super.key});

  final ToastMessage message;
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
