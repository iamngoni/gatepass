// Gatepass — quick_invite_sheet.dart. Created 2026-10-19.
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/data/request_status.dart';
import '../../../core/utils/date_helpers.dart';
import '../../../core/utils/extensions/invites_bloc_extensions.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/delivery_services.dart';
import '../../models/data/invite.dart';
import '../../models/data/invite_draft.dart';
import '../../state/invites/invites_bloc.dart';
import 'service_icon.dart';
import 'share_sheet.dart';

/// One tap: create the invite straight away and show its code.
Future<void> quickInvite(BuildContext context, InviteDraft draft) {
  HapticFeedback.lightImpact();
  final requestId = context.read<InvitesBloc>().create(draft);
  return showGpSheet<void>(
    context,
    builder: (_) => QuickInviteSheet(draft: draft, requestId: requestId),
  );
}

class QuickInviteSheet extends StatefulWidget {
  const QuickInviteSheet({
    required this.draft,
    required this.requestId,
    super.key,
  });

  final InviteDraft draft;

  /// The create in [InvitesState.requests] this sheet shows.
  final String requestId;

  @override
  State<QuickInviteSheet> createState() => _QuickInviteSheetState();
}

class _QuickInviteSheetState extends State<QuickInviteSheet> {
  final copied = ValueNotifier(false);
  final revoking = ValueNotifier(false);
  Timer? copiedReset;

  @override
  void dispose() {
    copiedReset?.cancel();
    copied.dispose();
    revoking.dispose();
    super.dispose();
  }

  Future<void> copy(Invite invite) async {
    await Clipboard.setData(ClipboardData(text: invite.code));
    if (!mounted) return;
    copied.value = true;
    copiedReset?.cancel();
    copiedReset = Timer(const Duration(seconds: 2), () {
      if (mounted) copied.value = false;
    });
  }

  Future<void> revoke(Invite invite) async {
    revoking.value = true;
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final result = await context.read<InvitesBloc>().revoke(invite.id);
    if (!mounted) return;
    result.fold(
      (error) {
        revoking.value = false;
        Toast.show(context, error.describe(l10n));
      },
      (_) {
        Toast.show(context, l10n.quickRevoked(widget.draft.visitorName));
        if (ModalRoute.of(context)?.isCurrent ?? false) navigator.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final l10n = context.l10n;
    final format = context.format;
    final d = widget.draft;
    final service = serviceById(d.serviceId);
    final first = service == null
        ? d.visitorName.split(' ').first
        : d.visitorName;
    final status = context.select(
      (InvitesBloc bloc) => bloc.state.requests[widget.requestId],
    );
    final invite = switch (status) {
      RequestSucceeded(:final value) => value,
      _ => null,
    };
    final failed = status is RequestFailed;
    final until = isToday(d.until)
        ? format.time(d.until)
        : l10n.quickUntilOtherDay(
            format.time(d.until),
            format.day(d.until).toLowerCase(),
          );

    // Scrolls rather than clipping its buttons on a small phone or at a
    // large text size.
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          GpSpace.gutter,
          GpSpace.sm,
          GpSpace.gutter,
          GpSpace.lg,
        ),
        child: ListenableBuilder(
          listenable: Listenable.merge([copied, revoking]),
          builder: (context, _) {
            final ready = invite != null && !revoking.value;
            final hasCode = ready && invite.code.isNotEmpty;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (service != null)
                  ServiceIcon(service: service, size: 52)
                else
                  InitialsAvatar(
                    name: d.visitorName,
                    size: 52,
                    tone: Tone.accent,
                  ),
                const SizedBox(height: GpSpace.lg),
                Text(
                  failed
                      ? l10n.quickFailed
                      : service != null
                      ? l10n.inviteServiceCanComeIn(first)
                      : l10n.invitePersonInvited(first),
                  style: type.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: GpSpace.xs),
                Text(
                  l10n.quickUntil(until),
                  style: type.body.copyWith(color: colors.inkMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: GpSpace.lg),
                if (!failed)
                  GatePass(
                    code: invite?.code,
                    caption: service != null ? l10n.quickServiceCaption : null,
                  ),
                const SizedBox(height: GpSpace.lg),
                Row(
                  children: [
                    Expanded(
                      child: GpButton(
                        label: copied.value
                            ? l10n.quickCopied
                            : l10n.inviteCopyCode,
                        icon: copied.value ? GpIcons.check : GpIcons.copy,
                        variant: GpButtonVariant.secondary,
                        size: GpButtonSize.large,
                        onPressed: hasCode ? () => copy(invite) : null,
                      ),
                    ),
                    const SizedBox(width: GpSpace.sm),
                    Expanded(
                      child: GpButton(
                        label: l10n.inviteShare,
                        icon: GpIcons.share,
                        size: GpButtonSize.large,
                        onPressed: hasCode
                            ? () => showShareOptions(context, invite)
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: GpSpace.sm),
                Row(
                  children: [
                    Expanded(
                      child: GpButton(
                        label: l10n.commonRevoke,
                        variant: GpButtonVariant.danger,
                        loading: revoking.value,
                        onPressed: ready ? () => revoke(invite) : null,
                      ),
                    ),
                    const SizedBox(width: GpSpace.sm),
                    Expanded(
                      child: GpButton(
                        label: l10n.commonDone,
                        variant: GpButtonVariant.secondary,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
