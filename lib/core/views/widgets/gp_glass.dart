//
//  Gatepass
//  gp_glass.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

/// Frosted surface for chrome that floats over scrolling content.
class GpGlass extends StatelessWidget {
  const GpGlass({required this.child, super.key});

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
