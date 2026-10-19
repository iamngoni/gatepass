// Gatepass — time_picker_sheet.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import '../../utils/extensions/localization_extensions.dart';
import 'gp_button.dart';
import 'gp_sheet_route.dart';
import 'time_wheel.dart';

/// Hour and minute wheels. Works in minutes since midnight.
Future<int?> pickTime(
  BuildContext context, {
  required int initialMinutes,
  required String title,
}) => showGpSheet<int>(
  context,
  builder: (_) => TimePickerSheet(initial: initialMinutes, title: title),
);

/// The sheet behind [pickTime]: looping hour and minute wheels.
class TimePickerSheet extends StatefulWidget {
  const TimePickerSheet({
    required this.initial,
    required this.title,
    super.key,
  });

  final int initial;
  final String title;

  @override
  State<TimePickerSheet> createState() => _TimePickerSheetState();
}

class _TimePickerSheetState extends State<TimePickerSheet> {
  late int hour = widget.initial ~/ 60;
  late int minute = widget.initial % 60;
  late final hourController = FixedExtentScrollController(initialItem: hour);
  late final minuteController = FixedExtentScrollController(
    initialItem: minute,
  );

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
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
                      child: TimeWheel(
                        controller: hourController,
                        count: 24,
                        align: Alignment.centerRight,
                        onChanged: (i) => hour = i,
                      ),
                    ),
                    Text(':', style: context.type.title),
                    Expanded(
                      child: TimeWheel(
                        controller: minuteController,
                        count: 60,
                        align: Alignment.centerLeft,
                        onChanged: (i) => minute = i,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: GpSpace.lg),
          GpButton(
            label: context.l10n.commonSetTime,
            onPressed: () => Navigator.of(context).pop(hour * 60 + minute),
          ),
        ],
      ),
    );
  }
}
