import 'package:flutter/widgets.dart';

import '../util/format.dart';

/// Stand-in for the gate camera photo the real system attaches to entries.
class GateCameraSnapshot extends StatelessWidget {
  const GateCameraSnapshot({
    super.key,
    required this.seed,
    required this.gateName,
    required this.time,
    this.withVehicle = false,
    this.showOverlay = true,
  });

  final String seed;
  final String gateName;
  final DateTime time;
  final bool withVehicle;
  final bool showOverlay;

  @override
  Widget build(BuildContext context) {
    final hue = (seed.hashCode % 60 + 140).toDouble();
    final base = HSLColor.fromAHSL(1, hue, 0.12, 0.22).toColor();
    final light = HSLColor.fromAHSL(1, hue, 0.10, 0.36).toColor();
    const mono = TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
      fontFeatures: [FontFeature.tabularFigures()],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [light, base],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _ScenePainter(withVehicle: withVehicle)),
          if (showOverlay) ...[
            Positioned(
              left: 12,
              top: 10,
              child: Text('${gateName.toUpperCase()} · CAM 1', style: mono),
            ),
            Positioned(
              left: 12,
              bottom: 10,
              child: Text(
                '${dayLabel(time).toUpperCase()} ${formatTime(time)}:'
                '${time.second.toString().padLeft(2, '0')}',
                style: mono,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ScenePainter extends CustomPainter {
  _ScenePainter({required this.withVehicle});

  final bool withVehicle;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final faint = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.08);
    final shape = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.22);

    // Road with perspective lane lines.
    final road = Path()
      ..moveTo(w * 0.30, h * 0.45)
      ..lineTo(w * 0.70, h * 0.45)
      ..lineTo(w * 1.05, h)
      ..lineTo(-w * 0.05, h)
      ..close();
    canvas.drawPath(road, faint);
    final lane = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.18)
      ..strokeWidth = 2;
    for (var i = 0; i < 4; i++) {
      final y = h * (0.52 + i * 0.12);
      canvas.drawLine(Offset(w * 0.5, y), Offset(w * 0.5, y + h * 0.05), lane);
    }

    // Boom arm.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.06, h * 0.38, w * 0.5, h * 0.025),
        const Radius.circular(4),
      ),
      shape,
    );

    if (withVehicle) {
      final body = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(w * 0.5, h * 0.72),
          width: w * 0.42,
          height: h * 0.26,
        ),
        Radius.circular(h * 0.06),
      );
      canvas.drawRRect(body, shape);
      final glass = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(w * 0.5, h * 0.64),
          width: w * 0.30,
          height: h * 0.08,
        ),
        Radius.circular(h * 0.03),
      );
      canvas.drawRRect(glass, faint);
    } else {
      canvas.drawCircle(Offset(w * 0.5, h * 0.55), h * 0.08, shape);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(w * 0.5, h * 0.82),
            width: h * 0.32,
            height: h * 0.34,
          ),
          Radius.circular(h * 0.12),
        ),
        shape,
      );
    }
  }

  @override
  bool shouldRepaint(_ScenePainter old) => old.withVehicle != withVehicle;
}
