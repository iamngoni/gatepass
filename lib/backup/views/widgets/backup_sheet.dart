// Gatepass — backup_sheet.dart. Created 2026-10-19.
// Cloud backup: turning it on shows a new recovery phrase, a phone that finds
// an existing backup asks for that phrase, and an active backup can be run or
// turned off.
import 'package:dartz/dartz.dart' show Either, Unit;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/data/application_error.dart';
import '../../../core/utils/extensions/backup_bloc_extensions.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/backup_action.dart';
import '../../models/data/backup_step.dart';
import '../../state/backup/backup_bloc.dart';
import 'backup_sheet_actions.dart';
import 'phrase_grid.dart';

Future<void> showBackupSheet(BuildContext context) =>
    showGpSheet<void>(context, builder: (_) => const BackupSheet());

class BackupSheet extends StatefulWidget {
  const BackupSheet({super.key});

  @override
  State<BackupSheet> createState() => _BackupSheetState();
}

class _BackupSheetState extends State<BackupSheet> {
  final step = ValueNotifier(BackupStep.checking);
  final entry = TextEditingController();
  final busy = ValueNotifier(false);
  final error = ValueNotifier<String?>(null);

  BackupBloc get bloc => context.read<BackupBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => check());
  }

  @override
  void dispose() {
    step.dispose();
    entry.dispose();
    busy.dispose();
    error.dispose();
    super.dispose();
  }

  Future<void> check() async {
    if (bloc.state.on) {
      step.value = BackupStep.on;
      return;
    }
    final l10n = context.l10n;
    final exists = await bloc.checkRemote();
    if (!mounted) return;
    exists.fold(
      (_) {
        step.value = BackupStep.intro;
        error.value = l10n.backupUnreachable;
      },
      (exists) => step.value = exists ? BackupStep.restore : BackupStep.intro,
    );
  }

  Future<void> newPhrase() async {
    final result = await bloc.run(
      BackupAction.newPhrase,
      const BackupEvent.newPhraseRequested(),
    );
    if (!mounted) return;
    result.fold((e) => error.value = message(e), (_) {
      error.value = null;
      step.value = BackupStep.phrase;
    });
  }

  Future<void> run(
    Future<Either<ApplicationError, Unit>> Function() action,
    String done,
  ) async {
    busy.value = true;
    error.value = null;
    final result = await action();
    if (!mounted) return;
    busy.value = false;
    result.fold((e) => error.value = message(e), (_) {
      Navigator.of(context).pop();
      Toast.show(context, done);
    });
  }

  String message(ApplicationError e) {
    final l10n = context.l10n;
    return switch (e.code) {
      ApplicationErrorCode.backupDecrypt => l10n.backupWrongPhrase,
      ApplicationErrorCode.phraseInvalid => l10n.backupEnterAllWords,
      _ => l10n.backupSomethingWrong,
    };
  }

  Future<void> turnOn() => run(
    () => bloc.run(BackupAction.turnOn, const BackupEvent.turnOnRequested()),
    context.l10n.backupIsOn,
  );

  Future<void> restore() => run(
    () => bloc.run(
      BackupAction.restore,
      BackupEvent.restoreRequested(phrase: entry.text),
    ),
    context.l10n.backupRestored,
  );

  Future<void> backUpNow() => run(
    () => bloc.run(
      BackupAction.backUpNow,
      const BackupEvent.backUpNowRequested(),
    ),
    context.l10n.backupBackedUp,
  );

  Future<void> startOver() async {
    final l10n = context.l10n;
    final ok = await showGpConfirm(
      context,
      title: l10n.backupStartOverTitle,
      body: l10n.backupStartOverBody,
      confirmLabel: l10n.backupStartOver,
      cancelLabel: l10n.revokeKeep,
      danger: true,
    );
    if (ok && mounted) await newPhrase();
  }

  Future<void> turnOff() async {
    final l10n = context.l10n;
    final ok = await showGpConfirm(
      context,
      title: l10n.backupTurnOffTitle,
      body: l10n.backupTurnOffBody,
      confirmLabel: l10n.backupTurnOff,
      cancelLabel: l10n.backupKeepOn,
      danger: true,
    );
    if (ok && mounted) {
      await run(
        () => bloc.run(
          BackupAction.turnOff,
          const BackupEvent.turnOffRequested(),
        ),
        l10n.backupTurnedOff,
      );
    }
  }

  String onText(BackupState state) {
    final l10n = context.l10n;
    final format = context.format;
    final at = state.lastBackup;
    return at == null
        ? l10n.backupOnBody
        : l10n.backupOnBodyLast(
            format.day(at).toLowerCase(),
            format.time(at),
          );
  }

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    final l10n = context.l10n;
    final state = context.watch<BackupBloc>().state;

    return ListenableBuilder(
      listenable: Listenable.merge([step, busy, error]),
      builder: (context, _) {
        final (title, body) = switch (step.value) {
          BackupStep.checking => (l10n.backupTitle, l10n.backupChecking),
          BackupStep.intro => (l10n.backupTitle, l10n.backupIntro),
          BackupStep.phrase => (l10n.backupPhraseTitle, l10n.backupPhraseBody),
          BackupStep.restore => (
            l10n.backupRestoreTitle,
            l10n.backupRestoreBody,
          ),
          BackupStep.on => (l10n.backupOnTitle, onText(state)),
        };
        final phrase = state.phrase ?? const <String>[];
        final message = error.value;
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
                Text(title, style: type.title),
                const SizedBox(height: GpSpace.xs),
                Text(body, style: type.body.copyWith(color: colors.inkMuted)),
                const SizedBox(height: GpSpace.xl),
                if (step.value == BackupStep.checking)
                  Center(child: GpActivity(color: colors.inkMuted)),
                if (step.value == BackupStep.phrase) ...[
                  PhraseGrid(words: phrase),
                  const SizedBox(height: GpSpace.md),
                  GpButton(
                    label: l10n.backupCopyWords,
                    icon: GpIcons.copy,
                    variant: GpButtonVariant.text,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: phrase.join(' ')));
                      Toast.show(context, l10n.backupCopiedWords);
                    },
                  ),
                  const SizedBox(height: GpSpace.md),
                ],
                if (step.value == BackupStep.restore) ...[
                  GpField(
                    controller: entry,
                    label: l10n.backupPhraseLabel,
                    hint: l10n.backupPhraseHint,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => restore(),
                  ),
                  const SizedBox(height: GpSpace.lg),
                ],
                if (message != null) ...[
                  Text(
                    message,
                    style: type.small.copyWith(color: colors.danger),
                  ),
                  const SizedBox(height: GpSpace.md),
                ],
                BackupSheetActions(
                  step: step.value,
                  busy: busy.value,
                  onTurnOn: newPhrase,
                  onSaved: turnOn,
                  onRestore: restore,
                  onStartOver: startOver,
                  onBackUpNow: backUpNow,
                  onTurnOff: turnOff,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
