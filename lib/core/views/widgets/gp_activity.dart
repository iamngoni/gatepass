// Gatepass — gp_activity.dart. Created 2026-10-18.
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../utils/extensions/build_context_extensions.dart';
import '../../utils/extensions/localization_extensions.dart';

/// A thin rotating arc while work is pending. Holds still when the phone
/// asks for reduced motion.
class GpActivity extends StatefulWidget {
  const GpActivity({
    this.size = 22,
    this.color,
    this.strokeWidth = 2.2,
    super.key,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  State<GpActivity> createState() => _GpActivityState();
}

class _GpActivityState extends State<GpActivity>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      controller.stop();
    } else if (!controller.isAnimating) {
      controller.repeat();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: context.l10n.commonLoading,
    liveRegion: true,
    child: SizedBox.square(
      dimension: widget.size,
      child: RotationTransition(
        turns: controller,
        child: CustomPaint(
          painter: _ArcPainter(
            color: widget.color ?? context.colors.accent,
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    ),
  );
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(strokeWidth / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas
      ..drawArc(
        rect,
        0,
        math.pi * 2,
        false,
        paint..color = color.withValues(alpha: .2),
      )
      ..drawArc(
        rect,
        -math.pi / 2,
        math.pi * .6,
        false,
        paint..color = color,
      );
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}
