// Gatepass — icon_badge.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../configs/tone.dart';
import '../../utils/extensions/build_context_extensions.dart';

/// An icon in a soft tinted circle.
class IconBadge extends StatelessWidget {
  const IconBadge({
    required this.icon,
    this.tone = Tone.neutral,
    this.size = GpSizes.avatar,
    super.key,
  });

  final IconData icon;
  final Tone tone;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.toneSoft(tone),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: size * .44,
        color: tone == Tone.neutral ? colors.ink : colors.tone(tone),
      ),
    );
  }
}
