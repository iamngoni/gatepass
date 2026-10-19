// Gatepass — recovery_phrase_repository.dart. Created 2026-10-19.
import 'package:dartz/dartz.dart';

import '../../../../core/models/data/application_error.dart';

/// The 12-word phrase the backup key is derived from.
abstract interface class RecoveryPhraseRepository {
  Future<Either<ApplicationError, List<String>>> generate();

  /// Lowercased words in order. Left with
  /// [ApplicationErrorCode.phraseInvalid] when it isn't 12 known words.
  Future<Either<ApplicationError, List<String>>> parse(String input);
}
