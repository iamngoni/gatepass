// Gatepass — gp_selection_toolbar.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_spacing.dart';
import '../../utils/extensions/build_context_extensions.dart';
import 'pressable.dart';

/// The phone's own edit menu where iOS allows it, the app's otherwise.
class GpSelectionToolbar extends StatelessWidget {
  const GpSelectionToolbar({
    required this.anchors,
    required this.state,
    super.key,
  });

  final TextSelectionToolbarAnchors anchors;
  final EditableTextState state;

  static Widget adaptive(BuildContext context, EditableTextState state) =>
      SystemContextMenu.isSupportedByField(state)
      ? SystemContextMenu.editableText(editableTextState: state)
      : GpSelectionToolbar(anchors: state.contextMenuAnchors, state: state);

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
