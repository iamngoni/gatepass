//
//  Gatepass
//  gp_screen.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

// The screen shell and header, in place of Scaffold and AppBar. Big page
// titles are drawn in the content itself; the header is a plain 56pt bar.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

class GpScreen extends StatelessWidget {
  const GpScreen({
    required this.child,
    this.header,
    this.bottomBar,
    this.safeTop = true,
    this.avoidKeyboard = false,
    super.key,
  });

  final Widget child;
  final Widget? header;

  /// Pinned under the content, such as a Create button.
  final Widget? bottomBar;
  final bool safeTop;

  /// Lifts the content and [bottomBar] above the software keyboard.
  final bool avoidKeyboard;

  @override
  Widget build(BuildContext context) {
    final keyboard = avoidKeyboard
        ? MediaQuery.viewInsetsOf(context).bottom
        : 0.0;
    Widget body = Column(
      children: [
        ?header,
        Expanded(child: child),
        if (bottomBar != null)
          MediaQuery.removePadding(
            context: context,
            removeBottom: keyboard > 0,
            child: bottomBar!,
          ),
      ],
    );
    if (safeTop) body = SafeArea(bottom: false, child: body);
    return ColoredBox(
      color: context.colors.canvas,
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboard),
        child: body,
      ),
    );
  }
}

/// Bottom padding for a scroll view, so its last row clears the tab bar
/// and the home indicator.
double scrollEnd(BuildContext context) =>
    MediaQuery.paddingOf(context).bottom + GpSpace.xxxl;
