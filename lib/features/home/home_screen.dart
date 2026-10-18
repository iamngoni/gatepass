import 'package:flutter/widgets.dart';

import '../../data/models.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import '../../widgets/tiles.dart';
import '../notifications/notifications_screen.dart';
import '../pass/pass_screen.dart';
import '../visitors/invite_actions.dart';
import '../visitors/invite_detail_screen.dart';
import '../visitors/invite_form_screen.dart';

/// Built around one job: letting someone in, in a single tap, and taking it
/// back just as fast.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onOpenTab});

  final ValueChanged<int> onOpenTab;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final colors = context.colors;
    final live = state.live;
    final recent = state.entries.take(3).toList();

    return GpScreen(
      child: ListView(
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
                const Expanded(child: _SiteSwitcher()),
                GpIconButton(
                  icon: GpIcons.refresh,
                  label: 'Refresh',
                  onPressed: () => state.refresh(),
                ),
                GpIconButton(
                  icon: GpIcons.pass,
                  label: 'My pass',
                  onPressed: () => openPass(context),
                ),
                GpIconButton(
                  icon: GpIcons.bell,
                  label: state.unreadCount == 0
                      ? 'Notifications'
                      : '${state.unreadCount} unread notifications',
                  badge: state.unreadCount,
                  onPressed: () => pushPage<void>(
                    context,
                    (_) => const NotificationsScreen(),
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
              '${greeting(DateTime.now())}, ${state.resident!.firstName}',
              style: context.type.display,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: GpSpace.gutter),
            child: _QuickInvitePanel(),
          ),
          SectionHeading(
            'Live invites',
            action: 'All visitors',
            onAction: () => onOpenTab(1),
          ),
          if (live.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
              child: Text(
                'No live invites. Tap a tile above to let someone in.',
                style: context.type.body.copyWith(color: colors.inkMuted),
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
                'Swipe an invite left to revoke it.',
                style: context.type.caption.copyWith(color: colors.inkFaint),
              ),
            ),
          ],
          SectionHeading(
            'Recent activity',
            action: 'See all',
            onAction: () => onOpenTab(2),
          ),
          if (recent.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
              child: Text(
                'Nothing yet.',
                style: context.type.body.copyWith(color: colors.inkMuted),
              ),
            )
          else
            TileGroup(
              children: [
                for (final e in recent)
                  EntryTile(entry: e, showDay: !isToday(e.time)),
              ],
            ),
        ],
      ),
    );
  }
}

void openPass(BuildContext context) =>
    pushPage<void>(context, (_) => const PassScreen(), fullscreenDialog: true);

/// Delivery services and people from past invites, on the forest brand
/// surface. Tap creates a code straight away; hold opens the full form,
/// prefilled.
class _QuickInvitePanel extends StatelessWidget {
  const _QuickInvitePanel();

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final type = context.type;

    Widget label(String text) => Padding(
      padding: const EdgeInsets.fromLTRB(GpSpace.xl, 0, GpSpace.xl, GpSpace.sm),
      child: Text(
        text.toUpperCase(),
        style: type.overline.copyWith(color: GpColors.onBrandMuted),
      ),
    );

