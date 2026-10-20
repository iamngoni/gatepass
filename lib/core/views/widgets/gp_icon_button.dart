//
//  Gatepass
//  gp_icon_button.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_colors.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'pressable.dart';

/// A 44pt icon target: header actions, copy buttons.
class GpIconButton extends StatelessWidget {
  const GpIconButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
    this.badge,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final Color? color;

  /// A count drawn on the icon's corner; hidden at zero.
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final count = badge ?? 0;
    return Semantics(
      label: label,
      button: true,
      excludeSemantics: true,
      child: Pressable(
        onTap: onPressed,
        child: SizedBox.square(
          dimension: GpSizes.tapTarget,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Icon(icon, size: GpSizes.iconLg - 2, color: color ?? colors.ink),
              if (count > 0)
                Positioned(
                  top: 6,
                  right: 4,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 18),
                    height: 18,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: GpColors.unread,
                      borderRadius: BorderRadius.circular(GpRadius.pill),
                      border: Border.all(color: colors.canvas, width: 2),
                    ),
                    child: Text(
                      '$count',
                      style: context.type.navLabel.copyWith(
                        color: const Color(0xFFFFFFFF),
                        height: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
