// Gatepass — login_start_dto.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_start_dto.freezed.dart';
part 'login_start_dto.g.dart';

/// `POST /open/login/start`: sends the sign-in code. ATG's own web-client
/// shape, recovered verbatim.
@freezed
abstract class LoginStartDTO with _$LoginStartDTO {
  const factory LoginStartDTO({
    required String loginString,

    /// `sms` or `whatsapp`.
    required String channel,
    required String deviceId,
    required String appVersion,
    required String appBuildNumber,
    required String platform,
  }) = _LoginStartDTO;

  factory LoginStartDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginStartDTOFromJson(json);
}
