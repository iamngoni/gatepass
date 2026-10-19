import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../gate_repository.dart';
import '../models.dart';
import '../services.dart';
import 'atg_client.dart';
import 'atg_config.dart';

/// A live [GateRepository] that talks to the real At The Gate backend with the
/// signed-in resident's own Firebase token.
///
/// What's wired: OTP sign-in, account discovery, invitations
/// (list/create/revoke), and notifications.
/// The account has no gate-entry permission, so the app does not offer an
/// activity screen or invent visitor arrival history.
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
  int? _invitationHorizonDays;

  int? _invitationCategoryId;

  static final String _notificationReadPath =
      '${Directory.systemTemp.path}/gatepass_notifications_seen.json';
  Set<String>? _seenNotificationIds;
  bool _seededNotificationBaseline = false;

  // --- auth / transport ---

  Future<Map<String, String>> _authHeaders() async {
    await _auth.restore();
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

  /// The estate account uid used by visitor endpoints. It is distinct
  /// from the Firebase login uid: `/api/user/v2/settings` returns it as
  /// `accessPermissions.hostUid`.
  String? get _uid => _accountUid ?? _resident?.id ?? _auth.session?.uid;

  String? get _firebaseUid => _auth.session?.uid;

  Future<dynamic> _postForm(
    String path,
    Map<String, String> body, {
    String context = '',
  }) async {
    return _http.send(
      'POST',
      Uri.parse('${AtgConfig.apiBase}$path'),
      headers: await _authHeaders(),
      formBody: body,
      context: context.isEmpty ? path : context,
    );
  }

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
  Future<void> requestCode(
    String phone, {
    OtpChannel channel = OtpChannel.sms,
  }) => _auth.startLogin(
    _normalizeMobile(phone),
    whatsApp: channel == OtpChannel.whatsapp,
  );

  @override
  Future<Resident?> restoreSession() async {
    await _auth.restore();
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
  Future<CloudIdentity> cloudIdentity() async {
    final headers = await _authHeaders();
    final uid = _auth.session?.uid;
    if (uid == null) throw AtgException('Not signed in.');
    return (uid: uid, idToken: headers[AtgConfig.authHeader]!);
  }

  @override
  Future<void> signOut() async {
    _resident = null;
    _accountUid = null;
    _invitationCategoryId = null;
    await _auth.signOut();
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
        inviteHorizonDays: _invitationHorizonDays ?? 30,
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
      final userSettings = _asMapOrEmpty(settings['userSettings']);
      final horizon = userSettings['invitationMaxDaysFromToday'];
      if (horizon is num) {
        _invitationHorizonDays = horizon.toInt().clamp(1, 365);
      }
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
      query: {'uid': ?_uid, 'limit': '$invitePageLimit'},
      context: 'invites',
    );
    final list = _listOf(res);
    return [
      for (final item in list)
        if (item is Map) _mapInvite(item.cast<String, dynamic>(), siteId),
    ];
  }

  @override
  Future<Invite> createInvite(String siteId, InviteDraft draft) async {
    final (first, last) = _splitName(draft.visitorName);
    final categoryId = await _invitationCategory();
    final body = <String, dynamic>{
      'uid': ?_uid,
      AtgConfig.fFirstName: first,
      if (last.isNotEmpty) AtgConfig.fLastName: last,
      AtgConfig.fMobile: ?draft.phone,
      AtgConfig.fLicence: ?draft.vehicleReg,
      AtgConfig.fCategoryId: ?categoryId,
      // ATG stores timestamps as epoch milliseconds.
      AtgConfig.fValidFrom: draft.from.toUtc().millisecondsSinceEpoch,
      AtgConfig.fValidTill: draft.until.toUtc().millisecondsSinceEpoch,
      // This flow creates a single-entry invitation.
      AtgConfig.fVisitsAllowed: 1,
      AtgConfig.fNotifyOn: 'both',
    };
    _guardWrite('create invite', AtgConfig.createVisitorPath, body);

    final created = _asMap(
      await _post(AtgConfig.createVisitorPath, body, context: 'create'),
    );
    final id =
        _firstString(created, const ['id', 'profileId', 'uid']) ??
        'atg-${DateTime.now().millisecondsSinceEpoch}';

    // Creating the profile already returns its code and share link, so no
    // second "share" request is needed here. Sending the link stays an
    // explicit user action.
    return _mapInvite(created, siteId, fallbackDraft: draft, fallbackId: id);
  }

  /// The estate's "Invitation" visitor category. ATG rejects a create without
  /// one, and the id is per-estate, so it has to be read rather than hardcoded.
  Future<int?> _invitationCategory() async {
    final cached = _invitationCategoryId;
    if (cached != null) return cached;
    try {
      final res = await _get(
        AtgConfig.categoriesPath,
        query: {'uid': ?_uid},
        context: 'categories',
      );
      for (final item in _listOf(res)) {
        if (item is! Map) continue;
        final map = item.cast<String, dynamic>();
        final name = _firstString(map, const [
          'name',
          'categoryName',
        ])?.toLowerCase();
        if (name != 'invitation' && name != 'visitor') continue;
        final id = map['id'];
        final value = id is num ? id.toInt() : int.tryParse('$id');
        if (value != null) return _invitationCategoryId = value;
      }
    } on Object catch (e) {
      debugPrint('[ATG] visitor categories unavailable: $e');
    }
    return null;
  }

  @override
  Future<Invite> revokeInvite(String inviteId) async {
    // Verified live: this endpoint ignores a JSON body and answers
    // `500 id can't be null`. It wants the id as a form/query parameter.
    final body = {AtgConfig.fProfileId: inviteId};
    _guardWrite('revoke invite', AtgConfig.deleteVisitorPath, body);
    await _postForm(AtgConfig.deleteVisitorPath, body, context: 'revoke');
    // The app refreshes from this returned invite; we only know its new status.
    return _revokedStub(inviteId);
  }

  @override
  Future<List<AppNotification>> fetchNotifications(String siteId) async {
    final res = await _get(
      AtgConfig.notificationsListPath,
      context: 'notifications',
    );
    final list = _listOf(res);
    final mapped = [
      for (final item in list)
        if (item is Map) _mapNotification(item.cast<String, dynamic>(), siteId),
    ];
    final seen = _loadSeenNotifications();
    final hadBaseline = File(_notificationReadPath).existsSync();
    if (!hadBaseline && !_seededNotificationBaseline) {
      // First run sees the existing archive. Treat it as history instead of
      // showing fifty old notifications as new.
      seen.addAll(mapped.map((n) => n.id));
      _saveSeenNotifications();
      _seededNotificationBaseline = true;
      return [for (final n in mapped) n.copyWith(read: true)];
    }
    return [
      for (final n in mapped) seen.contains(n.id) ? n.copyWith(read: true) : n,
    ];
  }

  @override
  Future<void> markNotificationsRead(Iterable<String> ids) async {
    _loadSeenNotifications().addAll(ids);
    _saveSeenNotifications();
  }

  Set<String> _loadSeenNotifications() {
    final cached = _seenNotificationIds;
    if (cached != null) return cached;
    final seen = <String>{};
    try {
      final file = File(_notificationReadPath);
      if (file.existsSync()) {
        final decoded = jsonDecode(file.readAsStringSync());
        if (decoded is List) {
          seen.addAll(decoded.whereType<String>());
        }
      }
    } on Object catch (e) {
      debugPrint('[ATG] could not read notification state: $e');
    }
    return _seenNotificationIds = seen;
  }

  void _saveSeenNotifications() {
    try {
      final seen = _seenNotificationIds;
      if (seen == null) return;
      final ids = seen.toList();
      // The archive can grow forever; keep the most recent 1,000 ids.
      final kept = ids.length > 1000 ? ids.sublist(ids.length - 1000) : ids;
      File(_notificationReadPath).writeAsStringSync(jsonEncode(kept));
    } on Object catch (e) {
      debugPrint('[ATG] could not save notification state: $e');
    }
  }

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

  AppNotification _mapNotification(Map<String, dynamic> m, String siteId) {
    final title =
        _firstString(m, const ['title', 'message', 'body']) ?? 'Estate update';
    final customFields = m['customFields'];
    final body = customFields is List
        ? customFields
              .whereType<String>()
              .where((s) => s.isNotEmpty)
              .join(' · ')
        : (_firstString(m, const ['message', 'body', 'description']) ?? '');
    final lower = title.toLowerCase();
    final kind = lower.contains('enter') || lower.contains('arriv')
        ? NotificationKind.arrival
        : lower.contains('exit') ||
              lower.contains('left') ||
              lower.contains('depart')
        ? NotificationKind.departure
        : NotificationKind.notice;
    return AppNotification(
      id:
          _firstString(m, const ['id', 'notificationId', 'uid']) ??
          'atg-${m['dataAdded'] ?? DateTime.now().millisecondsSinceEpoch}',
      siteId: siteId,
      kind: kind,
      title: title,
      body: body,
      time:
          _parseDate(m['dataAdded'] ?? m['dateCreated'] ?? m['createdAt']) ??
          DateTime.now(),
      read: _asBool(m['read'] ?? m['isRead']) ?? false,
    );
  }

  Invite _mapInvite(
    Map<String, dynamic> m,
    String siteId, {
    InviteDraft? fallbackDraft,
    String? fallbackId,
  }) {
    final createdAt =
        _parseDate(m['dateCreated'] ?? m['createdAt'] ?? m['created']) ??
        DateTime.now();
    final explicitFrom = _parseDate(
      m[AtgConfig.fValidFrom] ??
          m[AtgConfig.fDateFrom] ??
          m['from'] ??
          m['startDate'],
    );
    final explicitUntil = _parseDate(
      m[AtgConfig.fDateTo] ??
          m['validTill'] ??
          m['to'] ??
          m['until'] ??
          m['endDate'],
    );
    // ATG profiles are frequently open-ended: no validFrom/validTill at all.
    // `rememberTill` is the retention horizon (default ~10 years), not the
    // booking window, so it is only a fallback for sorting.
    final rememberTill = _parseDate(m['rememberTill']);
    final openEnded =
        explicitFrom == null && explicitUntil == null && fallbackDraft == null;
    final from = explicitFrom ?? fallbackDraft?.from ?? createdAt;
    final until = explicitUntil ?? fallbackDraft?.until ?? rememberTill ?? from;
    final fromText = _firstString(m, const ['validFromDateText']);
    final tillText = _firstString(m, const ['validTillDateText']);
    // ATG's own text has no time component, so it is only a fallback for
    // responses that lack the raw timestamps.
    final windowText =
        (explicitFrom == null || explicitUntil == null) &&
            fromText != null &&
            tillText != null
        ? '$fromText – $tillText'
        : null;
    // ATG stores the parts separately (`name` + `surname`); joining them keeps
    // "Quick Invite Probe" from collapsing to "Quick".
    final explicitName = _firstString(m, const ['visitorName', 'fullName']);
    final composed = [
      _firstString(m, const ['name', 'visitor']),
      _firstString(m, const ['surname', 'lastName']),
    ].whereType<String>().where((part) => part.trim().isNotEmpty).join(' ');
    final name =
        explicitName ??
        (composed.isNotEmpty
            ? composed
            : fallbackDraft?.visitorName ?? 'Visitor');
    return Invite(
      // `uid` is the estate host uid shared by every visitor record, so it is
      // the last resort. `id` is the per-invite record id.
      id:
          _firstString(m, const ['id', 'profileId', 'uid']) ??
          fallbackId ??
          'atg-${from.millisecondsSinceEpoch}',
      siteId: siteId,
      visitorName: name,
      serviceId: fallbackDraft?.serviceId ?? serviceIdForName(name),
      phone:
          _firstString(m, const ['mobile', 'phoneNumber', 'phone']) ??
          fallbackDraft?.phone,
      vehicleReg:
          _firstString(m, const [
            AtgConfig.fLicence,
            'licence',
            'license',
            'vehicle',
            'registration',
          ]) ??
          fallbackDraft?.vehicleReg,
      from: from,
      until: until,
      status: _mapStatus(
        _firstString(m, const ['status', 'state']),
        deleted: _asBool(m['deleted']),
        until: until,
      ),
      code: _firstString(m, const ['code', 'pin', 'accessCode']) ?? '',
      link:
          _firstString(m, const [
            AtgConfig.fShareLink,
            'link',
            'linkInvitation',
            'url',
          ]) ??
          '',
      createdAt: createdAt,
      openEnded: openEnded,
      windowText: windowText,
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

  InviteStatus _mapStatus(
    String? raw, {
    bool? deleted,
    required DateTime until,
  }) {
    if (deleted == true) return InviteStatus.revoked;
    final s = (raw ?? '').toLowerCase();
    if (s.contains('revok') || s.contains('delet') || s.contains('cancel')) {
      return InviteStatus.revoked;
    }
    if (s.contains('expire') || until.isBefore(DateTime.now())) {
      return InviteStatus.expired;
    }
    return InviteStatus.active;
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
