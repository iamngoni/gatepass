//
//  Gatepass
//  gp_switch.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_colors.dart';
import '../../configs/gp_motion.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'pressable.dart';

/// The slim switch, identical on every platform.
class GpSwitch extends StatelessWidget {
  const GpSwitch({
    required this.value,
    required this.onChanged,
    this.semanticLabel,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final enabled = onChanged != null;
    final track = !enabled
        ? colors.disabled
        : value
        ? GpColors.toggleOn
        : colors.control;
    return Semantics(
      toggled: value,
      enabled: enabled,
      label: semanticLabel,
      child: Pressable(
        onTap: enabled ? () => onChanged!(!value) : null,
        child: AnimatedContainer(
          duration: GpMotion.base,
          curve: GpMotion.curve,
          width: 52,
          height: 32,
          padding: const EdgeInsets.all(3),
          alignment: value
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart,
          decoration: BoxDecoration(
            color: track,
            borderRadius: BorderRadius.circular(GpRadius.pill),
          ),
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: enabled ? GpColors.toggleKnob : colors.disabledInk,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
