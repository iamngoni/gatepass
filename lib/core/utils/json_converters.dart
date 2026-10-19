// Gatepass — json_converters.dart. Created 2026-10-19.
import 'package:json_annotation/json_annotation.dart';

import 'atg_json.dart';

/// Local time stored as epoch milliseconds, the format the invite archive
/// and cloud backups have always used.
class EpochMillisConverter implements JsonConverter<DateTime, int> {
  const EpochMillisConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}

/// ATG's loose timestamps: epoch seconds or milliseconds, as a number or
/// text, or ISO 8601. Read-only; requests send epoch milliseconds.
class AtgDateConverter implements JsonConverter<DateTime?, Object?> {
  const AtgDateConverter();

  @override
  DateTime? fromJson(Object? json) => parseAtgDate(json);

  @override
  Object? toJson(DateTime? object) => object?.millisecondsSinceEpoch;
}
