// Gatepass — kdf_params.dart. Created 2026-10-19.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kdf_params.freezed.dart';

/// Argon2id cost. The default is OWASP's baseline: 19 MiB, 2 passes,
/// 1 lane.
@freezed
abstract class KdfParams with _$KdfParams {
  const factory KdfParams({
    @Default(19456) int memoryKib,
    @Default(2) int iterations,
  }) = _KdfParams;
}
