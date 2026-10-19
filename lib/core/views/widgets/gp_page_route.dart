// Gatepass — gp_page_route.dart. Created 2026-10-18.
// Page navigation. On iOS the framework's page transition is also the edge
// swipe that takes someone back, so that one mixin is the only Cupertino
// piece in the app; page content stays the app's own.
import 'package:flutter/cupertino.dart' show CupertinoRouteTransitionMixin;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class GpPageRoute<T> extends PageRoute<T>
    with CupertinoRouteTransitionMixin<T> {
  GpPageRoute({required this.builder, super.fullscreenDialog, super.settings});

  final WidgetBuilder builder;

  @override
  String? get title => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return super.buildTransitions(
        context,
        animation,
        secondaryAnimation,
        child,
      );
    }
    if (MediaQuery.disableAnimationsOf(context)) return child;
    final curved = animation.drive(CurveTween(curve: Curves.easeOutCubic));
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween(
          begin: fullscreenDialog ? const Offset(0, .06) : const Offset(.05, 0),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}

Future<T?> pushPage<T>(
  BuildContext context,
  WidgetBuilder builder, {
  bool fullscreenDialog = false,
}) => Navigator.of(
  context,
).push<T>(GpPageRoute<T>(builder: builder, fullscreenDialog: fullscreenDialog));
