// Gatepass — invite_merge_test.dart. Created 2026-10-19.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/core/services/secure_storage_service.dart';
import 'package:gatepass/core/utils/invite_merge.dart';
import 'package:gatepass/invites/models/data/invite.dart';
import 'package:gatepass/invites/models/data/invite_status.dart';
import 'package:gatepass/invites/models/repos/impl/secure_invite_archive_repository.dart';
import 'package:gatepass/invites/state/invites/invites_bloc.dart';

import '../helpers/app_harness.dart';

Invite _invite(
  String id, {
  String name = 'Chipo Ndlovu',
  String? phone,
  Duration endsIn = const Duration(hours: 4),
}) {
  final now = DateTime.now();
  return Invite(
    id: id,
    siteId: 's',
    visitorName: name,
    phone: phone,
    from: now.subtract(const Duration(hours: 1)),
    until: now.add(endsIn),
    status: InviteStatus.active,
    code: 'ATG$id',
    link: '',
    createdAt: now.subtract(const Duration(hours: 2)),
  );
}

void main() {
  final now = DateTime.now();

  test('an invite survives the JSON round trip', () {
    final original = _invite('1', phone: '+27825550199');
    final copy = Invite.fromJson(original.toJson());
    expect(copy.toJson(), original.toJson());
  });

  test('ATG wins for what it lists, and keeps what only the app knew', () {
    final merged = mergeInvites(
      [_invite('1', phone: '+27825550199')],
      [_invite('1', name: 'Chipo N')],
      fetchedIsComplete: true,
      now: now,
    );
    expect(merged.single.visitorName, 'Chipo N');
    expect(merged.single.phone, '+27825550199');
  });

  test('a live invite ATG dropped from a full list shows as revoked', () {
    final merged = mergeInvites(
      [_invite('1'), _invite('2')],
      [_invite('2')],
      fetchedIsComplete: true,
      now: now,
    );
    final gone = merged.firstWhere((i) => i.id == '1');
    expect(gone.status, InviteStatus.revoked);
    expect(gone.visitorName, 'Chipo Ndlovu');
  });

  test('past a full page, a missing invite is only aged, not revoked', () {
    final merged = mergeInvites(
      [_invite('old', endsIn: const Duration(hours: -1)), _invite('live')],
      [],
      fetchedIsComplete: false,
      now: now,
    );
    expect(
      merged.firstWhere((i) => i.id == 'old').status,
      InviteStatus.expired,
    );
    expect(
      merged.firstWhere((i) => i.id == 'live').status,
      InviteStatus.active,
    );
  });

  test('a revoke on one phone wins when two archives meet', () {
    final merged = unionInvites(
      [_invite('1', phone: '+27825550199')],
      [_invite('1').copyWith(status: InviteStatus.revoked, code: '')],
    );
    expect(merged.single.status, InviteStatus.revoked);
    expect(merged.single.phone, '+27825550199');
    expect(merged.single.code, 'ATG1');
  });

  test(
    'revoking keeps the person and their details, across sign-ins',
    () async {
      final archive = MemoryArchive();
      final gate = FakeGate(invites: [_invite('1', phone: '+27825550199')]);
      final bloc = InvitesBloc(gate, archive)
        ..add(const InvitesEvent.started(account: testAccount));
      await bloc.stream.firstWhere((s) => s.changeRevision == 1);
      gate.invites.clear(); // ATG deletes the profile on revoke.
      bloc.add(
        const InvitesEvent.revokeRequested(requestId: 'r', inviteId: '1'),
      );
      await bloc.stream.firstWhere((s) => s.changeRevision == 2);
      bloc.add(const InvitesEvent.refreshRequested());
      await bloc.stream.firstWhere((s) => s.changeRevision == 3);

      final revoked = bloc.state.invites.single;
      expect(revoked.status, InviteStatus.revoked);
      expect(revoked.visitorName, 'Chipo Ndlovu');
      expect(revoked.phone, '+27825550199');
      expect(bloc.state.recentPeople.single.visitorName, 'Chipo Ndlovu');

      bloc.add(const InvitesEvent.cleared());
      final again = InvitesBloc(gate, archive)
        ..add(const InvitesEvent.started(account: testAccount));
      await again.stream.firstWhere((s) => s.loaded);
      expect(again.state.invites.single.visitorName, 'Chipo Ndlovu');
      await bloc.close();
      await again.close();
    },
  );

  test('the secure archive reads back what it wrote, per account', () async {
    FlutterSecureStorage.setMockInitialValues({});
    final archive = SecureInviteArchiveRepository(
      SecureStorageService(const FlutterSecureStorage()),
    );
    await archive.save('a', [_invite('1')]);
    expect((await archive.load('a')).getOrElse(() => []).single.id, '1');
    expect((await archive.load('b')).getOrElse(() => [_invite('x')]), isEmpty);
  });
}
