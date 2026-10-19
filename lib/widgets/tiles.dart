import 'package:flutter/widgets.dart';

import '../data/models.dart';
import '../features/visitors/invite_actions.dart';
import '../features/visitors/invite_detail_screen.dart';
import '../ui/ui.dart';
import '../util/format.dart';
import 'common.dart';

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
                    Text(invite.displayName, style: context.type.heading),
                    const SizedBox(height: GpSpace.xxs),
                    Text(
                      inviteValidityLabel(invite),
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
              // Every live invite is active, so the pill would only repeat
              // the list it sits in; past ones say how they ended.
              if (invite.status.isLive)
                Icon(GpIcons.chevronRight, size: 18, color: colors.chevron)
              else
                StatusPill(
                  label: invite.status.label,
                  tone: invite.status.tone,
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
