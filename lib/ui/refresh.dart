// Pull-to-refresh without Material's RefreshIndicator: pull the list past its
// top edge, let go, and the content holds down over a spinner until the
// reload finishes.
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'activity.dart';
import 'theme.dart';

class GpRefresh extends StatefulWidget {
  const GpRefresh({super.key, required this.onRefresh, required this.child});

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
  static const _trigger = 72.0;
  static const _hold = 52.0;

  final _overscroll = ValueNotifier<double>(0);
  bool _armed = false;
  bool _refreshing = false;

  @override
  void dispose() {
    _overscroll.dispose();
    super.dispose();
  }

  bool _onScroll(ScrollNotification n) {
    if (n.depth != 0 || n.metrics.axis != Axis.vertical) return false;
    final over = (n.metrics.minScrollExtent - n.metrics.pixels).clamp(
      0.0,
      double.infinity,
    );
    _overscroll.value = over;
    if (_refreshing) return false;
    // Only a scroll update without a drag (the list springing back) or the
    // end of the scroll means the finger has lifted. Other notifications,
    // such as a direction change while easing back, arrive mid-drag.
    final released =
        n is ScrollEndNotification ||
        (n is ScrollUpdateNotification && n.dragDetails == null);
    if (n is ScrollUpdateNotification && n.dragDetails != null) {
      if (over >= _trigger && !_armed) {
        _armed = true;
        HapticFeedback.selectionClick();
      } else if (over < _trigger) {
        _armed = false;
      }
    } else if (_armed && released) {
      _armed = false;
      _refresh();
    }
    return false;
  }

  Future<void> _refresh() async {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        // VoiceOver and Switch Control can't overscroll, so the pull is also
        // offered as an action.
        child: Semantics(
          customSemanticsActions: {
            const CustomSemanticsAction(label: 'Refresh'): _refresh,
          },
          child: Stack(
            children: [
              AnimatedPadding(
                duration: GpMotion.slow,
                curve: GpMotion.riseCurve,
                padding: EdgeInsets.only(top: _refreshing ? _hold : 0),
                child: widget.child,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: ValueListenableBuilder<double>(
                    valueListenable: _overscroll,
                    builder: (context, over, _) {
                      final gap = _refreshing ? _hold + over : over;
                      final shown = _refreshing
                          ? 1.0
                          : (over / _trigger).clamp(0.0, 1.0);
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
        ),
      );
}
