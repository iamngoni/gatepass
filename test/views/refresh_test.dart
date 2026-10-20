//
//  Gatepass
//  refresh_test.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/core/models/data/application_error.dart';
import 'package:gatepass/core/views/widgets/gp_widgets.dart';
import 'package:gatepass/home/views/pages/home_shell_page.dart';
import 'package:gatepass/invites/models/data/invite.dart';

import '../helpers/app_harness.dart';
import '../helpers/localized.dart';

/// ATG fails every invite fetch.
class OfflineGate extends FakeGate {
  @override
  Future<Either<ApplicationError, List<Invite>>> fetchInvites(
    String siteId,
  ) async => const Left(
    ApplicationError(code: ApplicationErrorCode.atg, message: 'ATG is down'),
  );
}

void main() {
  Future<int Function()> pumpList(WidgetTester tester) async {
    var calls = 0;
    await tester.pumpWidget(
      localized(
        GpRefresh(
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

  testWidgets('a failed refresh says why, in ATG’s words', (tester) async {
    await pumpGatepass(tester, OfflineGate(), signedIn: true);
    await tester.pumpAndSettle();
    expect(find.byType(HomeShellPage), findsOneWidget);
    final gesture = await pullDown(tester);
    await gesture.up();
    await settle(tester);
    expect(find.text('ATG is down'), findsOneWidget);
  });
}
