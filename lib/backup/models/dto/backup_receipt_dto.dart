//
//  Gatepass
//  backup_receipt_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_receipt_dto.freezed.dart';
part 'backup_receipt_dto.g.dart';

/// The Worker's reply to a saved backup.
@freezed
abstract class BackupReceiptDTO with _$BackupReceiptDTO {
  const factory BackupReceiptDTO({required int version}) = _BackupReceiptDTO;

  factory BackupReceiptDTO.fromJson(Map<String, dynamic> json) =>
      _$BackupReceiptDTOFromJson(json);
}
