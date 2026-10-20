//
//  Gatepass
//  gp_switch_row.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'gp_switch.dart';

/// A row with a title, a helper line and a switch: the whole row toggles.
class GpSwitchRow extends StatelessWidget {
  const GpSwitchRow({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => Semantics(
    toggled: value,
    label: title,
    excludeSemantics: true,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GpSpace.lg,
          vertical: GpSpace.md + 2,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.type.heading),
                  if (subtitle != null) ...[
                    const SizedBox(height: GpSpace.xxs),
                    Text(subtitle!, style: context.type.caption),
                  ],
                ],
              ),
            ),
            const SizedBox(width: GpSpace.md),
            GpSwitch(value: value, onChanged: onChanged),
          ],
        ),
      ),
    ),
  );
}
