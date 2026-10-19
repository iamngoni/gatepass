// Gatepass — gate_pass_image.dart. Created 2026-10-19.
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../models/data/delivery_services.dart';
import '../../models/data/invite.dart';
import 'gate_pass_card.dart';

/// Draws [GatePassCard] off screen and returns it as a PNG at 3x.
Future<Uint8List> renderGatePassImage(
  BuildContext context,
  Invite invite,
  String siteName,
) async {
  final service = serviceById(invite.serviceId);
  if (service != null) {
    await precacheImage(AssetImage(service.iconAsset), context);
  }
  if (!context.mounted) throw StateError('The invite closed');
  final key = GlobalKey();
  // Laid out and painted like any other widget, just beyond the left edge
  // of the screen, so the picture matches the app exactly.
  final entry = OverlayEntry(
    builder: (_) => Positioned(
      left: -GatePassCard.width * 4,
      top: 0,
      child: IgnorePointer(
        child: ExcludeSemantics(
          child: RepaintBoundary(
            key: key,
            child: GatePassCard(invite: invite, siteName: siteName),
          ),
        ),
      ),
    ),
  );
  Overlay.of(context, rootOverlay: true).insert(entry);
  try {
    // The second frame paints the icon, which resolves during the first.
    for (var i = 0; i < 2; i++) {
      await WidgetsBinding.instance.endOfFrame;
    }
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      return data!.buffer.asUint8List();
    } finally {
      image.dispose();
    }
  } finally {
    entry.remove();
  }
}
