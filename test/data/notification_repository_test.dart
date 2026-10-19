// Gatepass — notification_repository_test.dart. Created 2026-10-19.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/core/configs/atg_config.dart';
import 'package:gatepass/core/services/seen_notifications_service.dart';
import 'package:gatepass/notifications/models/data/notification_kind.dart';
import 'package:gatepass/notifications/models/repos/impl/dio_notification_repository.dart';

import '../helpers/atg_harness.dart';

void main() {
  late Directory dir;
  late List<Map<String, Object?>> list;
  late AtgHarness h;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('seen');
    list = [
      {
        'id': 'n1',
        'title': 'Mr D has entered',
        'customFields': ['Main gate', '', 'HN 42'],
        'dataAdded': 1760860800,
      },
      {'id': 'n2', 'title': 'Visitor left', 'message': 'Bye'},
    ];
    h = AtgHarness({
      'GET ${AtgConfig.notificationsListPath}': (_) =>
          (status: 200, body: {'data': list}),
    })..signIn();
  });

  tearDown(() => dir.deleteSync(recursive: true));

  DioNotificationRepository repo() => DioNotificationRepository(
    h.atg,
    SeenNotificationsService.at(File('${dir.path}/seen.json')),
  );

  test('the first fetch is history, later ones are new', () async {
    final first = (await repo().fetchNotifications('s')).getOrElse(
      () => throw StateError('left'),
    );
    expect(first.every((n) => n.read), isTrue);
    expect(first[0].kind, NotificationKind.arrival);
    expect(first[0].body, 'Main gate · HN 42');
    expect(
      first[0].time,
      DateTime.fromMillisecondsSinceEpoch(1760860800000),
    );
    expect(first[1].kind, NotificationKind.departure);
    expect(first[1].title, 'Visitor left');
    expect(first[1].body, 'Bye');

    list.add({'id': 'n3', 'title': 'Notice'});
    // A fresh service, as after a relaunch, reads the saved baseline.
    final second = (await repo().fetchNotifications('s')).getOrElse(
      () => throw StateError('left'),
    );
    expect(second.where((n) => !n.read).map((n) => n.id), ['n3']);
    expect(second.last.kind, NotificationKind.notice);
  });

  test('markRead persists', () async {
    final r = repo();
    await r.fetchNotifications('s');
    list.add({'id': 'n3', 'title': 'Notice'});
    await r.markRead(['n3']);
    final again = (await repo().fetchNotifications('s')).getOrElse(
      () => throw StateError('left'),
    );
    expect(again.every((n) => n.read), isTrue);
  });
}
