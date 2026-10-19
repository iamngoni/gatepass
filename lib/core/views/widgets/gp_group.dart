// Gatepass — gp_group.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import 'gp_separator.dart';
import 'gp_surface.dart';

/// Rows in one surface, split by hairlines inset past the leading mark.
class GpGroup extends StatelessWidget {
  const GpGroup({required this.children, this.inset = 72, super.key});

  final List<Widget> children;
  final double inset;

  @override
  Widget build(BuildContext context) => GpSurface(
    padding: EdgeInsets.zero,
    child: Column(
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) GpSeparator(inset: inset),
          children[i],
        ],
      ],
    ),
  );
}
