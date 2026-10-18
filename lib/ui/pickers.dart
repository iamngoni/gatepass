// Day and time pickers in the app's own sheet, in place of Material's
// date and time dialogs.
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../util/format.dart';
import 'button.dart';
import 'icons.dart';
import 'pressable.dart';
import 'sheet.dart';
import 'theme.dart';

/// A month grid; days outside [first]–[last] can't be picked.
Future<DateTime?> pickDay(
  BuildContext context, {
  required DateTime initial,
  required DateTime first,
  required DateTime last,
}) => showGpSheet<DateTime>(
  context,
  builder: (_) => _DaySheet(initial: initial, first: first, last: last),
);

/// Hour and minute wheels. Works in minutes since midnight.
Future<int?> pickTime(
  BuildContext context, {
  required int initialMinutes,
  required String title,
}) => showGpSheet<int>(
  context,
  builder: (_) => _TimeSheet(initial: initialMinutes, title: title),
);

class _DaySheet extends StatefulWidget {
  const _DaySheet({
    required this.initial,
    required this.first,
    required this.last,
  });

  final DateTime initial;
  final DateTime first;
  final DateTime last;

  @override
  State<_DaySheet> createState() => _DaySheetState();
}

class _DaySheetState extends State<_DaySheet> {
  late DateTime _month = DateTime(widget.initial.year, widget.initial.month);
  static final _monthFormat = DateFormat('MMMM y');

  bool get _canGoBack =>
      _month.isAfter(DateTime(widget.first.year, widget.first.month));
  bool get _canGoForward =>
      _month.isBefore(DateTime(widget.last.year, widget.last.month));

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final days = daysInMonth(_month);
    // Monday-first grid.
    final lead = (DateTime(_month.year, _month.month).weekday + 6) % 7;
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
                child: Text(_monthFormat.format(_month), style: type.title),
              ),
              GpIconButton(
                icon: GpIcons.chevronLeft,
                label: 'Previous month',
                color: _canGoBack ? colors.ink : colors.disabledInk,
                onPressed: _canGoBack
                    ? () => setState(
                        () => _month = DateTime(_month.year, _month.month - 1),
                      )
                    : null,
              ),
              GpIconButton(
                icon: GpIcons.chevronRight,
                label: 'Next month',
                color: _canGoForward ? colors.ink : colors.disabledInk,
                onPressed: _canGoForward
                    ? () => setState(
                        () => _month = DateTime(_month.year, _month.month + 1),
                      )
                    : null,
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
                _day(
                  context,
                  DateTime(_month.year, _month.month, d),
                  first,
                  last,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _day(
    BuildContext context,
    DateTime day,
    DateTime first,
    DateTime last,
  ) {
    final colors = context.colors;
    final enabled = !day.isBefore(first) && !day.isAfter(last);
    final selected = isSameDay(day, widget.initial);
    final today = isSameDay(day, DateTime.now());
    return Pressable(
      onTap: enabled ? () => Navigator.of(context).pop(day) : null,
      semanticLabel: DateFormat('EEEE d MMMM').format(day),
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? colors.ink : null,
            border: today && !selected
                ? Border.all(color: colors.lineStrong)
                : null,
          ),
          child: Text(
            '${day.day}',
            style: context.type.bodyStrong.copyWith(
              color: selected
                  ? colors.onInk
                  : enabled
                  ? colors.ink
                  : colors.disabledInk.withValues(alpha: .5),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeSheet extends StatefulWidget {
  const _TimeSheet({required this.initial, required this.title});

  final int initial;
  final String title;

  @override
  State<_TimeSheet> createState() => _TimeSheetState();
}

class _TimeSheetState extends State<_TimeSheet> {
  late int _hour = widget.initial ~/ 60;
  late int _minute = widget.initial % 60;
  late final _hours = FixedExtentScrollController(initialItem: _hour);
  late final _minutes = FixedExtentScrollController(initialItem: _minute);

  @override
  void dispose() {
    _hours.dispose();
    _minutes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        GpSpace.gutter,
        0,
        GpSpace.gutter,
        GpSpace.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.title, style: context.type.title),
          const SizedBox(height: GpSpace.lg),
          SizedBox(
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // The band the chosen time sits in.
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.surfaceMuted,
                    borderRadius: BorderRadius.circular(GpRadius.md),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _Wheel(
                        controller: _hours,
                        count: 24,
                        align: Alignment.centerRight,
                        onChanged: (i) => _hour = i,
                      ),
                    ),
                    Text(':', style: context.type.title),
                    Expanded(
                      child: _Wheel(
                        controller: _minutes,
                        count: 60,
                        align: Alignment.centerLeft,
                        onChanged: (i) => _minute = i,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: GpSpace.lg),
          GpButton(
            label: 'Set time',
            onPressed: () => Navigator.of(context).pop(_hour * 60 + _minute),
          ),
        ],
      ),
    );
  }
}

class _Wheel extends StatelessWidget {
  const _Wheel({
    required this.controller,
    required this.count,
    required this.align,
    required this.onChanged,
  });

  final FixedExtentScrollController controller;
  final int count;
  final Alignment align;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => ListWheelScrollView.useDelegate(
    controller: controller,
    itemExtent: 44,
    diameterRatio: 1.6,
    overAndUnderCenterOpacity: .35,
    physics: const FixedExtentScrollPhysics(),
    onSelectedItemChanged: (i) => onChanged(i % count),
    childDelegate: ListWheelChildLoopingListDelegate(
      children: [
        for (var i = 0; i < count; i++)
          Align(
            alignment: align,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: GpSpace.lg),
              child: Text(
                i.toString().padLeft(2, '0'),
                style: context.type.title.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
