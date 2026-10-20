//
//  Gatepass
//  gp_refresh.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

// Pull-to-refresh without Material's RefreshIndicator: pull the list past its
// top edge, let go, and the content holds down over a spinner until the
// reload finishes.
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../configs/gp_motion.dart';
import '../../utils/extensions/localization_extensions.dart';
import 'gp_activity.dart';

class GpRefresh extends StatefulWidget {
  const GpRefresh({required this.onRefresh, required this.child, super.key});

  final Future<void> Function() onRefresh;

  /// A vertical scroll view using [GpRefresh.physics].
  final Widget child;

  /// Bouncing on every platform, so the pull shows past the top on Android
  /// too, and always scrollable, so a short list can still be pulled.
  static const physics = AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );

  @override
  State<GpRefresh> createState() => _GpRefreshState();
}

class _GpRefreshState extends State<GpRefresh> {
  /// How far past the top a pull has to go before letting go refreshes.
  static const trigger = 72.0;
  static const hold = 52.0;

  final overscroll = ValueNotifier<double>(0);

  /// True while [GpRefresh.onRefresh] runs: the content holds down.
  final refreshing = ValueNotifier(false);

  /// Past the trigger while the finger is still down.
  bool armed = false;

  bool onScroll(ScrollNotification n) {
    if (n.depth != 0 || n.metrics.axis != Axis.vertical) return false;
    final over = (n.metrics.minScrollExtent - n.metrics.pixels).clamp(
      0.0,
      double.infinity,
    );
    overscroll.value = over;
    if (refreshing.value) return false;
    // Only a scroll update without a drag (the list springing back) or the
    // end of the scroll means the finger has lifted. Other notifications,
    // such as a direction change while easing back, arrive mid-drag.
    final released =
        n is ScrollEndNotification ||
        (n is ScrollUpdateNotification && n.dragDetails == null);
    if (n is ScrollUpdateNotification && n.dragDetails != null) {
      if (over >= trigger && !armed) {
        armed = true;
        HapticFeedback.selectionClick();
      } else if (over < trigger) {
        armed = false;
      }
    } else if (armed && released) {
      armed = false;
      refresh();
    }
    return false;
  }

  Future<void> refresh() async {
    if (refreshing.value) return;
    refreshing.value = true;
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) refreshing.value = false;
    }
  }

  @override
  void dispose() {
    overscroll.dispose();
    refreshing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollNotification>(
        onNotification: onScroll,
        // VoiceOver and Switch Control can't overscroll, so the pull is also
        // offered as an action.
        child: Semantics(
          customSemanticsActions: {
            CustomSemanticsAction(label: context.l10n.commonRefresh): refresh,
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: refreshing,
            builder: (context, isRefreshing, child) => Stack(
              children: [
                AnimatedPadding(
                  duration: GpMotion.slow,
                  curve: GpMotion.riseCurve,
                  padding: EdgeInsets.only(top: isRefreshing ? hold : 0),
                  child: child,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: ValueListenableBuilder<double>(
                      valueListenable: overscroll,
                      builder: (context, over, _) {
                        final gap = isRefreshing ? hold + over : over;
                        final shown = isRefreshing
                            ? 1.0
                            : (over / trigger).clamp(0.0, 1.0);
                        if (shown == 0) return const SizedBox.shrink();
                        return SizedBox(
                          height: gap,
                          child: Center(
                            child: Opacity(
                              opacity: shown,
                              child: Transform.scale(
                                scale: .6 + .4 * shown,
                                child: const GpActivity(size: 24),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      );
}
