import 'package:flutter/widgets.dart';

import '../ui/ui.dart';
import '../util/format.dart';

/// The invite as the gate reads it: a QR of the access code over the code
/// itself. ATG's own visitor page encodes the bare code, so the guard's
/// scanner treats this one the same.
///
/// Always a white card, in dark mode too, because scanners need dark modules
/// on a light field.
class GatePass extends StatelessWidget {
  const GatePass({super.key, required this.code, this.caption});

  /// Null while the invite is still being created.
  final String? code;
  final String? caption;

  static const _ink = GpColors.light;

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
        border: Border.all(color: _ink.lineStrong, width: GpSizes.hairline),
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
                            color: _ink.surfaceMuted,
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
                                        color: _ink.inkMuted,
                                      ),
                                    ),
                                  )
                                : GpActivity(color: _ink.accent),
                          ),
                        ),
                ),
              );
            },
          ),
          const SizedBox(height: GpSpace.lg),
          Text(
            'GATE CODE',
            style: type.overline.copyWith(color: _ink.inkFaint),
          ),
          const SizedBox(height: GpSpace.xs),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              ready
                  ? formatCode(code)
                  : missing
                  ? 'No code'
                  : '•••• •••• ••••',
              maxLines: 1,
              style: type.code.copyWith(
                fontSize: 28,
                letterSpacing: 2,
                color: ready ? _ink.ink : _ink.inkFaint,
              ),
            ),
          ),
          if (caption != null) ...[
            const SizedBox(height: GpSpace.sm),
            Text(
              caption!,
              textAlign: TextAlign.center,
              style: type.caption.copyWith(color: _ink.inkMuted),
            ),
          ],
        ],
      ),
    );
  }
}
