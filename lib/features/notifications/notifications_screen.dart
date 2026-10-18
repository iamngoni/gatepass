import 'package:flutter/widgets.dart';

import '../../data/models.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import '../activity/entry_detail_screen.dart';
import '../visitors/invite_detail_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final unread = state.notifications.where((n) => !n.read).toList();
    final earlier = state.notifications.where((n) => n.read).toList();

    return GpScreen(
      header: GpHeader(
        title: 'Notifications',
        trailing: unread.isEmpty
            ? null
            : GpButton(
                label: 'Mark all read',
                variant: GpButtonVariant.text,
                size: GpButtonSize.compact,
                expand: false,
                onPressed: state.markAllRead,
              ),
      ),
      child: state.notifications.isEmpty
          ? const Center(
              child: EmptyPanel(
                icon: GpIcons.bellOff,
                title: 'You’re all caught up',
                body: 'Arrivals, departures and estate notices show up here.',
              ),
            )
          : ListView(
              padding: EdgeInsets.only(bottom: scrollEnd(context)),
              children: [
                if (unread.isNotEmpty) ...[
                  const GroupLabel('New'),
                  _Group(unread),
                ],
                if (earlier.isNotEmpty) ...[
                  const GroupLabel('Earlier'),
                  _Group(earlier),
                ],
              ],
            ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group(this.items);

  final List<AppNotification> items;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
    child: GpGroup(
      inset: 68,
      children: [for (final n in items) _NotificationTile(n)],
    ),
  );
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile(this.n);

  final AppNotification n;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (icon, tone) = switch (n.kind) {
      NotificationKind.arrival => (GpIcons.arrivals, Tone.accent),
      NotificationKind.departure => (GpIcons.departures, Tone.neutral),
      NotificationKind.prescreen => (GpIcons.verified, Tone.info),
      NotificationKind.notice => (GpIcons.notice, Tone.warning),
    };

    return Pressable(
      onTap: () {
        final state = AppScope.read(context);
        if (!n.read) state.markRead(n.id);
        final Widget? target = n.entryId != null
            ? EntryDetailScreen(entryId: n.entryId!)
            : n.inviteId != null
            ? InviteDetailScreen(inviteId: n.inviteId!)
            : null;
        if (target != null) pushPage<void>(context, (_) => target);
      },
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
                      '${dayLabel(n.time)}, ${formatTime(n.time)}',
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
