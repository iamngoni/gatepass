// Gatepass — appearance.dart. Created 2026-10-18.

/// Light, dark, or whatever the phone is set to.
enum Appearance {
  system('System'),
  light('Light'),
  dark('Dark');

  const Appearance(this.label);
  final String label;
}
