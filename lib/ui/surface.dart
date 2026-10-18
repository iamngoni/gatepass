import 'package:flutter/widgets.dart';

import 'icons.dart';
import 'pressable.dart';
import 'theme.dart';

/// The raised content container. Flat: a surface tone, one hairline, one
/// radius. Depth comes from canvas versus surface, never from a shadow.
///
/// Children are clipped to the shape and the outline is painted after them,
/// so an opaque row never squares off the rounded corners.
class GpSurface extends StatelessWidget {
  const GpSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(GpSpace.lg),
    this.onTap,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final shape = BorderRadius.circular(GpRadius.xl);
    final box = Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color ?? colors.surface,
        borderRadius: shape,
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: shape,
        border: Border.all(color: colors.line, width: GpSizes.hairline),
      ),
      padding: padding,
      child: child,
    );
    return onTap == null ? box : Pressable(onTap: onTap, child: box);
  }
}

/// Rows in one surface, split by hairlines inset past the leading mark.
class GpGroup extends StatelessWidget {
  const GpGroup({super.key, required this.children, this.inset = 72});

  final List<Widget> children;
  final double inset;

  @override
  Widget build(BuildContext context) => GpSurface(
    padding: EdgeInsets.zero,
    child: Column(
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) GpSeparator(inset: inset),
          children[i],
        ],
      ],
    ),
  );
}

class GpSeparator extends StatelessWidget {
  const GpSeparator({super.key, this.inset = 0});

  final double inset;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsDirectional.only(start: inset),
    child: SizedBox(
      height: GpSizes.hairline,
      width: double.infinity,
      child: ColoredBox(color: context.colors.line),
    ),
  );
}

/// A list row: leading mark, title over subtitle, trailing content.
class GpRow extends StatelessWidget {
  const GpRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.chevron = false,
    this.titleStyle,
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
