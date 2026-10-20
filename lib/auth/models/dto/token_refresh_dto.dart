//
//  Gatepass
//  token_refresh_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_refresh_dto.freezed.dart';
part 'token_refresh_dto.g.dart';

/// Secure Token `v1/token` request: renews the ID token.
@freezed
abstract class TokenRefreshDTO with _$TokenRefreshDTO {
  const factory TokenRefreshDTO({
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'grant_type') @Default('refresh_token') String grantType,
  }) = _TokenRefreshDTO;

  factory TokenRefreshDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshDTOFromJson(json);
}
