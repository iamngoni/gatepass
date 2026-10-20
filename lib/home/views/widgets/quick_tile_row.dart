//
//  Gatepass
//  quick_tile_row.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

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
