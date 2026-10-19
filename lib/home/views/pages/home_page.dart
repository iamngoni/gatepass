// Gatepass — home_page.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/state/session/session_bloc.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../../invites/state/invites/invites_bloc.dart';
import '../../../invites/views/widgets/gate_refresh.dart';
import '../../../invites/views/widgets/invite_tile.dart';
import '../../../notifications/state/notifications/notifications_bloc.dart';
import '../../../notifications/views/pages/notifications_page.dart';
import '../widgets/estate_heading.dart';
import '../widgets/quick_invite_panel.dart';

/// Built around one job: letting someone in, in a single tap, and taking it
/// back just as fast.
class HomePage extends StatelessWidget {
  const HomePage({required this.onOpenTab, super.key});

  final ValueChanged<int> onOpenTab;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final live = context.select((InvitesBloc bloc) => bloc.state.live);
    final unread = context.select(
      (NotificationsBloc bloc) => bloc.state.unreadCount,
    );
    final firstName =
        context.select(
          (SessionBloc bloc) => bloc.state.signedInAccount?.resident.firstName,
        ) ??
        '';

    return GpScreen(
      child: GpRefresh(
        onRefresh: () => refreshGate(context),
        child: ListView(
          physics: GpRefresh.physics,
          padding: EdgeInsets.only(bottom: scrollEnd(context)),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                GpSpace.gutter - GpSpace.sm,
                GpSpace.sm,
                GpSpace.sm,
                0,
              ),
              child: Row(
                children: [
                  const Expanded(child: EstateHeading()),
                  GpIconButton(
                    icon: GpIcons.bell,
                    label: unread == 0
                        ? l10n.notificationsTitle
                        : l10n.homeUnreadNotifications(unread),
                    badge: unread,
                    onPressed: () => pushPage<void>(
                      context,
                      (_) => const NotificationsPage(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                GpSpace.gutter,
                GpSpace.md,
                GpSpace.gutter,
                GpSpace.xl,
              ),
              child: Text(
                l10n.homeGreeting(
                  context.format.greeting(DateTime.now()),
                  firstName,
                ),
                style: context.type.display,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: GpSpace.gutter),
              child: QuickInvitePanel(),
            ),
            SectionHeading(
              l10n.homeLiveInvites,
              action: l10n.homeAllVisitors,
              onAction: () => onOpenTab(1),
            ),
            if (live.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
                child: GpGroup(
                  inset: GpSpace.lg,
                  children: [
                    GpRow(
                      leading: const IconBadge(
                        icon: GpIcons.calendarCheck,
                        tone: Tone.accent,
                        size: 40,
                      ),
                      title: l10n.homeNoLiveTitle,
                      subtitle: l10n.homeNoLiveBody,
                    ),
                  ],
                ),
              )
            else ...[
              TileGroup(
                children: [
                  for (final i in live.take(5))
                    InviteTile(invite: i, revocable: true),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  GpSpace.gutter,
                  GpSpace.sm,
                  GpSpace.gutter,
                  0,
                ),
                child: Text(
                  l10n.visitorsSwipeHint,
                  style: context.type.caption.copyWith(color: colors.inkFaint),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
