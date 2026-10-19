// Sharing an invite through the phone's own share sheet: the bare code, ATG's
// visitor link, a picture of the gate pass, or (for people) a full message.
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models.dart';
import '../../data/services.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import '../../widgets/gate_pass.dart';

/// ATG's public visitor page for a code. It shows the same QR as the app.
Uri visitorLink(String code) =>
    Uri.https('new.atthegate.biz', '/visitor/shared', {'code': code});

/// For a driver or a delivery app's note field. Raw, not grouped, so nobody
/// types the spaces.
String gateCodeText(Invite invite, String siteName) => invite.openEnded
    ? 'Gate code for $siteName: ${invite.code}'
    : 'Gate code for $siteName: ${invite.code} '
          '(valid until ${formatTime(invite.until)})';

String inviteMessage(Invite invite, String siteName) =>
    'Hi ${invite.firstName}, you’re invited to $siteName '
    '(${inviteValidityLabel(invite)}). '
    'Show the QR code from this link at the gate: '
    '${visitorLink(invite.code)} '
    '— or give the guard the access code ${invite.code}.';

Future<void> showShareOptions(BuildContext context, Invite invite) =>
    showGpSheet<void>(context, builder: (_) => _ShareSheet(invite: invite));

class _ShareSheet extends StatefulWidget {
  const _ShareSheet({required this.invite});

  final Invite invite;

  @override
  State<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<_ShareSheet> {
  bool _rendering = false;

  /// Where the share sheet points from on iPad; iPhone ignores it.
  Rect? get _origin {
    final box = context.findRenderObject() as RenderBox?;
    return box == null ? null : box.localToGlobal(Offset.zero) & box.size;
  }

  /// Closes this sheet first, so finishing in the share sheet lands back on
  /// the invite rather than on a list of options.
  Future<void> _share(ShareParams Function(Rect? origin) params) async {
    final shared = params(_origin);
    Navigator.of(context).pop();
    await SharePlus.instance.share(shared);
  }

  Future<void> _shareImage() async {
    setState(() => _rendering = true);
    final site = AppScope.read(context).site.name;
    try {
      final png = await renderGatePassImage(context, widget.invite, site);
      if (!mounted) return;
      await _share(
        (origin) => ShareParams(
          files: [XFile.fromData(png, mimeType: 'image/png')],
          fileNameOverrides: ['Gate pass ${widget.invite.code}.png'],
          sharePositionOrigin: origin,
        ),
      );
    } on Object catch (e) {
      debugPrint('[Gatepass] gate pass image failed: $e');
      if (!mounted) return;
      setState(() => _rendering = false);
      Toast.show(
        context,
        'Couldn’t make the picture. Share the code or link instead.',
        tone: ToastTone.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final invite = widget.invite;
    final site = AppScope.read(context).site.name;
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
            Text('Share', style: type.title),
            const SizedBox(height: GpSpace.xs),
            Text(
              invite.isService
                  ? 'Send the driver any of these.'
                  : 'Send ${invite.firstName} any of these.',
              style: type.body.copyWith(color: colors.inkMuted),
            ),
            const SizedBox(height: GpSpace.lg),
            GpGroup(
              children: [
                GpRow(
                  leading: badge(GpIcons.code),
                  title: 'Code',
                  subtitle: formatCode(invite.code),
                  chevron: true,
                  onTap: () => _share(
                    (origin) => ShareParams(
                      text: gateCodeText(invite, site),
                      sharePositionOrigin: origin,
                    ),
                  ),
                ),
                GpRow(
                  leading: badge(GpIcons.link),
                  title: 'Link',
                  subtitle: link.toString(),
                  chevron: true,
                  onTap: () => _share(
                    (origin) =>
                        ShareParams(uri: link, sharePositionOrigin: origin),
                  ),
                ),
                GpRow(
                  leading: badge(GpIcons.image),
                  title: 'Image',
                  subtitle: 'The QR code and gate code as a picture',
                  trailing: _rendering
                      ? GpActivity(color: colors.accent)
                      : null,
                  chevron: !_rendering,
                  onTap: _rendering ? null : _shareImage,
                ),
                if (!invite.isService)
                  GpRow(
                    leading: badge(GpIcons.message),
                    title: 'Invite message',
                    subtitle: 'A note with the link and the code',
                    chevron: true,
                    onTap: () => _share(
                      (origin) => ShareParams(
                        text: inviteMessage(invite, site),
                        sharePositionOrigin: origin,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: GpSpace.lg),
            GpButton(
              label: 'Cancel',
              variant: GpButtonVariant.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

/// The gate pass as a picture: who it's for, the estate and window, then the
/// QR and code. Always light, like a printed pass, so any scanner reads it.
class GatePassCard extends StatelessWidget {
  const GatePassCard({super.key, required this.invite, required this.siteName});

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
                      ? '${invite.displayName} can come in'
                      : '${invite.firstName} is invited',
                  style: type.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: GpSpace.xs),
                Text(
                  '$siteName · ${inviteValidityLabel(invite)}',
                  style: type.body.copyWith(color: colors.inkMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: GpSpace.xl),
                GatePass(
                  code: invite.code,
                  caption: 'Scan this at the gate, or give the guard the code.',
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

/// Draws [GatePassCard] off screen and returns it as a PNG at 3x.
Future<Uint8List> renderGatePassImage(
  BuildContext context,
  Invite invite,
  String siteName,
) async {
  final service = serviceById(invite.serviceId);
  if (service != null) {
    await precacheImage(AssetImage(service.iconAsset), context);
  }
  if (!context.mounted) throw StateError('The invite closed');
  final key = GlobalKey();
  // Laid out and painted like any other widget, just beyond the left edge
  // of the screen, so the picture matches the app exactly.
  final entry = OverlayEntry(
    builder: (_) => Positioned(
      left: -GatePassCard.width * 4,
      top: 0,
      child: IgnorePointer(
        child: ExcludeSemantics(
          child: RepaintBoundary(
            key: key,
            child: GatePassCard(invite: invite, siteName: siteName),
          ),
        ),
      ),
    ),
  );
  Overlay.of(context, rootOverlay: true).insert(entry);
  try {
    // The second frame paints the icon, which resolves during the first.
    for (var i = 0; i < 2; i++) {
      await WidgetsBinding.instance.endOfFrame;
    }
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      return data!.buffer.asUint8List();
    } finally {
      image.dispose();
    }
  } finally {
    entry.remove();
  }
}
