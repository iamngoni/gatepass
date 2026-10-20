//
//  Gatepass
//  kdf_params.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

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
