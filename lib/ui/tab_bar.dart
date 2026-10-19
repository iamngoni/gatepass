import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import 'icons.dart';
import 'pressable.dart';
import 'theme.dart';

class GpTab {
  const GpTab(this.icon, this.label);

  final IconData icon;
  final String label;
}

/// The bottom bar: a floating capsule of tabs, with the add action as its
/// own round button at the thumb's end of the row rather than wedged
/// between tabs.
class GpTabBar extends StatelessWidget {
  const GpTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onSelect,
    required this.onAdd,
    required this.addLabel,
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
                child: _Glass(
                  child: Padding(
                    padding: const EdgeInsets.all(_TabTrack.inset),
                    child: _TabTrack(
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

/// Frosted surface for chrome that floats over scrolling content.
class _Glass extends StatelessWidget {
  const _Glass({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final shape = BorderRadius.circular(GpRadius.pill);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: shape,
        boxShadow: colors.floatShadow,
      ),
      child: ClipRRect(
        borderRadius: shape,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.chrome,
              borderRadius: shape,
              border: Border.all(
                color: colors.lineStrong,
                width: GpSizes.hairline,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// The tabs over a sliding highlight, like the segmented control's thumb.
class _TabTrack extends StatelessWidget {
  const _TabTrack({
    required this.tabs,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<GpTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  static const inset = 5.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth / tabs.length;
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
                  color: colors.accentSoft,
                  borderRadius: BorderRadius.circular(GpRadius.pill),
                ),
              ),
            ),
            Row(
              children: [
                for (var i = 0; i < tabs.length; i++)
                  Expanded(
                    child: _TabItem(
                      tab: tabs[i],
                      selected: i == selectedIndex,
                      onTap: () => onSelect(i),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final GpTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = selected ? colors.accent : colors.inkMuted;
    return Semantics(
      selected: selected,
      button: true,
      label: tab.label,
      excludeSemantics: true,
      child: Pressable(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tab.icon, size: 22, color: color),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: GpMotion.fast,
              style: context.type.navLabel.copyWith(color: color),
              child: Text(tab.label, maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }
}
