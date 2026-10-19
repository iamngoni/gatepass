// Gatepass — remote_backup.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_backup.freezed.dart';

/// The sealed backup on the server and the version a write must match.
@freezed
abstract class RemoteBackup with _$RemoteBackup {
  const factory RemoteBackup({
    required int version,
    required String blob,
    required DateTime updatedAt,
  }) = _RemoteBackup;
}
