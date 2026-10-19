// Gatepass — gp_spacing.dart. Created 2026-10-18.

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
  static const tabBar = 64.0;
  static const tapTarget = 44.0;
  static const hairline = 0.6;
}