    return Container(
      padding: const EdgeInsets.only(top: GpSpace.xl, bottom: GpSpace.md),
      decoration: BoxDecoration(
        color: GpColors.brand,
        borderRadius: BorderRadius.circular(GpRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GpSpace.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let someone in',
                  style: type.title.copyWith(color: GpColors.onBrand),
                ),
                const SizedBox(height: GpSpace.xs),
                Text(
                  'One tap creates a gate code. Hold a tile to adjust it.',
                  style: type.small.copyWith(color: GpColors.onBrandMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: GpSpace.xl),
          label('Deliveries & rides'),
          _TileRow(
            children: [
              for (final s in state.servicesByUse)
                _QuickTile(
                  label: s.name,
                  semantics: 'Create a gate code for ${s.name}',
                  onTap: () => quickInvite(context, state.serviceDraft(s)),
                  onLongPress: () =>
                      openInviteForm(context, initial: state.serviceDraft(s)),
                  child: Icon(s.kind.icon, color: GpColors.onBrand, size: 22),
                ),
            ],
          ),
          const SizedBox(height: GpSpace.sm),
          label('People you’ve invited'),
          _TileRow(
            children: [
              _QuickTile(
                label: 'Someone new',
                semantics: 'Invite someone new',
                outlined: true,
                onTap: () => openInviteForm(context),
                child: const Icon(
                  GpIcons.add,
                  color: GpColors.onBrand,
                  size: 22,
                ),
              ),
              for (final last in state.recentPeople)
                _personTile(context, state, last),
            ],
          ),
        ],
      ),
    );
  }

  Widget _personTile(BuildContext context, AppState state, Invite last) {
    final live = state.liveInviteFor(last.visitorName);
    return _QuickTile(
      label: last.firstName,
      badge: live != null,
      semantics: live != null
          ? '${last.visitorName} already has an invite'
          : 'Invite ${last.visitorName} again',
      onTap: live != null
          ? () => pushPage<void>(
              context,
              (_) => InviteDetailScreen(inviteId: live.id),
            )
          : () => quickInvite(
              context,
              state.reinviteDraft(last),
              note: last.prescreenedAt != null
                  ? 'Verified before · no pre-screen'
                  : null,
            ),
      onLongPress: () =>
          openInviteForm(context, initial: state.reinviteDraft(last)),
      child: Text(
        initials(last.visitorName),
        style: context.type.bodyStrong.copyWith(
          color: GpColors.onBrand,
          height: 1,
        ),
      ),
    );
  }
}

class _TileRow extends StatelessWidget {
  const _TileRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 100,
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: GpSpace.md),
      children: children,
    ),
  );
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.label,
    required this.semantics,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.badge = false,
    this.outlined = false,
  });

  final String label;
  final String semantics;
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  /// Marks a person who already has a live invite.
  final bool badge;

  /// The "Someone new" tile: an outline instead of a fill.
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semantics,
      excludeSemantics: true,
      child: Pressable(
        onTap: onTap,
        onLongPress: onLongPress,
        child: SizedBox(
          width: 76,
          child: Column(
            children: [
              const SizedBox(height: GpSpace.xs),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: outlined ? null : GpColors.brandRaised,
                      borderRadius: BorderRadius.circular(GpRadius.lg),
                      border: outlined
                          ? Border.all(color: GpColors.brandLine)
                          : null,
                    ),
                    child: child,
                  ),
                  if (badge)
                    Positioned(
                      right: -3,
                      bottom: -3,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: GpColors.brandMint,
                          shape: BoxShape.circle,
                          border: Border.all(color: GpColors.brand, width: 2.5),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: GpSpace.sm),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: context.type.caption.copyWith(
                  color: GpColors.onBrand,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SiteSwitcher extends StatelessWidget {
  const _SiteSwitcher();

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final colors = context.colors;
    final canSwitch = state.sites.length > 1;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Pressable(
        onTap: canSwitch ? () => showSitePicker(context) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GpSpace.sm,
            vertical: GpSpace.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.site.name,
                      style: context.type.section,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(state.site.area, style: context.type.caption),
                  ],
                ),
              ),
              if (canSwitch) ...[
                const SizedBox(width: GpSpace.xs),
                Icon(GpIcons.chevronsUpDown, size: 18, color: colors.inkMuted),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showSitePicker(BuildContext context) {
  final state = AppScope.read(context);
  return showGpSheet<void>(
    context,
    builder: (sheet) => Padding(
      padding: const EdgeInsets.fromLTRB(
        GpSpace.gutter,
        GpSpace.sm,
        GpSpace.gutter,
        GpSpace.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your properties', style: sheet.type.title),
          const SizedBox(height: GpSpace.lg),
          GpGroup(
            children: [
              for (final s in state.sites)
                GpRow(
                  leading: IconBadge(
                    icon: GpIcons.property,
                    tone: s.id == state.site.id ? Tone.accent : Tone.neutral,
                    size: 40,
                  ),
                  title: s.name,
                  subtitle: '${s.unit} · ${s.area}',
                  trailing: s.id == state.site.id
                      ? Icon(
                          GpIcons.check,
                          color: sheet.colors.accent,
                          size: 20,
                        )
                      : null,
                  onTap: () {
                    Navigator.of(sheet).pop();
                    state.selectSite(s);
                  },
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
