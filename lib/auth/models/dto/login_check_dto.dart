//
//  Gatepass
//  login_check_dto.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_check_dto.freezed.dart';
part 'login_check_dto.g.dart';

/// `POST /open/login/check`: verifies the code and returns a Firebase custom
/// token. ATG's own web-client shape, confirmed live.
@freezed
abstract class LoginCheckDTO with _$LoginCheckDTO {
  const factory LoginCheckDTO({
    required String contact,
    required String code,
    required String deviceId,
    required String appVersion,
    required String appBuildNumber,
    required String platform,
  }) = _LoginCheckDTO;

  factory LoginCheckDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginCheckDTOFromJson(json);
}
