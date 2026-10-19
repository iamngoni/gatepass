// Gatepass — app.dart. Created 2026-10-18.
// The app root is a WidgetsApp, the unstyled foundation: Gatepass's own
// tokens, type and routes, with no MaterialApp or ThemeData underneath.
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/state/session/session_bloc.dart';
import 'auth/views/pages/launch_page.dart';
import 'auth/views/pages/sign_in_page.dart';
import 'core/state/appearance/appearance_bloc.dart';
import 'core/views/widgets/gp_widgets.dart';
import 'home/views/pages/home_shell_page.dart';
import 'invites/state/invites/invites_bloc.dart';
import 'l10n/generated/app_localizations.dart';
import 'notifications/state/notifications/notifications_bloc.dart';

class GatepassApp extends StatefulWidget {
  const GatepassApp({super.key});

  @override
  State<GatepassApp> createState() => _GatepassAppState();
}

class _GatepassAppState extends State<GatepassApp> {
  /// Dev aid: after a hot reload, refetch so live API shapes can be checked
  /// without signing in again. Never runs in release.
  @override
  void reassemble() {
    super.reassemble();
    if (!kDebugMode) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<InvitesBloc>().add(const InvitesEvent.refreshRequested());
      context.read<NotificationsBloc>().add(
        const NotificationsEvent.refreshRequested(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appearance = context.select(
      (AppearanceBloc bloc) => bloc.state.appearance,
    );
    final session = context.watch<SessionBloc>().state;
    return WidgetsApp(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      color: GpColors.brand,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      pageRouteBuilder: <T>(settings, builder) =>
          GpPageRoute<T>(builder: builder, settings: settings),
      builder: (context, child) {
        final theme = switch (appearance) {
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
      home: switch (session) {
        SessionSignedInState() => const HomeShellPage(),
        SessionRestoringState() => const LaunchPage(),
        SessionSignedOutState() => const SignInPage(),
      },
    );
  }
}
