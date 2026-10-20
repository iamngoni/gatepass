//
//  Gatepass
//  recovery_phrase_repository.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:dartz/dartz.dart';

import '../../../../core/models/data/application_error.dart';

/// The 12-word phrase the backup key is derived from.
abstract interface class RecoveryPhraseRepository {
  Future<Either<ApplicationError, List<String>>> generate();

  /// Lowercased words in order. Left with
  /// [ApplicationErrorCode.phraseInvalid] when it isn't 12 known words.
  Future<Either<ApplicationError, List<String>>> parse(String input);
}
