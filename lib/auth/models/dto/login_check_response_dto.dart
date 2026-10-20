//
//  Gatepass
//  login_check_response_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/configs/atg_config.dart';

part 'login_check_response_dto.freezed.dart';
part 'login_check_response_dto.g.dart';

/// `/open/login/check`'s reply: the Firebase custom token, under `token`.
@freezed
abstract class LoginCheckResponseDTO with _$LoginCheckResponseDTO {
  const factory LoginCheckResponseDTO({
    @JsonKey(readValue: _readCustomToken) String? customToken,
  }) = _LoginCheckResponseDTO;

  factory LoginCheckResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginCheckResponseDTOFromJson(json);
}

/// `token` first, else a deep search for any of
/// [AtgConfig.customTokenKeys] whose value looks like a JWT, so a nested or
/// renamed envelope still works.
Object? _readCustomToken(Map<dynamic, dynamic> json, String _) {
  final direct = json[AtgConfig.customTokenKeys.first];
  if (direct is String) return direct;
  String? found;
  void walk(Object? node) {
    if (found != null) return;
    if (node is Map) {
      for (final MapEntry(:key, :value) in node.entries) {
        if (found != null) return;
        final isTokenKey = AtgConfig.customTokenKeys.contains(key.toString());
        if (isTokenKey && value is String && value.split('.').length >= 2) {
          found = value;
        } else {
          walk(value);
        }
      }
    } else if (node is List) {
      node.forEach(walk);
    }
  }

  walk(json);
  return found;
}
