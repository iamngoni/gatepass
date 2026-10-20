//
//  Gatepass
//  remote_backup.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

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
