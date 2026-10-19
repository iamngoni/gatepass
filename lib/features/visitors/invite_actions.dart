import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../data/models.dart';
import '../../data/services.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import '../../widgets/gate_pass.dart';

/// A short, user-facing line for an error from the backend (e.g. the live
/// ATG client's dry-run notice or a network failure).
String describeError(Object e) {
  final s = e.toString().replaceFirst(
    RegExp(r'^[A-Za-z]+Exception(\([^)]*\))?:\s*'),
    '',
  );
  return s.isEmpty ? 'Something went wrong. Please try again.' : s;
}

/// Pull-to-refresh: reloads invites and notifications, and says so when the
/// network lets it down instead of failing silently.
Future<void> refreshInvites(BuildContext context) async {
  try {
    // A stalled request must not hold the pull open forever.
    await AppScope.read(context).refresh().timeout(const Duration(seconds: 20));
  } on TimeoutException {
    if (context.mounted) {
      Toast.show(
        context,
        'ATG is taking too long to answer. Try again in a moment.',
        tone: ToastTone.error,
      );
    }
  } on Object catch (e) {
    if (context.mounted) {
      Toast.show(context, describeError(e), tone: ToastTone.error);
    }
  }
}

/// One tap: create the invite straight away and show its code.
Future<void> quickInvite(BuildContext context, InviteDraft draft) {
  HapticFeedback.lightImpact();
  final invite = AppScope.read(context).createInvite(draft);
  // The sheet attaches its own error handler, but it may not be mounted before
  // a fast failure (dry run, cached category) completes. `ignore()` only stops
  // that failure being reported as an unhandled async error; listeners still
  // receive it.
  invite.ignore();
  return showGpSheet<void>(
    context,
    builder: (_) => QuickInviteSheet(draft: draft, invite: invite),
  );
}

class QuickInviteSheet extends StatefulWidget {
  const QuickInviteSheet({
    super.key,
    required this.draft,
    required this.invite,
  });

  final InviteDraft draft;
  final Future<Invite> invite;

  @override
  State<QuickInviteSheet> createState() => _QuickInviteSheetState();
}

class _QuickInviteSheetState extends State<QuickInviteSheet> {
  Invite? _invite;
  bool _failed = false;
  bool _copied = false;
  bool _revoking = false;
  Timer? _copiedReset;

  @override
  void initState() {
    super.initState();
    widget.invite.then(
      (i) => mounted ? setState(() => _invite = i) : null,
      onError: (Object _) => mounted ? setState(() => _failed = true) : null,
    );
  }

  @override
  void dispose() {
    _copiedReset?.cancel();
    super.dispose();
  }

  Future<void> _copy() async {
    final invite = _invite!;
    final site = AppScope.read(context).site.name;
    if (invite.isService) {
      await copyGateCode(invite, site);
    } else {
      await shareInvite(context, invite, site, confirm: false);
    }
    if (!mounted) return;
    setState(() => _copied = true);
    _copiedReset?.cancel();
    _copiedReset = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  Future<void> _revoke() async {
    setState(() => _revoking = true);
    final navigator = Navigator.of(context);
    try {
      await AppScope.read(context).revokeInvite(_invite!.id);
    } on Object catch (e) {
      if (mounted) {
        setState(() => _revoking = false);
        Toast.show(context, describeError(e));
      }
      return;
    }
    if (!mounted) return;
    Toast.show(context, 'Code for ${widget.draft.visitorName} revoked');
    if (ModalRoute.of(context)?.isCurrent ?? false) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final d = widget.draft;
    final service = serviceById(d.serviceId);
    final first = service == null
        ? d.visitorName.split(' ').first
        : d.visitorName;
    final invite = _invite;
    final ready = invite != null && !_revoking;
    final until = isToday(d.until)
        ? formatTime(d.until)
        : '${formatTime(d.until)} ${dayLabel(d.until).toLowerCase()}';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (service != null)
              ServiceIcon(service: service, size: 52)
            else
              InitialsAvatar(name: d.visitorName, size: 52, tone: Tone.accent),
            const SizedBox(height: GpSpace.lg),
            Text(
              _failed
                  ? 'Couldn’t create the code'
                  : service != null
                  ? '$first can come in'
                  : '$first is invited',
              style: type.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: GpSpace.xs),
            Text(
              'Until $until',
              style: type.body.copyWith(color: colors.inkMuted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: GpSpace.lg),
            if (!_failed)
              GatePass(
                code: invite?.code,
                caption: service != null
                    ? 'Send the driver the code. The guard can also scan this.'
                    : null,
              ),
            const SizedBox(height: GpSpace.lg),
            GpButton(
              label: _copied
                  ? (service != null ? 'Copied' : 'Invite copied')
                  : service != null
                  ? 'Copy code'
                  : 'Copy invite message',
              icon: _copied
                  ? GpIcons.check
                  : service != null
                  ? GpIcons.copy
                  : GpIcons.share,
              size: GpButtonSize.large,
              onPressed: ready ? _copy : null,
            ),
            const SizedBox(height: GpSpace.sm),
            Row(
              children: [
                Expanded(
                  child: GpButton(
                    label: 'Revoke',
                    variant: GpButtonVariant.danger,
                    loading: _revoking,
                    onPressed: ready ? _revoke : null,
                  ),
                ),
                const SizedBox(width: GpSpace.sm),
                Expanded(
                  child: GpButton(
                    label: 'Done',
                    variant: GpButtonVariant.secondary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Asks first, then revokes. Returns whether the invite was revoked.
Future<bool> confirmRevoke(BuildContext context, Invite invite) async {
  final ok = await showGpConfirm(
    context,
    title: invite.isService
        ? 'Revoke the ${invite.displayName} code?'
        : 'Revoke ${invite.firstName}’s invite?',
    body: 'The link and gate code stop working straight away.',
    confirmLabel: 'Revoke',
    cancelLabel: 'Keep it',
    danger: true,
  );
  if (!ok || !context.mounted) return false;
  try {
    await AppScope.read(context).revokeInvite(invite.id);
  } on Object catch (e) {
    if (context.mounted) Toast.show(context, describeError(e));
    return false;
  }
  return true;
}

/// For a driver: just the code, which they read out or type at the gate.
/// Shared raw, not grouped, so nobody types the spaces.
Future<void> copyGateCode(Invite invite, String siteName) => Clipboard.setData(
  ClipboardData(
    text: invite.openEnded
        ? 'Gate code for $siteName: ${invite.code}'
        : 'Gate code for $siteName: ${invite.code} '
              '(valid until ${formatTime(invite.until)})',
  ),
);

/// Copies a ready-to-send message; the app does not send SMS itself.
Future<void> shareInvite(
  BuildContext context,
  Invite invite,
  String siteName, {
  bool confirm = true,
}) async {
  // The link opens ATG's visitor page, which shows the same QR as the app.
  final message =
      'Hi ${invite.firstName}, you’re invited to $siteName '
      '(${inviteValidityLabel(invite)}). '
      'Show the QR code from this link at the gate: ${invite.link} '
      '— or give the guard the access code ${invite.code}.';
  await Clipboard.setData(ClipboardData(text: message));
  if (!confirm || !context.mounted) return;
  Toast.show(context, 'Invite copied. Paste it into WhatsApp or SMS.');
}
