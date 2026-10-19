// Gatepass — invite_form_bar.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../core/utils/date_helpers.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/invite_form_data.dart';

/// The form's footer: when the invite is valid, and Create.
class InviteFormBar extends StatelessWidget {
  const InviteFormBar({
    required this.data,
    required this.valid,
    required this.onSubmit,
    super.key,
  });

  final InviteFormData data;
  final bool valid;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final now = DateTime.now();
    final startsInPast = data.startsInPast(now);
    final tone = startsInPast ? colors.warning : colors.accent;
    return GpBottomBar(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                startsInPast ? GpIcons.alert : GpIcons.calendarCheck,
                size: 16,
                color: tone,
              ),
              const SizedBox(width: GpSpace.sm),
              Flexible(
                child: Text(
                  startsInPast
                      ? l10n.inviteFormStartPassed
                      : validity(context, now),
                  style: context.type.small
                      .weighted(FontWeight.w600)
                      .copyWith(color: tone),
                ),
              ),
            ],
          ),
          const SizedBox(height: GpSpace.md),
          GpButton(
            label: l10n.inviteFormCreate,
            size: GpButtonSize.large,
            loading: data.saving,
            onPressed: valid && !startsInPast ? onSubmit : null,
          ),
        ],
      ),
    );
  }

  String validity(BuildContext context, DateTime now) {
    final l10n = context.l10n;
    final format = context.format;
    final from = data.from(now);
    final until = data.until(now);
    if (data.stay.duration == null && isSameDay(until, data.date)) {
      final today = dateOnly(now);
      if (isSameDay(data.date, today)) {
        return l10n.inviteFormValidAllDayToday(format.time(until));
      }
      if (isSameDay(data.date, addDays(today, 1))) {
        return l10n.inviteFormValidAllDayTomorrow;
      }
      return l10n.inviteFormValidAllDayOn(format.day(data.date));
    }
    return l10n.inviteFormValid(format.window(from, until));
  }
}
