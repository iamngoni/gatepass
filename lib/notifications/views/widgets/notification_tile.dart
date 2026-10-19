// Gatepass — notification_tile.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/app_notification.dart';
import '../../models/data/notification_kind.dart';
import '../../state/notifications/notifications_bloc.dart';

/// One notification; tapping an unread one marks it read.
class NotificationTile extends StatelessWidget {
  const NotificationTile({required this.notification, super.key});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final n = notification;
    final format = context.format;
    final (icon, tone) = switch (n.kind) {
      NotificationKind.arrival => (GpIcons.arrivals, Tone.accent),
      NotificationKind.departure => (GpIcons.departures, Tone.neutral),
      NotificationKind.notice => (GpIcons.notice, Tone.warning),
    };

    return Pressable(
      onTap: n.read
          ? null
          : () => context.read<NotificationsBloc>().add(
              NotificationsEvent.markReadRequested(ids: [n.id]),
            ),
      child: ColoredBox(
        color: colors.surface,
        child: Padding(
          padding: const EdgeInsets.all(GpSpace.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBadge(icon: icon, tone: tone, size: 40),
              const SizedBox(width: GpSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      n.title,
                      style: context.type.heading.weighted(
                        n.read ? FontWeight.w500 : FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: GpSpace.xxs),
                    Text(n.body, style: context.type.caption),
                    const SizedBox(height: GpSpace.xs),
                    Text(
                      context.l10n.notificationsTime(
                        format.day(n.time),
                        format.time(n.time),
                      ),
                      style: context.type.caption.copyWith(
                        color: colors.inkFaint,
                      ),
                    ),
                  ],
                ),
              ),
              if (!n.read)
                Container(
                  width: 9,
                  height: 9,
                  margin: const EdgeInsets.only(top: 6, left: GpSpace.sm),
                  decoration: const BoxDecoration(
                    color: GpColors.unread,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
