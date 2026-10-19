// Gatepass — quick_tile_row.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';

class QuickTileRow extends StatelessWidget {
  const QuickTileRow({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 100,
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: GpSpace.md),
      children: children,
    ),
  );
}
