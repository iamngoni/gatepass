//
//  Gatepass
//  create_visitor_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_visitor_dto.freezed.dart';
part 'create_visitor_dto.g.dart';

/// `POST /api/v5/visitor/profile`: a single-entry invitation. Field names
/// confirmed against ATG's own web client; null fields are left out.
@freezed
abstract class CreateVisitorDTO with _$CreateVisitorDTO {
  @JsonSerializable(includeIfNull: false)
  const factory CreateVisitorDTO({
    required String? uid,
    required String name,

    /// Epoch milliseconds, UTC.
    required int validFrom,
    required int validTill,
    String? surname,
    String? phoneNumber,
    String? carLic,
    int? categoryId,
    @Default(1) int visitsAllowed,
    @Default('both') String notifyOn,
  }) = _CreateVisitorDTO;

  factory CreateVisitorDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateVisitorDTOFromJson(json);
}
