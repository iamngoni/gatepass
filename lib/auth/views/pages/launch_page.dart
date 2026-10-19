// Gatepass — launch_page.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';

/// Shown while a saved session is checked, in place of the sign-in screen.
class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(GpRadius.lg),
          child: Image.asset(
            'assets/brand/gatepass-mark.png',
            width: 72,
            height: 72,
            semanticLabel: context.l10n.appTitle,
          ),
        ),
        const SizedBox(height: GpSpace.xl),
        GpActivity(color: context.colors.inkMuted),
      ],
    ),
  );
}
