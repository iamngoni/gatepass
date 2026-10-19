// Gatepass — gp_sheet_page.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_motion.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';

/// The sheet's body: handle, drag-to-dismiss, safe area and keyboard.
class GpSheetPage extends StatefulWidget {
  const GpSheetPage({
    required this.builder,
    required this.maxHeightFactor,
    super.key,
  });

  final WidgetBuilder builder;
  final double maxHeightFactor;

  @override
  State<GpSheetPage> createState() => _GpSheetPageState();
}

class _GpSheetPageState extends State<GpSheetPage> {
  final offset = ValueNotifier<double>(0);

  @override
  void dispose() {
    offset.dispose();
    super.dispose();
  }

  void onDragUpdate(DragUpdateDetails details) {
    final delta = details.primaryDelta ?? 0;
    offset.value = (offset.value + delta).clamp(0, double.infinity);
  }

  void onDragEnd(DragEndDetails details) {
    if (offset.value > 120 || (details.primaryVelocity ?? 0) > 700) {
      Navigator.of(context).pop();
      return;
    }
    offset.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final media = MediaQuery.of(context);
    final available =
        (media.size.height - media.padding.top - media.viewInsets.bottom).clamp(
          0.0,
          media.size.height,
        );
    return ValueListenableBuilder<double>(
      valueListenable: offset,
      builder: (context, offset, _) => Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedPadding(
          duration: GpMotion.base,
          curve: GpMotion.curve,
          padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
          child: AnimatedContainer(
            duration: offset == 0
                ? GpMotion.base
                : const Duration(milliseconds: 1),
            curve: GpMotion.curveInOut,
            transform: Matrix4.translationValues(0, offset, 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600,
                maxHeight: available * widget.maxHeightFactor,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(GpRadius.sheet),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    border: Border(
                      top: BorderSide(
                        color: colors.line,
                        width: GpSizes.hairline,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onVerticalDragUpdate: onDragUpdate,
                          onVerticalDragEnd: onDragEnd,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Container(
                                width: 40,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: colors.control,
                                  borderRadius: BorderRadius.circular(
                                    GpRadius.pill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(child: widget.builder(context)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
