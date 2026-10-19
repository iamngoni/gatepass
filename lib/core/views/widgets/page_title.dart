// Gatepass — page_title.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

/// A tab's big title, drawn in the page.
class PageTitle extends StatelessWidget {
  const PageTitle(this.text, {this.trailing, super.key});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      GpSpace.gutter,
      GpSpace.lg,
      GpSpace.sm,
      GpSpace.lg,
    ),
    child: Row(
      children: [
        Expanded(child: Text(text, style: context.type.display)),
        ?trailing,
      ],
    ),
  );
}
