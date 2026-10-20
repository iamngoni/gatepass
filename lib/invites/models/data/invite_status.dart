//
//  Gatepass
//  invite_status.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

enum InviteStatus {
  active,
  expired,
  revoked;

  /// The code still works, so the invite can be revoked.
  bool get isLive => this == active;

  bool get isPast => this == expired || this == revoked;
}
