//
//  Gatepass
//  gp_progress_bar.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

/// A rounded track and fill for a determinate progress value.
class GpProgressBar extends StatelessWidget {
  const GpProgressBar({required this.value, this.height = 4, super.key});

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(GpRadius.pill),
      child: SizedBox(
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(color: colors.track),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: FractionallySizedBox(
              widthFactor: value.clamp(0, 1),
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.accent,
                  borderRadius: BorderRadius.circular(GpRadius.pill),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
