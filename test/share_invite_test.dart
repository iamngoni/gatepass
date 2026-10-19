import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/app.dart';
import 'package:gatepass/data/gate_repository.dart';
import 'package:gatepass/data/models.dart';
import 'package:gatepass/features/visitors/share_invite.dart';
import 'package:gatepass/state/app_state.dart';

class _Repo implements GateRepository {
  @override
  Future<List<Site>> fetchSites() async => const [
    Site(id: 's', name: 'Waterfall Crest', unit: '', area: ''),
  ];

  @override
  Future<Resident> signIn({
    required String phone,
    required String code,
  }) async => const Resident(id: 'r', name: 'Resident', phone: '', email: '');

  @override
  Future<List<Invite>> fetchInvites(String siteId) async => [];

  @override
  Future<List<AppNotification>> fetchNotifications(String siteId) async => [];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

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
  final shared = <Map<Object?, Object?>>[];

  setUp(() {
    shared.clear();
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (_) async => null,
    );
    messenger.setMockMethodCallHandler(
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
      _invite(name: 'Chipo Ndlovu', service: null),
      'Waterfall Crest',
    );
    expect(
      message,
      contains('https://new.atthegate.biz/visitor/shared?code=ATGM2UAZALP9'),
    );
    expect(message, contains('access code ATGM2UAZALP9'));
  });

  Future<BuildContext> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(402 * 3, 874 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final state = AppState(_Repo());
    await state.signIn('+27 82 000 0000', '123456');
    await tester.pumpWidget(GatepassApp(state: state));
    await tester.pump();
    return tester.element(find.byType(HomeShell));
  }

  testWidgets('a service shares code, link or image; a person also gets the '
      'message', (tester) async {
    final ctx = await pumpApp(tester);
    showShareOptions(ctx, _invite());
    await tester.pumpAndSettle();
    expect(find.text('Code'), findsOneWidget);
    expect(find.text('Link'), findsOneWidget);
    expect(find.text('Image'), findsOneWidget);
    expect(find.text('Invite message'), findsNothing);
    Navigator.of(ctx).pop();
    await tester.pumpAndSettle();

    showShareOptions(ctx, _invite(name: 'Chipo Ndlovu', service: null));
    await tester.pumpAndSettle();
    expect(find.text('Invite message'), findsOneWidget);
  });

  testWidgets('Link hands the visitor page to the share sheet and closes', (
    tester,
  ) async {
    final ctx = await pumpApp(tester);
    showShareOptions(ctx, _invite());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Link'));
    await tester.pumpAndSettle();
    expect(shared.single['uri'], visitorLink('ATGM2UAZALP9').toString());
    expect(find.text('Link'), findsNothing);
  });

  testWidgets('Code shares the raw code with the estate name', (tester) async {
    final ctx = await pumpApp(tester);
    showShareOptions(ctx, _invite());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Code'));
    await tester.pumpAndSettle();
    expect(
      shared.single['text'],
      startsWith('Gate code for Waterfall Crest: '),
    );
    expect(shared.single['text'], contains('ATGM2UAZALP9'));
  });

  testWidgets('the gate pass card lays out without overflow', (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        // As in the app: an unbounded slot in the overlay.
        child: Stack(
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
