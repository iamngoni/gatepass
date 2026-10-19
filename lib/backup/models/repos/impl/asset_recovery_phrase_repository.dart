// Gatepass — asset_recovery_phrase_repository.dart. Created 2026-10-19.
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/data/application_error.dart';
import '../abs/recovery_phrase_repository.dart';

/// Words from the BIP39 English list (assets/backup/bip39-english.txt),
/// picked with a secure random source: 12 of 2048 is 132 bits.
@LazySingleton(as: RecoveryPhraseRepository)
class AssetRecoveryPhraseRepository implements RecoveryPhraseRepository {
  AssetRecoveryPhraseRepository(this.bundle);

  final AssetBundle bundle;

  static const length = 12;
  static const asset = 'assets/backup/bip39-english.txt';

  List<String>? _words;

  Future<List<String>> _wordList() async =>
      _words ??= (await bundle.loadString(asset))
          .split('\n')
          .map((word) => word.trim())
          .where((word) => word.isNotEmpty)
          .toList(growable: false);

  @override
  Future<Either<ApplicationError, List<String>>> generate() async {
    try {
      final words = await _wordList();
      final random = Random.secure();
      return Right([
        for (var i = 0; i < length; i++) words[random.nextInt(words.length)],
      ]);
    } on Object catch (e) {
      debugPrint('[Gatepass] word list unavailable: $e');
      return const Left(ApplicationError(code: ApplicationErrorCode.unknown));
    }
  }

  @override
  Future<Either<ApplicationError, List<String>>> parse(String input) async {
    final List<String> known;
    try {
      known = await _wordList();
    } on Object catch (e) {
      debugPrint('[Gatepass] word list unavailable: $e');
      return const Left(ApplicationError(code: ApplicationErrorCode.unknown));
    }
    final words = input
        .toLowerCase()
        .split(RegExp('[^a-z]+'))
        .where((word) => word.isNotEmpty)
        .toList();
    final valid = words.length == length && words.every(known.toSet().contains);
    if (valid) return Right(words);
    return const Left(
      ApplicationError(code: ApplicationErrorCode.phraseInvalid),
    );
  }
}
