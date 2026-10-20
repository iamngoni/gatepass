//
//  Gatepass
//  text_helpers.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

String initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
  return parts.take(2).map((p) => p[0].toUpperCase()).join();
}

/// Splits a code into groups that are easy to read out: "418207" → "418 207",
/// ATG's "ATGM2UAZALP0" → "ATGM 2UAZ ALP0". Display only: copy and share the
/// raw code.
String formatCode(String code) {
  if (code.length == 6) return '${code.substring(0, 3)} ${code.substring(3)}';
  if (code.length <= 6) return code;
  return [
    for (var i = 0; i < code.length; i += 4)
      code.substring(i, i + 4 > code.length ? code.length : i + 4),
  ].join(' ');
}
