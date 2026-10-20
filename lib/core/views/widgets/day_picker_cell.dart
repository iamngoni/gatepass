//
//  Gatepass
//  day_picker_cell.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../utils/date_helpers.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'pressable.dart';

/// One day in the picker's month grid; tapping pops the sheet with it.
class DayPickerCell extends StatelessWidget {
  const DayPickerCell({
    required this.day,
    required this.first,
    required this.last,
    required this.selected,
    super.key,
  });

  final DateTime day;

  /// The earliest and latest pickable days, at midnight.
  final DateTime first;
  final DateTime last;

  /// The day the picker opened on.
  final DateTime selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final enabled = !day.isBefore(first) && !day.isAfter(last);
    final isSelected = isSameDay(day, selected);
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
            color: isSelected ? colors.ink : null,
            border: today && !isSelected
                ? Border.all(color: colors.lineStrong)
                : null,
          ),
          child: Text(
            '${day.day}',
            style: context.type.bodyStrong.copyWith(
              color: isSelected
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
