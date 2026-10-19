// Gatepass — sign_in_test.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/auth/models/data/otp_channel.dart';
import 'package:gatepass/home/views/pages/home_shell_page.dart';

import '../helpers/app_harness.dart';

void main() {
  late FakeGate gate;

  Future<void> enterNumber(WidgetTester tester) async {
    gate = FakeGate();
    gate.restore.complete(null);
    await pumpGatepass(tester, gate);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText), '82 555 0199');
    await tester.pump();
  }

  testWidgets('WhatsApp asks ATG for the code on WhatsApp', (tester) async {
    await enterNumber(tester);
    await tester.tap(find.text('WhatsApp'));
    await tester.pumpAndSettle();
    expect(gate.codeRequests.single.$2, OtpChannel.whatsapp);
    expect(find.text('Check WhatsApp'), findsOneWidget);

    await tester.tap(find.text('Resend code'));
    await tester.pumpAndSettle();
    expect(gate.codeRequests.last.$2, OtpChannel.whatsapp);
  });

  testWidgets('SMS still works, and the code can switch to WhatsApp', (
    tester,
  ) async {
    await enterNumber(tester);
    await tester.tap(find.text('SMS'));
    await tester.pumpAndSettle();
    expect(gate.codeRequests.single, ('+27 82 555 0199', OtpChannel.sms));
    expect(find.text('Check your messages'), findsOneWidget);

    await tester.tap(find.text('Send by WhatsApp instead'));
    await tester.pumpAndSettle();
    expect(gate.codeRequests.last.$2, OtpChannel.whatsapp);
    expect(find.text('Send by SMS instead'), findsOneWidget);
  });

  testWidgets('six digits sign in and enter the app', (tester) async {
    await enterNumber(tester);
    await tester.tap(find.text('SMS'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText), '123456');
    await tester.pumpAndSettle();
    expect(find.byType(HomeShellPage), findsOneWidget);
  });
}
