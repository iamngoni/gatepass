// Gatepass — home_shell_page.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../account/views/pages/account_page.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../../invites/views/pages/invite_form_page.dart';
import '../../../invites/views/pages/visitors_page.dart';
import 'home_page.dart';

/// The signed-in app: Home, Visitors and Account under a floating tab bar.
class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key});

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  final index = ValueNotifier(0);

  @override
  void dispose() {
    index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final l10n = context.l10n;
    final tabs = [
      GpTab(GpIcons.home, l10n.tabHome),
      GpTab(GpIcons.visitors, l10n.tabVisitors),
      GpTab(GpIcons.account, l10n.tabAccount),
    ];
    // Pages scroll under the floating bar; their lists end with scrollEnd()
    // so the last row clears it.
    return ValueListenableBuilder<int>(
      valueListenable: index,
      builder: (context, selected, _) => Stack(
        children: [
          MediaQuery(
            data: media.copyWith(
              padding: media.padding.copyWith(
                bottom: GpTabBar.extent(media.padding.bottom),
              ),
            ),
            child: IndexedStack(
              index: selected,
              children: [
                HomePage(onOpenTab: (tab) => index.value = tab),
                const VisitorsPage(),
                const AccountPage(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GpTabBar(
              tabs: tabs,
              selectedIndex: selected,
              onSelect: (tab) => index.value = tab,
              addLabel: l10n.tabInviteSomeone,
              onAdd: () => openInviteForm(context),
            ),
          ),
        ],
      ),
    );
  }
}
