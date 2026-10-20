//
//  Gatepass
//  token_refresh_response_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/atg_json.dart';

part 'token_refresh_response_dto.freezed.dart';
part 'token_refresh_response_dto.g.dart';

/// Secure Token's reply to a refresh.
@freezed
abstract class TokenRefreshResponseDTO with _$TokenRefreshResponseDTO {
  const factory TokenRefreshResponseDTO({
    @JsonKey(readValue: _readIdToken) String? idToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,

    /// Seconds, as text.
    @JsonKey(name: 'expires_in') String? expiresIn,
    @JsonKey(name: 'user_id') String? userId,
  }) = _TokenRefreshResponseDTO;

  factory TokenRefreshResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshResponseDTOFromJson(json);
}

Object? _readIdToken(Map<dynamic, dynamic> json, String _) =>
    firstString(json, const ['id_token', 'access_token']);
