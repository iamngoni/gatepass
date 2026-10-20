//
//  Gatepass
//  gate_pass.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_colors.dart';
import '../../configs/gp_motion.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import '../../utils/extensions/localization_extensions.dart';
import '../../utils/text_helpers.dart';
import 'gp_activity.dart';
import 'gp_qr_code.dart';

/// The invite as the gate reads it: a QR of the access code over the code
/// itself. ATG's own visitor page encodes the bare code, so the guard's
/// scanner treats this one the same.
///
/// Always a white card, in dark mode too, because scanners need dark modules
/// on a light field.
class GatePass extends StatelessWidget {
  const GatePass({required this.code, this.caption, super.key});

  /// Null while the invite is still being created.
  final String? code;
  final String? caption;

  /// The light palette, used in both themes for the white card.
  static const palette = GpColors.light;

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final code = this.code;
    final ready = code != null && code.isNotEmpty;
    // ATG answered without a code: say so rather than spin forever.
    final missing = code != null && code.isEmpty;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        GpSpace.xl,
        GpSpace.xl,
        GpSpace.xl,
        GpSpace.lg,
      ),
      decoration: BoxDecoration(
        color: GpQrCode.paper,
        borderRadius: BorderRadius.circular(GpRadius.xl),
        border: Border.all(color: palette.lineStrong, width: GpSizes.hairline),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.maxWidth.clamp(0.0, 216.0);
              return SizedBox.square(
                dimension: size,
                child: AnimatedSwitcher(
                  duration: GpMotion.base,
                  child: ready
                      ? GpQrCode(
                          key: ValueKey(code),
                          data: code,
                          size: size,
                          semanticLabel: 'QR code for gate code $code',
                        )
                      : DecoratedBox(
                          key: const ValueKey('pending'),
                          decoration: BoxDecoration(
                            color: palette.surfaceMuted,
                            borderRadius: BorderRadius.circular(GpRadius.md),
                          ),
                          child: Center(
                            child: missing
                                ? Padding(
                                    padding: const EdgeInsets.all(GpSpace.lg),
                                    child: Text(
                                      'ATG didn’t return a code for this '
                                      'invite. Pull to refresh, or revoke it '
                                      'and invite again.',
                                      textAlign: TextAlign.center,
                                      style: type.small.copyWith(
                                        color: palette.inkMuted,
                                      ),
                                    ),
                                  )
                                : GpActivity(color: palette.accent),
                          ),
                        ),
                ),
              );
            },
          ),
          const SizedBox(height: GpSpace.lg),
          Text(
            'GATE CODE',
            style: type.overline.copyWith(color: palette.inkFaint),
          ),
          const SizedBox(height: GpSpace.xs),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              ready
                  ? formatCode(code)
                  : missing
                  ? context.l10n.commonNoCode
                  : '•••• •••• ••••',
              maxLines: 1,
              style: type.code.copyWith(
                fontSize: 28,
                letterSpacing: 2,
                color: ready ? palette.ink : palette.inkFaint,
              ),
            ),
          ),
          if (caption != null) ...[
            const SizedBox(height: GpSpace.sm),
            Text(
              caption!,
              textAlign: TextAlign.center,
              style: type.caption.copyWith(color: palette.inkMuted),
            ),
          ],
        ],
      ),
    );
  }
}
