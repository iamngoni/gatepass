//
//  Gatepass
//  invite_status_extensions.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import '../../../invites/models/data/invite_status.dart';
import '../../configs/tone.dart';

extension InviteStatusUi on InviteStatus {
  Tone get tone => switch (this) {
    InviteStatus.active => Tone.accent,
    InviteStatus.revoked => Tone.danger,
    InviteStatus.expired => Tone.neutral,
  };
}
