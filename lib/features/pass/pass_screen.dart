import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../data/models.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';

/// Full-screen rotating QR pass. The card stays white in dark mode because
/// scanners need the contrast.
class PassScreen extends StatefulWidget {
  const PassScreen({super.key});

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  AccessPass? _pass;
  bool _loading = false;
  bool _failed = false;
  late final Timer _ticker;

  @override
  void initState() {
    super.initState();
    _load();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    if (_loading) return;
    _loading = true;
    try {
      final pass = await AppScope.read(context).fetchPass();
      if (mounted) setState(() => _pass = pass);
    } on Object {
      if (mounted) setState(() => _failed = true);
    } finally {
      _loading = false;
    }
  }

  void _tick() {
    final pass = _pass;
    if (pass != null && !DateTime.now().isBefore(pass.expiresAt)) _load();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final state = AppScope.of(context);
    final pass = _pass;
    final secondsLeft = pass == null
        ? 0
        : pass.expiresAt.difference(DateTime.now()).inSeconds.clamp(0, 30);
    const ink = Color(0xFF0F1F19);

    if (_failed) {
      return const GpScreen(
        header: GpHeader(title: 'Your pass'),
        child: Center(
          child: EmptyPanel(
            icon: GpIcons.pass,
            title: 'Pass not available yet',
            body:
                'Your estate’s live QR pass isn’t wired to the backend in '
                'this build. Creating and managing invites still works.',
          ),
        ),
      );
    }

    return GpScreen(
      header: const GpHeader(title: 'Your pass'),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            GpSpace.gutter,
            GpSpace.sm,
            GpSpace.gutter,
            GpSpace.lg,
          ),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(GpSpace.xxl),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(GpRadius.xl),
                  border: Border.all(
                    color: colors.line,
                    width: GpSizes.hairline,
                  ),
                ),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 260),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: AnimatedSwitcher(
                          duration: GpMotion.slow,
                          child: pass == null
                              ? const Center(child: GpActivity(color: ink))
                              : CustomPaint(
                                  key: ValueKey(pass.payload),
                                  painter: QrPainter(
                                    data: pass.payload,
                                    version: QrVersions.auto,
                                    eyeStyle: const QrEyeStyle(
                                      eyeShape: QrEyeShape.square,
                                      color: ink,
                                    ),
                                    dataModuleStyle: const QrDataModuleStyle(
                                      dataModuleShape: QrDataModuleShape.square,
                                      color: ink,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: GpSpace.xl),
                    Text(
                      state.resident!.name,
                      style: type.section.copyWith(color: ink),
                    ),
                    const SizedBox(height: GpSpace.xxs),
                    Text(
                      '${state.site.unit} · ${state.site.name}',
                      style: type.caption.copyWith(
                        color: GpColors.light.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: GpSpace.xl),
              Row(
                children: [
                  Expanded(child: GpProgressBar(value: secondsLeft / 30)),
                  const SizedBox(width: GpSpace.md),
                  SizedBox(
                    width: 112,
                    child: Text(
                      'New code in ${secondsLeft}s',
                      textAlign: TextAlign.end,
                      style: type.time,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: GpSpace.lg),
              GpSurface(
                padding: const EdgeInsets.symmetric(
                  horizontal: GpSpace.lg,
                  vertical: GpSpace.md,
                ),
                child: Row(
                  children: [
                    Icon(GpIcons.keypad, size: 20, color: colors.inkMuted),
                    const SizedBox(width: GpSpace.md),
                    Expanded(
                      child: Text(
                        'No scanner? Use the keypad',
                        style: type.caption,
                      ),
                    ),
                    Text(
                      pass == null ? '––– –––' : formatCode(pass.code),
                      style: type.title.copyWith(
                        letterSpacing: 2,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(GpIcons.info, size: 16, color: colors.inkMuted),
                  const SizedBox(width: GpSpace.sm),
                  Expanded(
                    child: Text(
                      'Hold your phone about 15 cm from the scanner. If it '
                      'won’t scan, turn up your screen brightness.',
                      style: type.caption,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
