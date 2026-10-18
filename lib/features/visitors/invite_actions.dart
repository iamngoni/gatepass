import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../data/models.dart';
import '../../data/services.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';

/// A short, user-facing line for an error from the backend (e.g. the live
/// ATG client's dry-run notice or a network failure).
String describeError(Object e) {
  final s = e.toString().replaceFirst(
    RegExp(r'^[A-Za-z]+Exception(\([^)]*\))?:\s*'),
    '',
  );
  return s.isEmpty ? 'Something went wrong. Please try again.' : s;
}

/// One tap: create the invite straight away and show its code.
Future<void> quickInvite(
  BuildContext context,
  InviteDraft draft, {
  String? note,
}) {
  HapticFeedback.lightImpact();
  final invite = AppScope.read(context).createInvite(draft);
  return showGpSheet<void>(
    context,
    builder: (_) => QuickInviteSheet(draft: draft, invite: invite, note: note),
  );
}

class QuickInviteSheet extends StatefulWidget {
  const QuickInviteSheet({
    super.key,
    required this.draft,
    required this.invite,
    this.note,
  });

  final InviteDraft draft;
  final Future<Invite> invite;
  final String? note;

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

    return Padding(
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
            IconBadge(
              icon: service.kind.icon,
              tone: service.kind.tone,
              size: 64,
            )
          else
            InitialsAvatar(name: d.visitorName, size: 64, tone: Tone.accent),
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
            'Until $until · ${d.multiEntry ? 'any number of entries' : 'one entry'}',
            style: type.body.copyWith(color: colors.inkMuted),
            textAlign: TextAlign.center,
          ),
          if (widget.note != null) ...[
            const SizedBox(height: GpSpace.sm),
            StatusPill(label: widget.note!, tone: Tone.accent),
          ],
          const SizedBox(height: GpSpace.xl),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: GpSpace.xl),
            decoration: BoxDecoration(
              color: colors.surfaceMuted,
              borderRadius: BorderRadius.circular(GpRadius.xl),
            ),
            child: Column(
              children: [
                Text(
                  service != null ? 'GATE CODE FOR THE DRIVER' : 'GATE CODE',
                  style: type.overline,
                ),
                const SizedBox(height: GpSpace.sm),
                AnimatedSwitcher(
                  duration: GpMotion.base,
                  child: Text(
                    invite == null ? '––– –––' : formatCode(invite.code),
                    key: ValueKey(invite?.code),
                    style: type.code.copyWith(
                      color: invite == null ? colors.inkFaint : colors.ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: GpSpace.xl),
          GpButton(
            label: _copied
                ? (service != null ? 'Copied' : 'Invite copied')
                : service != null
                ? 'Copy code'
                : 'Send to $first',
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
    );
  }
}

/// Asks first, then revokes. Returns whether the invite was revoked.
Future<bool> confirmRevoke(BuildContext context, Invite invite) async {
  final ok = await showGpConfirm(
    context,
    title: invite.isService
        ? 'Revoke the ${invite.visitorName} code?'
        : 'Revoke ${invite.firstName}’s invite?',
    body: invite.status == InviteStatus.onSite && !invite.isService
        ? '${invite.firstName} is on site now. Their code stops working '
              'straight away.'
        : 'The link and gate code stop working straight away.',
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

Future<void> copyGateCode(Invite invite, String siteName) => Clipboard.setData(
  ClipboardData(
    text:
        'Gate code for $siteName: ${formatCode(invite.code)} '
        '(valid until ${formatTime(invite.until)}).',
  ),
);

/// The prototype copies the message; the real app hands it to the share sheet.
Future<void> shareInvite(
  BuildContext context,
  Invite invite,
  String siteName, {
  bool confirm = true,
}) async {
  final message =
      'Hi ${invite.firstName}, you’re invited to $siteName '
      '(${windowLabel(invite.from, invite.until)}). '
      'Open this link at the gate: ${invite.link} '
      '— or use code ${formatCode(invite.code)} on the keypad.';
  await Clipboard.setData(ClipboardData(text: message));
  if (!confirm || !context.mounted) return;
  Toast.show(context, 'Invite copied. Paste it into WhatsApp or SMS.');
}
