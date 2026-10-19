// Gatepass — gate_code_test.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/core/utils/text_helpers.dart';
import 'package:gatepass/core/views/widgets/gp_qr_code.dart';
import 'package:gatepass/invites/models/data/invite.dart';
import 'package:gatepass/invites/models/data/invite_status.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../helpers/localized.dart';

Invite _invite({
  bool openEnded = false,
  String? windowText,
  String visitorName = 'Visitor',
  String? serviceId,
}) {
  final start = DateTime(2026, 10, 20, 9);
  return Invite(
    id: '1',
    siteId: 'site',
    visitorName: visitorName,
    serviceId: serviceId,
    from: start,
    until: start.add(const Duration(hours: 8)),
    status: InviteStatus.active,
    code: '1234',
    link: 'https://example.test/invite',
    createdAt: start,
    openEnded: openEnded,
    windowText: windowText,
  );
}

void main() {
  setUpAll(() => initializeDateFormatting('en'));

  group('formatCode', () {
    test('a six-digit keypad code splits in half', () {
      expect(formatCode('418207'), '418 207');
    });

    test('an ATG access code splits into groups of four', () {
      expect(formatCode('ATGM2UAZALP0'), 'ATGM 2UAZ ALP0');
    });

    test('grouping is display only: removing spaces gives the code back', () {
      for (final code in ['ATGM2UAZALP0', 'ATG12345', 'ATGX9', '418207']) {
        expect(formatCode(code).replaceAll(' ', ''), code);
      }
    });

    test('short codes are left alone', () {
      expect(formatCode('1234'), '1234');
      expect(formatCode(''), '');
    });
  });

  test('service invites use the service’s own spelling', () {
    final invite = _invite(visitorName: 'Uber eats', serviceId: 'uber-eats');
    expect(invite.displayName, 'Uber Eats');
    expect(invite.firstName, 'Uber Eats');
  });

  group('validity', () {
    test('open-ended ATG profiles do not invent a time window', () {
      expect(englishFormat.validity(_invite(openEnded: true)), 'Always valid');
    });

    test('server-rendered window text wins over local formatting', () {
      const text = '20 Oct 2026 09:00 – 20 Oct 2026 17:00';
      expect(englishFormat.validity(_invite(windowText: text)), text);
    });

    test('an explicit window falls back to the local label', () {
      final label = englishFormat.validity(_invite());
      expect(label, contains('09:00'));
      expect(label, contains('17:00'));
    });

    test('durations and stays read naturally', () {
      expect(englishFormat.duration(const Duration(minutes: 45)), '45 min');
      expect(englishFormat.duration(const Duration(hours: 2)), '2 h');
      expect(
        englishFormat.duration(const Duration(hours: 1, minutes: 30)),
        '1 h 30 min',
      );
      expect(englishL10n.stayHours(1), '1 hour');
      expect(englishL10n.stayHours(4), '4 hours');
    });
  });

  testWidgets('the QR code paints at the size it is given', (tester) async {
    await tester.pumpWidget(
      localized(
        const Center(child: GpQrCode(data: 'ATGM2UAZALP0', size: 180)),
      ),
    );
    expect(tester.getSize(find.byType(GpQrCode)), const Size(180, 180));
    expect(tester.takeException(), isNull);
  });
}
