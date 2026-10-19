import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/app.dart';
import 'package:gatepass/data/gate_repository.dart';
import 'package:gatepass/data/models.dart';
import 'package:gatepass/state/app_state.dart';

class _Repo implements GateRepository {
  final session = Completer<Resident?>();

  @override
  Future<Resident?> restoreSession() => session.future;

  @override
  Future<List<Site>> fetchSites() async => const [
    Site(id: 's', name: 'Estate', unit: '', area: ''),
  ];

  @override
  Future<List<Invite>> fetchInvites(String siteId) async => [];

  @override
  Future<List<AppNotification>> fetchNotifications(String siteId) async => [];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (_) async => null);
  });

  testWidgets('a saved session shows a loader, then Home, never sign-in', (
    tester,
  ) async {
    final repo = _Repo();
    final state = AppState(repo);
    await tester.pumpWidget(GatepassApp(state: state));
    unawaited(state.restoreSession());
    await tester.pump();
    expect(find.text('Get through the gate faster'), findsNothing);
    expect(find.bySemanticsLabel('Gatepass'), findsOneWidget);

    repo.session.complete(
      const Resident(id: 'r', name: 'Resident', phone: '', email: ''),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HomeShell), findsOneWidget);
  });

  testWidgets('no saved session goes to sign-in', (tester) async {
    final repo = _Repo();
    final state = AppState(repo);
    await tester.pumpWidget(GatepassApp(state: state));
    unawaited(state.restoreSession());
    repo.session.complete(null);
    await tester.pumpAndSettle();
    expect(find.text('Get through the gate faster'), findsOneWidget);
  });
}
