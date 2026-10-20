//
//  Gatepass
//  group_label.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

/// Small group label above a list: TODAY, UPCOMING.
class GroupLabel extends StatelessWidget {
  const GroupLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      GpSpace.gutter,
      GpSpace.xl,
      GpSpace.gutter,
      GpSpace.sm,
    ),
    child: Text(text.toUpperCase(), style: context.type.overline),
  );
}
