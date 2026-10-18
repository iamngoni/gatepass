import 'package:flutter/widgets.dart';

import 'activity.dart';
import 'pressable.dart';
import 'theme.dart';

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
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = GpButtonVariant.primary,
    this.size = GpButtonSize.regular,
    this.icon,
    this.loading = false,
    this.expand = true,
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

/// A 44pt icon target: header actions, copy buttons.
class GpIconButton extends StatelessWidget {
  const GpIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
    this.badge,
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
