// Gatepass — gate_pass_card.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/invite.dart';
import 'invite_avatar.dart';

/// The gate pass as a picture: who it's for, the estate and window, then
/// the QR and code. Always light, like a printed pass, so any scanner reads
/// it.
class GatePassCard extends StatelessWidget {
  const GatePassCard({required this.invite, required this.siteName, super.key});

  final Invite invite;
  final String siteName;

  static const width = 360.0;

  @override
  Widget build(BuildContext context) => GpTheme(
    data: GpThemeData.light,
    child: MediaQuery.withNoTextScaling(
      child: Builder(
        builder: (context) {
          final colors = context.colors;
          final type = context.type;
          final l10n = context.l10n;
          return Container(
            width: width,
            color: colors.canvas,
            padding: const EdgeInsets.fromLTRB(
              GpSpace.xl,
              GpSpace.xxxl,
              GpSpace.xl,
              GpSpace.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InviteAvatar(invite: invite, size: 64),
                const SizedBox(height: GpSpace.lg),
                Text(
                  invite.isService
                      ? l10n.inviteServiceCanComeIn(invite.displayName)
                      : l10n.invitePersonInvited(invite.firstName),
                  style: type.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: GpSpace.xs),
                Text(
                  l10n.passSiteAndWindow(
                    siteName,
                    context.format.validity(invite),
                  ),
                  style: type.body.copyWith(color: colors.inkMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: GpSpace.xl),
                GatePass(code: invite.code, caption: l10n.passCaption),
              ],
            ),
          );
        },
      ),
    ),
  );
}
