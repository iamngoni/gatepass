//
//  Gatepass
//  account_page.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/state/session/session_bloc.dart';
import '../../../backup/state/backup/backup_bloc.dart';
import '../../../backup/views/widgets/backup_sheet.dart';
import '../../../core/state/appearance/appearance_bloc.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../widgets/padded.dart';
import '../widgets/resident_card.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final account = context.select(
      (SessionBloc bloc) => bloc.state.signedInAccount,
    );
    if (account == null) return const SizedBox.shrink();
    final backupOn = context.select((BackupBloc bloc) => bloc.state.on);
    final appearance = context.select(
      (AppearanceBloc bloc) => bloc.state.appearance,
    );
    final colors = context.colors;
    final l10n = context.l10n;
    final site = account.site;
    final propertyLine = [
      site.unit,
      site.area,
    ].where((part) => part.trim().isNotEmpty).join(' · ');

    return GpScreen(
      child: ListView(
        padding: EdgeInsets.only(bottom: scrollEnd(context)),
        children: [
          PageTitle(l10n.tabAccount),
          Padded(child: ResidentCard(resident: account.resident)),
          SectionHeading(l10n.accountProperty),
          Padded(
            child: GpGroup(
              children: [
                GpRow(
                  leading: const IconBadge(
                    icon: GpIcons.property,
                    size: 40,
                    tone: Tone.accent,
                  ),
                  title: site.name,
                  subtitle: propertyLine.isEmpty ? null : propertyLine,
                ),
              ],
            ),
          ),
          SectionHeading(l10n.accountBackup),
          Padded(
            child: GpGroup(
              children: [
                GpRow(
                  leading: IconBadge(
                    icon: backupOn ? GpIcons.cloudOn : GpIcons.cloud,
                    size: 40,
                    tone: backupOn ? Tone.accent : Tone.neutral,
                  ),
                  title: l10n.backupTitle,
                  subtitle: backupOn ? l10n.accountBackupOn : l10n.accountOff,
                  chevron: true,
                  onTap: () => showBackupSheet(context),
                ),
              ],
            ),
          ),
          SectionHeading(l10n.accountAppearance),
          Padded(
            child: GpSegmented(
              segments: [for (final a in Appearance.values) a.label(l10n)],
              selectedIndex: appearance.index,
              onChanged: (i) => context.read<AppearanceBloc>().add(
                AppearanceEvent.changed(appearance: Appearance.values[i]),
              ),
            ),
          ),
          SectionHeading(l10n.accountAbout),
          Padded(
            child: GpGroup(
              inset: 52,
              children: [
                GpRow(
                  leading: Icon(GpIcons.info, color: colors.inkMuted),
                  title: l10n.accountAboutGatepass,
                  chevron: true,
                  onTap: () => showGpInfo(
                    context,
                    title: l10n.accountAboutGatepass,
                    body: l10n.accountAboutBody,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              GpSpace.gutter,
              GpSpace.xxxl,
              GpSpace.gutter,
              0,
            ),
            child: GpButton(
              label: l10n.accountSignOut,
              variant: GpButtonVariant.danger,
              onPressed: () => confirmSignOut(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> confirmSignOut(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await showGpConfirm(
      context,
      title: l10n.accountSignOutTitle,
      body: l10n.accountSignOutBody,
      confirmLabel: l10n.accountSignOut,
      cancelLabel: l10n.accountStaySignedIn,
      danger: true,
    );
    if (confirmed && context.mounted) {
      context.read<SessionBloc>().add(const SessionEvent.signOutRequested());
    }
  }
}
