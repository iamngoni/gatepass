// Gatepass — backup_sheet_actions.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/backup_step.dart';

/// The backup sheet's buttons for each step.
class BackupSheetActions extends StatelessWidget {
  const BackupSheetActions({
    required this.step,
    required this.busy,
    required this.onTurnOn,
    required this.onSaved,
    required this.onRestore,
    required this.onStartOver,
    required this.onBackUpNow,
    required this.onTurnOff,
    super.key,
  });

  final BackupStep step;
  final bool busy;
  final VoidCallback onTurnOn;
  final VoidCallback onSaved;
  final VoidCallback onRestore;
  final VoidCallback onStartOver;
  final VoidCallback onBackUpNow;
  final VoidCallback onTurnOff;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: switch (step) {
        BackupStep.checking => const <Widget>[],
        BackupStep.intro => [
          GpButton(
            label: l10n.backupTurnOn,
            icon: GpIcons.cloud,
            onPressed: onTurnOn,
          ),
        ],
        BackupStep.phrase => [
          GpButton(
            label: l10n.backupSaved,
            loading: busy,
            onPressed: busy ? null : onSaved,
          ),
        ],
        BackupStep.restore => [
          GpButton(
            label: l10n.backupRestore,
            icon: GpIcons.key,
            loading: busy,
            onPressed: busy ? null : onRestore,
          ),
          const SizedBox(height: GpSpace.sm),
          GpButton(
            label: l10n.backupLostPhrase,
            variant: GpButtonVariant.text,
            onPressed: busy ? null : onStartOver,
          ),
        ],
        BackupStep.on => [
          GpButton(
            label: l10n.backupBackUpNow,
            icon: GpIcons.cloud,
            loading: busy,
            onPressed: busy ? null : onBackUpNow,
          ),
          const SizedBox(height: GpSpace.sm),
          GpButton(
            label: l10n.backupTurnOffButton,
            variant: GpButtonVariant.danger,
            onPressed: busy ? null : onTurnOff,
          ),
        ],
      },
    );
  }
}
