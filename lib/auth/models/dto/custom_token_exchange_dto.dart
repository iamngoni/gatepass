// Gatepass — custom_token_exchange_dto.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_token_exchange_dto.freezed.dart';
part 'custom_token_exchange_dto.g.dart';

/// Identity Toolkit `accounts:signInWithCustomToken` request.
@freezed
abstract class CustomTokenExchangeDTO with _$CustomTokenExchangeDTO {
  const factory CustomTokenExchangeDTO({
    required String token,
    @Default(true) bool returnSecureToken,
  }) = _CustomTokenExchangeDTO;

  factory CustomTokenExchangeDTO.fromJson(Map<String, dynamic> json) =>
      _$CustomTokenExchangeDTOFromJson(json);
}
