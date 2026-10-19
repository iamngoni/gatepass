// Gatepass — gp_header.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_icons.dart';
import '../../configs/gp_spacing.dart';
import '../../configs/gp_type.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'gp_icon_button.dart';

/// A plain bar: a back chevron (or a close cross on a page that slid up), a
/// centred title and up to a couple of trailing actions.
class GpHeader extends StatelessWidget {
  const GpHeader({
    this.title,
    this.trailing,
    this.showBack = true,
    this.onBack,
    super.key,
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
