import 'package:flutter/foundation.dart';

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
  });

  final String id;
  final String name;
  final String unit;
  final String area;
}

/// The resident's own rotating QR pass, plus a keypad fallback code.
@immutable
class AccessPass {
  const AccessPass({
    required this.payload,
    required this.code,
    required this.issuedAt,
    required this.lifetime,
  });

  final String payload;
  final String code;
  final DateTime issuedAt;
  final Duration lifetime;

  DateTime get expiresAt => issuedAt.add(lifetime);
}

enum InviteStatus {
  awaitingPrescreen,
  ready,
  onSite,
  completed,
  expired,
  revoked;

  bool get isUpcoming => this == awaitingPrescreen || this == ready;

  /// The code still works, so the invite can be revoked.
  bool get isLive => isUpcoming || this == onSite;

  bool get isPast => this == completed || this == expired || this == revoked;
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
    this.multiEntry = false,
    this.prescreenRequired = true,
    this.prescreenedAt,
    this.arrivedAt,
    this.leftAt,
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
  final bool multiEntry;
  final bool prescreenRequired;
  final InviteStatus status;
  final String code;
  final String link;
  final DateTime createdAt;
  final DateTime? prescreenedAt;
  final DateTime? arrivedAt;
  final DateTime? leftAt;

  bool get isService => serviceId != null;

  String get firstName =>
      isService ? visitorName : visitorName.split(' ').first;

  Invite copyWith({InviteStatus? status}) => Invite(
    id: id,
    siteId: siteId,
    visitorName: visitorName,
    serviceId: serviceId,
    phone: phone,
    vehicleReg: vehicleReg,
    from: from,
    until: until,
    multiEntry: multiEntry,
    prescreenRequired: prescreenRequired,
    status: status ?? this.status,
    code: code,
    link: link,
    createdAt: createdAt,
    prescreenedAt: prescreenedAt,
    arrivedAt: arrivedAt,
    leftAt: leftAt,
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
    this.multiEntry = false,
    this.prescreenRequired = true,
  });

  final String visitorName;
  final String? serviceId;
  final String? phone;
  final String? vehicleReg;
  final DateTime from;
  final DateTime until;
  final bool multiEntry;
  final bool prescreenRequired;
}

enum EntryDirection { inbound, outbound }

enum EntryMethod {
  qr('QR code'),
  face('Face scan'),
  pin('Gate code'),
  guard('Guard');

  const EntryMethod(this.label);
  final String label;
}

enum EntrySubject {
  you('You'),
  household('Household'),
  visitor('Visitors'),
  delivery('Deliveries');

  const EntrySubject(this.label);
  final String label;
}

@immutable
class EntryEvent {
  const EntryEvent({
    required this.id,
    required this.siteId,
    required this.personName,
    required this.subject,
    required this.direction,
    required this.method,
    required this.gateName,
    required this.time,
    this.vehicleReg,
    this.inviteId,
    this.hasPhoto = false,
  });

  final String id;
  final String siteId;
  final String personName;
  final EntrySubject subject;
  final EntryDirection direction;
  final EntryMethod method;
  final String gateName;
  final DateTime time;
  final String? vehicleReg;
  final String? inviteId;
  final bool hasPhoto;

  bool get isInbound => direction == EntryDirection.inbound;

  String get headline => subject == EntrySubject.you
      ? (isInbound ? 'You came in' : 'You went out')
      : '$personName ${isInbound ? 'arrived' : 'left'}';
}

enum NotificationKind { arrival, departure, prescreen, notice }

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
    this.entryId,
    this.inviteId,
  });

  final String id;
  final String siteId;
  final NotificationKind kind;
  final String title;
  final String body;
  final DateTime time;
  final bool read;
  final String? entryId;
  final String? inviteId;

  AppNotification copyWith({bool? read}) => AppNotification(
    id: id,
    siteId: siteId,
    kind: kind,
    title: title,
    body: body,
    time: time,
    read: read ?? this.read,
    entryId: entryId,
    inviteId: inviteId,
  );
}
