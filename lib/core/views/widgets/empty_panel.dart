// Gatepass — empty_panel.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'gp_button.dart';

/// A designed empty state: a bordered surface, a soft mark, a title, a
/// line of help and an optional action. Never a lone centred spinner.
class EmptyPanel extends StatelessWidget {
  const EmptyPanel({
    required this.icon,
    required this.title,
    required this.body,
    this.action,
    this.onAction,
    super.key,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(GpRadius.xl),
          border: Border.all(color: colors.line, width: GpSizes.hairline),
        ),
        child: Padding(
          padding: const EdgeInsets.all(GpSpace.xxxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(GpSpace.xl),
                decoration: BoxDecoration(
                  color: colors.accentSoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: colors.accent, size: 28),
              ),
              const SizedBox(height: GpSpace.xxl),
              Text(
                title,
                style: context.type.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: GpSpace.sm),
              Text(
                body,
                style: context.type.body.copyWith(color: colors.inkMuted),
                textAlign: TextAlign.center,
              ),
              if (action != null) ...[
                const SizedBox(height: GpSpace.xxl),
                GpButton(
                  label: action!,
                  onPressed: onAction,
                  variant: GpButtonVariant.secondary,
                  expand: false,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
