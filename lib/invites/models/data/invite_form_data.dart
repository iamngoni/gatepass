// Gatepass — invite_form_data.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/date_helpers.dart';
import 'invite_day.dart';
import 'invite_draft.dart';
import 'invite_stay.dart';

part 'invite_form_data.freezed.dart';

/// The new-invite form's choices besides the text fields: the day, the
/// hours and whether they come by car.
@freezed
abstract class InviteFormData with _$InviteFormData {
  const factory InviteFormData({
    /// Midnight of the chosen day.
    required DateTime date,

    /// Arrival time for a set number of hours, in minutes since midnight.
    required int start,
    @Default(InviteDay.today) InviteDay day,
    @Default(InviteStay.allDay) InviteStay stay,
    @Default(false) bool byCar,

    /// The day, hours, mobile number and car. Closed by default, so the
    /// usual invite is a name and nothing else.
    @Default(false) bool advanced,
    @Default(false) bool saving,
  }) = _InviteFormData;

  const InviteFormData._();

  /// A fresh form, or one prefilled from [initial] (a held quick tile or a
  /// re-invite), which opens the options to adjust.
  factory InviteFormData.initial(InviteDraft? initial, DateTime now) {
    final today = dateOnly(now);
    if (initial == null) {
      return InviteFormData(date: today, start: nextQuarter(now));
    }
    final draftDay = dateOnly(initial.from);
    final date = draftDay.isBefore(today) ? today : draftDay;
    final length = initial.until.difference(initial.from);
    return InviteFormData(
      date: date,
      day: dayFor(date, today),
      // Quick drafts start now (the driver may already be on the way), so
      // keep their start instead of rounding up to the next quarter hour.
      start: isSameDay(initial.from, date)
          ? initial.from.hour * 60 + initial.from.minute
          : nextQuarter(now),
      stay: InviteStay.values.firstWhere(
        (s) => s.duration != null && length <= s.duration!,
        orElse: () => InviteStay.allDay,
      ),
      byCar: initial.vehicleReg != null,
      advanced: true,
    );
  }

  static int nextQuarter(DateTime now) {
    final minutes = ((now.hour * 60 + now.minute) ~/ 15 + 1) * 15;
    return minutes >= 24 * 60 ? 23 * 60 + 45 : minutes;
  }

  static InviteDay dayFor(DateTime date, DateTime today) =>
      isSameDay(date, today)
      ? InviteDay.today
      : isSameDay(date, addDays(today, 1))
      ? InviteDay.tomorrow
      : InviteDay.other;

  DateTime from(DateTime now) {
    if (stay.duration == null) {
      // All day runs from midnight, except today's, which starts now.
      return isSameDay(date, now) ? now : date;
    }
    return DateTime(date.year, date.month, date.day, start ~/ 60, start % 60);
  }

  DateTime until(DateTime now) {
    final start = from(now);
    final duration = stay.duration;
    if (duration != null) return start.add(duration);
    final end = DateTime(date.year, date.month, date.day, 23, 59);
    // Late at night, the rest of today is minutes; give them at least an
    // hour.
    final soonest = start.add(const Duration(hours: 1));
    return end.isBefore(soonest) ? soonest : end;
  }

  bool startsInPast(DateTime now) =>
      from(now).isBefore(now.subtract(const Duration(minutes: 15)));

  /// Today again: a start that has already passed moves to the next
  /// quarter hour.
  InviteFormData pickToday(DateTime now) {
    final soonest = nextQuarter(now);
    return copyWith(
      day: InviteDay.today,
      date: dateOnly(now),
      start: start < soonest ? soonest : start,
    );
  }

  InviteFormData pickDate(DateTime picked, DateTime now) =>
      copyWith(date: picked, day: dayFor(picked, dateOnly(now)));
}
