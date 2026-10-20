//
//  Gatepass
//  invite_merge.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import '../../invites/models/data/invite.dart';
import '../../invites/models/data/invite_status.dart';

/// ATG's current list wins for anything it still has, keeping details only
/// the app knew (service, phone, car). Anything ATG no longer lists stays,
/// and if ATG returned less than a full page, a missing invite that still
/// looked live was deleted there, so it shows as revoked.
List<Invite> mergeInvites(
  List<Invite> archived,
  List<Invite> fetched, {
  required bool fetchedIsComplete,
  required DateTime now,
}) {
  final byId = {for (final invite in archived) invite.id: invite};
  final merged = <String, Invite>{};
  for (final fresh in fetched) {
    final old = byId[fresh.id];
    merged[fresh.id] = old == null
        ? fresh
        : fresh.copyWith(
            serviceId: fresh.serviceId ?? old.serviceId,
            phone: fresh.phone ?? old.phone,
            vehicleReg: fresh.vehicleReg ?? old.vehicleReg,
            status: old.status == InviteStatus.revoked
                ? InviteStatus.revoked
                : fresh.status,
            code: fresh.code.isEmpty ? old.code : fresh.code,
            link: fresh.link.isEmpty ? old.link : fresh.link,
            windowText: fresh.windowText ?? old.windowText,
          );
  }
  for (final old in archived) {
    if (merged.containsKey(old.id)) continue;
    var status = old.status;
    if (status == InviteStatus.active) {
      if (fetchedIsComplete) {
        status = InviteStatus.revoked;
      } else if (!old.openEnded && old.until.isBefore(now)) {
        status = InviteStatus.expired;
      }
    }
    merged[old.id] = old.copyWith(status: status);
  }
  return merged.values.toList();
}

/// Two archives of the same account, from different phones. Per invite,
/// the later stage wins (revoked over expired over live) and missing
/// details are filled from the other copy.
List<Invite> unionInvites(List<Invite> a, List<Invite> b) {
  final merged = {for (final invite in a) invite.id: invite};
  for (final other in b) {
    final mine = merged[other.id];
    if (mine == null) {
      merged[other.id] = other;
      continue;
    }
    final base = other.status.index > mine.status.index ? other : mine;
    final rest = identical(base, mine) ? other : mine;
    merged[other.id] = base.copyWith(
      visitorName: base.visitorName.isEmpty
          ? rest.visitorName
          : base.visitorName,
      serviceId: base.serviceId ?? rest.serviceId,
      phone: base.phone ?? rest.phone,
      vehicleReg: base.vehicleReg ?? rest.vehicleReg,
      code: base.code.isEmpty ? rest.code : base.code,
      link: base.link.isEmpty ? rest.link : base.link,
      windowText: base.windowText ?? rest.windowText,
    );
  }
  return merged.values.toList();
}
