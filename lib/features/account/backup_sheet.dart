// Cloud backup: turning it on shows a new recovery phrase, a phone that finds
// an existing backup asks for that phrase, and an active backup can be run or
// turned off.
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../data/backup/backup_crypto.dart';
import '../../data/backup/recovery_phrase.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';

Future<void> showBackupSheet(BuildContext context) =>
    showGpSheet<void>(context, builder: (_) => const _BackupSheet());

enum _Step { checking, intro, phrase, restore, on }

class _BackupSheet extends StatefulWidget {
  const _BackupSheet();

  @override
  State<_BackupSheet> createState() => _BackupSheetState();
}

class _BackupSheetState extends State<_BackupSheet> {
  _Step _step = _Step.checking;
  List<String> _phrase = const [];
  final _entry = TextEditingController();
  bool _busy = false;
  String? _error;

  AppState get _state => AppScope.read(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  Future<void> _check() async {
    if (_state.backupOn) return setState(() => _step = _Step.on);
    try {
      final exists = await _state.hasCloudBackup();
      if (mounted) setState(() => _step = exists ? _Step.restore : _Step.intro);
    } on Object {
      if (mounted) {
        setState(() {
          _step = _Step.intro;
          _error = 'Couldn’t reach the backup. Check your connection.';
        });
      }
    }
  }

  Future<void> _newPhrase() async {
    final phrase = await newRecoveryPhrase();
    setState(() {
      _phrase = phrase;
      _error = null;
      _step = _Step.phrase;
    });
  }

  Future<void> _run(Future<void> Function() action, String done) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
      if (!mounted) return;
      Navigator.of(context).pop();
      Toast.show(context, done);
    } on BackupDecryptException {
      if (mounted) {
        setState(() => _error = 'That phrase doesn’t open this backup.');
      }
    } on Object {
      if (mounted) {
        setState(() => _error = 'Something went wrong. Try again.');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restore() async {
    final phrase = await parseRecoveryPhrase(_entry.text);
    if (phrase == null) {
      return setState(
        () => _error = 'Enter all 12 words, separated by spaces.',
      );
    }
    await _run(() => _state.restoreBackup(phrase), 'Backup restored');
  }

  Future<void> _startOver() async {
    final ok = await showGpConfirm(
      context,
      title: 'Start a new backup?',
      body:
          'The old backup is replaced, and anything only it had is lost. '
          'Invites on this phone are kept.',
      confirmLabel: 'Start over',
      cancelLabel: 'Keep it',
      danger: true,
    );
    if (ok && mounted) await _newPhrase();
  }

  Future<void> _turnOff() async {
    final ok = await showGpConfirm(
      context,
      title: 'Turn off cloud backup?',
      body: 'The backup is deleted from the cloud. Invites stay on this phone.',
      confirmLabel: 'Turn off',
      cancelLabel: 'Keep it on',
      danger: true,
    );
    if (ok && mounted) {
      await _run(_state.turnOffBackup, 'Cloud backup turned off');
    }
  }

  String _onText() {
    final at = _state.backup?.lastBackup;
    return at == null
        ? 'Changes back up automatically, encrypted on this phone first.'
        : 'Last backed up ${dayLabel(at).toLowerCase()} at '
              '${formatTime(at)}. Changes back up automatically.';
  }

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;

    final (title, body) = switch (_step) {
      _Step.checking => ('Cloud backup', 'Checking for a backup…'),
      _Step.intro => (
        'Cloud backup',
        'Keep your visitors and invites if you change or reset your phone. '
            'They’re encrypted on this phone with a recovery phrase only you '
            'have, so nobody else can read them, not even Gatepass.',
      ),
      _Step.phrase => (
        'Your recovery phrase',
        'Write these 12 words down and keep them safe. You’ll need them to '
            'restore on another phone. Without them the backup can’t be '
            'opened.',
      ),
      _Step.restore => (
        'Restore your backup',
        'This account already has a backup. Enter its 12-word recovery '
            'phrase to bring it to this phone.',
      ),
      _Step.on => ('Cloud backup is on', _onText()),
    };

    final error = _error;
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
            if (_step == _Step.checking)
              Center(child: GpActivity(color: colors.inkMuted)),
            if (_step == _Step.phrase) ...[
              _PhraseGrid(words: _phrase),
              const SizedBox(height: GpSpace.md),
              GpButton(
                label: 'Copy words',
                icon: GpIcons.copy,
                variant: GpButtonVariant.text,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _phrase.join(' ')));
                  Toast.show(context, 'Copied. Save them somewhere safe.');
                },
              ),
              const SizedBox(height: GpSpace.md),
            ],
            if (_step == _Step.restore) ...[
              GpField(
                controller: _entry,
                label: 'Recovery phrase',
                hint: '12 words',
                autofocus: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _restore(),
              ),
              const SizedBox(height: GpSpace.lg),
            ],
            if (error != null) ...[
              Text(error, style: type.small.copyWith(color: colors.danger)),
              const SizedBox(height: GpSpace.md),
            ],
            ...switch (_step) {
              _Step.checking => const <Widget>[],
              _Step.intro => [
                GpButton(
                  label: 'Turn on',
                  icon: GpIcons.cloud,
                  onPressed: _newPhrase,
                ),
              ],
              _Step.phrase => [
                GpButton(
                  label: 'I’ve saved them',
                  loading: _busy,
                  onPressed: _busy
                      ? null
                      : () => _run(
                          () => _state.turnOnBackup(_phrase),
                          'Cloud backup is on',
                        ),
                ),
              ],
              _Step.restore => [
                GpButton(
                  label: 'Restore',
                  icon: GpIcons.key,
                  loading: _busy,
                  onPressed: _busy ? null : _restore,
                ),
                const SizedBox(height: GpSpace.sm),
                GpButton(
                  label: 'Lost the phrase? Start a new backup',
                  variant: GpButtonVariant.text,
                  onPressed: _busy ? null : _startOver,
                ),
              ],
              _Step.on => [
                GpButton(
                  label: 'Back up now',
                  icon: GpIcons.cloud,
                  loading: _busy,
                  onPressed: _busy
                      ? null
                      : () => _run(
                          () => _state.backUpNow(rethrowErrors: true),
                          'Backed up',
                        ),
                ),
                const SizedBox(height: GpSpace.sm),
                GpButton(
                  label: 'Turn off cloud backup',
                  variant: GpButtonVariant.danger,
                  onPressed: _busy ? null : _turnOff,
                ),
              ],
            },
          ],
        ),
      ),
    );
  }
}

class _PhraseGrid extends StatelessWidget {
  const _PhraseGrid({required this.words});

  final List<String> words;

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    return GpSurface(
      child: Column(
        children: [
          for (var row = 0; row < words.length / 2; row++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: GpSpace.xs),
              child: Row(
                children: [
                  for (final i in [row, row + words.length ~/ 2])
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 28,
                            child: Text(
                              '${i + 1}',
                              style: type.small.copyWith(
                                color: colors.inkMuted,
                              ),
                            ),
                          ),
                          Text(words[i], style: type.bodyStrong),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
