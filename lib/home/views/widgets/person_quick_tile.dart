//
//  Gatepass
//  person_quick_tile.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../../core/utils/invite_drafts.dart';
import '../../../core/utils/text_helpers.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../../invites/models/data/invite.dart';
import '../../../invites/views/pages/invite_detail_page.dart';
import '../../../invites/views/pages/invite_form_page.dart';
import '../../../invites/views/widgets/quick_invite_sheet.dart';
import 'quick_tile.dart';

/// Someone invited before. Tap invites them again on the same terms, or
/// opens the invite they already have.
class PersonQuickTile extends StatelessWidget {
  const PersonQuickTile({required this.last, required this.live, super.key});

  /// Their latest invite.
  final Invite last;

  /// Their invite that still works, if any.
  final Invite? live;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final current = live;
    return QuickTile(
      label: last.firstName,
      badge: current != null,
      semantics: current != null
          ? l10n.homeAlreadyInvited(last.visitorName)
          : l10n.homeInviteAgain(last.visitorName),
      onTap: current != null
          ? () => pushPage<void>(
              context,
              (_) => InviteDetailPage(inviteId: current.id),
            )
          : () => quickInvite(context, reinviteDraft(last, DateTime.now())),
      onLongPress: () => openInviteForm(
        context,
        initial: reinviteDraft(last, DateTime.now()),
      ),
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
