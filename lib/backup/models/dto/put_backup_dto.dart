//
//  Gatepass
//  put_backup_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'put_backup_dto.freezed.dart';
part 'put_backup_dto.g.dart';

/// `PUT /v1/backup`. The Worker refuses it with 409 when another phone
/// wrote since [expectedVersion].
@freezed
abstract class PutBackupDTO with _$PutBackupDTO {
  const factory PutBackupDTO({
    required int expectedVersion,
    required String blob,
  }) = _PutBackupDTO;

  factory PutBackupDTO.fromJson(Map<String, dynamic> json) =>
      _$PutBackupDTOFromJson(json);
}
