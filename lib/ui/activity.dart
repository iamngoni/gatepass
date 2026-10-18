import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'theme.dart';

/// A thin rotating arc while work is pending. Holds still when the phone
/// asks for reduced motion.
class GpActivity extends StatefulWidget {
  const GpActivity({
    super.key,
    this.size = 22,
    this.color,
    this.strokeWidth = 2.2,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  State<GpActivity> createState() => _GpActivityState();
}

class _GpActivityState extends State<GpActivity>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Loading',
    liveRegion: true,
    child: SizedBox.square(
      dimension: widget.size,
      child: RotationTransition(
        turns: _controller,
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
    canvas.drawArc(
      rect,
      0,
      math.pi * 2,
      false,
      paint..color = color.withValues(alpha: .2),
    );
    canvas.drawArc(
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

/// A rounded track and fill for a determinate progress value.
class GpProgressBar extends StatelessWidget {
  const GpProgressBar({super.key, required this.value, this.height = 4});

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(GpRadius.pill),
      child: SizedBox(
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(color: colors.track),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: FractionallySizedBox(
              widthFactor: value.clamp(0, 1),
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.accent,
                  borderRadius: BorderRadius.circular(GpRadius.pill),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
