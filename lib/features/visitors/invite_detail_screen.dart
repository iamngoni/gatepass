import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import 'invite_actions.dart';

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
                InviteAvatar(invite: invite, size: 64),
                const SizedBox(width: GpSpace.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(invite.visitorName, style: context.type.title),
                      const SizedBox(height: GpSpace.sm),
                      StatusPill(
                        label: invite.status.label,
                        tone: invite.status.tone,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (live) ...[
            const SectionHeading('Gate code'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
              child: GpSurface(
                padding: const EdgeInsets.all(GpSpace.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            formatCode(invite.code),
                            style: context.type.code,
                          ),
                        ),
                        GpIconButton(
                          icon: GpIcons.copy,
                          label: 'Copy code',
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: invite.code),
                            );
                            if (context.mounted) {
                              Toast.show(context, 'Code copied');
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: GpSpace.xs),
                    Text(
                      'Share the link or code with ${invite.firstName}.',
                      style: context.type.caption,
                    ),
                    const SizedBox(height: GpSpace.lg),
                    GpButton(
                      label: 'Copy invite message',
                      icon: GpIcons.copy,
                      variant: GpButtonVariant.soft,
                      onPressed: () =>
                          shareInvite(context, invite, state.site.name),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SectionHeading('Details'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
            child: GpGroup(
              inset: GpSpace.lg,
              children: [
                DetailRow(
                  icon: GpIcons.clock,
                  label: 'Valid',
                  value: inviteValidityLabel(invite),
                ),
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
