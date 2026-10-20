//
//  Gatepass
//  notifications_page.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../state/notifications/notifications_bloc.dart';
import '../widgets/notification_group.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final notifications = context.select(
      (NotificationsBloc bloc) => bloc.state.notifications,
    );
    final unread = notifications.where((n) => !n.read).toList();
    final earlier = notifications.where((n) => n.read).toList();

    return GpScreen(
      header: GpHeader(
        title: l10n.notificationsTitle,
        trailing: unread.isEmpty
            ? null
            : GpButton(
                label: l10n.notificationsMarkAllRead,
                variant: GpButtonVariant.text,
                size: GpButtonSize.compact,
                expand: false,
                onPressed: () => context.read<NotificationsBloc>().add(
                  const NotificationsEvent.markAllReadRequested(),
                ),
              ),
      ),
      child: notifications.isEmpty
          ? Center(
              child: EmptyPanel(
                icon: GpIcons.bellOff,
                title: l10n.notificationsEmptyTitle,
                body: l10n.notificationsEmptyBody,
              ),
            )
          : ListView(
              padding: EdgeInsets.only(bottom: scrollEnd(context)),
              children: [
                if (unread.isNotEmpty) ...[
                  GroupLabel(l10n.notificationsNew),
                  NotificationGroup(items: unread),
                ],
                if (earlier.isNotEmpty) ...[
                  GroupLabel(l10n.notificationsEarlier),
                  NotificationGroup(items: earlier),
                ],
              ],
            ),
    );
  }
}
