// Gatepass — status_pill.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../configs/tone.dart';
import '../../utils/extensions/build_context_extensions.dart';

class StatusPill extends StatelessWidget {
  const StatusPill({required this.label, required this.tone, super.key});

  final String label;
  final Tone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.toneSoft(tone),
        borderRadius: BorderRadius.circular(GpRadius.pill),
      ),
      child: Text(
        label,
        maxLines: 1,
        style: context.type.chip.copyWith(color: colors.tone(tone)),
      ),
    );
  }
}
