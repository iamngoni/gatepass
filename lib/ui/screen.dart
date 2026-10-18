// The screen shell and header, in place of Scaffold and AppBar. Big page
// titles are drawn in the content itself; the header is a plain 56pt bar.
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'icons.dart';
import 'theme.dart';

class GpScreen extends StatelessWidget {
  const GpScreen({
    super.key,
    required this.child,
    this.header,
    this.bottomBar,
    this.safeTop = true,
    this.avoidKeyboard = false,
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

/// A plain bar: a back chevron (or a close cross on a page that slid up), a
/// centred title and up to a couple of trailing actions.
class GpHeader extends StatelessWidget {
  const GpHeader({
    super.key,
    this.title,
    this.trailing,
    this.showBack = true,
    this.onBack,
  });

  final String? title;
  final Widget? trailing;
  final bool showBack;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final canPop = route?.impliesAppBarDismissal ?? false;
    final modal = route is PageRoute && route.fullscreenDialog;
    return SizedBox(
      height: GpSizes.header,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GpSpace.sm),
        child: NavigationToolbar(
          leading: showBack && canPop
              ? GpIconButton(
                  icon: modal ? GpIcons.close : GpIcons.chevronLeft,
                  label: modal ? 'Close' : 'Back',
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                )
              : null,
          middle: title == null
              ? null
              : Text(
                  title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.type.action.weighted(FontWeight.w700),
                ),
          trailing: trailing,
        ),
      ),
    );
  }
}

/// The fixed strip under a form: canvas, a top hairline, safe-area padding.
class GpBottomBar extends StatelessWidget {
  const GpBottomBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.canvas,
        border: Border(
          top: BorderSide(color: colors.line, width: GpSizes.hairline),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            GpSpace.gutter,
            GpSpace.md,
            GpSpace.gutter,
            GpSpace.md,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// A tab's big title, drawn in the page.
class PageTitle extends StatelessWidget {
  const PageTitle(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      GpSpace.gutter,
      GpSpace.lg,
      GpSpace.sm,
      GpSpace.lg,
    ),
    child: Row(
      children: [
        Expanded(child: Text(text, style: context.type.display)),
        ?trailing,
      ],
    ),
  );
}

/// A section's title with an optional text action: "Live invites  All".
class SectionHeading extends StatelessWidget {
  const SectionHeading(this.title, {super.key, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      GpSpace.gutter,
      GpSpace.xxl,
      GpSpace.sm,
      GpSpace.md,
    ),
    child: Row(
      children: [
        Expanded(child: Text(title, style: context.type.cardTitle)),
        if (action != null)
          GpButton(
            label: action!,
            onPressed: onAction,
            variant: GpButtonVariant.text,
            size: GpButtonSize.compact,
            expand: false,
          ),
      ],
    ),
  );
}

/// Small group label above a list: TODAY, UPCOMING.
class GroupLabel extends StatelessWidget {
  const GroupLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      GpSpace.gutter,
      GpSpace.xl,
      GpSpace.gutter,
      GpSpace.sm,
    ),
    child: Text(text.toUpperCase(), style: context.type.overline),
  );
}

/// Bottom padding for a scroll view, so its last row clears the tab bar
/// and the home indicator.
double scrollEnd(BuildContext context) =>
    MediaQuery.paddingOf(context).bottom + GpSpace.xxxl;
