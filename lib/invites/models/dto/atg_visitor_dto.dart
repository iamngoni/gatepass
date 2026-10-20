//
//  Gatepass
//  atg_visitor_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/atg_json.dart';
import '../../../core/utils/json_converters.dart';
import '../data/delivery_services.dart';
import '../data/invite.dart';
import '../data/invite_draft.dart';
import '../data/invite_status.dart';

part 'atg_visitor_dto.freezed.dart';
part 'atg_visitor_dto.g.dart';

/// A visitor profile as ATG lists it (`/api/visitor/v3/profiles`) or
/// returns it from a create. Keys vary between endpoints and versions, so
/// each field reads the first of its known spellings.
@freezed
abstract class AtgVisitorDTO with _$AtgVisitorDTO {
  const factory AtgVisitorDTO({
    /// The per-invite record id. `uid` is the estate host uid shared by
    /// every visitor record, so it is the last resort.
    @JsonKey(readValue: _readId) String? id,
    @JsonKey(readValue: _readFullName) String? fullName,
    @JsonKey(readValue: _readFirstName) String? firstName,
    @JsonKey(readValue: _readLastName) String? lastName,
    @JsonKey(readValue: _readPhone) String? phone,
    @JsonKey(readValue: _readVehicle) String? vehicleReg,
    @AtgDateConverter() @JsonKey(readValue: _readFrom) DateTime? validFrom,
    @AtgDateConverter() @JsonKey(readValue: _readUntil) DateTime? validTill,

    /// The retention horizon (default ~10 years), not the booking window.
    @AtgDateConverter() DateTime? rememberTill,
    @AtgDateConverter() @JsonKey(readValue: _readCreated) DateTime? createdAt,
    String? validFromDateText,
    String? validTillDateText,
    @JsonKey(readValue: _readStatus) String? status,
    @JsonKey(readValue: _readDeleted) bool? deleted,
    @JsonKey(readValue: _readCode) String? code,
    @JsonKey(readValue: _readLink) String? link,
  }) = _AtgVisitorDTO;

  const AtgVisitorDTO._();

  factory AtgVisitorDTO.fromJson(Map<String, dynamic> json) =>
      _$AtgVisitorDTOFromJson(json);

  /// The app's invite. [draft] fills what a create reply leaves out.
  Invite toInvite({
    required String siteId,
    required DateTime now,
    InviteDraft? draft,
    String? fallbackId,
  }) {
    final created = createdAt ?? now;
    // ATG profiles are frequently open-ended: no validFrom/validTill at all.
    final openEnded = validFrom == null && validTill == null && draft == null;
    final from = validFrom ?? draft?.from ?? created;
    final until = validTill ?? draft?.until ?? rememberTill ?? from;
    // ATG's own text has no time component, so it is only a fallback for
    // replies that lack the raw timestamps.
    final windowText =
        (validFrom == null || validTill == null) &&
            validFromDateText != null &&
            validTillDateText != null
        ? '$validFromDateText – $validTillDateText'
        : null;
    // ATG stores the parts separately (`name` + `surname`); joining them
    // keeps "Quick Invite Probe" from collapsing to "Quick".
    final composed = [
      firstName,
      lastName,
    ].whereType<String>().where((part) => part.trim().isNotEmpty).join(' ');
    final name =
        fullName ??
        (composed.isNotEmpty ? composed : draft?.visitorName ?? 'Visitor');
    return Invite(
      id: id ?? fallbackId ?? 'atg-${from.millisecondsSinceEpoch}',
      siteId: siteId,
      visitorName: name,
      serviceId: draft?.serviceId ?? serviceIdForName(name),
      phone: phone ?? draft?.phone,
      vehicleReg: vehicleReg ?? draft?.vehicleReg,
      from: from,
      until: until,
      status: _status(until, now),
      code: code ?? '',
      link: link ?? '',
      createdAt: created,
      openEnded: openEnded,
      windowText: windowText,
    );
  }

  InviteStatus _status(DateTime until, DateTime now) {
    if (deleted ?? false) return InviteStatus.revoked;
    final s = (status ?? '').toLowerCase();
    if (s.contains('revok') || s.contains('delet') || s.contains('cancel')) {
      return InviteStatus.revoked;
    }
    if (s.contains('expire') || until.isBefore(now)) {
      return InviteStatus.expired;
    }
    return InviteStatus.active;
  }
}

Object? _readId(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['id', 'profileId', 'uid']);

Object? _readFullName(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['visitorName', 'fullName']);

Object? _readFirstName(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['name', 'visitor']);

Object? _readLastName(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['surname', 'lastName']);

Object? _readPhone(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['mobile', 'phoneNumber', 'phone']);

Object? _readVehicle(Map<dynamic, dynamic> json, String _) => firstString(
  json,
  const ['carLic', 'licence', 'license', 'vehicle', 'registration'],
);

Object? _readFrom(Map<dynamic, dynamic> json, String _) =>
    firstValue(json, const ['validFrom', 'from', 'startDate']);

Object? _readUntil(Map<dynamic, dynamic> json, String _) =>
    firstValue(json, const ['validTill', 'to', 'until', 'endDate']);

Object? _readCreated(Map<dynamic, dynamic> json, String _) =>
    firstValue(json, const ['dateCreated', 'createdAt', 'created']);

Object? _readStatus(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['status', 'state']);

Object? _readDeleted(Map<dynamic, dynamic> json, String _) =>
    asBool(json['deleted']);

Object? _readCode(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['code', 'pin', 'accessCode']);

Object? _readLink(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['linkInvitation', 'link', 'url']);
