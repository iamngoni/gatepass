//
//  Gatepass
//  invites_state.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

part of 'invites_bloc.dart';

@freezed
abstract class InvitesState with _$InvitesState {
  const factory InvitesState({
    /// The estate account the invites belong to; null when signed out.
    String? accountId,
    String? siteId,
    @Default([]) List<Invite> invites,

    /// The archive has been read.
    @Default(false) bool loaded,

    /// The latest fetch from ATG.
    RequestStatus<Unit>? refresh,

    /// Creates, by the request id their event carried.
    @Default({}) Map<String, RequestStatus<Invite>> requests,

    /// Revokes, by the request id their event carried.
    @Default({}) Map<String, RequestStatus<Unit>> revokes,

    /// Changes with each local change worth backing up.
    @Default(0) int changeRevision,
  }) = _InvitesState;

  const InvitesState._();

  /// Every invite whose code still works, ordered by start.
  List<Invite> get upcoming =>
      invites.where((i) => i.status == InviteStatus.active).toList()
        ..sort((a, b) => a.from.compareTo(b.from));

  List<Invite> get live => upcoming;

  List<Invite> get past =>
      invites.where((i) => i.status.isPast).toList()
        ..sort((a, b) => b.from.compareTo(a.from));

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
  Invite? liveInviteFor(String visitorName) => invites.firstWhereOrNull(
    (i) => !i.isService && i.visitorName == visitorName && i.status.isLive,
  );

  Invite? inviteById(String id) => invites.firstWhereOrNull((i) => i.id == id);
}
