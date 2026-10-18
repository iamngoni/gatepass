// The app root is a WidgetsApp, the unstyled foundation: Gatepass's own
// tokens, type and routes, with no MaterialApp or ThemeData underneath.
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'features/account/account_screen.dart';
import 'features/activity/activity_screen.dart';
import 'features/auth/sign_in_screen.dart';
import 'features/home/home_screen.dart';
import 'features/visitors/invite_form_screen.dart';
import 'features/visitors/visitors_screen.dart';
import 'state/app_state.dart';
import 'ui/ui.dart';

class GatepassApp extends StatefulWidget {
  const GatepassApp({super.key, required this.state});

  final AppState state;

  @override
  State<GatepassApp> createState() => _GatepassAppState();
}

class _GatepassAppState extends State<GatepassApp> {
  /// Dev aid: after a hot reload, refetch so live API shapes can be checked
  /// without signing in again. Never runs in release.
  @override
  void reassemble() {
    super.reassemble();
    if (kDebugMode && widget.state.signedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.state.refresh();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return AppScope(
      state: state,
      child: ListenableBuilder(
        listenable: state,
        builder: (context, _) => WidgetsApp(
          title: 'Gatepass',
          debugShowCheckedModeBanner: false,
          color: GpColors.brand,
          pageRouteBuilder: <T>(settings, builder) =>
              GpPageRoute<T>(builder: builder, settings: settings),
          builder: (context, child) {
            final theme = switch (state.appearance) {
              Appearance.light => GpThemeData.light,
              Appearance.dark => GpThemeData.dark,
              Appearance.system =>
                MediaQuery.platformBrightnessOf(context) == Brightness.dark
                    ? GpThemeData.dark
                    : GpThemeData.light,
            };
            return GpTheme(
              data: theme,
              child: Builder(
                builder: (context) => DefaultTextStyle(
                  style: context.type.body,
                  child: IconTheme(
                    data: IconThemeData(color: theme.colors.ink, size: 22),
                    child: AnnotatedRegion<SystemUiOverlayStyle>(
                      value: theme.isDark
                          ? SystemUiOverlayStyle.light
                          : SystemUiOverlayStyle.dark,
                      child: ColoredBox(
                        color: theme.colors.canvas,
                        child: ToastHost(child: child ?? const SizedBox()),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          home: state.signedIn ? const HomeShell() : const SignInScreen(),
        ),
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  void _go(int index) => setState(() => _index = index);

  static const _tabs = [
    GpTab(GpIcons.home, 'Home'),
    GpTab(GpIcons.visitors, 'Visitors'),
    GpTab(GpIcons.activity, 'Activity'),
    GpTab(GpIcons.account, 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    // Pages scroll under the bar; their lists end with scrollEnd() so the
    // last row clears it.
    return Stack(
      children: [
        MediaQuery(
          data: media.copyWith(
            padding: media.padding.copyWith(
              bottom: media.padding.bottom + GpSizes.tabBar - 8,
            ),
          ),
          child: IndexedStack(
            index: _index,
            children: [
              HomeScreen(onOpenTab: _go),
              const VisitorsScreen(),
              const ActivityScreen(),
              const AccountScreen(),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: GpTabBar(
            tabs: _tabs,
            selectedIndex: _index,
            onSelect: _go,
            addLabel: 'Invite someone',
            onAdd: () => openInviteForm(context),
          ),
        ),
      ],
    );
  }
}
