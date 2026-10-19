// Gatepass — atg_redactor.dart. Created 2026-10-18.
import 'dart:convert';

/// Masks credentials and phone numbers in logged ATG traffic, keeping the
/// shape (key names and harmless values) readable for schema discovery.
abstract final class AtgRedactor {
  static final _jwt = RegExp(
    r'[A-Za-z0-9_-]{16,}\.[A-Za-z0-9_-]{16,}\.[A-Za-z0-9_-]{8,}',
  );
  static final _opaqueCredential = RegExp('[A-Za-z0-9_-]{80,}');
  // No lookbehind: ATG builds account ids by appending the phone number to
  // the uid (`<uid>+27831234567`), so a digit often precedes the `+`.
  static final _e164Phone = RegExp(r'\+[1-9][0-9]{7,14}(?![0-9])');
  static final _credentialKeyFallback = RegExp(
    '("(?:refreshToken|refresh_token|idToken|id_token|access_token|token|'
    r'customToken|custom_token)"\s*:\s*")[^"]*(")',
    caseSensitive: false,
  );

  static const _credentialKeys = {
    'authorization',
    'cookie',
    'setcookie',
    'token',
    'customtoken',
    'authtoken',
    'firebasetoken',
    'idtoken',
    'accesstoken',
    'refreshtoken',
    'bearertoken',
    'sessiontoken',
    'securitytoken',
    'xidtoken',
    'apikey',
    'hostsharedkey',
    'sharedkey',
  };

  static const _phoneKeys = {
    'loginstring',
    'contact',
    'mobile',
    'phone',
    'phonenumber',
    'msisdn',
  };

  static String redact(String s) {
    final trimmed = s.trim();
    if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
      try {
        return jsonEncode(_redactValue(jsonDecode(trimmed)));
      } on FormatException {
        // Fall through to text/form redaction for malformed JSON.
      }
    }

    // Form bodies and query strings: mask by field name.
    if (s.contains('=') && !s.contains(' ')) {
      final parts = s.split('&');
      if (parts.every((part) => part.contains('='))) {
        return parts.map(_redactField).join('&');
      }
    }

    return _redactText(s).replaceAllMapped(
      _credentialKeyFallback,
      (m) => '${m[1]}«redacted»${m[2]}',
    );
  }

  static String _redactField(String part) {
    final i = part.indexOf('=');
    final key = part.substring(0, i);
    if (_isCredentialKey(key)) return '$key=«redacted»';
    if (_isPhoneKey(key)) return '$key=«phone»';
    return '$key=${_redactText(part.substring(i + 1))}';
  }

  static Object? _redactValue(Object? node) {
    if (node is Map) {
      return {
        for (final entry in node.entries)
          entry.key.toString(): _isCredentialKey(entry.key.toString())
              ? '«redacted»'
              : _isPhoneKey(entry.key.toString())
              ? '«phone»'
              : _redactValue(entry.value),
      };
    }
    if (node is List) return node.map(_redactValue).toList();
    if (node is String) return _redactText(node);
    return node;
  }

  static String _redactText(String value) => value
      .replaceAll(_jwt, '«jwt»')
      .replaceAll(_opaqueCredential, '«token»')
      .replaceAll(_e164Phone, '«phone»');

  static bool _isCredentialKey(String key) =>
      _credentialKeys.contains(_normalizeKey(key));

  static bool _isPhoneKey(String key) =>
      _phoneKeys.contains(_normalizeKey(key));

  static String _normalizeKey(String key) =>
      key.replaceAll(RegExp('[^A-Za-z0-9]'), '').toLowerCase();
}
