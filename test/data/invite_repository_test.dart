// Gatepass — invite_repository_test.dart. Created 2026-10-19.
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/core/configs/atg_config.dart';
import 'package:gatepass/core/models/data/application_error.dart';
import 'package:gatepass/invites/models/data/invite_draft.dart';
import 'package:gatepass/invites/models/data/invite_status.dart';
import 'package:gatepass/invites/models/repos/impl/dio_invite_repository.dart';

import '../helpers/atg_harness.dart';

void main() {
  late AtgHarness h;
  late DioInviteRepository repo;
  final now = DateTime.now();
  final later = now.add(const Duration(hours: 3));

  setUp(() {
    h = AtgHarness({
      'GET ${AtgConfig.invitesListPath}': (_) => (
        status: 200,
        body: {
          'profiles': [
            {
              'id': 41,
              'uid': 'host-1',
              'name': 'Quick Invite',
              'surname': 'Probe',
              'validFrom': now.millisecondsSinceEpoch ~/ 1000,
              'validTill': later.millisecondsSinceEpoch,
              'carLic': 'HN 42 KP GP',
              'code': 'ATG123',
              'linkInvitation': 'https://example.com/i/41',
            },
            {
              'id': '42',
              'name': 'Uber eats',
              'rememberTill': later.millisecondsSinceEpoch,
              'dateCreated': '2026-10-01T10:00:00Z',
            },
            {
              'id': '43',
              'name': 'Farai',
              'validFrom': 1000,
              'validTill': 2000,
            },
            {'id': '44', 'name': 'Gone', 'deleted': 1},
            'not an object',
          ],
        },
      ),
      'GET ${AtgConfig.categoriesPath}': (_) => (
        status: 200,
        body: [
          {'id': 3, 'name': 'Contractor'},
          {'id': '7', 'categoryName': 'Invitation'},
        ],
      ),
      'POST ${AtgConfig.createVisitorPath}': (_) => (
        status: 200,
        body: {'id': 99, 'code': 'NEW99', 'linkInvitation': 'https://x/99'},
      ),
      'POST ${AtgConfig.deleteVisitorPath}': (_) => (status: 200, body: ''),
    })..signIn();
    h.accounts.fallback();
    repo = DioInviteRepository(h.atg, h.accounts);
  });

  test('fetchInvites maps ATG profiles', () async {
    final invites = (await repo.fetchInvites('site')).getOrElse(
      () => throw StateError('left'),
    );
    expect(invites.map((i) => i.id), ['41', '42', '43', '44']);
    final first = invites[0];
    expect(first.visitorName, 'Quick Invite Probe');
    expect(first.vehicleReg, 'HN 42 KP GP');
    expect(first.status, InviteStatus.active);
    expect(first.openEnded, isFalse);
    expect(first.code, 'ATG123');
    expect(first.siteId, 'site');
    final service = invites[1];
    expect(service.serviceId, 'uber-eats');
    expect(service.openEnded, isTrue);
    expect(service.until, isNot(service.from));
    expect(service.createdAt, DateTime.parse('2026-10-01T10:00:00Z').toLocal());
    expect(invites[2].status, InviteStatus.expired);
    expect(invites[3].status, InviteStatus.revoked);
    final request = h.adapter.to(AtgConfig.invitesListPath).single;
    expect(request.uri.queryParameters, {'uid': 'firebase-uid', 'limit': '50'});
    expect(request.headers[AtgConfig.authHeader], 'id-token');
  });

  test('createInvite sends the single-entry body', () async {
    final draft = InviteDraft(
      visitorName: 'Chipo  Ndlovu Moyo',
      from: now,
      until: later,
      phone: '+27825550199',
    );
    final invite = (await repo.createInvite('site', draft)).getOrElse(
      () => throw StateError('left'),
    );
    expect(invite.id, '99');
    expect(invite.code, 'NEW99');
    expect(invite.visitorName, 'Chipo  Ndlovu Moyo');
    expect(invite.from, now);
    expect(invite.openEnded, isFalse);
    final body =
        jsonDecode(h.adapter.to(AtgConfig.createVisitorPath).single.body)
            as Map;
    expect(body, {
      'uid': 'firebase-uid',
      'name': 'Chipo',
      'surname': 'Ndlovu Moyo',
      'validFrom': now.toUtc().millisecondsSinceEpoch,
      'validTill': later.toUtc().millisecondsSinceEpoch,
      'phoneNumber': '+27825550199',
      'categoryId': 7,
      'visitsAllowed': 1,
      'notifyOn': 'both',
    });

    await repo.createInvite('site', draft);
    expect(h.adapter.to(AtgConfig.categoriesPath), hasLength(1));
  });

  test('revokeInvite posts the id as a form field', () async {
    final result = await repo.revokeInvite('41');
    expect(result.isRight(), isTrue);
    final request = h.adapter.to(AtgConfig.deleteVisitorPath).single;
    expect(request.body, 'id=41');
    expect(
      request.headers['content-type'],
      startsWith('application/x-www-form-urlencoded'),
    );
  });

  test('a signed-out request fails without reaching ATG', () async {
    await h.sessions.clear();
    final result = await repo.fetchInvites('site');
    expect(
      result.fold((l) => l.code, (_) => null),
      ApplicationErrorCode.notSignedIn,
    );
    expect(h.adapter.requests, isEmpty);
  });
}
