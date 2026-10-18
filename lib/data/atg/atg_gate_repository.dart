import 'package:flutter/foundation.dart';

import '../gate_repository.dart';
import '../models.dart';
import 'atg_client.dart';
import 'atg_config.dart';

/// A live [GateRepository] that talks to the real At The Gate backend with the
/// signed-in resident's own Firebase token.
///
/// What's wired: OTP sign-in, list invites, create invite, revoke invite.
/// What's deliberately not: the QR pass, gate entries and notifications aren't
/// mapped yet (their response shapes are unknown), so they return empty / throw
/// rather than invent data. The invite flow is the part to verify first.
///
/// The JSON field names used for *reading* invites and for *writing* create /
/// revoke are inferred (see [AtgConfig]). Reading is safe to run blind — it only
/// GETs your own data and logs the real shape. Writing is guarded by
/// [AtgConfig.dryRunWrites], which composes the request and throws instead of
/// sending until you've confirmed the shape.
class AtgGateRepository implements GateRepository {
  AtgGateRepository({AtgHttp? http}) : _http = http ?? AtgHttp() {
    _auth = AtgAuth(_http);
  }

  final AtgHttp _http;
  late final AtgAuth _auth;

  Resident? _resident;
  bool _loggedInviteShape = false;

  // --- auth / transport ---

  Future<Map<String, String>> _authHeaders() async {
    final s = _auth.session;
    if (s == null) throw AtgException('Not signed in.');
    if (s.isExpired) await _auth.refresh();
    return {AtgConfig.authHeader: _auth.session!.idToken};
  }

  Future<dynamic> _get(
    String path, {
    Map<String, String>? query,
    String context = '',
  }) async {
    var url = Uri.parse('${AtgConfig.apiBase}$path');
    if (query != null && query.isNotEmpty) {
      url = url.replace(queryParameters: query);
    }
    return _http.send(
      'GET',
      url,
      headers: await _authHeaders(),
      context: context.isEmpty ? path : context,
    );
  }

  /// The resident's uid: the profile id once known, else the Firebase subject.
  String? get _uid => _resident?.id ?? _auth.session?.uid;

  Future<dynamic> _post(String path, Object body, {String context = ''}) async {
    return _http.send(
      'POST',
      Uri.parse('${AtgConfig.apiBase}$path'),
      headers: await _authHeaders(),
      jsonBody: body,
      context: context.isEmpty ? path : context,
    );
  }

  // --- sign in ---

  @override
  Future<void> requestCode(String phone) =>
      _auth.startLogin(_normalizeMobile(phone));

  @override
  Future<Resident> signIn({required String phone, required String code}) async {
    await _auth.verifyAndExchange(_normalizeMobile(phone), code);
    // Pull the resident's profile so the app has a name/email and sites. A
    // failed profile read must not undo a successful OTP sign-in: log it and
    // enter with what the Firebase session already tells us.
    Resident who;
    try {
      final profile = await _get(
        AtgConfig.profileFullPath,
        query: {'uid': ?_auth.session?.uid},
        context: 'profile',
      );
      who = _mapResident(profile, fallbackPhone: phone);
    } on Object catch (e) {
      debugPrint('[ATG] profile unavailable after sign-in: $e');
      who = Resident(
        id: _auth.session?.uid ?? 'me',
        name: 'Resident',
        phone: phone,
        email: '',
      );
    }
    _resident = who;
    return who;
  }

  @override
  Future<List<Site>> fetchSites() async {
    // Sites usually arrive inside the profile; parse them if present, otherwise
    // fall back to a single site so the app can proceed (the invite endpoints
    // appear to be scoped by the token, not a site id).
    try {
      final profile = await _get(
        AtgConfig.profileFullPath,
        query: {'uid': ?_uid},
        context: 'profile',
      );
      final sites = _mapSites(profile);
      if (sites.isNotEmpty) return sites;
    } on Object catch (e) {
      debugPrint('[ATG] sites unavailable from profile: $e');
    }
    return [
      Site(
        id: _auth.session?.uid ?? 'atg',
        name: _resident?.name ?? 'My estate',
        unit: '',
        area: '',
      ),
    ];
  }

  // --- invites: the verify-first path ---

  @override
  Future<List<Invite>> fetchInvites(String siteId) async {
    final res = await _get(
      AtgConfig.invitesListPath,
      query: {'uid': ?_uid, 'limit': '50'},
      context: 'invites',
    );
    if (!_loggedInviteShape && AtgConfig.debugLog) {
      _loggedInviteShape = true;
      debugPrint(
        '[ATG] First invite payload above. Use it to confirm the f* field '
        'names in AtgConfig, then flip dryRunWrites off.',
      );
    }
    final list = _listOf(res);
    return [
      for (final item in list)
        if (item is Map) _mapInvite(item.cast<String, dynamic>(), siteId),
    ];
  }

