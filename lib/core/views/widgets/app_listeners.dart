//
//  Gatepass
//  app_listeners.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/state/session/session_bloc.dart';
import '../../../backup/state/backup/backup_bloc.dart';
import '../../../invites/state/invites/invites_bloc.dart';
import '../../../notifications/state/notifications/notifications_bloc.dart';

/// Wires the app-wide BLoCs to each other: signing in starts the account's
/// invites, notifications and backup; local invite changes back up; a
/// backup's merge comes back to the invites.
class AppListeners extends StatelessWidget {
  const AppListeners({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiBlocListener(
    listeners: [
      BlocListener<SessionBloc, SessionState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          final invites = context.read<InvitesBloc>();
          final notifications = context.read<NotificationsBloc>();
          final backup = context.read<BackupBloc>();
          switch (state) {
            case SessionSignedInState(:final account):
              invites.add(InvitesEvent.started(account: account));
              notifications.add(
                NotificationsEvent.started(siteId: account.site.id),
              );
              backup.add(BackupEvent.started(accountId: account.resident.id));
            case SessionSignedOutState():
              invites.add(const InvitesEvent.cleared());
              notifications.add(const NotificationsEvent.cleared());
              backup.add(const BackupEvent.cleared());
            case SessionRestoringState():
              break;
          }
        },
      ),
      BlocListener<InvitesBloc, InvitesState>(
        listenWhen: (previous, current) =>
            current.accountId != null &&
            (previous.loaded != current.loaded ||
                previous.changeRevision != current.changeRevision),
        listener: (context, state) => context.read<BackupBloc>().add(
          BackupEvent.changed(invites: state.invites),
        ),
      ),
      BlocListener<BackupBloc, BackupState>(
        listenWhen: (previous, current) =>
            previous.mergedRevision != current.mergedRevision,
        listener: (context, state) {
          final merged = state.merged;
          final accountId = state.accountId;
          if (merged == null || accountId == null) return;
          context.read<InvitesBloc>().add(
            InvitesEvent.backupAdopted(accountId: accountId, invites: merged),
          );
        },
      ),
    ],
    child: child,
  );
}
