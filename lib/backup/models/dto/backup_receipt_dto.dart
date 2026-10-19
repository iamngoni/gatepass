// Gatepass — backup_receipt_dto.dart. Created 2026-10-19.
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
