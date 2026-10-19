// Gatepass — gp_pill.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_motion.dart';
import '../../configs/gp_spacing.dart';
import '../../configs/gp_type.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'pressable.dart';

/// Choice and filter pill. Selected is an ink fill; unselected a surface
/// with a hairline.
class GpPill extends StatelessWidget {
  const GpPill({
    required this.label,
    required this.onPressed,
    this.selected = false,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      selected: selected,
      child: Pressable(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: GpMotion.base,
          curve: GpMotion.curve,
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          // No alignment: it would stretch the pill across a Wrap's width.
          decoration: BoxDecoration(
            color: selected ? colors.ink : colors.surface,
            borderRadius: BorderRadius.circular(GpRadius.pill),
            border: selected
                ? null
                : Border.all(color: colors.lineStrong, width: GpSizes.hairline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                maxLines: 1,
                style: context.type.label
                    .weighted(FontWeight.w600)
                    .copyWith(color: selected ? colors.onInk : colors.ink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
