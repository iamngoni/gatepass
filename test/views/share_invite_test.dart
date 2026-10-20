//
//  Gatepass
//  share_invite_test.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/auth/models/data/account_session.dart';
import 'package:gatepass/auth/models/data/resident.dart';
import 'package:gatepass/auth/models/data/site.dart';
import 'package:gatepass/home/views/pages/home_shell_page.dart';
import 'package:gatepass/invites/models/data/invite.dart';
import 'package:gatepass/invites/models/data/invite_status.dart';
import 'package:gatepass/invites/views/widgets/gate_pass_card.dart';
import 'package:gatepass/invites/views/widgets/share_sheet.dart';
import 'package:gatepass/invites/views/widgets/share_texts.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../helpers/app_harness.dart';
import '../helpers/localized.dart';

Invite _invite({String name = 'Amazon', String? service = 'amazon'}) => Invite(
  id: '1',
  siteId: 's',
  visitorName: name,
  serviceId: service,
  from: DateTime(2026, 10, 19, 9),
  until: DateTime(2026, 10, 19, 13),
  status: InviteStatus.active,
  code: 'ATGM2UAZALP9',
  link: '',
  createdAt: DateTime(2026, 10, 19, 9),
);

void main() {
  setUpAll(() => initializeDateFormatting('en'));

  final shared = <Map<Object?, Object?>>[];

  setUp(() {
    shared.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('dev.fluttercommunity.plus/share'),
          (call) async {
            shared.add(call.arguments as Map<Object?, Object?>);
            return 'dev.fluttercommunity.plus/share/unavailable';
          },
        );
  });

  test('the link is ATG’s visitor page for the code', () {
    expect(
      visitorLink('ATGM2UAZALP9').toString(),
      'https://new.atthegate.biz/visitor/shared?code=ATGM2UAZALP9',
    );
  });

  test('the invite message carries the visitor link and the raw code', () {
    final message = inviteMessage(
      englishFormat,
      _invite(name: 'Chipo Ndlovu', service: null),
      'Waterfall Crest',
    );
    expect(message, startsWith('Hi Chipo, you’re invited to Waterfall Crest'));
    expect(
      message,
      contains('https://new.atthegate.biz/visitor/shared?code=ATGM2UAZALP9'),
    );
    expect(message, contains('access code ATGM2UAZALP9'));
  });

  Future<BuildContext> pumpApp(WidgetTester tester) async {
    await pumpGatepass(
      tester,
      FakeGate(
        account: const AccountSession(
          resident: Resident(id: 'r', name: 'Resident', phone: '', email: ''),
          site: Site(id: 's', name: 'Waterfall Crest', unit: '', area: ''),
        ),
      ),
      signedIn: true,
    );
    await tester.pumpAndSettle();
    return tester.element(find.byType(HomeShellPage));
  }

  testWidgets('a service shares code, link or image; a person also gets the '
      'message', (tester) async {
    final ctx = await pumpApp(tester);
    // ignore: unawaited_futures
    showShareOptions(ctx, _invite());
    await tester.pumpAndSettle();
    expect(find.text('Code'), findsOneWidget);
    expect(find.text('Link'), findsOneWidget);
    expect(find.text('Image'), findsOneWidget);
    expect(find.text('Invite message'), findsNothing);
    Navigator.of(ctx).pop();
    await tester.pumpAndSettle();

    // ignore: unawaited_futures
    showShareOptions(ctx, _invite(name: 'Chipo Ndlovu', service: null));
    await tester.pumpAndSettle();
    expect(find.text('Invite message'), findsOneWidget);
  });

  testWidgets('Link hands the visitor page to the share sheet and closes', (
    tester,
  ) async {
    final ctx = await pumpApp(tester);
    // ignore: unawaited_futures
    showShareOptions(ctx, _invite());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Link'));
    await tester.pumpAndSettle();
    expect(shared.single['uri'], visitorLink('ATGM2UAZALP9').toString());
    expect(find.text('Link'), findsNothing);
  });

  testWidgets('Code shares the raw code with the estate name', (tester) async {
    final ctx = await pumpApp(tester);
    // ignore: unawaited_futures
    showShareOptions(ctx, _invite());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Code'));
    await tester.pumpAndSettle();
    expect(
      shared.single['text'],
      'Gate code for Waterfall Crest: ATGM2UAZALP9 (valid until 13:00)',
    );
  });

  testWidgets('the gate pass card lays out without overflow', (tester) async {
    await tester.pumpWidget(
      localized(
        // As in the app: an unbounded slot in the overlay.
        Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: GatePassCard(
                invite: _invite(name: 'Chipo Ndlovu', service: null),
                siteName: 'Waterfall Crest',
              ),
            ),
          ],
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(tester.getSize(find.byType(GatePassCard)).width, GatePassCard.width);
    expect(find.text('Chipo is invited'), findsOneWidget);
  });
}
