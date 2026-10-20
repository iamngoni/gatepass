//
//  Gatepass
//  gp_format.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:intl/intl.dart';

import '../../invites/models/data/invite.dart';
import '../../l10n/generated/app_localizations.dart';
import 'date_helpers.dart';

/// Dates, times and durations in the resident's language. Get one from
/// `context.format`.
class GpFormat {
  GpFormat(this.l10n)
    : _hm = DateFormat.Hm(l10n.localeName),
      _weekday = DateFormat.EEEE(l10n.localeName),
      _short = DateFormat('EEE d MMM', l10n.localeName),
      _full = DateFormat('EEEE d MMMM, HH:mm', l10n.localeName);

  final AppLocalizations l10n;
  final DateFormat _hm;
  final DateFormat _weekday;
  final DateFormat _short;
  final DateFormat _full;

  String time(DateTime t) => _hm.format(t);

  /// "17:05" from minutes since midnight.
  String minutes(int minutes) =>
      '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
      '${(minutes % 60).toString().padLeft(2, '0')}';

  String full(DateTime t) => _full.format(t);

  /// "Today", "Tomorrow", "Yesterday", a weekday within the week, else a
  /// date.
  String day(DateTime t) => switch (calendarDayOffset(t)) {
    0 => l10n.dayToday,
    1 => l10n.dayTomorrow,
    -1 => l10n.dayYesterday,
    >= -6 && <= 6 => _weekday.format(t),
    _ => _short.format(t),
  };

  String window(DateTime from, DateTime until) {
    if (calendarDayOffset(from) == calendarDayOffset(until)) {
      return l10n.windowSameDay(day(from), time(from), time(until));
    }
    return l10n.windowAcrossDays(
      day(from),
      time(from),
      day(until),
      time(until),
    );
  }

  String duration(Duration d) {
    if (d.inMinutes < 60) return l10n.durationMinutes(d.inMinutes);
    final minutes = d.inMinutes % 60;
    return minutes == 0
        ? l10n.durationHours(d.inHours)
        : l10n.durationHoursMinutes(d.inHours, minutes);
  }

  String greeting(DateTime now) => switch (now.hour) {
    < 12 => l10n.greetingMorning,
    < 18 => l10n.greetingAfternoon,
    _ => l10n.greetingEvening,
  };

  /// The validity line for an invite. ATG profiles often have no explicit
  /// window at all, in which case the invite stays valid until it is used
  /// up or revoked: printing a made-up time range would be wrong.
  String validity(Invite invite) {
    if (invite.openEnded) return l10n.inviteAlwaysValid;
    final text = invite.windowText?.trim();
    if (text != null && text.isNotEmpty) return text;
    return window(invite.from, invite.until);
  }
}
