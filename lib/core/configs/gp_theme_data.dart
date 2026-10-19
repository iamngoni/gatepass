// Gatepass — gp_theme_data.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import 'gp_colors.dart';

/// The two resolved themes. An enum, so only these two values exist.
enum GpThemeData {
  light(Brightness.light, GpColors.light),
  dark(Brightness.dark, GpColors.dark);

  const GpThemeData(this.brightness, this.colors);

  final Brightness brightness;
  final GpColors colors;

  bool get isDark => brightness == Brightness.dark;
}
