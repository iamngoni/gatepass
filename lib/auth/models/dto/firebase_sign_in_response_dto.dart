// Gatepass — firebase_sign_in_response_dto.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_sign_in_response_dto.freezed.dart';
part 'firebase_sign_in_response_dto.g.dart';

/// Identity Toolkit's reply to a custom-token sign-in.
@freezed
abstract class FirebaseSignInResponseDTO with _$FirebaseSignInResponseDTO {
  const factory FirebaseSignInResponseDTO({
    String? idToken,
    String? refreshToken,

    /// Seconds, as text.
    String? expiresIn,
    String? localId,
  }) = _FirebaseSignInResponseDTO;

  factory FirebaseSignInResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$FirebaseSignInResponseDTOFromJson(json);
}
