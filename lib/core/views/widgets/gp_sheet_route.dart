//
//  Gatepass
//  gp_sheet_route.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

// The app's own modal sheet: no Material sheet chrome. Safe area, keyboard,
// grab handle, drag-to-dismiss and transitions are defined here once.
import 'package:flutter/widgets.dart';

import '../../configs/gp_motion.dart';
import '../../utils/extensions/build_context_extensions.dart';
import '../../utils/extensions/localization_extensions.dart';
import 'gp_sheet_page.dart';

Future<T?> showGpSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  double maxHeightFactor = .92,
}) => Navigator.of(context).push<T>(
  GpSheetRoute<T>(
    builder: builder,
    barrier: context.colors.overlay,
    barrierText: context.l10n.commonClose,
    maxHeightFactor: maxHeightFactor,
  ),
);

class GpSheetRoute<T> extends PopupRoute<T> {
  GpSheetRoute({
    required this.builder,
    required this.barrier,
    required this.barrierText,
    this.maxHeightFactor = .92,
  });

  final WidgetBuilder builder;
  final Color barrier;

  /// What a screen reader calls the scrim, which closes the sheet.
  final String barrierText;
  final double maxHeightFactor;

  @override
  Color? get barrierColor => barrier;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => barrierText;

  @override
  Duration get transitionDuration => GpMotion.slow;

  @override
  Duration get reverseTransitionDuration => GpMotion.base;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) => GpSheetPage(builder: builder, maxHeightFactor: maxHeightFactor);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}
