// Gatepass — gp_field.dart. Created 2026-10-18.
// A text field built on Flutter's unstyled EditableText, not TextField. The
// label sits above the box, errors wrap beneath it, and selection keeps the
// phone's own gestures and edit menu.
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../configs/gp_motion.dart';
import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'gp_selection_gestures.dart';
import 'gp_selection_toolbar.dart';

class GpField extends StatefulWidget {
  const GpField({
    required this.controller,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onSubmitted,
    this.autofocus = false,
    this.enabled = true,
    this.prefix,
    this.style,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    super.key,
  });

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final bool enabled;
  final Widget? prefix;

  /// Replaces the body style, as for the sign-in code.
  final TextStyle? style;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;

  @override
  State<GpField> createState() => _GpFieldState();
}

class _GpFieldState extends State<GpField> {
  final internalFocus = FocusNode();

  FocusNode get focus => widget.focusNode ?? internalFocus;

  @override
  void dispose() {
    internalFocus.dispose();
    super.dispose();
  }

  // The border and tap target follow focus; listening here replaces a
  // setState on every focus change.
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: focus,
    builder: (context, _) {
      final colors = context.colors;
      final type = context.type;
      final hasError = widget.error != null;
      final focused = focus.hasFocus;
      final border = hasError
          ? colors.danger
          : focused
          ? colors.accent
          : colors.lineStrong;
      final textStyle = (widget.style ?? type.lead).copyWith(
        color: widget.enabled ? colors.ink : colors.disabledInk,
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: type.label.copyWith(
                color: hasError ? colors.danger : colors.inkMuted,
              ),
            ),
            const SizedBox(height: 6),
          ],
          TextFieldTapRegion(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.enabled && !focused ? focus.requestFocus : null,
              child: AnimatedContainer(
                duration: GpMotion.fast,
                constraints: const BoxConstraints(minHeight: GpSizes.control),
                padding: const EdgeInsets.symmetric(horizontal: GpSpace.lg),
                decoration: BoxDecoration(
                  color: widget.enabled ? colors.surface : colors.surfaceMuted,
                  borderRadius: BorderRadius.circular(GpRadius.md),
                  border: Border.all(
                    color: border,
                    width: focused || hasError ? 1.2 : GpSizes.hairline,
                  ),
                ),
                child: Row(
                  children: [
                    if (widget.prefix != null) ...[
                      widget.prefix!,
                      const SizedBox(width: GpSpace.sm),
                    ],
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          if (widget.hint != null)
                            ListenableBuilder(
                              listenable: widget.controller,
                              builder: (context, _) =>
                                  widget.controller.text.isEmpty
                                  ? IgnorePointer(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          widget.hint!,
                                          textAlign: widget.textAlign,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle.copyWith(
                                            color: colors.inkFaint,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          GpSelectionGestures(
                            enabled: widget.enabled,
                            builder: (context, key) => EditableText(
                              key: key,
                              rendererIgnoresPointer: true,
                              controller: widget.controller,
                              focusNode: focus,
                              style: textStyle,
                              cursorColor: colors.accent,
                              backgroundCursorColor: colors.line,
                              cursorWidth: 1.6,
                              selectionColor: colors.accent.withValues(
                                alpha: .22,
                              ),
                              selectionControls: _HandleControls(),
                              contextMenuBuilder: GpSelectionToolbar.adaptive,
                              keyboardType: widget.keyboardType,
                              textInputAction: widget.textInputAction,
                              inputFormatters: widget.inputFormatters,
                              onSubmitted: widget.onSubmitted,
                              // Phones keep the keyboard up on an outside tap
                              // by default, and a number pad has no Done key.
                              onTapOutside: (_) => focus.unfocus(),
                              readOnly: !widget.enabled,
                              autofocus: widget.autofocus,
                              autofillHints: widget.autofillHints ?? const [],
                              textAlign: widget.textAlign,
                              textCapitalization: widget.textCapitalization,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (hasError) ...[
            const SizedBox(height: 6),
            Text(
              widget.error!,
              style: type.caption.copyWith(color: colors.danger),
            ),
          ] else if (widget.helper != null) ...[
            const SizedBox(height: 6),
            Text(widget.helper!, style: type.caption),
          ],
        ],
      );
    },
  );
}

/// Flat selection handles: a solid accent dot at each end.
class _HandleControls extends TextSelectionControls
    with TextSelectionHandleControls {
  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    final colors = context.colors;
    final handle = Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: colors.accent,
        shape: BoxShape.circle,
        border: Border.all(color: colors.surface, width: 1.5),
      ),
    );
    return onTap == null
        ? handle
        : GestureDetector(onTap: onTap, child: handle);
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) =>
      const Offset(6, 6);

  @override
  Size getHandleSize(double textLineHeight) => const Size(12, 12);
}
