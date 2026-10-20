//
//  Gatepass
//  padded.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';

/// A section inset by the page gutter.
class Padded extends StatelessWidget {
  const Padded({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
    child: child,
  );
}
