// Gatepass — gp_surface.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'pressable.dart';

/// The raised content container. Flat: a surface tone, one hairline, one
/// radius. Depth comes from canvas versus surface, never from a shadow.
///
/// Children are clipped to the shape and the outline is painted after them,
/// so an opaque row never squares off the rounded corners.
class GpSurface extends StatelessWidget {
  const GpSurface({
    required this.child,
    this.padding = const EdgeInsets.all(GpSpace.lg),
    this.onTap,
    this.color,
    super.key,
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
