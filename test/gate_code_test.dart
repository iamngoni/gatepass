import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/data/models.dart';
import 'package:gatepass/ui/qr.dart';
import 'package:gatepass/util/format.dart';

void main() {
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
    final invite = Invite(
      id: '1',
      siteId: 's',
      visitorName: 'Uber eats',
      serviceId: 'uber-eats',
      from: DateTime(2026, 10, 19),
      until: DateTime(2026, 10, 19, 1),
      status: InviteStatus.active,
      code: 'ATGM2UAZALP0',
      link: 'https://new.atthegate.biz/visitor/shared?code=ATGM2UAZALP0',
      createdAt: DateTime(2026, 10, 19),
    );
    expect(invite.displayName, 'Uber Eats');
    expect(invite.firstName, 'Uber Eats');
  });

  testWidgets('the QR code paints at the size it is given', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(child: GpQrCode(data: 'ATGM2UAZALP0', size: 180)),
      ),
    );
    expect(tester.getSize(find.byType(GpQrCode)), const Size(180, 180));
    expect(tester.takeException(), isNull);
  });
}
