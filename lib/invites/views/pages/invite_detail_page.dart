// Gatepass — invite_detail_page.dart. Created 2026-10-19.
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/extensions/invite_status_extensions.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../state/invites/invites_bloc.dart';
import '../widgets/invite_avatar.dart';
import '../widgets/revoke_confirmation.dart';
import '../widgets/share_sheet.dart';

class InviteDetailPage extends StatelessWidget {
  const InviteDetailPage({required this.inviteId, super.key});

  final String inviteId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final invite = context.select(
      (InvitesBloc bloc) => bloc.state.inviteById(inviteId),
    );
    if (invite == null) {
      return GpScreen(
        header: const GpHeader(),
        child: Center(
          child: EmptyPanel(
            icon: GpIcons.personMissing,
            title: l10n.inviteNotFoundTitle,
            body: l10n.inviteNotFoundBody,
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
                        context.format.validity(invite),
                        style: context.type.small.copyWith(
                          color: context.colors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: GpSpace.sm),
                StatusPill(
                  label: invite.status.label(l10n),
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
                    ? l10n.inviteDetailServiceCaption
                    : l10n.inviteDetailPersonCaption(invite.firstName),
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
                      label: l10n.inviteCopyCode,
                      icon: GpIcons.copy,
                      variant: GpButtonVariant.secondary,
                      onPressed: invite.code.isEmpty
                          ? null
                          : () async {
                              await Clipboard.setData(
                                ClipboardData(text: invite.code),
                              );
                              if (context.mounted) {
                                Toast.show(context, l10n.inviteCodeCopied);
                              }
                            },
                    ),
                  ),
                  const SizedBox(width: GpSpace.sm),
                  Expanded(
                    child: GpButton(
                      label: l10n.inviteShare,
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
          SectionHeading(l10n.inviteDetails),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
            child: GpGroup(
              inset: GpSpace.lg,
              children: [
                if (invite.phone case final phone?)
                  DetailRow(
                    icon: GpIcons.phone,
                    label: l10n.inviteMobile,
                    value: phone,
                  ),
                if (invite.vehicleReg case final reg?)
                  DetailRow(
                    icon: GpIcons.car,
                    label: l10n.inviteVehicle,
                    value: reg,
                  ),
                DetailRow(
                  icon: GpIcons.calendar,
                  label: l10n.inviteAdded,
                  value: context.format.full(invite.createdAt),
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
                    ? l10n.inviteRevokeCode
                    : l10n.inviteRevokePerson(invite.firstName),
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
