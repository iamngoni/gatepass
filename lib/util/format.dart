import '../data/models.dart';
import 'package:intl/intl.dart';

final _hm = DateFormat.Hm();
final _weekday = DateFormat.EEEE();
final _short = DateFormat('EEE d MMM');
final _full = DateFormat('EEEE d MMMM, HH:mm');

String formatTime(DateTime t) => _hm.format(t);

/// Midnight at the start of [t]'s day.
DateTime dateOnly(DateTime t) => DateTime(t.year, t.month, t.day);

/// Calendar arithmetic, so a DST change never lands on the wrong day.
DateTime addDays(DateTime t, int days) =>
    DateTime(t.year, t.month, t.day + days);

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

int daysInMonth(DateTime month) => DateTime(month.year, month.month + 1, 0).day;

/// "17:05" from minutes since midnight.
String formatMinutes(int minutes) =>
    '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
    '${(minutes % 60).toString().padLeft(2, '0')}';

String formatFull(DateTime t) => _full.format(t);

int _dayOffset(DateTime t) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(t.year, t.month, t.day);
  return (day.difference(today).inHours / 24).round();
}

bool isToday(DateTime t) => _dayOffset(t) == 0;

/// "Today", "Tomorrow", "Yesterday", a weekday within the week, else a date.
String dayLabel(DateTime t) {
  final offset = _dayOffset(t);
  return switch (offset) {
    0 => 'Today',
    1 => 'Tomorrow',
    -1 => 'Yesterday',
    >= -6 && <= 6 => _weekday.format(t),
    _ => _short.format(t),
  };
}

String windowLabel(DateTime from, DateTime until) {
  if (_dayOffset(from) == _dayOffset(until)) {
    return '${dayLabel(from)}, ${formatTime(from)} – ${formatTime(until)}';
  }
  return '${dayLabel(from)} ${formatTime(from)} – '
      '${dayLabel(until)} ${formatTime(until)}';
}

/// The validity line for an invite. ATG profiles often have no explicit
/// window at all, in which case the invite stays valid until it is used up or
/// revoked — printing a made-up time range would be wrong.
String inviteValidityLabel(Invite invite) {
  if (invite.openEnded) return 'Always valid';
  final text = invite.windowText?.trim();
  if (text != null && text.isNotEmpty) return text;
  return windowLabel(invite.from, invite.until);
}

String durationLabel(Duration d) {
  if (d.inMinutes < 60) return '${d.inMinutes} min';
  final minutes = d.inMinutes % 60;
  return minutes == 0 ? '${d.inHours} h' : '${d.inHours} h $minutes min';
}

String greeting(DateTime now) => switch (now.hour) {
  < 12 => 'Good morning',
  < 18 => 'Good afternoon',
  _ => 'Good evening',
};

String initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
  return parts.take(2).map((p) => p[0].toUpperCase()).join();
}

/// Splits a code into groups that are easy to read out: "418207" → "418 207",
/// ATG's "ATGM2UAZALP0" → "ATGM 2UAZ ALP0". Display only: copy and share the
/// raw code.
String formatCode(String code) {
  if (code.length == 6) return '${code.substring(0, 3)} ${code.substring(3)}';
  if (code.length <= 6) return code;
  return [
    for (var i = 0; i < code.length; i += 4)
      code.substring(i, i + 4 > code.length ? code.length : i + 4),
  ].join(' ');
}
