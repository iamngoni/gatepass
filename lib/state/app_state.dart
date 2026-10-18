import 'package:flutter/widgets.dart';

import '../data/gate_repository.dart';
import '../data/models.dart';
import '../data/services.dart';
import '../ui/theme.dart';

enum NotifyPref {
  arrivals('Visitors arrive'),
  departures('Visitors leave'),
  prescreen('Pre-screening is done'),
  notices('Estate notices');

  const NotifyPref(this.label);
  final String label;
}

class AppState extends ChangeNotifier {
  AppState(this._repo);

  final GateRepository _repo;

  Resident? resident;
  List<Site> sites = const [];
  Site? _site;
  List<Invite> invites = const [];
  List<EntryEvent> entries = const [];
  List<AppNotification> notifications = const [];
  Appearance appearance = Appearance.system;
  final prefs = {for (final p in NotifyPref.values) p: true};

  bool get signedIn => resident != null && _site != null;
  Site get site => _site!;
  int get unreadCount => notifications.where((n) => !n.read).length;

  List<Invite> get upcoming =>
      invites.where((i) => i.status.isUpcoming).toList()
        ..sort((a, b) => a.from.compareTo(b.from));

  List<Invite> get onSite =>
      invites.where((i) => i.status == InviteStatus.onSite).toList()
        ..sort((a, b) => a.from.compareTo(b.from));

  List<Invite> get past =>
      invites.where((i) => i.status.isPast).toList()
        ..sort((a, b) => b.from.compareTo(a.from));

  /// Every invite whose code still works: on site first, then by start.
  List<Invite> get live => [...onSite, ...upcoming];

  /// The latest invite for each person (not services), newest first.
  List<Invite> get recentPeople {
    final newestFirst = [...invites]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final latest = <String, Invite>{};
    for (final i in newestFirst.where((i) => !i.isService)) {
      latest.putIfAbsent(i.visitorName.toLowerCase(), () => i);
    }
    return latest.values.take(12).toList();
  }

  /// Services used most recently first, then the rest in catalogue order.
  List<DeliveryService> get servicesByUse {
    final lastUsed = <String, DateTime>{};
    for (final i in invites) {
      final id = i.serviceId;
      if (id == null) continue;
      final seen = lastUsed[id];
      if (seen == null || i.createdAt.isAfter(seen)) lastUsed[id] = i.createdAt;
    }
    final order = {
      for (var i = 0; i < deliveryServices.length; i++) deliveryServices[i]: i,
    };
    return [...deliveryServices]..sort((a, b) {
      final ta = lastUsed[a.id];
      final tb = lastUsed[b.id];
      if (ta != null && tb != null) return tb.compareTo(ta);
      if (ta != null) return -1;
      if (tb != null) return 1;
      return order[a]!.compareTo(order[b]!);
    });
  }

  /// A person's invite that still works, if they have one.
  Invite? liveInviteFor(String visitorName) => invites
      .where(
        (i) => !i.isService && i.visitorName == visitorName && i.status.isLive,
      )
      .firstOrNull;

  /// Same person, same settings as last time, starting now. Anyone who was
  /// pre-screened before skips it.
  InviteDraft reinviteDraft(Invite last) {
    final now = DateTime.now();
    final length = last.until.difference(last.from);
    final stay =
        length < const Duration(hours: 1) || length > const Duration(hours: 12)
        ? const Duration(hours: 4)
        : length;
    // An evening re-invite shouldn't run into tomorrow just because last
    // time was a full working day.
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59);
    var until = now.add(stay);
    if (until.isAfter(endOfDay) &&
        endOfDay.difference(now) >= const Duration(hours: 1)) {
      until = endOfDay;
    }
    return InviteDraft(
      visitorName: last.visitorName,
      phone: last.phone,
      vehicleReg: last.vehicleReg,
      from: now,
      until: until,
      multiEntry: last.multiEntry,
      prescreenRequired: last.prescreenRequired && last.prescreenedAt == null,
    );
  }

  InviteDraft serviceDraft(DeliveryService service) {
    final now = DateTime.now();
    return InviteDraft(
      visitorName: service.name,
      serviceId: service.id,
      from: now,
      until: now.add(service.window),
      prescreenRequired: false,
    );
  }

  Invite? inviteById(String id) => invites.where((i) => i.id == id).firstOrNull;

  EntryEvent? entryById(String id) =>
      entries.where((e) => e.id == id).firstOrNull;

  List<EntryEvent> entriesForInvite(String inviteId) =>
      entries.where((e) => e.inviteId == inviteId).toList();

  Future<void> requestCode(String phone) => _repo.requestCode(phone);

  Future<void> signIn(String phone, String code) async {
    final who = await _repo.signIn(phone: phone, code: code);
    sites = await _repo.fetchSites();
    _site = sites.first;
    await refresh();
    resident = who;
    notifyListeners();
  }

  void signOut() {
    resident = null;
    _site = null;
    invites = const [];
    entries = const [];
    notifications = const [];
    notifyListeners();
  }

  Future<void> selectSite(Site site) async {
    if (site.id == _site?.id) return;
    _site = site;
    invites = const [];
    entries = const [];
    notifications = const [];
    notifyListeners();
    await refresh();
  }

  Future<void> refresh() async {
    final id = site.id;
    final (i, e, n) = await (
      _repo.fetchInvites(id),
      _repo.fetchEntries(id),
      _repo.fetchNotifications(id),
    ).wait;
    if (id != _site?.id) return;
    invites = i;
    entries = e;
    notifications = n;
    notifyListeners();
  }

  Future<AccessPass> fetchPass() => _repo.fetchPass(site.id);

  Future<Invite> createInvite(InviteDraft draft) async {
    final siteId = site.id;
    final invite = await _repo.createInvite(siteId, draft);
    if (siteId == _site?.id) {
      invites = [...invites, invite];
      notifyListeners();
    }
    return invite;
  }

  Future<void> revokeInvite(String id) async {
    final updated = await _repo.revokeInvite(id);
    invites = [for (final i in invites) i.id == id ? updated : i];
    notifyListeners();
  }

  Future<void> markRead(String id) => _markRead([id]);

  Future<void> markAllRead() =>
      _markRead(notifications.where((n) => !n.read).map((n) => n.id));

  Future<void> _markRead(Iterable<String> ids) async {
    final wanted = ids.toSet();
    if (wanted.isEmpty) return;
    notifications = [
      for (final n in notifications)
        wanted.contains(n.id) ? n.copyWith(read: true) : n,
    ];
    notifyListeners();
    await _repo.markNotificationsRead(wanted);
  }

  void setAppearance(Appearance value) {
    appearance = value;
    notifyListeners();
  }

  void setPref(NotifyPref pref, bool on) {
    prefs[pref] = on;
    notifyListeners();
  }
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
    : super(notifier: state);

  /// Rebuilds the caller whenever [AppState] changes.
  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;

  /// For callbacks: reads without subscribing.
  static AppState read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<AppScope>()!.notifier!;
}
