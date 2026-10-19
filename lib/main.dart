import 'package:flutter/widgets.dart';

import 'app.dart';
import 'data/atg/atg_gate_repository.dart';
import 'data/backup/cloud_backup.dart';
import 'data/invite_archive.dart';
import 'state/app_state.dart';

void main() {
  // Live only: the app talks to the real At The Gate backend with the signed-in
  // resident's own account. See lib/data/atg/ for configuration and the
  // verify-first notes (writes are dry-run until shapes are confirmed).
  final repo = AtgGateRepository();
  final state = AppState(
    repo,
    archive: SecureInviteArchive(),
    backup: CloudBackup(identity: repo.cloudIdentity),
  );
  runApp(GatepassApp(state: state));
  state.restoreSession();
}
