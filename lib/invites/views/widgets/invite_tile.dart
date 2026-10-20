//
//  Gatepass
//  invite_tile.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../../core/configs/gp_icons.dart';
import '../../../core/configs/gp_spacing.dart';
import '../../../core/utils/extensions/build_context_extensions.dart';
import '../../../core/utils/extensions/localization_extensions.dart';
import '../../models/data/invite.dart';
import 'invite_tile_content.dart';
import 'revoke_confirmation.dart';

class InviteTile extends StatelessWidget {
  const InviteTile({required this.invite, this.revocable = false, super.key});

  final Invite invite;

  /// Swipe left to revoke, while the code still works.
  final bool revocable;

  @override
  Widget build(BuildContext context) {
    final tile = InviteTileContent(invite: invite);
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
                  context.l10n.commonRevoke,
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
}
