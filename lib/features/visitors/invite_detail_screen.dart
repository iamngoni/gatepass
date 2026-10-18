import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../data/models.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import '../../widgets/tiles.dart';
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
    final entries = state.entriesForInvite(invite.id);
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
                      invite.multiEntry
                          ? 'Works for every visit in the window.'
                          : 'Works once, then expires.',
                      style: context.type.caption,
                    ),
                    const SizedBox(height: GpSpace.lg),
                    GpButton(
                      label: 'Send invite again',
                      icon: GpIcons.share,
                      variant: GpButtonVariant.soft,
                      onPressed: () =>
                          shareInvite(context, invite, state.site.name),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SectionHeading('Progress'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
            child: GpSurface(child: _Timeline(invite: invite)),
          ),
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
                  icon: GpIcons.repeat,
                  label: 'Entries',
                  value: invite.multiEntry ? 'More than one' : 'One',
                ),
              ],
            ),
          ),
          if (entries.isNotEmpty) ...[
            const SectionHeading('At the gate'),
            TileGroup(
              children: [
                for (final e in entries) EntryTile(entry: e, showDay: true),
              ],
            ),
          ],
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

class _Timeline extends StatelessWidget {
  const _Timeline({required this.invite});

  final Invite invite;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final status = invite.status;
    final noShow = status == InviteStatus.expired && invite.arrivedAt == null;

    final steps = <(String, DateTime?, String)>[
      ('Invited', invite.createdAt, ''),
      if (invite.prescreenRequired)
        (
          'Pre-screened',
          invite.prescreenedAt,
          status == InviteStatus.awaitingPrescreen
              ? 'Waiting for their ID and photo'
              : 'Not done',
        ),
      (
        'Arrived',
        invite.arrivedAt,
        switch (status) {
          InviteStatus.revoked => 'Invite revoked',
          _ when noShow => 'Didn’t arrive',
          _ when invite.openEnded => 'Anytime — no fixed window',
          _ =>
            'Expected ${dayLabel(invite.from).toLowerCase()} '
                'from ${formatTime(invite.from)}',
        },
      ),
      (
        'Left',
        invite.leftAt,
        status == InviteStatus.onSite ? 'Still on site' : '—',
      ),
    ];

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 20,
                  child: Column(
                    children: [
                      const SizedBox(height: 3),
                      _Dot(done: steps[i].$2 != null),
                      if (i < steps.length - 1)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: steps[i + 1].$2 != null
                                  ? colors.accent
                                  : colors.lineStrong,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: GpSpace.md),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: i < steps.length - 1 ? GpSpace.lg : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[i].$1,
                          style: context.type.heading.copyWith(
                            color: steps[i].$2 == null
                                ? colors.inkMuted
                                : colors.ink,
                          ),
                        ),
                        const SizedBox(height: GpSpace.xxs),
                        Text(
                          steps[i].$2 == null
                              ? steps[i].$3
                              : '${dayLabel(steps[i].$2!)}, ${formatTime(steps[i].$2!)}',
                          style: context.type.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.done});

  final bool done;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: done ? colors.accent : colors.surface,
        border: Border.all(
          color: done ? colors.accent : colors.lineStrong,
          width: 1.5,
        ),
      ),
      child: done
          ? Icon(GpIcons.check, size: 10, color: colors.onAccent)
          : null,
    );
  }
}
