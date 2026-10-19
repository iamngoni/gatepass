import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/app.dart';
import 'package:gatepass/data/gate_repository.dart';
import 'package:gatepass/state/app_state.dart';

class _Repo implements GateRepository {
  final requests = <(String, OtpChannel)>[];

  @override
  Future<void> requestCode(
    String phone, {
    OtpChannel channel = OtpChannel.sms,
  }) async => requests.add((phone, channel));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _Repo repo;

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (_) async => null);
  });

  Future<void> enterNumber(WidgetTester tester) async {
    tester.view.physicalSize = const Size(402 * 3, 874 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    repo = _Repo();
    await tester.pumpWidget(GatepassApp(state: AppState(repo)));
    await tester.pump();
    await tester.enterText(find.byType(EditableText), '82 555 0199');
    await tester.pump();
  }

  testWidgets('WhatsApp asks ATG for the code on WhatsApp', (tester) async {
    await enterNumber(tester);
    await tester.tap(find.text('WhatsApp'));
    await tester.pumpAndSettle();
    expect(repo.requests.single.$2, OtpChannel.whatsapp);
    expect(find.text('Check WhatsApp'), findsOneWidget);

    await tester.tap(find.text('Resend code'));
    await tester.pumpAndSettle();
    expect(repo.requests.last.$2, OtpChannel.whatsapp);
  });

  testWidgets('SMS still works, and the code can switch to WhatsApp', (
    tester,
  ) async {
    await enterNumber(tester);
    await tester.tap(find.text('SMS'));
    await tester.pumpAndSettle();
    expect(repo.requests.single.$2, OtpChannel.sms);
    expect(find.text('Check your messages'), findsOneWidget);

    await tester.tap(find.text('Send by WhatsApp instead'));
    await tester.pumpAndSettle();
    expect(repo.requests.last.$2, OtpChannel.whatsapp);
    expect(find.text('Send by SMS instead'), findsOneWidget);
  });
}
