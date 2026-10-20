//
//  Gatepass
//  phrase_grid.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';

/// The 12 recovery words in two numbered columns.
class PhraseGrid extends StatelessWidget {
  const PhraseGrid({required this.words, super.key});

  final List<String> words;

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final colors = context.colors;
    return GpSurface(
      child: Column(
        children: [
          for (var row = 0; row < words.length / 2; row++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: GpSpace.xs),
              child: Row(
                children: [
                  for (final i in [row, row + words.length ~/ 2])
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 28,
                            child: Text(
                              '${i + 1}',
                              style: type.small.copyWith(
                                color: colors.inkMuted,
                              ),
                            ),
                          ),
                          Text(words[i], style: type.bodyStrong),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
