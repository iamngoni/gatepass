//
//  Gatepass
//  invite_drafts.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import '../../invites/models/data/delivery_service.dart';
import '../../invites/models/data/invite.dart';
import '../../invites/models/data/invite_draft.dart';

/// Same person and settings as last time, starting [now].
InviteDraft reinviteDraft(Invite last, DateTime now) {
  final length = last.until.difference(last.from);
  final stay =
      length < const Duration(hours: 1) || length > const Duration(hours: 12)
      ? const Duration(hours: 4)
      : length;
  // An evening re-invite shouldn't run into tomorrow just because last time
  // was a full working day.
  final endOfDay = DateTime(now.year, now.month, now.day, 23, 59);
  var until = now.add(stay);
  if (until.isAfter(endOfDay) &&
      endOfDay.difference(now) >= const Duration(hours: 1)) {
    until = endOfDay;
  }
  return InviteDraft(
    visitorName: last.visitorName,
    phone: last.phone,
    vehicleReg: last.vehicleReg,
    from: now,
    until: until,
  );
}

/// A delivery or ride invite for [service]'s usual window, starting [now].
InviteDraft serviceDraft(DeliveryService service, DateTime now) => InviteDraft(
  visitorName: service.name,
  serviceId: service.id,
  from: now,
  until: now.add(service.window),
);
