// The app's own modal sheet: no Material sheet chrome. Safe area, keyboard,
// grab handle, drag-to-dismiss and transitions are defined here once.
import 'package:flutter/widgets.dart';

import 'theme.dart';

Future<T?> showGpSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  double maxHeightFactor = .92,
}) => Navigator.of(context).push<T>(
  GpSheetRoute<T>(
    builder: builder,
    barrier: context.colors.overlay,
    maxHeightFactor: maxHeightFactor,
  ),
);

class GpSheetRoute<T> extends PopupRoute<T> {
  GpSheetRoute({
    required this.builder,
    required this.barrier,
    this.maxHeightFactor = .92,
  });

  final WidgetBuilder builder;
  final Color barrier;
  final double maxHeightFactor;

  @override
  Color? get barrierColor => barrier;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'Close';

  @override
  Duration get transitionDuration => GpMotion.slow;

  @override
  Duration get reverseTransitionDuration => GpMotion.base;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) => _SheetPage(builder: builder, maxHeightFactor: maxHeightFactor);

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

class _SheetPage extends StatefulWidget {
  const _SheetPage({required this.builder, required this.maxHeightFactor});

  final WidgetBuilder builder;
  final double maxHeightFactor;

  @override
  State<_SheetPage> createState() => _SheetPageState();
}

class _SheetPageState extends State<_SheetPage> {
  final _offset = ValueNotifier<double>(0);

  @override
  void dispose() {
    _offset.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final delta = details.primaryDelta ?? 0;
    _offset.value = (_offset.value + delta).clamp(0, double.infinity);
  }

  void _onDragEnd(DragEndDetails details) {
    if (_offset.value > 120 || (details.primaryVelocity ?? 0) > 700) {
      Navigator.of(context).pop();
      return;
    }
    _offset.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final media = MediaQuery.of(context);
    final available =
        (media.size.height - media.padding.top - media.viewInsets.bottom).clamp(
          0.0,
          media.size.height,
        );
    return ValueListenableBuilder<double>(
      valueListenable: _offset,
      builder: (context, offset, _) => Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedPadding(
          duration: GpMotion.base,
          curve: GpMotion.curve,
          padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
          child: AnimatedContainer(
            duration: offset == 0
                ? GpMotion.base
                : const Duration(milliseconds: 1),
            curve: GpMotion.curveInOut,
            transform: Matrix4.translationValues(0, offset, 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600,
                maxHeight: available * widget.maxHeightFactor,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(GpRadius.sheet),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    border: Border(
                      top: BorderSide(
                        color: colors.line,
                        width: GpSizes.hairline,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onVerticalDragUpdate: _onDragUpdate,
                          onVerticalDragEnd: _onDragEnd,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Container(
                                width: 40,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: colors.control,
                                  borderRadius: BorderRadius.circular(
                                    GpRadius.pill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(child: widget.builder(context)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