  @override
  Future<Invite> createInvite(String siteId, InviteDraft draft) async {
    final (first, last) = _splitName(draft.visitorName);
    final body = <String, dynamic>{
      AtgConfig.fVisitorName: draft.visitorName,
      AtgConfig.fFirstName: first,
      if (last.isNotEmpty) AtgConfig.fLastName: last,
      if (draft.phone != null) AtgConfig.fMobile: draft.phone,
      if (draft.vehicleReg != null) AtgConfig.fLicence: draft.vehicleReg,
      AtgConfig.fDateFrom: draft.from.toUtc().toIso8601String(),
      AtgConfig.fDateTo: draft.until.toUtc().toIso8601String(),
      AtgConfig.fSingleEntry: !draft.multiEntry,
    };
    _guardWrite('create invite', AtgConfig.createVisitorPath, body);

    final created = _asMap(
      await _post(AtgConfig.createVisitorPath, body, context: 'create'),
    );
    final id =
        _firstString(created, const ['uid', 'id', 'profileId']) ??
        'atg-${DateTime.now().millisecondsSinceEpoch}';

    // Second call: generate/send the share link for the invite just created.
    dynamic shared;
    final shareBody = {AtgConfig.fProfileId: id};
    if (!AtgConfig.dryRunWrites) {
      shared = await _post(
        AtgConfig.shareVisitorPath,
        shareBody,
        context: 'share',
      );
    }

    return _mapInvite(
      {...created, if (shared is Map) ...shared.cast<String, dynamic>()},
      siteId,
      fallbackDraft: draft,
      fallbackId: id,
    );
  }

  @override
  Future<Invite> revokeInvite(String inviteId) async {
    final body = {AtgConfig.fProfileId: inviteId};
    _guardWrite('revoke invite', AtgConfig.deleteVisitorPath, body);
    await _post(AtgConfig.deleteVisitorPath, body, context: 'revoke');
    // The app refreshes from this returned invite; we only know its new status.
    return _revokedStub(inviteId);
  }

  // --- not mapped yet (shapes unknown): stay honest rather than fake data ---

  @override
  Future<AccessPass> fetchPass(String siteId) async {
    throw AtgException(
      'The resident QR pass is not mapped to the live API yet. '
      'Use mock mode for the Pass tab, or capture the pass request to add it.',
    );
  }

  @override
  Future<List<EntryEvent>> fetchEntries(String siteId) async => const [];

  @override
  Future<List<AppNotification>> fetchNotifications(String siteId) async =>
      const [];

  @override
  Future<void> markNotificationsRead(Iterable<String> ids) async {}

  // --- write safety ---

  void _guardWrite(String what, String path, Map<String, dynamic> body) {
    if (!AtgConfig.dryRunWrites) return;
    debugPrint('[ATG] DRY RUN — would POST $path\n$body');
    throw AtgException(
      'Dry run: $what was NOT sent. The composed request is in the log. '
      'Confirm the field names against a real capture, then set '
      'AtgConfig.dryRunWrites = false.',
    );
  }

  // --- mapping helpers (all defensive: ATG's exact keys are inferred) ---

  Resident _mapResident(dynamic json, {required String fallbackPhone}) {
    final m = _asMapOrEmpty(json);
    final profile = _asMapOrEmpty(m['profile'] ?? m['user'] ?? m['data']);
    final src = profile.isNotEmpty ? profile : m;
    final name =
        _firstString(src, const [
          'name',
          'fullName',
          'full_name',
          'displayName',
        ]) ??
        [
          _firstString(src, const ['firstName', 'first_name']),
          _firstString(src, const ['lastName', 'last_name']),
        ].whereType<String>().join(' ').trim();
    return Resident(
      id:
          _firstString(src, const ['uid', 'id', 'userId']) ??
          _auth.session?.uid ??
          'me',
      name: name.isEmpty ? 'Resident' : name,
      phone:
          _firstString(src, const ['mobile', 'phoneNumber', 'phone']) ??
          fallbackPhone,
      email: _firstString(src, const ['email']) ?? '',
    );
  }

  List<Site> _mapSites(dynamic json) {
    final m = _asMapOrEmpty(json);
    final raw =
        m['sites'] ??
        m['estates'] ??
        m['complexes'] ??
        _asMapOrEmpty(m['profile'])['sites'];
    return [
      for (final s in _listOf(raw))
        if (s is Map)
          () {
            final sm = s.cast<String, dynamic>();
            return Site(
              id: _firstString(sm, const ['uid', 'id', 'siteId']) ?? '',
              name:
                  _firstString(sm, const ['name', 'siteName', 'estate']) ??
                  'Estate',
              unit: _firstString(sm, const ['unit', 'erf', 'address']) ?? '',
              area: _firstString(sm, const ['area', 'suburb', 'city']) ?? '',
            );
          }(),
    ].where((s) => s.id.isNotEmpty).toList();
  }

