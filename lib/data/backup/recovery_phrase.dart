// The 12-word recovery phrase that the backup key is derived from. Words come
// from the BIP39 English list (assets/backup/bip39-english.txt), picked with
// a secure random source: 12 of 2048 is 132 bits.
import 'dart:math';

import 'package:flutter/services.dart';

const recoveryPhraseLength = 12;

List<String>? _words;

Future<List<String>> recoveryWords() async =>
    _words ??= (await rootBundle.loadString('assets/backup/bip39-english.txt'))
        .split('\n')
        .map((w) => w.trim())
        .where((w) => w.isNotEmpty)
        .toList(growable: false);

Future<List<String>> newRecoveryPhrase() async {
  final words = await recoveryWords();
  final random = Random.secure();
  return [
    for (var i = 0; i < recoveryPhraseLength; i++)
      words[random.nextInt(words.length)],
  ];
}

/// Lowercased words in order, or null when it isn't 12 known words.
Future<List<String>?> parseRecoveryPhrase(String input) async {
  final known = (await recoveryWords()).toSet();
  final words = input
      .toLowerCase()
      .split(RegExp(r'[^a-z]+'))
      .where((w) => w.isNotEmpty)
      .toList();
  if (words.length != recoveryPhraseLength) return null;
  return words.every(known.contains) ? words : null;
}
