import 'package:flutter/widgets.dart';

import 'icons.dart';
import 'pressable.dart';
import 'theme.dart';

class GpTab {
  const GpTab(this.icon, this.label);

  final IconData icon;
  final String label;
}

/// The bottom bar: tabs either side of a centred add action that lives in
/// the bar itself, not a floating button.
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

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final half = tabs.length ~/ 2;
    Widget tab(int i) => Expanded(
      child: _TabItem(
        tab: tabs[i],
        selected: i == selectedIndex,
        onTap: () => onSelect(i),
      ),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(color: colors.line, width: GpSizes.hairline),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: GpSizes.tabBar - 8,
          child: Row(
            children: [
              for (var i = 0; i < half; i++) tab(i),
              Semantics(
                button: true,
                label: addLabel,
                excludeSemantics: true,
                child: Pressable(
                  onTap: onAdd,
                  child: Container(
                    width: 58,
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: GpSpace.xs),
                    decoration: BoxDecoration(
                      color: colors.accent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(GpIcons.add, color: colors.onAccent, size: 24),
                  ),
                ),
              ),
              for (var i = half; i < tabs.length; i++) tab(i),
            ],
          ),
        ),
      ),
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
    final color = selected ? colors.accent : colors.inkFaint;
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
            Text(
              tab.label,
              maxLines: 1,
              style: context.type.navLabel.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
