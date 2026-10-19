// Gatepass — atg_json.dart. Created 2026-10-19.
//
// ATG's JSON is loosely shaped: the same value arrives under different keys,
// as a number or a string, in seconds or milliseconds. These readers turn
// that into one typed value at the boundary, for the DTOs' `readValue` and
// converters, so nothing past the DTO has to guess.

/// The first non-empty string (or number, as text) among [keys].
String? firstString(Map<dynamic, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is String && value.isNotEmpty) return value;
    if (value is num) return value.toString();
  }
  return null;
}

/// The first value present among [keys], untouched.
Object? firstValue(Map<dynamic, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value != null) return value;
  }
  return null;
}

/// `true`/`false` from a bool, a number, or text like "yes" and "0".
bool? asBool(Object? value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final s = value.toLowerCase();
    if (s == 'true' || s == '1' || s == 'yes') return true;
    if (s == 'false' || s == '0' || s == 'no') return false;
  }
  return null;
}

/// A local time from epoch seconds or milliseconds (as a number or text),
/// or an ISO 8601 string.
DateTime? parseAtgDate(Object? value) {
  if (value == null) return null;
  if (value is num) {
    final ms = value > 1e11 ? value.toInt() : (value * 1000).toInt();
    return DateTime.fromMillisecondsSinceEpoch(ms).toLocal();
  }
  if (value is String) {
    final asInt = int.tryParse(value);
    if (asInt != null) return parseAtgDate(asInt);
    return DateTime.tryParse(value)?.toLocal();
  }
  return null;
}

/// The list inside a response: the body itself, or under one of ATG's
/// envelope keys.
List<Object?> listOf(Object? value) {
  if (value is List) return value.cast<Object?>();
  if (value is Map) {
    for (final key in const [
      'data',
      'items',
      'results',
      'profiles',
      'visitors',
      'list',
    ]) {
      final inner = value[key];
      if (inner is List) return inner.cast<Object?>();
    }
  }
  return const [];
}

/// The JSON objects in [value]'s list, ready for a DTO's `fromJson`.
List<Map<String, dynamic>> objectsOf(Object? value) => [
  for (final item in listOf(value))
    if (item is Map) item.cast<String, dynamic>(),
];

/// [value] as a JSON object, or empty when it is anything else.
Map<String, dynamic> objectOrEmpty(Object? value) =>
    value is Map ? value.cast<String, dynamic>() : const {};
