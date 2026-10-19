// Gatepass — invite_status_extensions.dart. Created 2026-10-18.
import '../../../invites/models/data/invite_status.dart';
import '../../configs/tone.dart';

extension InviteStatusUi on InviteStatus {
  Tone get tone => switch (this) {
    InviteStatus.active => Tone.accent,
    InviteStatus.revoked => Tone.danger,
    InviteStatus.expired => Tone.neutral,
  };
}
