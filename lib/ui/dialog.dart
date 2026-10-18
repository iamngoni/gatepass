// Confirmation and info dialogs: an owned route, surface and buttons.
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'theme.dart';

class GpDialog extends StatelessWidget {
  const GpDialog({
    super.key,
    required this.title,
    required this.body,
    required this.actions,
  });

  final String title;
  final String body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GpSpace.xxxl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(GpRadius.xl),
              border: Border.all(color: colors.line, width: GpSizes.hairline),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                GpSpace.xxl,
                GpSpace.xxl,
                GpSpace.xxl,
                GpSpace.xl,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(title, style: context.type.title),
                    const SizedBox(height: GpSpace.sm),
                    Text(
                      body,
                      style: context.type.body.copyWith(color: colors.inkMuted),
                    ),
                    const SizedBox(height: GpSpace.xxl),
                    ...actions,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<T?> _showGpDialog<T>(
  BuildContext context, {
  required String title,
  required Widget Function(BuildContext dialog) builder,
}) => showGeneralDialog<T>(
  context: context,
  barrierDismissible: true,
  barrierLabel: title,
  barrierColor: context.colors.overlay,
  transitionDuration: GpMotion.base,
  transitionBuilder: (context, animation, _, child) {
    final curved = CurvedAnimation(parent: animation, curve: GpMotion.curve);
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(begin: .96, end: 1).animate(curved),
        child: child,
      ),
    );
  },
  pageBuilder: (dialog, _, _) => builder(dialog),
);

/// Returns true only on an explicit confirm.
Future<bool> showGpConfirm(
  BuildContext context, {
  required String title,
  required String body,
  required String confirmLabel,
  required String cancelLabel,
  bool danger = false,
}) async {
  final confirmed = await _showGpDialog<bool>(
    context,
    title: title,
    builder: (dialog) => GpDialog(
      title: title,
      body: body,
      actions: [
        GpButton(
          label: confirmLabel,
          variant: danger ? GpButtonVariant.danger : GpButtonVariant.primary,
          onPressed: () => Navigator.of(dialog).pop(true),
        ),
        const SizedBox(height: GpSpace.sm),
        GpButton(
          label: cancelLabel,
          variant: GpButtonVariant.secondary,
          onPressed: () => Navigator.of(dialog).pop(false),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

Future<void> showGpInfo(
  BuildContext context, {
  required String title,
  required String body,
  String closeLabel = 'OK',
}) => _showGpDialog<void>(
  context,
  title: title,
  builder: (dialog) => GpDialog(
    title: title,
    body: body,
    actions: [
      GpButton(label: closeLabel, onPressed: () => Navigator.of(dialog).pop()),
    ],
  ),
);
