import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/data/gate_repository.dart';
import 'package:gatepass/data/models.dart';
import 'package:gatepass/state/app_state.dart';
import 'package:gatepass/ui/ui.dart';

class _FailingRepo implements GateRepository {
  @override
  Future<List<Site>> fetchSites() async => const [
    Site(id: 's', name: 'Estate', unit: '', area: ''),
  ];

  @override
  Future<Resident> signIn({
    required String phone,
    required String code,
  }) async => const Resident(id: 'r', name: 'Resident', phone: '', email: '');

  @override
  Future<List<Invite>> fetchInvites(String siteId) async =>
      throw const FormatException('No connection to ATG');

  @override
  Future<List<AppNotification>> fetchNotifications(String siteId) async => [];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUp(() {
    // Haptics go to a platform channel that a test has no host for.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (_) async => null);
  });

  Future<int Function()> pumpList(WidgetTester tester) async {
    var calls = 0;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: GpRefresh(
          onRefresh: () async {
            calls++;
            await Future<void>.delayed(const Duration(milliseconds: 100));
          },
          child: ListView(
            physics: GpRefresh.physics,
            children: [
              for (var i = 0; i < 40; i++)
                SizedBox(height: 50, child: Text('row $i')),
            ],
          ),
        ),
      ),
    );
    return () => calls;
  }

  Future<TestGesture> pullDown(WidgetTester tester) async {
    final gesture = await tester.startGesture(const Offset(200, 100));
    for (var i = 0; i < 30; i++) {
      await gesture.moveBy(const Offset(0, 15));
      await tester.pump(const Duration(milliseconds: 16));
    }
    return gesture;
  }

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 40; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('letting go past the trigger refreshes once', (tester) async {
    final calls = await pumpList(tester);
    final gesture = await pullDown(tester);
    expect(calls(), 0, reason: 'nothing happens while the finger is down');
    await gesture.up();
    await settle(tester);
    expect(calls(), 1);
  });

  testWidgets('easing back mid-pull does not refresh before letting go', (
    tester,
  ) async {
    final calls = await pumpList(tester);
    final gesture = await pullDown(tester);
    await gesture.moveBy(const Offset(0, -4));
    await tester.pump(const Duration(milliseconds: 16));
    expect(calls(), 0);
  });

  testWidgets('pulling back above the trigger cancels the refresh', (
    tester,
  ) async {
    final calls = await pumpList(tester);
    final gesture = await pullDown(tester);
    for (var i = 0; i < 40; i++) {
      await gesture.moveBy(const Offset(0, -15));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await settle(tester);
    expect(calls(), 0);
  });

  test(
    'a failed refresh surfaces the real error, not ParallelWaitError',
    () async {
      final state = AppState(_FailingRepo());
      // Signing in swallows the first refresh's failure by design.
      await state.signIn('+27 82 000 0000', '123456');
      await expectLater(
        state.refresh(),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            'No connection to ATG',
          ),
        ),
      );
    },
  );
}
