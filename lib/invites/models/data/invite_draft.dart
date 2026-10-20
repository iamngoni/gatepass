//
//  Gatepass
//  invite_draft.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_draft.freezed.dart';

/// What the resident asked for, before ATG has created the invite.
@freezed
abstract class InviteDraft with _$InviteDraft {
  const factory InviteDraft({
    required String visitorName,
    required DateTime from,
    required DateTime until,
    String? serviceId,
    String? phone,
    String? vehicleReg,
  }) = _InviteDraft;
}
