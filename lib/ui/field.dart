// A text field built on Flutter's unstyled EditableText, not TextField. The
// label sits above the box, errors wrap beneath it, and selection keeps the
// phone's own gestures and edit menu.
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'pressable.dart';
import 'theme.dart';

class GpField extends StatefulWidget {
  const GpField({
    super.key,
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
  final _internalFocus = FocusNode();
  FocusNode get _focus => widget.focusNode ?? _internalFocus;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocus);
  }

  @override
  void didUpdateWidget(GpField old) {
    super.didUpdateWidget(old);
    if (old.focusNode != widget.focusNode) {
      (old.focusNode ?? _internalFocus).removeListener(_onFocus);
      _focus.addListener(_onFocus);
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    _internalFocus.dispose();
    super.dispose();
  }

  void _onFocus() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final hasError = widget.error != null;
    final focused = _focus.hasFocus;
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
            onTap: widget.enabled && !focused ? _focus.requestFocus : null,
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
                        _SelectionGestures(
                          enabled: widget.enabled,
                          builder: (context, key) => EditableText(
                            key: key,
                            rendererIgnoresPointer: true,
                            controller: widget.controller,
                            focusNode: _focus,
                            style: textStyle,
                            cursorColor: colors.accent,
                            backgroundCursorColor: colors.line,
                            cursorWidth: 1.6,
                            selectionColor: colors.accent.withValues(
                              alpha: .22,
                            ),
                            selectionControls: _HandleControls(),
                            contextMenuBuilder: _SelectionToolbar.adaptive,
                            keyboardType: widget.keyboardType,
                            textInputAction: widget.textInputAction,
                            inputFormatters: widget.inputFormatters,
                            onSubmitted: widget.onSubmitted,
                            // Phones keep the keyboard up on an outside tap
                            // by default, and a number pad has no Done key.
                            onTapOutside: (_) => _focus.unfocus(),
                            readOnly: !widget.enabled,
                            autofocus: widget.autofocus,
                            maxLines: 1,
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
  }
}

/// A bare EditableText has no touch gestures of its own: no long-press or
/// double-tap selection and no menu. This adds the platform's.
class _SelectionGestures extends StatefulWidget {
  const _SelectionGestures({required this.builder, required this.enabled});

  final Widget Function(BuildContext, GlobalKey<EditableTextState>) builder;
  final bool enabled;

  @override
  State<_SelectionGestures> createState() => _SelectionGesturesState();
}

class _SelectionGesturesState extends State<_SelectionGestures>
    implements TextSelectionGestureDetectorBuilderDelegate {
  @override
  final editableTextKey = GlobalKey<EditableTextState>();

  late final _gestures = TextSelectionGestureDetectorBuilder(delegate: this);

  @override
  bool get forcePressEnabled => defaultTargetPlatform == TargetPlatform.iOS;

  @override
  bool get selectionEnabled => widget.enabled;

  @override
  Widget build(BuildContext context) => _gestures.buildGestureDetector(
    behavior: HitTestBehavior.translucent,
    child: widget.builder(context, editableTextKey),
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

/// The phone's own edit menu where iOS allows it, the app's otherwise.
class _SelectionToolbar extends StatelessWidget {
  const _SelectionToolbar({required this.anchors, required this.state});

  final TextSelectionToolbarAnchors anchors;
  final EditableTextState state;

  static Widget adaptive(BuildContext context, EditableTextState state) =>
      SystemContextMenu.isSupportedByField(state)
      ? SystemContextMenu.editableText(editableTextState: state)
      : _SelectionToolbar(anchors: state.contextMenuAnchors, state: state);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final items = [
      for (final item in state.contextMenuButtonItems)
        if (item.onPressed != null) item,
    ];
    return CustomSingleChildLayout(
      delegate: TextSelectionToolbarLayoutDelegate(
        anchorAbove: anchors.primaryAnchor,
        anchorBelow: anchors.secondaryAnchor ?? anchors.primaryAnchor,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(GpRadius.sm),
          border: Border.all(color: colors.lineStrong, width: GpSizes.hairline),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final item in items)
                Pressable(
                  onTap: () {
                    item.onPressed?.call();
                    state.hideToolbar();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text(
                      item.label ??
                          switch (item.type) {
                            ContextMenuButtonType.cut => 'Cut',
                            ContextMenuButtonType.copy => 'Copy',
                            ContextMenuButtonType.paste => 'Paste',
                            ContextMenuButtonType.selectAll => 'Select all',
                            _ => '',
                          },
                      style: context.type.chip,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
