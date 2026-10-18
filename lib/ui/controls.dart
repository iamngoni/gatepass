import 'package:flutter/widgets.dart';

import 'pressable.dart';
import 'theme.dart';

/// The slim switch, identical on every platform.
class GpSwitch extends StatelessWidget {
  const GpSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.semanticLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final enabled = onChanged != null;
    final track = !enabled
        ? colors.disabled
        : value
        ? GpColors.toggleOn
        : colors.control;
    return Semantics(
      toggled: value,
      enabled: enabled,
      label: semanticLabel,
      child: Pressable(
        onTap: enabled ? () => onChanged!(!value) : null,
        child: AnimatedContainer(
          duration: GpMotion.base,
          curve: GpMotion.curve,
          width: 52,
          height: 32,
          padding: const EdgeInsets.all(3),
          alignment: value
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart,
          decoration: BoxDecoration(
            color: track,
            borderRadius: BorderRadius.circular(GpRadius.pill),
          ),
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: enabled ? GpColors.toggleKnob : colors.disabledInk,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

/// A row with a title, a helper line and a switch: the whole row toggles.
class GpSwitchRow extends StatelessWidget {
  const GpSwitchRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => Semantics(
    toggled: value,
    label: title,
    excludeSemantics: true,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GpSpace.lg,
          vertical: GpSpace.md + 2,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.type.heading),
                  if (subtitle != null) ...[
                    const SizedBox(height: GpSpace.xxs),
                    Text(subtitle!, style: context.type.caption),
                  ],
                ],
              ),
            ),
            const SizedBox(width: GpSpace.md),
            GpSwitch(value: value, onChanged: onChanged),
          ],
        ),
      ),
    ),
  );
}

/// One groove, one borderless sliding thumb.
class GpSegmented extends StatelessWidget {
  const GpSegmented({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const _inset = 3.0;
  static const _thumbRadius = GpRadius.md - _inset;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: 44,
      padding: const EdgeInsets.all(_inset),
      decoration: BoxDecoration(
        color: colors.track,
        borderRadius: BorderRadius.circular(GpRadius.md),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth / segments.length;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: GpMotion.slow,
                curve: GpMotion.riseCurve,
                left: width * selectedIndex,
                top: 0,
                bottom: 0,
                width: width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.trackThumb,
                    borderRadius: BorderRadius.circular(_thumbRadius),
                  ),
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < segments.length; i++)
                    Expanded(
                      child: Semantics(
                        selected: i == selectedIndex,
                        child: Pressable(
                          onTap: i == selectedIndex ? null : () => onChanged(i),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: GpSpace.sm,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: AnimatedDefaultTextStyle(
                                  duration: GpMotion.fast,
                                  style: context.type.bodyStrong.copyWith(
                                    height: 1.2,
                                    color: i == selectedIndex
                                        ? colors.ink
                                        : colors.inkMuted,
                                  ),
                                  child: Text(segments[i], maxLines: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Choice and filter pill. Selected is an ink fill; unselected a surface
/// with a hairline.
class GpPill extends StatelessWidget {
  const GpPill({
    super.key,
    required this.label,
    required this.onPressed,
    this.selected = false,
  });

  final String label;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      selected: selected,
      child: Pressable(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: GpMotion.base,
          curve: GpMotion.curve,
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          // No alignment: it would stretch the pill across a Wrap's width.
          decoration: BoxDecoration(
            color: selected ? colors.ink : colors.surface,
            borderRadius: BorderRadius.circular(GpRadius.pill),
            border: selected
                ? null
                : Border.all(color: colors.lineStrong, width: GpSizes.hairline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                maxLines: 1,
                style: context.type.label
                    .weighted(FontWeight.w600)
                    .copyWith(color: selected ? colors.onInk : colors.ink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
