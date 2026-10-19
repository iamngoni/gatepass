import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import '../../widgets/gate_pass.dart';
import 'invite_actions.dart';
import 'share_invite.dart';

class InviteDetailScreen extends StatelessWidget {
  const InviteDetailScreen({super.key, required this.inviteId});

  final String inviteId;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final invite = state.inviteById(inviteId);
    if (invite == null) {
      return const GpScreen(
        header: GpHeader(),
        child: Center(
          child: EmptyPanel(
            icon: GpIcons.personMissing,
            title: 'Invite not found',
            body: 'It may belong to another property.',
          ),
        ),
      );
    }
    final live = invite.status.isLive;

    return GpScreen(
      header: const GpHeader(),
      child: ListView(
        padding: EdgeInsets.only(bottom: scrollEnd(context)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              GpSpace.gutter,
              GpSpace.sm,
              GpSpace.gutter,
              0,
            ),
            child: Row(
              children: [
                InviteAvatar(invite: invite, size: 56),
                const SizedBox(width: GpSpace.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(invite.displayName, style: context.type.title),
                      const SizedBox(height: GpSpace.xxs),
                      Text(
                        inviteValidityLabel(invite),
                        style: context.type.small.copyWith(
                          color: context.colors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: GpSpace.sm),
                StatusPill(
                  label: invite.status.label,
                  tone: invite.status.tone,
                ),
              ],
            ),
          ),
          if (live) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                GpSpace.gutter,
                GpSpace.xxl,
                GpSpace.gutter,
                0,
              ),
              child: GatePass(
                code: invite.code,
                caption: invite.isService
                    ? 'The guard scans this, or the driver gives the code.'
                    : 'Show this at the gate, or send ${invite.firstName} '
                          'the invite.',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                GpSpace.gutter,
                GpSpace.md,
                GpSpace.gutter,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GpButton(
                      label: 'Copy code',
                      icon: GpIcons.copy,
                      variant: GpButtonVariant.secondary,
                      onPressed: invite.code.isEmpty
                          ? null
                          : () async {
                              await Clipboard.setData(
                                ClipboardData(text: invite.code),
                              );
                              if (context.mounted) {
                                Toast.show(context, 'Code copied');
                              }
                            },
                    ),
                  ),
                  const SizedBox(width: GpSpace.sm),
                  Expanded(
                    child: GpButton(
                      label: 'Share',
                      icon: GpIcons.share,
                      onPressed: invite.code.isEmpty
                          ? null
                          : () => showShareOptions(context, invite),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SectionHeading('Details'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
            child: GpGroup(
              inset: GpSpace.lg,
              children: [
                if (invite.phone != null)
                  DetailRow(
                    icon: GpIcons.phone,
                    label: 'Mobile',
                    value: invite.phone!,
                  ),
                if (invite.vehicleReg != null)
                  DetailRow(
                    icon: GpIcons.car,
                    label: 'Vehicle',
                    value: invite.vehicleReg!,
                  ),
                DetailRow(
                  icon: GpIcons.calendar,
                  label: 'Added',
                  value: formatFull(invite.createdAt),
                ),
              ],
            ),
          ),
          if (live)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                GpSpace.gutter,
                GpSpace.xxxl,
                GpSpace.gutter,
                0,
              ),
              child: GpButton(
                label: invite.isService
                    ? 'Revoke code'
                    : 'Revoke ${invite.firstName}’s invite',
                icon: GpIcons.revoke,
                variant: GpButtonVariant.danger,
                onPressed: () => confirmRevoke(context, invite),
              ),
            ),
        ],
      ),
    );
  }
}
