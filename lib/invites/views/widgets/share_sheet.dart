// Gatepass — share_sheet.dart. Created 2026-10-19.
// Sharing an invite through the phone's own share sheet: the bare code, ATG's
// visitor link, a picture of the gate pass, or (for people) a full message.
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../auth/state/session/session_bloc.dart';
import '../../../core/utils/text_helpers.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/invite.dart';
import 'gate_pass_image.dart';
import 'share_texts.dart';

Future<void> showShareOptions(BuildContext context, Invite invite) =>
    showGpSheet<void>(context, builder: (_) => ShareSheet(invite: invite));

class ShareSheet extends StatefulWidget {
  const ShareSheet({required this.invite, super.key});

  final Invite invite;

  @override
  State<ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<ShareSheet> {
  final rendering = ValueNotifier(false);

  String get siteName =>
      context.read<SessionBloc>().state.signedInAccount?.site.name ?? '';

  /// Where the share sheet points from on iPad; iPhone ignores it.
  Rect? get origin {
    final box = context.findRenderObject() as RenderBox?;
    return box == null ? null : box.localToGlobal(Offset.zero) & box.size;
  }

  @override
  void dispose() {
    rendering.dispose();
    super.dispose();
  }

  /// Closes this sheet first, so finishing in the share sheet lands back on
  /// the invite rather than on a list of options.
  Future<void> share(ShareParams Function(Rect? origin) params) async {
    final shared = params(origin);
    Navigator.of(context).pop();
    await SharePlus.instance.share(shared);
  }

  Future<void> shareImage() async {
    rendering.value = true;
    final l10n = context.l10n;
    try {
      final png = await renderGatePassImage(context, widget.invite, siteName);
      if (!mounted) return;
      await share(
        (origin) => ShareParams(
          files: [XFile.fromData(png, mimeType: 'image/png')],
          fileNameOverrides: [l10n.shareImageFileName(widget.invite.code)],
          sharePositionOrigin: origin,
        ),
      );
    } on Object catch (e) {
      debugPrint('[Gatepass] gate pass image failed: $e');
      if (!mounted) return;
      rendering.value = false;
      Toast.show(context, l10n.shareImageFailed, tone: ToastTone.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final l10n = context.l10n;
    final format = context.format;
    final invite = widget.invite;
    final site = siteName;
    final link = visitorLink(invite.code);

    Widget badge(IconData icon) =>
        IconBadge(icon: icon, tone: Tone.accent, size: 40);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          GpSpace.gutter,
          0,
          GpSpace.gutter,
          GpSpace.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.inviteShare, style: type.title),
            const SizedBox(height: GpSpace.xs),
            Text(
              invite.isService
                  ? l10n.shareSendDriver
                  : l10n.shareSendPerson(invite.firstName),
              style: type.body.copyWith(color: colors.inkMuted),
            ),
            const SizedBox(height: GpSpace.lg),
            GpGroup(
              children: [
                GpRow(
                  leading: badge(GpIcons.code),
                  title: l10n.shareCode,
                  subtitle: formatCode(invite.code),
                  chevron: true,
                  onTap: () => share(
                    (origin) => ShareParams(
                      text: gateCodeText(format, invite, site),
                      sharePositionOrigin: origin,
                    ),
                  ),
                ),
                GpRow(
                  leading: badge(GpIcons.link),
                  title: l10n.shareLink,
                  subtitle: link.toString(),
                  chevron: true,
                  onTap: () => share(
                    (origin) =>
                        ShareParams(uri: link, sharePositionOrigin: origin),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: rendering,
                  builder: (context, busy, _) => GpRow(
                    leading: badge(GpIcons.image),
                    title: l10n.shareImage,
                    subtitle: l10n.shareImageSubtitle,
                    trailing: busy ? GpActivity(color: colors.accent) : null,
                    chevron: !busy,
                    onTap: busy ? null : shareImage,
                  ),
                ),
                if (!invite.isService)
                  GpRow(
                    leading: badge(GpIcons.message),
                    title: l10n.shareMessage,
                    subtitle: l10n.shareMessageSubtitle,
                    chevron: true,
                    onTap: () => share(
                      (origin) => ShareParams(
                        text: inviteMessage(format, invite, site),
                        sharePositionOrigin: origin,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: GpSpace.lg),
            GpButton(
              label: l10n.commonCancel,
              variant: GpButtonVariant.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
