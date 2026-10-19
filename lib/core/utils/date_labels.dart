// Gatepass — date_labels.dart. Created 2026-10-18.
import 'package:intl/intl.dart';

import 'date_helpers.dart';

final _hm = DateFormat.Hm();
final _weekday = DateFormat.EEEE();
final _short = DateFormat('EEE d MMM');
final _full = DateFormat('EEEE d MMMM, HH:mm');

String formatTime(DateTime t) => _hm.format(t);

/// "17:05" from minutes since midnight.
String formatMinutes(int minutes) =>
    '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
    '${(minutes % 60).toString().padLeft(2, '0')}';

String formatFull(DateTime t) => _full.format(t);

/// "Today", "Tomorrow", "Yesterday", a weekday within the week, else a date.
String dayLabel(DateTime t) {
  final offset = calendarDayOffset(t);
  return switch (offset) {
    0 => 'Today',
    1 => 'Tomorrow',
    -1 => 'Yesterday',
    >= -6 && <= 6 => _weekday.format(t),
    _ => _short.format(t),
  };
}

String windowLabel(DateTime from, DateTime until) {
  if (calendarDayOffset(from) == calendarDayOffset(until)) {
    return '${dayLabel(from)}, ${formatTime(from)} – ${formatTime(until)}';
  }
  return '${dayLabel(from)} ${formatTime(from)} – '
      '${dayLabel(until)} ${formatTime(until)}';
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
