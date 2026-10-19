import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/app.dart';
import 'package:gatepass/data/gate_repository.dart';
import 'package:gatepass/data/models.dart';
import 'package:gatepass/data/services.dart';
import 'package:gatepass/features/visitors/invite_form_screen.dart';
import 'package:gatepass/state/app_state.dart';

class _Repo implements GateRepository {
  final drafts = <InviteDraft>[];

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
  Future<List<Invite>> fetchInvites(String siteId) async => [];

  @override
  Future<List<AppNotification>> fetchNotifications(String siteId) async => [];

  @override
  Future<Invite> createInvite(String siteId, InviteDraft draft) async {
    drafts.add(draft);
    return Invite(
      id: '1',
      siteId: siteId,
      visitorName: draft.visitorName,
      from: draft.from,
      until: draft.until,
      status: InviteStatus.active,
      code: 'ATGM2UAZALP0',
      link: 'https://new.atthegate.biz/visitor/shared?code=ATGM2UAZALP0',
      createdAt: DateTime.now(),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _Repo repo;

  setUp(() {
    // Haptics go to a platform channel that a test has no host for.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (_) async => null);
  });

  Future<void> openForm(WidgetTester tester, {InviteDraft? initial}) async {
    tester.view.physicalSize = const Size(402 * 3, 874 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    repo = _Repo();
    final state = AppState(repo);
    await state.signIn('+27 82 000 0000', '123456');
    await tester.pumpWidget(GatepassApp(state: state));
    await tester.pump();
    openInviteForm(tester.element(find.byType(HomeShell)), initial: initial);
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

    final draft = repo.drafts.single;
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
    expect(repo.drafts.single.vehicleReg, isNull);
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