  Invite _mapInvite(
    Map<String, dynamic> m,
    String siteId, {
    InviteDraft? fallbackDraft,
    String? fallbackId,
  }) {
    final from =
        _parseDate(
          m[AtgConfig.fDateFrom] ??
              m['from'] ??
              m['validFrom'] ??
              m['startDate'],
        ) ??
        fallbackDraft?.from ??
        DateTime.now();
    final until =
        _parseDate(
          m[AtgConfig.fDateTo] ?? m['to'] ?? m['until'] ?? m['endDate'],
        ) ??
        fallbackDraft?.until ??
        from.add(const Duration(hours: 4));
    final name =
        _firstString(m, const ['visitorName', 'name', 'fullName', 'visitor']) ??
        fallbackDraft?.visitorName ??
        'Visitor';
    return Invite(
      id:
          _firstString(m, const ['uid', 'id', 'profileId']) ??
          fallbackId ??
          'atg-${from.millisecondsSinceEpoch}',
      siteId: siteId,
      visitorName: name,
      serviceId: fallbackDraft?.serviceId,
      phone:
          _firstString(m, const ['mobile', 'phoneNumber', 'phone']) ??
          fallbackDraft?.phone,
      vehicleReg:
          _firstString(m, const [
            'licence',
            'license',
            'vehicle',
            'registration',
          ]) ??
          fallbackDraft?.vehicleReg,
      from: from,
      until: until,
      multiEntry: switch (_asBool(m[AtgConfig.fSingleEntry] ?? m['single'])) {
        final bool single => !single,
        null => fallbackDraft?.multiEntry ?? false,
      },
      prescreenRequired: fallbackDraft?.prescreenRequired ?? true,
      status: _mapStatus(_firstString(m, const ['status', 'state'])),
      code: _firstString(m, const ['code', 'pin', 'accessCode']) ?? '',
      link: _firstString(m, const [AtgConfig.fShareLink, 'link', 'url']) ?? '',
      createdAt:
          _parseDate(m['createdAt'] ?? m['created'] ?? m['dateCreated']) ??
          DateTime.now(),
    );
  }

  Invite _revokedStub(String id) => Invite(
    id: id,
    siteId: '',
    visitorName: '',
    from: DateTime.now(),
    until: DateTime.now(),
    status: InviteStatus.revoked,
    code: '',
    link: '',
    createdAt: DateTime.now(),
  );

  InviteStatus _mapStatus(String? raw) {
    final s = (raw ?? '').toLowerCase();
    if (s.contains('revok') || s.contains('delet') || s.contains('cancel')) {
      return InviteStatus.revoked;
    }
    if (s.contains('onsite') ||
        s.contains('on_site') ||
        s.contains('on site')) {
      return InviteStatus.onSite;
    }
    if (s.contains('complete') || s.contains('left') || s.contains('done')) {
      return InviteStatus.completed;
    }
    if (s.contains('expire')) return InviteStatus.expired;
    if (s.contains('pending') ||
        s.contains('await') ||
        s.contains('prescreen') ||
        s.contains('pre-screen')) {
      return InviteStatus.awaitingPrescreen;
    }
    return InviteStatus.ready;
  }

  // --- tiny utils ---

  /// To South African E.164. Drops spaces/punctuation, then a leading country
  /// code and/or trunk '0', and re-prefixes +27. So '+27 0821234567',
  /// '0821234567', '27821234567' and '821234567' all become '+27821234567'.
  static String _normalizeMobile(String phone) {
    var d = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (d.startsWith('27')) d = d.substring(2);
    if (d.startsWith('0')) d = d.substring(1);
    return '+27$d';
  }

  static (String, String) _splitName(String full) {
    final parts = full.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return (full.trim(), '');
    return (parts.first, parts.sublist(1).join(' '));
  }

  static String? _firstString(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      final v = m[k];
      if (v is String && v.isNotEmpty) return v;
      if (v is num) return v.toString();
    }
    return null;
  }

  static bool? _asBool(Object? v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.toLowerCase();
      if (s == 'true' || s == '1' || s == 'yes') return true;
      if (s == 'false' || s == '0' || s == 'no') return false;
    }
    return null;
  }

  static DateTime? _parseDate(Object? v) {
    if (v == null) return null;
    if (v is num) {
      // Epoch seconds vs milliseconds.
      final ms = v > 1e11 ? v.toInt() : (v * 1000).toInt();
      return DateTime.fromMillisecondsSinceEpoch(ms).toLocal();
    }
    if (v is String) {
      final asInt = int.tryParse(v);
      if (asInt != null) return _parseDate(asInt);
      return DateTime.tryParse(v)?.toLocal();
    }
    return null;
  }

  static List<dynamic> _listOf(dynamic v) {
    if (v is List) return v;
    if (v is Map) {
      for (final key in const [
        'data',
        'items',
        'results',
        'profiles',
        'list',
      ]) {
        final inner = v[key];
        if (inner is List) return inner;
      }
    }
    return const [];
  }

  static Map<String, dynamic> _asMap(dynamic v) {
    if (v is Map<String, dynamic>) return v;
    if (v is Map) return v.cast<String, dynamic>();
    throw AtgException('Expected a JSON object, got ${v.runtimeType}.');
  }

  static Map<String, dynamic> _asMapOrEmpty(dynamic v) {
    if (v is Map<String, dynamic>) return v;
    if (v is Map) return v.cast<String, dynamic>();
    return const {};
  }
}
