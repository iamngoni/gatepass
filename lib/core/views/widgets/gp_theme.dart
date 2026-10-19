// Gatepass — gp_theme.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../configs/gp_theme_data.dart';

class GpTheme extends InheritedWidget {
  const GpTheme({required this.data, required super.child, super.key});

  final GpThemeData data;

  /// Falls back to light so a component pumped on its own still builds.
  static GpThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GpTheme>()?.data ??
      GpThemeData.light;

  @override
  bool updateShouldNotify(GpTheme oldWidget) => oldWidget.data != data;
}
