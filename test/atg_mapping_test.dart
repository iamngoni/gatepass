import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/data/atg/atg_client.dart';
import 'package:gatepass/data/atg/atg_gate_repository.dart';
import 'package:gatepass/data/models.dart';
import 'package:gatepass/util/format.dart';

/// Serves the exact JSON shapes captured from the live API, so the mapping is
/// tested without touching the network.
class _FakeHttp extends AtgHttp {
  _FakeHttp(this.routes);

  final Map<String, dynamic Function()> routes;

  @override
  Future<dynamic> send(
    String method,
    Uri url, {
    Map<String, String> headers = const {},
    Object? jsonBody,
    Map<String, String>? formBody,
    String context = '',
  }) async {
    if (url.host == 'securetoken.googleapis.com') {
      return {
        'id_token': 'fake.id.token',
        'refresh_token': 'refresh',
        'expires_in': '3600',
        'user_id': 'firebase-uid',
      };
    }
    final handler = routes[url.path];
    if (handler == null) {
      fail('unexpected request: $method ${url.path}');
    }
    return handler();
  }
}

const _liveInvite = {
  'id': 5489823974817792,
  'uid': 'NpLFMcSEWSZO2Yyd8yrndww0ael1',
  'name': 'Uber eats',
  'generateCode': true,
  'code': 'ATGM2UAZALP0',
  'categoryId': 5219924235255808,
  'visitsAllowed': 1,
  'changeOrVisitDate': 1792339708895,
  'type': 'profile',
  'dateCreated': 1792339708895,
  'dateChanged': 1792339708895,
  'deleted': false,
  'rememberTill': 2107699708895,
  'statuses': <String>[],
  'link': 'https://new.atthegate.biz/visitor/shared?code=ATGM2UAZALP0',
  'linkInvitation':
      'https://new.atthegate.biz/visitor/shared?code=ATGM2UAZALP0',
  'notifyOn': 'both',
};

Map<String, dynamic> _notification(String id, String title) => {
  'id': id,
  'title': title,
  'uid': 'NpLFMcSEWSZO2Yyd8yrndww0ael1',
  'notificationType': 'CUSTOM_NOTIFICATION',
  'dataAdded': 1792342835288,
  'entryId': 'NpLFMcSEWSZO2Yyd8yrndww0ael1-bebd1478add3407e9a9',
  'profileName': 'Pedestrian',
  'customFields': ['Name and Surname: Uber'],
};

void main() {
  final sessionFile = File(
    '${Directory.systemTemp.path}/gatepass_session.json',
  );
  final seenFile = File(
    '${Directory.systemTemp.path}/gatepass_notifications_seen.json',
  );

  setUp(() {
    sessionFile.writeAsStringSync(
      jsonEncode({
        'idToken': 'fake.id.token',
        'refreshToken': 'refresh',
        'expiresAt': 0,
        'uid': 'firebase-uid',
        'phone': null,
      }),
    );
    if (seenFile.existsSync()) seenFile.deleteSync();
  });

  tearDown(() {
    if (sessionFile.existsSync()) sessionFile.deleteSync();
    if (seenFile.existsSync()) seenFile.deleteSync();
  });

  test(
    'a live visitor row maps the record id, not the shared host uid',
    () async {
      final repo = AtgGateRepository(
        http: _FakeHttp({
          '/api/visitor/v3/profiles': () => {
            'visitors': [_liveInvite],
            'totalNumberFound': 1,
            'loadMore': false,
          },
        }),
      );

      final invite = (await repo.fetchInvites('site')).single;
      expect(invite.id, '5489823974817792');
      expect(invite.id, isNot('NpLFMcSEWSZO2Yyd8yrndww0ael1'));
      expect(invite.visitorName, 'Uber eats');
      expect(invite.code, 'ATGM2UAZALP0');
      expect(invite.link, contains('new.atthegate.biz'));
      expect(invite.multiEntry, isFalse);
      expect(invite.status, InviteStatus.ready);
    },
  );

  test(
    'a profile without validFrom/validTill is open-ended, not 4 hours',
    () async {
      final repo = AtgGateRepository(
        http: _FakeHttp({
          '/api/visitor/v3/profiles': () => {
            'visitors': [_liveInvite],
          },
        }),
      );

      final invite = (await repo.fetchInvites('site')).single;
      expect(invite.openEnded, isTrue);
      expect(inviteValidityLabel(invite), 'Always valid');
    },
  );

  test('name and surname from ATG are joined for display', () async {
    final repo = AtgGateRepository(
      http: _FakeHttp({
        '/api/visitor/v3/profiles': () => {
          'visitors': [
            {..._liveInvite, 'name': 'Quick', 'surname': 'Invite Probe'},
          ],
        },
      }),
    );

    expect(
      (await repo.fetchInvites('site')).single.visitorName,
      'Quick Invite Probe',
    );
  });

  test('deleted visitor rows map to revoked', () async {
    final repo = AtgGateRepository(
      http: _FakeHttp({
        '/api/visitor/v3/profiles': () => {
          'visitors': [
            {..._liveInvite, 'deleted': true},
          ],
        },
      }),
    );

    expect(
      (await repo.fetchInvites('site')).single.status,
      InviteStatus.revoked,
    );
  });

  test('notifications map and only new ones start unread', () async {
    var items = <Map<String, dynamic>>[
      _notification('1', 'Uber has just Exited Waterfall Crest'),
    ];
    final repo = AtgGateRepository(
      http: _FakeHttp({'/api/notifications/getList': () => items}),
    );

    final baseline = await repo.fetchNotifications('site');
    expect(baseline.single.kind, NotificationKind.departure);
    expect(baseline.single.read, isTrue, reason: 'first run seeds history');

    items = [
      _notification('2', 'Uber Eats has just Entered Waterfall Crest'),
      _notification('1', 'Uber has just Exited Waterfall Crest'),
    ];
    final next = await repo.fetchNotifications('site');
    expect(next.first.kind, NotificationKind.arrival);
    expect(next.first.read, isFalse, reason: 'new since the baseline');
    expect(next.last.read, isTrue, reason: 'already seen');

    await repo.markNotificationsRead(['2']);
    final after = await repo.fetchNotifications('site');
    expect(after.first.read, isTrue);
  });
}
