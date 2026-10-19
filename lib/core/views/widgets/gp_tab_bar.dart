// Gatepass — gp_tab_bar.dart. Created 2026-10-18.
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../configs/gp_icons.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'gp_glass.dart';
import 'gp_tab.dart';
import 'gp_tab_track.dart';
import 'pressable.dart';

/// The bottom bar: a floating capsule of tabs, with the add action as its
/// own round button at the thumb's end of the row rather than wedged
/// between tabs.
class GpTabBar extends StatelessWidget {
  const GpTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onSelect,
    required this.onAdd,
    required this.addLabel,
    super.key,
  });

  final List<GpTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onAdd;
  final String addLabel;

  /// The capsule floats this far above the bottom edge: just inside the
  /// home indicator's area, or a small margin on phones without one.
  static double bottomGap(double safeBottom) =>
      safeBottom > 0 ? math.max(safeBottom - 10, GpSpace.md) : GpSpace.md;

  /// Everything the bar covers, measured from the bottom of the screen.
  static double extent(double safeBottom) =>
      bottomGap(safeBottom) + GpSizes.tabBar;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    // The capsule has a fixed height; past this, labels would overflow it.
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.5,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          GpSpace.gutter,
          0,
          GpSpace.gutter,
          bottomGap(safeBottom),
        ),
        child: SizedBox(
          height: GpSizes.tabBar,
          child: Row(
            children: [
              Expanded(
                child: GpGlass(
                  child: Padding(
                    padding: const EdgeInsets.all(GpTabTrack.inset),
                    child: GpTabTrack(
                      tabs: tabs,
                      selectedIndex: selectedIndex,
                      onSelect: onSelect,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: GpSpace.md),
              Semantics(
                button: true,
                label: addLabel,
                excludeSemantics: true,
                child: Pressable(
                  onTap: onAdd,
                  child: Container(
                    width: GpSizes.tabBar,
                    height: GpSizes.tabBar,
                    decoration: BoxDecoration(
                      color: colors.accent,
                      shape: BoxShape.circle,
                      boxShadow: colors.floatShadow,
                    ),
                    child: Icon(GpIcons.add, color: colors.onAccent, size: 28),
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
