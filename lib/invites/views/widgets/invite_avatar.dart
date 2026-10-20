//
//  Gatepass
//  invite_avatar.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../../core/configs/gp_spacing.dart';
import '../../../core/configs/tone.dart';
import '../../../core/views/widgets/initials_avatar.dart';
import '../../models/data/delivery_services.dart';
import '../../models/data/invite.dart';
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
