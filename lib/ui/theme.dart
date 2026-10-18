// The single source of Gatepass's presentation tokens, after dueo's
// zero-Material system. Nothing here imports Material: these values replace
// framework defaults rather than theme them, and no screen hard-codes a
// colour, radius, duration or type style of its own.
import 'package:flutter/widgets.dart';

/// Semantic colour role for status pills, badges and marks.
enum Tone { accent, info, warning, danger, neutral }

@immutable
class GpColors {
  const GpColors({
    required this.canvas,
    required this.surface,
    required this.surfaceMuted,
    required this.ink,
    required this.inkMuted,
    required this.inkFaint,
    required this.line,
    required this.lineStrong,
    required this.accent,
    required this.accentSoft,
    required this.onAccent,
    required this.danger,
    required this.dangerSoft,
    required this.warning,
    required this.warningSoft,
    required this.info,
    required this.infoSoft,
    required this.onInk,
    required this.overlay,
    required this.disabled,
    required this.disabledInk,
    required this.control,
    required this.chevron,
    required this.track,
    required this.trackThumb,
  });

  final Color canvas;
  final Color surface;
  final Color surfaceMuted;
  final Color ink;
  final Color inkMuted;
  final Color inkFaint;

  /// Hairlines between rows and around surfaces.
  final Color line;

  /// Outlines that carry a control's shape.
  final Color lineStrong;
  final Color accent;
  final Color accentSoft;
  final Color onAccent;
  final Color danger;
  final Color dangerSoft;
  final Color warning;
  final Color warningSoft;
  final Color info;
  final Color infoSoft;

  /// Text on an ink fill: a selected pill, the toast.
  final Color onInk;
  final Color overlay;
  final Color disabled;
  final Color disabledInk;

  /// The off groove of a switch, a sheet's grab handle.
  final Color control;
  final Color chevron;

  /// The segmented control's groove and its thumb.
  final Color track;
  final Color trackThumb;

  static const toggleOn = Color(0xFF2E7D5B);
  static const toggleKnob = Color(0xFFFFFFFF);

  /// The quick-invite panel on Home: forest in both themes.
  static const brand = Color(0xFF1D4B3D);
  static const onBrand = Color(0xFFFFFFFF);
  static const onBrandMuted = Color(0xFFBFD9CC);
  static const brandMint = Color(0xFFA8DDC2);

  /// A mark sitting on the brand surface: a quick tile's circle.
  static const brandRaised = Color(0x1FFFFFFF);
  static const brandLine = Color(0x47FFFFFF);
  static const unread = Color(0xFFE0623F);

  Color tone(Tone tone) => switch (tone) {
    Tone.accent => accent,
    Tone.info => info,
    Tone.warning => warning,
    Tone.danger => danger,
    Tone.neutral => inkMuted,
  };

  Color toneSoft(Tone tone) => switch (tone) {
    Tone.accent => accentSoft,
    Tone.info => infoSoft,
    Tone.warning => warningSoft,
    Tone.danger => dangerSoft,
    Tone.neutral => surfaceMuted,
  };

