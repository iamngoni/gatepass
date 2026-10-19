// Gatepass — phone_numbers.dart. Created 2026-10-19.

/// To South African E.164. Drops spaces and punctuation, then a leading
/// country code and/or trunk '0', and re-prefixes +27. So
/// '+27 0821234567', '0821234567', '27821234567' and '821234567' all become
/// '+27821234567'.
String normalizeSaMobile(String phone) {
  var digits = phone.replaceAll(RegExp('[^0-9]'), '');
  if (digits.startsWith('27')) digits = digits.substring(2);
  if (digits.startsWith('0')) digits = digits.substring(1);
  return '+27$digits';
}

/// "Chipo Ndlovu Moyo" → ("Chipo", "Ndlovu Moyo"), as ATG stores them.
(String, String) splitFullName(String full) {
  final parts = full.trim().split(RegExp(r'\s+'));
  if (parts.length < 2) return (full.trim(), '');
  return (parts.first, parts.sublist(1).join(' '));
}
