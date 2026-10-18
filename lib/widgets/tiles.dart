import 'package:flutter/widgets.dart';

import '../data/models.dart';
import '../features/activity/entry_detail_screen.dart';
import '../features/visitors/invite_actions.dart';
import '../features/visitors/invite_detail_screen.dart';
import '../ui/ui.dart';
import '../util/format.dart';
import 'common.dart';
import 'gate_camera.dart';

class InviteTile extends StatelessWidget {
  const InviteTile({super.key, required this.invite, this.revocable = false});

  final Invite invite;

  /// Swipe left to revoke, while the code still works.
  final bool revocable;

  @override
  Widget build(BuildContext context) {
    final tile = _content(context);
    if (!revocable || !invite.status.isLive) return tile;
    final colors = context.colors;
    return Dismissible(
      key: ValueKey('revoke-${invite.id}'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => confirmRevoke(context, invite),
      background: ColoredBox(
        color: colors.dangerSoft,
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: GpSpace.xl),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(GpIcons.revoke, size: 18, color: colors.danger),
                const SizedBox(width: GpSpace.sm),
                Text(
                  'Revoke',
                  style: context.type.bodyStrong.copyWith(color: colors.danger),
                ),
              ],
            ),
          ),
        ),
      ),
      child: tile,
    );
  }

  Widget _content(BuildContext context) {
    final colors = context.colors;
    final onSite = invite.status == InviteStatus.onSite;
    return Pressable(
      onTap: () => pushPage<void>(
        context,
        (_) => InviteDetailScreen(inviteId: invite.id),
      ),
      child: ColoredBox(
        color: colors.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GpSpace.lg,
            vertical: GpSpace.md,
          ),
          child: Row(
            children: [
              InviteAvatar(invite: invite),
              const SizedBox(width: GpSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invite.visitorName, style: context.type.heading),
                    const SizedBox(height: GpSpace.xxs),
                    Text(
                      onSite && invite.arrivedAt != null
                          ? invite.openEnded
                                ? 'Arrived ${formatTime(invite.arrivedAt!)}'
                                : 'Arrived ${formatTime(invite.arrivedAt!)} · until ${formatTime(invite.until)}'
                          : inviteValidityLabel(invite),
                      style: context.type.caption,
                    ),
                    if (invite.vehicleReg != null) ...[
                      const SizedBox(height: GpSpace.xxs),
                      Row(
                        children: [
                          Icon(GpIcons.car, size: 13, color: colors.inkFaint),
                          const SizedBox(width: GpSpace.xs),
                          Flexible(
                            child: Text(
                              invite.vehicleReg!,
                              style: context.type.caption,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: GpSpace.sm),
              StatusPill(label: invite.status.label, tone: invite.status.tone),
            ],
          ),
        ),
      ),
    );
  }
}

class EntryTile extends StatelessWidget {
  const EntryTile({super.key, required this.entry, this.showDay = false});

  final EntryEvent entry;
  final bool showDay;

  @override
  Widget build(BuildContext context) {
    final leading = entry.hasPhoto
        ? ClipRRect(
            borderRadius: BorderRadius.circular(GpRadius.sm),
            child: SizedBox.square(
              dimension: GpSizes.avatar,
              child: GateCameraSnapshot(
                seed: entry.id,
                gateName: entry.gateName,
                time: entry.time,
                withVehicle: entry.vehicleReg != null,
                showOverlay: false,
              ),
            ),
          )
        : IconBadge(
            icon: entry.isInbound ? GpIcons.arrivals : GpIcons.departures,
            tone: entry.isInbound ? Tone.accent : Tone.neutral,
          );

    return Pressable(
      onTap: () =>
          pushPage<void>(context, (_) => EntryDetailScreen(entryId: entry.id)),
      child: ColoredBox(
        color: context.colors.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GpSpace.lg,
            vertical: GpSpace.md,
          ),
          child: Row(
            children: [
              leading,
              const SizedBox(width: GpSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.headline, style: context.type.heading),
                    const SizedBox(height: GpSpace.xxs),
                    Text(
                      '${entry.gateName} · ${entry.method.label}',
                      style: context.type.caption,
                    ),
                  ],
                ),
              ),
              Text(
                showDay
                    ? '${dayLabel(entry.time)}, ${formatTime(entry.time)}'
                    : formatTime(entry.time),
                style: context.type.time,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tiles in one surface, inset by the page gutter.
class TileGroup extends StatelessWidget {
  const TileGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
    child: GpGroup(children: children),
  );
}
