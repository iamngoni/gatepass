// Gatepass — gp_segmented.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_motion.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'pressable.dart';

/// One groove, one borderless sliding thumb.
class GpSegmented extends StatelessWidget {
  const GpSegmented({
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const inset = 3.0;
  static const thumbRadius = GpRadius.md - inset;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: 44,
      padding: const EdgeInsets.all(inset),
      decoration: BoxDecoration(
        color: colors.track,
        borderRadius: BorderRadius.circular(GpRadius.md),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth / segments.length;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: GpMotion.slow,
                curve: GpMotion.riseCurve,
                left: width * selectedIndex,
                top: 0,
                bottom: 0,
                width: width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.trackThumb,
                    borderRadius: BorderRadius.circular(thumbRadius),
                  ),
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < segments.length; i++)
                    Expanded(
                      child: Semantics(
                        selected: i == selectedIndex,
                        child: Pressable(
                          onTap: i == selectedIndex ? null : () => onChanged(i),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: GpSpace.sm,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: AnimatedDefaultTextStyle(
                                  duration: GpMotion.fast,
                                  style: context.type.bodyStrong.copyWith(
                                    height: 1.2,
                                    color: i == selectedIndex
                                        ? colors.ink
                                        : colors.inkMuted,
                                  ),
                                  child: Text(segments[i], maxLines: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
