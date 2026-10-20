//
//  Gatepass
//  time_wheel.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

/// One looping wheel of zero-padded numbers.
class TimeWheel extends StatelessWidget {
  const TimeWheel({
    required this.controller,
    required this.count,
    required this.align,
    required this.onChanged,
    super.key,
  });

  final FixedExtentScrollController controller;
  final int count;
  final Alignment align;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => ListWheelScrollView.useDelegate(
    controller: controller,
    itemExtent: 44,
    diameterRatio: 1.6,
    overAndUnderCenterOpacity: .35,
    physics: const FixedExtentScrollPhysics(),
    onSelectedItemChanged: (i) => onChanged(i % count),
    childDelegate: ListWheelChildLoopingListDelegate(
      children: [
        for (var i = 0; i < count; i++)
          Align(
            alignment: align,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: GpSpace.lg),
              child: Text(
                i.toString().padLeft(2, '0'),
                style: context.type.title.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
