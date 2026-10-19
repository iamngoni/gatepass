// Gatepass — backup_step.dart. Created 2026-10-19.

/// Where the backup sheet is: looking for a backup, offering to turn it on,
/// showing a new phrase, asking for an existing one, or managing it.
enum BackupStep { checking, intro, phrase, restore, on }
