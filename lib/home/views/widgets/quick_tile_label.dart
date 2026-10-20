//
//  Gatepass
//  quick_tile_label.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';

/// An overline above a row of quick tiles.
class QuickTileLabel extends StatelessWidget {
  const QuickTileLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(GpSpace.xl, 0, GpSpace.xl, GpSpace.sm),
    child: Text(
      text.toUpperCase(),
      style: context.type.overline.copyWith(color: GpColors.onBrandMuted),
    ),
  );
}
