// Gatepass — invite_status.dart. Created 2026-10-18.

enum InviteStatus {
  active,
  expired,
  revoked;

  /// The code still works, so the invite can be revoked.
  bool get isLive => this == active;

  bool get isPast => this == expired || this == revoked;
}
