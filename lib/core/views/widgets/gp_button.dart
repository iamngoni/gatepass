//
//  Gatepass
//  gp_button.dart
//
//  Created by Ngonidzashe Mangudya on 18/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_colors.dart';
import '../../configs/gp_spacing.dart';
import '../../configs/gp_type.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'gp_activity.dart';
import 'pressable.dart';

enum GpButtonVariant {
  /// Forest fill, white label: Create invite, Sign in.
  primary,

  /// Hairline surface: Done, secondary actions.
  secondary,

  /// No container, accent label: See all, Resend code.
  text,

  /// Soft red fill with a red label: Revoke, Sign out.
  danger,

  /// Soft forest fill with a forest label: Send invite again.
  soft,

  /// White on the brand surface.
  inverse,
}

enum GpButtonSize { large, regular, compact }

/// The app's button. One fixed height per size and a one-line label that
/// scales down rather than wrapping, so buttons in a row always line up.
class GpButton extends StatelessWidget {
  const GpButton({
    required this.label,
    required this.onPressed,
    this.variant = GpButtonVariant.primary,
    this.size = GpButtonSize.regular,
    this.icon,
    this.loading = false,
    this.expand = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final GpButtonVariant variant;
  final GpButtonSize size;
  final IconData? icon;
  final bool loading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final live = onPressed != null || loading;
    final enabled = onPressed != null && !loading;
    final height = switch (size) {
      GpButtonSize.large => GpSizes.action,
      GpButtonSize.regular => GpSizes.control,
      GpButtonSize.compact => GpSizes.controlCompact,
    };
    final radius = size == GpButtonSize.compact ? GpRadius.md : GpRadius.lg;
    final (background, foreground, border) = switch (variant) {
      GpButtonVariant.primary => (
        live ? colors.accent : colors.disabled,
        live ? colors.onAccent : colors.disabledInk,
        null,
      ),
      GpButtonVariant.secondary => (
        live ? colors.surface : colors.disabled,
        live ? colors.ink : colors.disabledInk,
        colors.lineStrong,
      ),
      GpButtonVariant.text => (
        const Color(0x00000000),
        live ? colors.accent : colors.disabledInk,
        null,
      ),
      GpButtonVariant.danger => (
        live ? colors.dangerSoft : colors.disabled,
        live ? colors.danger : colors.disabledInk,
        null,
      ),
      GpButtonVariant.soft => (
        live ? colors.accentSoft : colors.disabled,
        live ? colors.accent : colors.disabledInk,
        null,
      ),
      GpButtonVariant.inverse => (GpColors.onBrand, GpColors.brand, null),
    };
    final labelStyle = switch (size) {
      GpButtonSize.large => context.type.action,
      GpButtonSize.regular => context.type.bodyStrong,
      GpButtonSize.compact => context.type.label.weighted(FontWeight.w600),
    }.copyWith(color: foreground);

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      excludeSemantics: true,
      child: Pressable(
        onTap: enabled ? onPressed : null,
        child: Container(
          height: height,
          width: expand ? double.infinity : null,
          padding: EdgeInsets.symmetric(
            horizontal: variant == GpButtonVariant.text
                ? GpSpace.sm
                : GpSpace.lg,
          ),
          // Centre only a full-width button; on a hugging one, alignment
          // would stretch it across whatever width its parent offers.
          alignment: expand ? Alignment.center : null,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(radius),
            border: border == null
                ? null
                : Border.all(color: border, width: GpSizes.hairline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading) ...[
                GpActivity(size: 20, color: foreground),
              ] else ...[
                if (icon != null) ...[
                  Icon(icon, size: 18, color: foreground),
                  const SizedBox(width: GpSpace.sm),
                ],
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      maxLines: 1,
                      softWrap: false,
                      style: labelStyle,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
