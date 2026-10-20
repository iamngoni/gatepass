//
//  Gatepass
//  gp_selection_gestures.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A bare EditableText has no touch gestures of its own: no long-press or
/// double-tap selection and no menu. This adds the platform's.
class GpSelectionGestures extends StatefulWidget {
  const GpSelectionGestures({
    required this.builder,
    required this.enabled,
    super.key,
  });

  final Widget Function(BuildContext, GlobalKey<EditableTextState>) builder;
  final bool enabled;

  @override
  State<GpSelectionGestures> createState() => _GpSelectionGesturesState();
}

class _GpSelectionGesturesState extends State<GpSelectionGestures>
    implements TextSelectionGestureDetectorBuilderDelegate {
  @override
  final editableTextKey = GlobalKey<EditableTextState>();

  late final gestures = TextSelectionGestureDetectorBuilder(delegate: this);

  @override
  bool get forcePressEnabled => defaultTargetPlatform == TargetPlatform.iOS;

  @override
  bool get selectionEnabled => widget.enabled;

  @override
  Widget build(BuildContext context) => gestures.buildGestureDetector(
    behavior: HitTestBehavior.translucent,
    child: widget.builder(context, editableTextKey),
  );
}
