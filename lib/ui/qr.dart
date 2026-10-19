// A QR code drawn by the app itself: the `qr` package encodes, this paints.
// Square modules, dark on light in both themes, so any gate scanner reads it.
import 'package:flutter/widgets.dart';
import 'package:qr/qr.dart';

class GpQrCode extends StatelessWidget {
  const GpQrCode({
    super.key,
    required this.data,
    this.size = 200,
    this.semanticLabel,
  });

  final String data;
  final double size;
  final String? semanticLabel;

  static const ink = Color(0xFF0F1F19);
  static const paper = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) => Semantics(
    image: true,
    label: semanticLabel ?? 'QR code',
    child: RepaintBoundary(
      child: CustomPaint(size: Size.square(size), painter: _QrPainter(data)),
    ),
  );
}

class _QrPainter extends CustomPainter {
  _QrPainter(this.data)
    : image = QrImage(
        QrCode.fromData(data: data, errorCorrectLevel: QrErrorCorrectLevel.M),
      );

  final String data;
  final QrImage image;

  /// Light modules kept around the symbol so it reads on any background.
  static const _quiet = 2;

  @override
  void paint(Canvas canvas, Size size) {
    final count = image.moduleCount + _quiet * 2;
    final module = size.shortestSide / count;
    canvas.drawRect(Offset.zero & size, Paint()..color = GpQrCode.paper);
    // One path, filled once and without anti-aliasing, so neighbouring
    // modules meet without hairline seams.
    final path = Path();
    for (var row = 0; row < image.moduleCount; row++) {
      for (var col = 0; col < image.moduleCount; col++) {
        if (!image.isDark(row, col)) continue;
        path.addRect(
          Rect.fromLTWH(
            (col + _quiet) * module,
            (row + _quiet) * module,
            module,
            module,
          ),
        );
      }
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = GpQrCode.ink
        ..isAntiAlias = false,
    );
  }

  @override
  bool shouldRepaint(_QrPainter old) => old.data != data;
}
