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
  String? _accountUid;
  String? _accountName;
  String? _accountEmail;
  String? _accountUnit;
  String? _estateName;
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

  /// The estate account uid used by visitor/entry endpoints. It is distinct
  /// from the Firebase login uid: `/api/user/v2/settings` returns it as
  /// `accessPermissions.hostUid`.
  String? get _uid => _accountUid ?? _resident?.id ?? _auth.session?.uid;

  String? get _firebaseUid => _auth.session?.uid;

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
  Future<Resident?> restoreSession() async {
    if (!_auth.isSignedIn) return null;
    try {
      // Restored sessions deliberately start expired, so this both proves the
      // stored refresh token still works and recovers the Firebase uid.
      await _auth.refresh();
    } on Object catch (e) {
      debugPrint('[ATG] stored session could not be refreshed: $e');
      return null;
    }

    final phone = _auth.session?.phone ?? '';
    _resident = Resident(
      id: _auth.session?.uid ?? 'me',
      name: 'Resident',
      phone: phone,
      email: '',
    );
    try {
      _resident = await _loadAccount();
    } on Object catch (e) {
      debugPrint('[ATG] account settings unavailable after restore: $e');
    }
    return _resident;
  }

  @override
  Future<Resident> signIn({required String phone, required String code}) async {
    await _auth.verifyAndExchange(_normalizeMobile(phone), code);
    // The Firebase uid authenticates the token. The estate account uid used by
    // visitor endpoints is a different value returned by the account settings
    // endpoint, so load that before entering the app.
    Resident who;
    try {
      who = await _loadAccount();
    } on Object catch (e) {
      debugPrint('[ATG] account settings unavailable after sign-in: $e');
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
    if (_accountUid == null) {
      try {
        await _loadAccount();
      } on Object catch (e) {
        debugPrint('[ATG] sites unavailable from account settings: $e');
      }
    }
    // A resident account is scoped to one estate in this API. The account
    // settings response carries the estate name and the resident's unit.
    return [
      Site(
        id: _accountUid ?? _auth.session?.uid ?? 'atg',
        name: _estateName ?? 'My estate',
        unit: _accountUnit ?? '',
        area: '',
      ),
    ];
  }

  /// Resolves the estate/account attached to the Firebase login. The login uid
  /// is not the `hostUid` visitor endpoints use, so this is the necessary
  /// bridge between authentication and resident data.
  Future<Resident> _loadAccount() async {
    final shared = _asMap(
      await _post(AtgConfig.sharedAccessPath, {
        'deviceType': AtgConfig.platform,
        'deviceId': 'gatepass',
        'appVersion': AtgConfig.appVersion,
        'appBuildNumber': AtgConfig.appBuildNumber,
      }, context: 'accounts'),
    );
    final accounts = _listOf(shared['sharedAccess']);
    final account = accounts.whereType<Map>().firstOrNull;
    if (account == null) {
      throw AtgException('No estate account is linked to this login.');
    }
    final accountMap = account.cast<String, dynamic>();
    _accountUid =
        _firstString(accountMap, const ['hostUid', 'accountUid']) ??
        _accountUid;
    _estateName =
        _firstString(accountMap, const ['accountName', 'name']) ?? _estateName;
    _accountUnit =
        _firstString(accountMap, const ['invitationsUserUnit', 'unit']) ??
        _accountUnit;
    final accountName =
        _firstString(accountMap, const ['invitationsUserName'])?.trim() ?? '';
    if (accountName.isNotEmpty) _accountName = accountName;
    _accountEmail = _firstString(accountMap, const ['email']) ?? _accountEmail;

    // The account settings read adds the estate branding and confirms the
    // permissions behind this hostUid. If it is unavailable, the shared-access
    // row above is still enough to enter and load visitor data.
    try {
      final settings = _asMap(
        await _get(
          AtgConfig.userSettingsPath,
          query: {'uid': ?_accountUid},
          context: 'account',
        ),
      );
      final app = _asMapOrEmpty(settings['appSettings']);
      final access = _asMapOrEmpty(settings['accessPermissions']);
      _estateName =
          _firstString(app, const ['brandName', 'name']) ?? _estateName;
      _accountUnit =
          _firstString(access, const ['invitationsUserUnit', 'unit']) ??
          _accountUnit;
      final first =
          _firstString(access, const [
            'invitationsUserName',
            'firstName',
          ])?.trim() ??
          '';
      final last =
          _firstString(access, const [
            'invitationsUserSurname',
            'lastName',
          ])?.trim() ??
          '';
      final fullName = [first, last].where((part) => part.isNotEmpty).join(' ');
      if (fullName.isNotEmpty) _accountName = fullName;
      _accountEmail = _firstString(access, const ['email']) ?? _accountEmail;
    } on Object catch (e) {
      debugPrint('[ATG] account settings unavailable: $e');
    }

    if (AtgConfig.debugLog) {
      debugPrint(
        '[ATG] account resolved: hostUid ${_accountUid ?? 'missing'}, '
        'estate ${_estateName ?? 'missing'}',
      );
    }
    return Resident(
      id: _accountUid ?? _firebaseUid ?? 'me',
      name: _accountName ?? 'Resident',
      phone: _auth.session?.phone ?? '',
      email: _accountEmail ?? '',
    );
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
        'visitors',
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
