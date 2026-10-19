// Gatepass — detail_row.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

/// Label and value on one line, for detail cards.
class DetailRow extends StatelessWidget {
  const DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: GpSpace.lg,
        vertical: GpSpace.md + 2,
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colors.inkFaint),
          const SizedBox(width: GpSpace.md),
          Text(
            label,
            style: context.type.body.copyWith(color: colors.inkMuted),
          ),
          const SizedBox(width: GpSpace.lg),
          Expanded(
            child: Text(
              value,
              style: context.type.bodyStrong,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
