// Gatepass — invite_status_extensions.dart. Created 2026-10-18.
import '../../../data/models.dart';
import '../../configs/tone.dart';

extension InviteStatusUi on InviteStatus {
  String get label => switch (this) {
    InviteStatus.active => 'Active',
    InviteStatus.expired => 'Expired',
    InviteStatus.revoked => 'Revoked',
  };

  Tone get tone => switch (this) {
    InviteStatus.active => Tone.accent,
    InviteStatus.revoked => Tone.danger,
    InviteStatus.expired => Tone.neutral,
  };
}
