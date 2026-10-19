// Gatepass — auth_repository_test.dart. Created 2026-10-19.
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/auth/models/data/otp_channel.dart';
import 'package:gatepass/auth/models/repos/impl/dio_auth_repository.dart';
import 'package:gatepass/core/configs/atg_config.dart';
import 'package:gatepass/core/models/data/application_error.dart';
import 'package:gatepass/core/services/atg_session_service.dart';
import 'package:gatepass/core/services/device_id_service.dart';

import '../helpers/atg_harness.dart';
import '../helpers/route_adapter.dart';

void main() {
  late AtgHarness h;
  late DioAuthRepository repo;

  Map<String, FakeReply Function(SeenRequest)> routes({
    Object? shared,
    FakeReply? settings,
  }) => {
    'POST ${AtgConfig.loginStartPath}': (_) => (status: 200, body: ''),
    'POST ${AtgConfig.loginCheckPath}': (r) {
      final body = jsonDecode(r.body) as Map;
      return body['code'] == '123456'
          ? (status: 200, body: {'token': 'custom.token.jwt'})
          : (status: 200, body: {'error': 'Invalid verification code'});
    },
    'POST /v1/accounts:signInWithCustomToken': (_) => (
      status: 200,
      body: {
        'idToken': fakeJwt('jwt-sub'),
        'refreshToken': 'refresh-1',
        'expiresIn': '3600',
      },
    ),
    'POST /v1/token': (_) => (
      status: 200,
      body: {
        'id_token': 'renewed',
        'refresh_token': 'refresh-2',
        'expires_in': '3600',
        'user_id': 'firebase-uid',
      },
    ),
    'POST ${AtgConfig.sharedAccessPath}': (_) => (
      status: 200,
      body:
          shared ??
          {
            'sharedAccess': [
              {
                'hostUid': 'host-1',
                'accountName': 'Waterfall Crest',
                'invitationsUserUnit': 'Unit 14',
                'invitationsUserName': ' Tariro ',
                'email': 'row@example.com',
              },
            ],
          },
    ),
    'GET ${AtgConfig.userSettingsPath}': (_) =>
        settings ??
        (
          status: 200,
          body: {
            'appSettings': {'brandName': 'Waterfall Estate'},
            'accessPermissions': {
              'invitationsUserName': 'Tariro',
              'invitationsUserSurname': 'Mapfumo',
              'email': 'tariro@example.com',
            },
            'userSettings': {'invitationMaxDaysFromToday': 900},
          },
        ),
  };

  void build([Map<String, FakeReply Function(SeenRequest)>? table]) {
    h = AtgHarness(table ?? routes());
    repo = DioAuthRepository(h.atg, h.sessions, h.accounts, DeviceIdService());
  }

  test('requestCode sends ATG web-client body', () async {
    build();
    final result = await repo.requestCode(
      '082 123 4567',
      channel: OtpChannel.whatsapp,
    );
    expect(result.isRight(), isTrue);
    final body =
        jsonDecode(h.adapter.to(AtgConfig.loginStartPath).single.body) as Map;
    expect(body['loginString'], '+27821234567');
    expect(body['channel'], 'whatsapp');
    expect(body['appVersion'], AtgConfig.appVersion);
    expect(body['appBuildNumber'], AtgConfig.appBuildNumber);
    expect(body['platform'], 'android');
    expect(body['deviceId'], isNotEmpty);
  });

  test('signIn exchanges the token and resolves the estate account', () async {
    build();
    final result = await repo.signIn(phone: '0821234567', code: '123456');
    final account = result.getOrElse(() => throw StateError('left'));
    expect(account.resident.id, 'host-1');
    expect(account.resident.name, 'Tariro Mapfumo');
    expect(account.resident.email, 'tariro@example.com');
    expect(account.resident.phone, '+27821234567');
    expect(account.site.name, 'Waterfall Estate');
    expect(account.site.unit, 'Unit 14');
    expect(account.site.inviteHorizonDays, 365);
    // No localId: the uid comes from the ID token's subject.
    expect(h.sessions.session?.uid, 'jwt-sub');
    final settings = h.adapter.to(AtgConfig.userSettingsPath).single;
    expect(settings.uri.queryParameters['uid'], 'host-1');
    expect(settings.headers[AtgConfig.authHeader], fakeJwt('jwt-sub'));
    final stored =
        jsonDecode(
              h.storage.values[AtgSessionService.sessionKey]!,
            )
            as Map;
    expect(stored['refreshToken'], 'refresh-1');
    expect(stored['phone'], '+27821234567');
    expect(stored['expiresAt'], isA<int>());
  });

  test('signIn surfaces ATG error text', () async {
    build();
    final result = await repo.signIn(phone: '0821234567', code: '000000');
    expect(
      result.fold((l) => l, (_) => null),
      const ApplicationError(
        code: ApplicationErrorCode.atg,
        message: 'Invalid verification code',
      ),
    );
  });

  test('signIn still enters when settings fail', () async {
    build(routes(settings: (status: 500, body: 'boom')));
    final result = await repo.signIn(phone: '0821234567', code: '123456');
    final account = result.getOrElse(() => throw StateError('left'));
    expect(account.resident.id, 'host-1');
    expect(account.resident.name, 'Tariro');
    expect(account.site.name, 'Waterfall Crest');
    expect(account.site.inviteHorizonDays, 30);
  });

  test('signIn falls back to the login when there is no estate', () async {
    build(routes(shared: {'sharedAccess': <Object>[]}));
    final result = await repo.signIn(phone: '0821234567', code: '123456');
    final account = result.getOrElse(() => throw StateError('left'));
    expect(account.resident.id, 'jwt-sub');
    expect(account.resident.name, 'Resident');
    expect(account.site.name, 'My estate');
  });

  test('restoreSession refreshes a stored session first', () async {
    build();
    h.storage.values[AtgSessionService.sessionKey] = jsonEncode({
      'idToken': 'stale',
      'refreshToken': 'refresh-1',
      'expiresAt': 0,
      'uid': 'old-uid',
      'phone': '+27821234567',
    });
    final result = await repo.restoreSession();
    final account = result.getOrElse(() => throw StateError('left'));
    expect(account?.resident.id, 'host-1');
    expect(h.adapter.to('/v1/token'), hasLength(1));
    expect(h.sessions.session?.idToken, 'renewed');
    expect(h.sessions.session?.uid, 'firebase-uid');
  });

  test('restoreSession is null without a stored session', () async {
    build();
    final result = await repo.restoreSession();
    expect(result.getOrElse(() => throw StateError('left')), isNull);
  });

  test('restoreSession is null when the refresh is refused', () async {
    build({
      ...routes(),
      'POST /v1/token': (_) => (
        status: 400,
        body: {
          'error': {'message': 'TOKEN_EXPIRED'},
        },
      ),
    });
    h.storage.values[AtgSessionService.sessionKey] = jsonEncode({
      'idToken': 'stale',
      'refreshToken': 'refresh-1',
      'expiresAt': 0,
    });
    final result = await repo.restoreSession();
    expect(result.getOrElse(() => throw StateError('left')), isNull);
  });

  test('concurrent requests share one refresh', () async {
    build();
    h.storage.values[AtgSessionService.sessionKey] = jsonEncode({
      'idToken': 'stale',
      'refreshToken': 'refresh-1',
      'expiresAt': 0,
      'uid': 'firebase-uid',
    });
    final tokens = await Future.wait([
      h.sessions.freshIdToken(),
      h.sessions.freshIdToken(),
      h.sessions.freshIdToken(),
    ]);
    expect(tokens, ['renewed', 'renewed', 'renewed']);
    expect(h.adapter.to('/v1/token'), hasLength(1));
  });

  test('signOut forgets the stored session', () async {
    build();
    await repo.signIn(phone: '0821234567', code: '123456');
    await repo.signOut();
    expect(h.storage.values, isEmpty);
    expect(h.sessions.isSignedIn, isFalse);
    expect(h.accounts.account, isNull);
    final identity = await repo.cloudIdentity();
    expect(
      identity.fold((l) => l.code, (_) => null),
      ApplicationErrorCode.notSignedIn,
    );
  });
}
