//
//  Gatepass
//  visitor_category_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/atg_json.dart';

part 'visitor_category_dto.freezed.dart';
part 'visitor_category_dto.g.dart';

/// One of the estate's visitor categories (`/api/visitor/categories`).
@freezed
abstract class VisitorCategoryDTO with _$VisitorCategoryDTO {
  const factory VisitorCategoryDTO({
    @JsonKey(readValue: _readId) int? id,
    @JsonKey(readValue: _readName) String? name,
  }) = _VisitorCategoryDTO;

  const VisitorCategoryDTO._();

  factory VisitorCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$VisitorCategoryDTOFromJson(json);

  /// ATG rejects a create without the estate's "Invitation" category.
  bool get isInvitation {
    final lower = name?.toLowerCase();
    return lower == 'invitation' || lower == 'visitor';
  }
}

Object? _readId(Map<dynamic, dynamic> json, String _) {
  final id = json['id'];
  return id is num ? id.toInt() : int.tryParse('$id');
}

Object? _readName(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['name', 'categoryName']);
