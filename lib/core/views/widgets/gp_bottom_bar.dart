//
//  Gatepass
//  gp_bottom_bar.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

/// The fixed strip under a form: canvas, a top hairline, safe-area padding.
class GpBottomBar extends StatelessWidget {
  const GpBottomBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.canvas,
        border: Border(
          top: BorderSide(color: colors.line, width: GpSizes.hairline),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            GpSpace.gutter,
            GpSpace.md,
            GpSpace.gutter,
            GpSpace.md,
          ),
          child: child,
        ),
      ),
    );
  }
}
