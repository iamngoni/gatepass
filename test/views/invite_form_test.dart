// Gatepass — invite_form_test.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/home/views/pages/home_shell_page.dart';
import 'package:gatepass/invites/models/data/delivery_services.dart';
import 'package:gatepass/invites/models/data/invite_draft.dart';
import 'package:gatepass/invites/views/pages/invite_form_page.dart';

import '../helpers/app_harness.dart';

void main() {
  late FakeGate gate;

  Future<void> openForm(WidgetTester tester, {InviteDraft? initial}) async {
    gate = FakeGate();
    await pumpGatepass(tester, gate, signedIn: true);
    await tester.pumpAndSettle();
    final shell = tester.element(find.byType(HomeShellPage));
    // Not awaited: the form stays open for the test.
    // ignore: unawaited_futures
    openInviteForm(shell, initial: initial);
    await tester.pumpAndSettle();
  }

  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.ensureVisible(find.text(text));
    await tester.pumpAndSettle();
    await tester.tap(find.text(text));
    await tester.pumpAndSettle();
  }

  testWidgets('a name is all a new invite asks for, valid all day today', (
    tester,
  ) async {
    await openForm(tester);
    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('More options'), findsOneWidget);
    expect(find.text('Which day?'), findsNothing);
    expect(find.text('Mobile number (optional)'), findsNothing);
    expect(find.textContaining('Valid all day today'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'Chipo Ndlovu');
    await tester.pump();
    final now = DateTime.now();
    await tester.tap(find.text('Create invite'));
    await tester.pumpAndSettle();

    final draft = gate.drafts.single;
    expect(draft.visitorName, 'Chipo Ndlovu');
    expect(draft.phone, isNull);
    expect(draft.vehicleReg, isNull);
    expect(
      draft.from.difference(now).abs(),
      lessThan(const Duration(minutes: 1)),
    );
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59);
    if (endOfDay.difference(now) > const Duration(hours: 1, minutes: 1)) {
      expect(draft.until, endOfDay);
    }
    expect(
      draft.until.difference(draft.from),
      greaterThanOrEqualTo(const Duration(minutes: 59)),
    );
    expect(find.text('Invite ready'), findsOneWidget);
  });

  testWidgets('More options shows the day, hours, mobile number and car', (
    tester,
  ) async {
    await openForm(tester);
    await tester.tap(find.text('More options'));
    await tester.pumpAndSettle();
    expect(find.text('Which day?'), findsOneWidget);
    expect(find.text('How long can they stay?'), findsOneWidget);
    expect(find.text('Mobile number (optional)'), findsOneWidget);
    expect(find.text('Coming by car'), findsOneWidget);
    expect(find.text('Arriving from'), findsNothing, reason: 'All day');

    await tapText(tester, '2 hours');
    expect(find.text('Arriving from'), findsOneWidget);

    await tapText(tester, 'Fewer options');
    expect(find.text('Which day?'), findsNothing);
  });

  testWidgets('closing options with an empty car registration keeps Create '
      'usable', (tester) async {
    await openForm(tester);
    await tester.enterText(find.byType(EditableText), 'Chipo Ndlovu');
    await tester.tap(find.text('More options'));
    await tester.pumpAndSettle();
    await tapText(tester, 'Coming by car');
    expect(find.text('Registration number'), findsOneWidget);
    await tapText(tester, 'Fewer options');

    await tester.tap(find.text('Create invite'));
    await tester.pumpAndSettle();
    expect(gate.drafts.single.vehicleReg, isNull);
  });

  testWidgets('a held quick tile opens the form with its options showing', (
    tester,
  ) async {
    final now = DateTime.now();
    await openForm(
      tester,
      initial: InviteDraft(
        visitorName: 'Amazon',
        serviceId: 'amazon',
        from: now,
        until: now.add(serviceById('amazon')!.window),
      ),
    );
    expect(find.text('Fewer options'), findsOneWidget);
    expect(find.text('Which day?'), findsOneWidget);
  });
}
