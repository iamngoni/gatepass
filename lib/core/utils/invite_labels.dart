// Gatepass — invite_labels.dart. Created 2026-10-18.
import '../../data/models.dart';
import 'date_labels.dart';

/// The validity line for an invite. ATG profiles often have no explicit
/// window at all, in which case the invite stays valid until it is used up or
/// revoked — printing a made-up time range would be wrong.
String inviteValidityLabel(Invite invite) {
  if (invite.openEnded) return 'Always valid';
  final text = invite.windowText?.trim();
  if (text != null && text.isNotEmpty) return text;
  return windowLabel(invite.from, invite.until);
}
