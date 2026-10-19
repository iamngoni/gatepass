// Gatepass — quick_tile.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';

class QuickTile extends StatelessWidget {
  const QuickTile({
    required this.label,
    required this.semantics,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.badge = false,
    this.outlined = false,
    super.key,
  });

  final String label;
  final String semantics;
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  /// Marks a person who already has a live invite.
  final bool badge;

  /// The "Someone new" tile: an outline instead of a fill.
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semantics,
      excludeSemantics: true,
      child: Pressable(
        onTap: onTap,
        onLongPress: onLongPress,
        child: SizedBox(
          width: 76,
          child: Column(
            children: [
              const SizedBox(height: GpSpace.xs),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: outlined ? null : GpColors.brandRaised,
                      borderRadius: BorderRadius.circular(GpRadius.lg),
                      border: outlined
                          ? Border.all(color: GpColors.brandLine)
                          : null,
                    ),
                    child: child,
                  ),
                  if (badge)
                    Positioned(
                      right: -3,
                      bottom: -3,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: GpColors.brandMint,
                          shape: BoxShape.circle,
                          border: Border.all(color: GpColors.brand, width: 2.5),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: GpSpace.sm),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: context.type.caption.copyWith(
                  color: GpColors.onBrand,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
