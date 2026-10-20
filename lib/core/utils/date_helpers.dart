//
//  Gatepass
//  date_helpers.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

/// Midnight at the start of [t]'s day.
DateTime dateOnly(DateTime t) => DateTime(t.year, t.month, t.day);

/// Calendar arithmetic, so a DST change never lands on the wrong day.
DateTime addDays(DateTime t, int days) =>
    DateTime(t.year, t.month, t.day + days);

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

int daysInMonth(DateTime month) => DateTime(month.year, month.month + 1, 0).day;

/// Whole calendar days from today to [t]'s day: 0 today, 1 tomorrow.
int calendarDayOffset(DateTime t) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(t.year, t.month, t.day);
  return (day.difference(today).inHours / 24).round();
}

bool isToday(DateTime t) => calendarDayOffset(t) == 0;
