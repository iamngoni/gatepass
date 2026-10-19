// Gatepass — invite_tile_content.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../../data/models.dart';
import '../../../features/visitors/invite_detail_screen.dart';
import '../../configs/gp_icons.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import '../../utils/extensions/invite_status_extensions.dart';
import '../../utils/invite_labels.dart';
import 'gp_page_route.dart';
import 'invite_avatar.dart';
import 'pressable.dart';
import 'status_pill.dart';

/// An invite's row: its mark, name, validity and vehicle; tapping opens
/// the invite.
class InviteTileContent extends StatelessWidget {
  const InviteTileContent({required this.invite, super.key});

  final Invite invite;

  @override
  Widget build(BuildContext context) {
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