  static const light = GpColors(
    canvas: Color(0xFFEEF1EC),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF3F6F1),
    ink: Color(0xFF0F1F19),
    inkMuted: Color(0xFF4A5A53),
    inkFaint: Color(0xFF6B7A73),
    line: Color(0xFFEDF0EB),
    lineStrong: Color(0xFFD5DDD7),
    accent: Color(0xFF1D4B3D),
    accentSoft: Color(0xFFE2F0E8),
    onAccent: Color(0xFFFFFFFF),
    danger: Color(0xFFA63426),
    dangerSoft: Color(0xFFFBE4DF),
    warning: Color(0xFF7A4A12),
    warningSoft: Color(0xFFFAEFD8),
    info: Color(0xFF2F5DA8),
    infoSoft: Color(0xFFE6EEFB),
    onInk: Color(0xFFFFFFFF),
    overlay: Color(0x730F1F19),
    disabled: Color(0xFFDDE3DC),
    disabledInk: Color(0xFF6B7A73),
    control: Color(0xFFC9D3CC),
    chevron: Color(0xFF8A968F),
    track: Color(0xFFDDE3DC),
    trackThumb: Color(0xFFFFFFFF),
  );

  static const dark = GpColors(
    canvas: Color(0xFF0E1714),
    surface: Color(0xFF17221E),
    surfaceMuted: Color(0xFF22302A),
    ink: Color(0xFFEEF3EF),
    inkMuted: Color(0xFFA9B8B0),
    inkFaint: Color(0xFF8A9A92),
    line: Color(0xFF24332D),
    lineStrong: Color(0xFF34463F),
    accent: Color(0xFFA8DDC2),
    accentSoft: Color(0xFF1C3329),
    onAccent: Color(0xFF0E1714),
    danger: Color(0xFFF4A595),
    dangerSoft: Color(0xFF3A201B),
    warning: Color(0xFFEBC27F),
    warningSoft: Color(0xFF36290F),
    info: Color(0xFF8DB4EC),
    infoSoft: Color(0xFF1E2A3D),
    onInk: Color(0xFF0E1714),
    overlay: Color(0x8C000000),
    disabled: Color(0xFF24332D),
    disabledInk: Color(0xFF7E8E86),
    control: Color(0xFF46584F),
    chevron: Color(0xFF6B7A73),
    track: Color(0xFF24332D),
    trackThumb: Color(0xFF3A4D45),
  );
}

/// Figtree for reading, Bricolage Grotesque for display. Both are variable
/// fonts, so weight is set as a font variation as well as a weight.
class GpType {
  const GpType._(this.colors, {this.boldText = false});

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

  /// Small caps-style group label above a list: TODAY, ON SITE NOW.
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

/// Four-point spacing ramp.
abstract final class GpSpace {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;
  static const xxxl = 32.0;

  /// Horizontal page margin shared by every screen.
  static const gutter = 20.0;
}

abstract final class GpRadius {
  static const sm = 10.0;
  static const md = 14.0;
  static const lg = 18.0;
  static const xl = 20.0;
  static const sheet = 32.0;
  static const pill = 999.0;
}

abstract final class GpSizes {
  /// The one call to action a screen asks for.
  static const action = 56.0;
  static const control = 52.0;
  static const controlCompact = 40.0;
  static const row = 64.0;
  static const icon = 20.0;
  static const iconLg = 24.0;
  static const avatar = 44.0;
  static const header = 56.0;
  static const tabBar = 68.0;
  static const tapTarget = 44.0;
  static const hairline = 0.6;
}

abstract final class GpMotion {
  static const fast = Duration(milliseconds: 120);
  static const base = Duration(milliseconds: 180);
  static const slow = Duration(milliseconds: 260);
  static const curve = Curves.easeOut;
  static const curveInOut = Curves.easeInOut;

  /// Something new arriving on screen.
  static const rise = Duration(milliseconds: 350);
  static const riseCurve = Cubic(.2, .8, .2, 1);
}

/// Light, dark, or whatever the phone is set to.
enum Appearance {
  system('System'),
  light('Light'),
  dark('Dark');

  const Appearance(this.label);
  final String label;
}

@immutable
class GpThemeData {
  const GpThemeData._(this.brightness, this.colors);

  final Brightness brightness;
  final GpColors colors;

  static const light = GpThemeData._(Brightness.light, GpColors.light);
  static const dark = GpThemeData._(Brightness.dark, GpColors.dark);

  bool get isDark => brightness == Brightness.dark;
}

class GpTheme extends InheritedWidget {
  const GpTheme({super.key, required this.data, required super.child});

  final GpThemeData data;

  /// Falls back to light so a component pumped on its own still builds.
  static GpThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GpTheme>()?.data ??
      GpThemeData.light;

  @override
  bool updateShouldNotify(GpTheme oldWidget) => oldWidget.data != data;
}

extension GpThemeContext on BuildContext {
  GpThemeData get gp => GpTheme.of(this);
  GpColors get colors => GpTheme.of(this).colors;
  GpType get type =>
      GpType._(GpTheme.of(this).colors, boldText: MediaQuery.boldTextOf(this));
}
