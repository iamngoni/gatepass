// Gatepass — gp_separator.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

class GpSeparator extends StatelessWidget {
  const GpSeparator({this.inset = 0, super.key});

  final double inset;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsDirectional.only(start: inset),
    child: SizedBox(
      height: GpSizes.hairline,
      width: double.infinity,
      child: ColoredBox(color: context.colors.line),
    ),
  );
}
