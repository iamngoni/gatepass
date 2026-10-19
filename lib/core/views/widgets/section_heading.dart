// Gatepass — section_heading.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'gp_button.dart';

/// A section's title with an optional text action: "Live invites  All".
class SectionHeading extends StatelessWidget {
  const SectionHeading(
    this.title, {
    this.action,
    this.onAction,
    super.key,
  });

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      GpSpace.gutter,
      GpSpace.xxl,
      GpSpace.sm,
      GpSpace.md,
    ),
    child: Row(
      children: [
        Expanded(child: Text(title, style: context.type.cardTitle)),
        if (action != null)
          GpButton(
            label: action!,
            onPressed: onAction,
            variant: GpButtonVariant.text,
            size: GpButtonSize.compact,
            expand: false,
          ),
      ],
    ),
  );
}
