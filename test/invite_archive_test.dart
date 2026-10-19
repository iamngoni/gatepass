import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/data/gate_repository.dart';
import 'package:gatepass/data/invite_archive.dart';
import 'package:gatepass/data/models.dart';
import 'package:gatepass/state/app_state.dart';

Invite _invite(
  String id, {
  String name = 'Chipo Ndlovu',
  InviteStatus status = InviteStatus.active,
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
    status: status,
    code: 'CODE$id',
    link: '',
    createdAt: now.subtract(const Duration(hours: 1)),
  );
}

class _Repo implements GateRepository {
  _Repo(this.listed);

  List<Invite> listed;

  @override
  Future<Resident> signIn({
    required String phone,
    required String code,
  }) async => const Resident(id: 'acct', name: 'R', phone: '', email: '');

  @override
  Future<List<Site>> fetchSites() async => const [
    Site(id: 's', name: 'Estate', unit: '', area: ''),
  ];

  @override
  Future<List<Invite>> fetchInvites(String siteId) async => listed;

  @override
  Future<List<AppNotification>> fetchNotifications(String siteId) async => [];

  @override
  Future<Invite> revokeInvite(String inviteId) async {
    // As ATG does: the profile is deleted.
    listed = [...listed.where((i) => i.id != inviteId)];
    return _invite(inviteId, name: '', status: InviteStatus.revoked);
  }

  @override
  Future<void> signOut() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
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
    );
    expect(merged.single.visitorName, 'Chipo N');
    expect(merged.single.phone, '+27825550199');
  });

  test('a live invite ATG dropped from a full list shows as revoked', () {
    final merged = mergeInvites(
      [_invite('1'), _invite('2')],
      [_invite('2')],
      fetchedIsComplete: true,
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

  test(
    'revoking keeps the person and their details, across sign-ins',
    () async {
      final archive = MemoryInviteArchive();
      final repo = _Repo([_invite('1', phone: '+27825550199')]);
      final state = AppState(repo, archive: archive);
      await state.signIn('+27 82 000 0000', '123456');
      await state.revokeInvite('1');
      await state.refresh();

      final revoked = state.invites.single;
      expect(revoked.status, InviteStatus.revoked);
      expect(revoked.visitorName, 'Chipo Ndlovu');
      expect(revoked.phone, '+27825550199');
      expect(state.recentPeople.single.visitorName, 'Chipo Ndlovu');

      state.signOut();
      final again = AppState(repo, archive: archive);
      await again.signIn('+27 82 000 0000', '123456');
      expect(again.invites.single.visitorName, 'Chipo Ndlovu');
    },
  );

  test('the secure archive reads back what it wrote, per account', () async {
    FlutterSecureStorage.setMockInitialValues({});
    final archive = SecureInviteArchive();
    await archive.save('a', [_invite('1')]);
    expect((await archive.load('a')).single.id, '1');
    expect(await archive.load('b'), isEmpty);
  });
}
