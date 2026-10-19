import 'dart:async';

import 'package:flutter/widgets.dart';

import '../data/gate_repository.dart';
import '../data/models.dart';
import '../data/services.dart';
import '../ui/theme.dart';

class AppState extends ChangeNotifier {
  AppState(this._repo);

  final GateRepository _repo;

  Resident? resident;
  Site? _site;
  List<Invite> invites = const [];
  List<AppNotification> notifications = const [];
  Appearance appearance = Appearance.system;

  bool get signedIn => resident != null && _site != null;
  Site get site => _site!;
  int get unreadCount => notifications.where((n) => !n.read).length;

  List<Invite> get upcoming =>
      invites.where((i) => i.status == InviteStatus.active).toList()
        ..sort((a, b) => a.from.compareTo(b.from));

  List<Invite> get past =>
      invites.where((i) => i.status.isPast).toList()
        ..sort((a, b) => b.from.compareTo(a.from));

  /// Every invite whose code still works, ordered by start.
  List<Invite> get live => upcoming;

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

  /// Same person and settings as last time, starting now.
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
    );
  }

  InviteDraft serviceDraft(DeliveryService service) {
    final now = DateTime.now();
    return InviteDraft(
      visitorName: service.name,
      serviceId: service.id,
      from: now,
      until: now.add(service.window),
    );
  }

  Invite? inviteById(String id) => invites.where((i) => i.id == id).firstOrNull;

  Future<void> requestCode(String phone) => _repo.requestCode(phone);

  Future<void> signIn(String phone, String code) async {
    await _enter(await _repo.signIn(phone: phone, code: code));
  }

  /// Uses the stored Firebase refresh token on launch. A network failure keeps
  /// the token for the next attempt and leaves the sign-in screen available.
  Future<void> restoreSession() async {
    try {
      final who = await _repo.restoreSession();
      if (who != null) await _enter(who);
    } on Object catch (e) {
      debugPrint('[Gatepass] session restore failed: $e');
    }
  }

  Future<void> _enter(Resident who) async {
    final sites = await _repo.fetchSites();
    _site = sites.first;
    resident = who;
    notifyListeners();
    // Entering the app must not depend on the first data load: authenticated
    // endpoints may still be settling, and the tabs can retry on pull.
    try {
      await refresh();
    } on Object catch (e) {
      debugPrint('[Gatepass] initial refresh failed: $e');
    }
  }

  void signOut() {
    resident = null;
    _site = null;
    invites = const [];
    notifications = const [];
    notifyListeners();
  }

  Future<void> refresh() async {
    final id = site.id;
    final List<Invite> i;
    final List<AppNotification> n;
    try {
      (i, n) = await (
        _repo.fetchInvites(id),
        _repo.fetchNotifications(id),
      ).wait;
    } on ParallelWaitError<
      (List<Invite>?, List<AppNotification>?),
      (AsyncError?, AsyncError?)
    > catch (e) {
      // Rethrow the underlying failure, so callers can show its message.
      final first = (e.errors.$1 ?? e.errors.$2)!;
      Error.throwWithStackTrace(first.error, first.stackTrace);
    }
    if (id != _site?.id) return;
    invites = i;
    notifications = n;
    notifyListeners();
  }

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
