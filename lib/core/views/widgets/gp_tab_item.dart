//
//  Gatepass
//  gp_tab_item.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_motion.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'gp_tab.dart';
import 'pressable.dart';

/// One tab: its icon over its label.
class GpTabItem extends StatelessWidget {
  const GpTabItem({
    required this.tab,
    required this.selected,
    required this.onTap,
    super.key,
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
