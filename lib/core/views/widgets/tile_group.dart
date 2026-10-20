//
//  Gatepass
//  tile_group.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import 'gp_group.dart';

/// Tiles in one surface, inset by the page gutter.
class TileGroup extends StatelessWidget {
  const TileGroup({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
    child: GpGroup(children: children),
  );
}
