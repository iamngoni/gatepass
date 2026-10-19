// Gatepass — invite_avatar.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../../data/models.dart';
import '../../../data/services.dart';
import '../../configs/gp_spacing.dart';
import '../../configs/tone.dart';
import 'initials_avatar.dart';
import 'service_icon.dart';

/// Service mark for delivery and ride invites, initials for people.
class InviteAvatar extends StatelessWidget {
  const InviteAvatar({
    required this.invite,
    this.size = GpSizes.avatar,
    super.key,
  });

  final Invite invite;
  final double size;

  @override
  Widget build(BuildContext context) {
    final service = serviceById(invite.serviceId);
    if (service != null) {
      return ServiceIcon(service: service, size: size);
    }
    return InitialsAvatar(
      name: invite.visitorName,
      size: size,
      tone: invite.status.isLive ? Tone.accent : Tone.neutral,
    );
  }
}
