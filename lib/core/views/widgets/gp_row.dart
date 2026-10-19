// Gatepass — gp_row.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_icons.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'pressable.dart';

/// A list row: leading mark, title over subtitle, trailing content.
class GpRow extends StatelessWidget {
  const GpRow({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.chevron = false,
    this.titleStyle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  /// Shows a chevron when the row opens another page.
  final bool chevron;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final row = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: GpSizes.row),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GpSpace.lg,
          vertical: GpSpace.md,
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: GpSpace.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: titleStyle ?? context.type.heading),
                  if (subtitle != null) ...[
                    const SizedBox(height: GpSpace.xxs),
                    Text(subtitle!, style: context.type.caption),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: GpSpace.sm),
              trailing!,
            ],
            if (chevron) ...[
              const SizedBox(width: GpSpace.xs),
              Icon(GpIcons.chevronRight, size: 18, color: colors.chevron),
            ],
          ],
        ),
      ),
    );
    return onTap == null ? row : Pressable(onTap: onTap, child: row);
  }
}
