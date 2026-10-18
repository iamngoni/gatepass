import 'package:flutter_test/flutter_test.dart';
import 'package:gatepass/data/models.dart';
import 'package:gatepass/util/format.dart';

Invite _invite({
  bool openEnded = false,
  String? windowText,
  DateTime? from,
  DateTime? until,
}) {
  final start = from ?? DateTime(2026, 10, 20, 9);
  return Invite(
    id: '1',
    siteId: 'site',
    visitorName: 'Visitor',
    from: start,
    until: until ?? start.add(const Duration(hours: 8)),
    status: InviteStatus.ready,
    code: '1234',
    link: 'https://example.test/invite',
    createdAt: start,
    openEnded: openEnded,
    windowText: windowText,
  );
}

void main() {
  test('open-ended ATG profiles do not invent a time window', () {
    expect(inviteValidityLabel(_invite(openEnded: true)), 'Always valid');
  });

  test('server-rendered window text wins over local formatting', () {
    const text = '20 Oct 2026 09:00 – 20 Oct 2026 17:00';
    expect(inviteValidityLabel(_invite(windowText: text)), text);
  });

  test('an explicit window falls back to the local label', () {
    final label = inviteValidityLabel(_invite());
    expect(label, contains('09:00'));
    expect(label, contains('17:00'));
  });
}
