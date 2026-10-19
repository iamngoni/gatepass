// Gatepass — padded.dart. Created 2026-10-19.
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
