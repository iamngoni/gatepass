// Gatepass — providers.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'auth/state/session/session_bloc.dart';
import 'backup/state/backup/backup_bloc.dart';
import 'core/state/appearance/appearance_bloc.dart';
import 'core/views/widgets/app_listeners.dart';
import 'injection.dart';
import 'invites/state/invites/invites_bloc.dart';
import 'notifications/state/notifications/notifications_bloc.dart';

/// The app-wide BLoCs, above every route.
class GatepassProviders extends StatelessWidget {
  const GatepassProviders({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        lazy: false,
        create: (_) => getIt<SessionBloc>()..add(const SessionEvent.started()),
      ),
      BlocProvider(create: (_) => getIt<InvitesBloc>()),
      BlocProvider(create: (_) => getIt<NotificationsBloc>()),
      BlocProvider(create: (_) => getIt<BackupBloc>()),
      BlocProvider(create: (_) => getIt<AppearanceBloc>()),
    ],
    child: const AppListeners(child: GatepassApp()),
  );
}
