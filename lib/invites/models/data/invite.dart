// Gatepass — invite.dart. Created 2026-10-18.
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/json_converters.dart';
import 'delivery_services.dart';
import 'invite_status.dart';

part 'invite.freezed.dart';
part 'invite.g.dart';

/// One invitation: who may come in, when, and the code that lets them.
///
/// The JSON is what the on-device archive and cloud backups store: times as
/// epoch milliseconds, `status` by name. Phones on older builds read it, so
/// field names and formats must not change.
@freezed
abstract class Invite with _$Invite {
  const factory Invite({
    required String id,
    required String siteId,
    required String visitorName,
    @EpochMillisConverter() required DateTime from,
    @EpochMillisConverter() required DateTime until,
    required InviteStatus status,
    required String code,
    required String link,
    @EpochMillisConverter() required DateTime createdAt,

    /// Set for delivery and ride invites; see `deliveryServices`.
    String? serviceId,
    String? phone,
    String? vehicleReg,

    /// True when ATG gave this profile no `validFrom`/`validTill` window.
    /// Such an invite is valid until it is used up or revoked; it is not a
    /// same-day booking, so the UI must not invent times for it.
    @Default(false) bool openEnded,

    /// ATG's own formatted window text, when it supplies one.
    String? windowText,
  }) = _Invite;

  const Invite._();

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);

  bool get isService => serviceId != null;

  /// A service's own spelling ("Uber Eats", where ATG stored "Uber eats"),
  /// else the visitor's name as entered.
  String get displayName => serviceById(serviceId)?.name ?? visitorName;

  String get firstName =>
      isService ? displayName : visitorName.split(' ').first;
}
