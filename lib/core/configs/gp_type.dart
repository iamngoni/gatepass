// Gatepass — gp_type.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import 'gp_colors.dart';

/// Figtree for reading, Bricolage Grotesque for display. Both are variable
/// fonts, so weight is set as a font variation as well as a weight.
class GpType {
  const GpType(this.colors, {this.boldText = false});

  final GpColors colors;
  final bool boldText;

  static const family = 'Figtree';
  static const displayFamily = 'Bricolage Grotesque';

  /// A tab's own title, drawn in the page rather than in a bar.
  TextStyle get display => _base(
    fontSize: 32,
    weight: FontWeight.w700,
    letterSpacing: -1.1,
    height: 1.15,
    display: true,
  );

  TextStyle get title => _base(
    fontSize: 22,
    weight: FontWeight.w700,
    letterSpacing: -.6,
    height: 1.2,
    display: true,
  );

  /// A card's own name: a visitor on their detail page, the quick panel.
  TextStyle get cardTitle => _base(
    fontSize: 19,
    weight: FontWeight.w700,
    letterSpacing: -.4,
    height: 1.25,
    display: true,
  );

  /// A gate code: big, tabular and spaced so it reads off a phone.
  TextStyle get code => _base(
    fontSize: 34,
    weight: FontWeight.w700,
    letterSpacing: 3,
    height: 1.1,
    tabular: true,
    display: true,
  );

  /// The label of a full-width call to action, and the header title.
  TextStyle get action =>
      _base(fontSize: 17, weight: FontWeight.w600, height: 1.2);
  TextStyle get lead => _base(fontSize: 16, height: 22 / 16);
  TextStyle get section => _base(
    fontSize: 16,
    weight: FontWeight.w700,
    letterSpacing: -.2,
    height: 1.25,
  );
  TextStyle get heading => _base(
    fontSize: 15,
    weight: FontWeight.w600,
    letterSpacing: -.1,
    height: 1.3,
  );
  TextStyle get body => _base(fontSize: 15, height: 1.4);
  TextStyle get bodyStrong =>
      _base(fontSize: 15, weight: FontWeight.w600, height: 1.4);
  TextStyle get small => _base(fontSize: 14, height: 19 / 14);
  TextStyle get label =>
      _base(fontSize: 13, weight: FontWeight.w500, height: 1.35);
  TextStyle get caption =>
      _base(fontSize: 12, height: 1.35, color: colors.inkMuted);
  TextStyle get chip =>
      _base(fontSize: 12, weight: FontWeight.w600, height: 1.3);

  /// Small caps-style group label above a list: TODAY, UPCOMING.
  TextStyle get overline => _base(
    fontSize: 11,
    weight: FontWeight.w700,
    letterSpacing: 1,
    height: 1.2,
    color: colors.inkFaint,
  );
  TextStyle get navLabel =>
      _base(fontSize: 11, weight: FontWeight.w600, height: 1.2);

  /// Times in lists, so columns of them line up.
  TextStyle get time => _base(
    fontSize: 13,
    weight: FontWeight.w500,
    height: 1.35,
    tabular: true,
    color: colors.inkMuted,
  );

  TextStyle _base({
    required double fontSize,
    FontWeight weight = FontWeight.w400,
    double? letterSpacing,
    double? height,
    bool tabular = false,
    bool display = false,
    Color? color,
  }) {
    final resolved = boldText
        ? FontWeight.values[(weight.value ~/ 100).clamp(0, 8)]
        : weight;
    return TextStyle(
      fontFamily: display ? displayFamily : family,
      fontSize: fontSize,
      fontWeight: resolved,
      letterSpacing: letterSpacing,
      height: height,
      color: color ?? colors.ink,
      fontFeatures: tabular ? const [FontFeature.tabularFigures()] : const [],
      fontVariations: [
        FontVariation.weight(resolved.value.toDouble()),
        if (display) FontVariation.opticalSize(fontSize.clamp(12, 96)),
      ],
    );
  }
}

/// A weight change has to move the font variation too, or a variable font
/// keeps drawing the style's original weight.
extension GpTextWeight on TextStyle {
  TextStyle weighted(FontWeight weight) => copyWith(
    fontWeight: weight,
    fontVariations: [
      ...?fontVariations?.where((v) => v.axis != 'wght'),
      FontVariation.weight(weight.value.toDouble()),
    ],
  );
}
