// Gatepass — site.dart. Created 2026-10-18.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'site.freezed.dart';

/// The estate the resident's account belongs to. ATG scopes a resident
/// account to one estate.
@freezed
abstract class Site with _$Site {
  const factory Site({
    required String id,
    required String name,
    required String unit,
    required String area,

    /// How far ahead this estate accepts a new invitation. Read from ATG's
    /// `userSettings.invitationMaxDaysFromToday`; 30 is only the UI
    /// fallback while account settings are unavailable.
    @Default(30) int inviteHorizonDays,
  }) = _Site;
}
