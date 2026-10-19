// Gatepass — day_picker_sheet.dart. Created 2026-10-18.
// Day and time pickers in the app's own sheet, in place of Material's
// date and time dialogs.
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../configs/gp_icons.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/date_helpers.dart';
import '../../utils/extensions/build_context_extensions.dart';
import '../../utils/extensions/localization_extensions.dart';
import 'day_picker_cell.dart';
import 'gp_icon_button.dart';
import 'gp_sheet_route.dart';

/// A month grid; days outside [first]–[last] can't be picked.
Future<DateTime?> pickDay(
  BuildContext context, {
  required DateTime initial,
  required DateTime first,
  required DateTime last,
}) => showGpSheet<DateTime>(
  context,
  builder: (_) => DayPickerSheet(initial: initial, first: first, last: last),
);

/// The sheet behind [pickDay]: one month at a time, Monday first.
class DayPickerSheet extends StatefulWidget {
  const DayPickerSheet({
    required this.initial,
    required this.first,
    required this.last,
    super.key,
  });

  final DateTime initial;
  final DateTime first;
  final DateTime last;

  @override
  State<DayPickerSheet> createState() => _DayPickerSheetState();
}

class _DayPickerSheetState extends State<DayPickerSheet> {
  static final monthFormat = DateFormat('MMMM y');

  late final month = ValueNotifier(
    DateTime(widget.initial.year, widget.initial.month),
  );

  bool get canGoBack =>
      month.value.isAfter(DateTime(widget.first.year, widget.first.month));
  bool get canGoForward =>
      month.value.isBefore(DateTime(widget.last.year, widget.last.month));

  void showPreviousMonth() =>
      month.value = DateTime(month.value.year, month.value.month - 1);

  void showNextMonth() =>
      month.value = DateTime(month.value.year, month.value.month + 1);

  @override
  void dispose() {
    month.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<DateTime>(
    valueListenable: month,
    builder: (context, month, _) {
      final colors = context.colors;
      final type = context.type;
      final days = daysInMonth(month);
      // Monday-first grid.
      final lead = (DateTime(month.year, month.month).weekday + 6) % 7;
      final first = dateOnly(widget.first);
      final last = dateOnly(widget.last);

      return Padding(
        padding: const EdgeInsets.fromLTRB(
          GpSpace.gutter,
          0,
          GpSpace.gutter,
          GpSpace.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(monthFormat.format(month), style: type.title),
                ),
                GpIconButton(
                  icon: GpIcons.chevronLeft,
                  label: context.l10n.commonPreviousMonth,
                  color: canGoBack ? colors.ink : colors.disabledInk,
                  onPressed: canGoBack ? showPreviousMonth : null,
                ),
                GpIconButton(
                  icon: GpIcons.chevronRight,
                  label: context.l10n.commonNextMonth,
                  color: canGoForward ? colors.ink : colors.disabledInk,
                  onPressed: canGoForward ? showNextMonth : null,
                ),
              ],
            ),
            const SizedBox(height: GpSpace.md),
            Row(
              children: [
                for (final d in const ['M', 'T', 'W', 'T', 'F', 'S', 'S'])
                  Expanded(
                    child: Center(child: Text(d, style: type.overline)),
                  ),
              ],
            ),
            const SizedBox(height: GpSpace.sm),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var i = 0; i < lead; i++) const SizedBox.shrink(),
                for (var d = 1; d <= days; d++)
                  DayPickerCell(
                    day: DateTime(month.year, month.month, d),
                    first: first,
                    last: last,
                    selected: widget.initial,
                  ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
