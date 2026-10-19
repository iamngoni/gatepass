import 'package:flutter/foundation.dart';

import 'services.dart';

@immutable
class Resident {
  const Resident({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  final String id;
  final String name;
  final String phone;
  final String email;

  String get firstName => name.split(' ').first;
}

@immutable
class Site {
  const Site({
    required this.id,
    required this.name,
    required this.unit,
    required this.area,
    this.inviteHorizonDays = 30,
  });

  final String id;
  final String name;
  final String unit;
  final String area;

  /// How far ahead this estate accepts a new invitation. Read from ATG's
  /// `userSettings.invitationMaxDaysFromToday`; 30 is only the UI fallback
  /// while account settings are unavailable.
  final int inviteHorizonDays;
}

enum InviteStatus {
  active,
  expired,
  revoked;

  /// The code still works, so the invite can be revoked.
  bool get isLive => this == active;

  bool get isPast => this == expired || this == revoked;
}

@immutable
class Invite {
  const Invite({
    required this.id,
    required this.siteId,
    required this.visitorName,
    required this.from,
    required this.until,
    required this.status,
    required this.code,
    required this.link,
    required this.createdAt,
    this.serviceId,
    this.phone,
    this.vehicleReg,
    this.openEnded = false,
    this.windowText,
  });

  final String id;
  final String siteId;
  final String visitorName;

  /// Set for delivery and ride invites; see `deliveryServices`.
  final String? serviceId;
  final String? phone;
  final String? vehicleReg;
  final DateTime from;
  final DateTime until;
  final InviteStatus status;
  final String code;
  final String link;
  final DateTime createdAt;

  /// True when ATG gave this profile no `validFrom`/`validTill` window. Such
  /// an invite is valid until it is used up or revoked; it is not a same-day
  /// booking, so the UI must not invent times for it.
  final bool openEnded;

  /// ATG's own formatted window text, when it supplies one.
  final String? windowText;

  bool get isService => serviceId != null;

  /// A service's own spelling ("Uber Eats", where ATG stored "Uber eats"),
  /// else the visitor's name as entered.
  String get displayName => serviceById(serviceId)?.name ?? visitorName;

  String get firstName =>
      isService ? displayName : visitorName.split(' ').first;

  Invite copyWith({InviteStatus? status}) => Invite(
    id: id,
    siteId: siteId,
    visitorName: visitorName,
    serviceId: serviceId,
    phone: phone,
    vehicleReg: vehicleReg,
    from: from,
    until: until,
    status: status ?? this.status,
    code: code,
    link: link,
    createdAt: createdAt,
    openEnded: openEnded,
    windowText: windowText,
  );
}

@immutable
class InviteDraft {
  const InviteDraft({
    required this.visitorName,
    required this.from,
    required this.until,
    this.serviceId,
    this.phone,
    this.vehicleReg,
  });

  final String visitorName;
  final String? serviceId;
  final String? phone;
  final String? vehicleReg;
  final DateTime from;
  final DateTime until;
}

enum NotificationKind { arrival, departure, notice }

@immutable
class AppNotification {
  const AppNotification({
    required this.id,
    required this.siteId,
    required this.kind,
    required this.title,
    required this.body,
    required this.time,
    this.read = false,
  });

  final String id;
  final String siteId;
  final NotificationKind kind;
  final String title;
  final String body;
  final DateTime time;
  final bool read;

  AppNotification copyWith({bool? read}) => AppNotification(
    id: id,
    siteId: siteId,
    kind: kind,
    title: title,
    body: body,
    time: time,
    read: read ?? this.read,
  );
}
