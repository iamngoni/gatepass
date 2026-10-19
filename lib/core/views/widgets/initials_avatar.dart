// Gatepass — initials_avatar.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../configs/tone.dart';
import '../../utils/extensions/build_context_extensions.dart';
import '../../utils/text_helpers.dart';

class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    required this.name,
    this.size = GpSizes.avatar,
    this.tone = Tone.neutral,
    super.key,
  });

  final String name;
  final double size;
  final Tone tone;

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
      child: Text(
        initials(name),
        style: context.type.bodyStrong.copyWith(
          color: tone == Tone.neutral ? colors.ink : colors.tone(tone),
          fontSize: size * .34,
          height: 1,
        ),
      ),
    );
  }
}
