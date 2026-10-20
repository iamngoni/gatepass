//
//  Gatepass
//  gp_colors.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

// The single source of Gatepass's presentation tokens, after dueo's
// zero-Material system. Nothing here imports Material: these values replace
// framework defaults rather than theme them, and no screen hard-codes a
// colour, radius, duration or type style of its own.
import 'package:flutter/widgets.dart';

import 'tone.dart';

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
    required this.chrome,
    required this.floatShadow,
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

  /// Translucent fill for chrome that floats over content: the tab bar.
  final Color chrome;

  /// The app's one shadow, for chrome floating over scrolling content.
  /// Surfaces in the page stay flat.
  final List<BoxShadow> floatShadow;

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
    chrome: Color(0xE6FFFFFF),
    floatShadow: [
      BoxShadow(color: Color(0x140F1F19), blurRadius: 24, offset: Offset(0, 8)),
      BoxShadow(color: Color(0x0A0F1F19), blurRadius: 2, offset: Offset(0, 1)),
    ],
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
    chrome: Color(0xE01B2722),
    floatShadow: [
      BoxShadow(
        color: Color(0x73000000),
        blurRadius: 28,
        offset: Offset(0, 10),
      ),
    ],
  );
}
