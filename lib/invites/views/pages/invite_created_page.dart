//
//  Gatepass
//  invite_created_page.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/invite.dart';
import '../widgets/share_sheet.dart';

/// Shown right after creating an invite: the next job is sharing it.
class InviteCreatedPage extends StatelessWidget {
  const InviteCreatedPage({required this.invite, super.key});

  final Invite invite;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    return GpScreen(
      bottomBar: GpBottomBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GpButton(
              label: l10n.inviteCreatedShare,
              icon: GpIcons.share,
              size: GpButtonSize.large,
              onPressed: invite.code.isEmpty
                  ? null
                  : () => showShareOptions(context, invite),
            ),
            const SizedBox(height: GpSpace.sm),
            GpButton(
              label: l10n.commonDone,
              variant: GpButtonVariant.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          GpSpace.gutter,
          GpSpace.xxxl,
          GpSpace.gutter,
          GpSpace.xxl,
        ),
        children: [
          Row(
            children: [
              const IconBadge(icon: GpIcons.check, tone: Tone.accent),
              const SizedBox(width: GpSpace.md),
              Expanded(
                child: Text(
                  l10n.inviteCreatedTitle,
                  style: context.type.display,
                ),
              ),
            ],
          ),
          const SizedBox(height: GpSpace.sm),
          Text(
            l10n.inviteCreatedBody(invite.firstName),
            style: context.type.body.copyWith(color: colors.inkMuted),
          ),
          const SizedBox(height: GpSpace.xl),
          GatePass(code: invite.code),
          const SizedBox(height: GpSpace.lg),
          GpGroup(
            inset: GpSpace.lg,
            children: [
              DetailRow(
                icon: GpIcons.clock,
                label: l10n.inviteCreatedValid,
                value: context.format.validity(invite),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
