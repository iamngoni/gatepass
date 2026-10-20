//
//  Gatepass
//  launch_test.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/home/views/pages/home_shell_page.dart';

import '../helpers/app_harness.dart';

void main() {
  testWidgets('a saved session shows a loader, then Home, never sign-in', (
    tester,
  ) async {
    final gate = FakeGate();
    await pumpGatepass(tester, gate);
    expect(find.text('Get through the gate faster'), findsNothing);
    expect(find.bySemanticsLabel('Gatepass'), findsOneWidget);

    gate.restore.complete(testAccount);
    await tester.pumpAndSettle();
    expect(find.byType(HomeShellPage), findsOneWidget);
  });

  testWidgets('no saved session goes to sign-in', (tester) async {
    final gate = FakeGate();
    await pumpGatepass(tester, gate);
    gate.restore.complete(null);
    await tester.pumpAndSettle();
    expect(find.text('Get through the gate faster'), findsOneWidget);
  });
}
