//
//  Gatepass
//  gp_tab_track.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_motion.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'gp_tab.dart';
import 'gp_tab_item.dart';

/// The tabs over a sliding highlight, like the segmented control's thumb.
class GpTabTrack extends StatelessWidget {
  const GpTabTrack({
    required this.tabs,
    required this.selectedIndex,
    required this.onSelect,
    super.key,
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
                    child: GpTabItem(
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
