import 'package:flutter/widgets.dart';

import '../../data/models.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/tiles.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  EntrySubject? _subject;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final entries = state.entries
        .where((e) => _subject == null || e.subject == _subject)
        .toList();

    final groups = <(String, List<EntryEvent>)>[];
    for (final e in entries) {
      final label = dayLabel(e.time);
      if (groups.isEmpty || groups.last.$1 != label) {
        groups.add((label, [e]));
      } else {
        groups.last.$2.add(e);
      }
    }

    return GpScreen(
      child: ListView(
        padding: EdgeInsets.only(bottom: scrollEnd(context)),
        children: [
          const PageTitle('Activity'),
          SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
              children: [
                GpPill(
                  label: 'All',
                  selected: _subject == null,
                  onPressed: () => setState(() => _subject = null),
                ),
                for (final s in EntrySubject.values) ...[
                  const SizedBox(width: GpSpace.sm),
                  GpPill(
                    label: s.label,
                    selected: _subject == s,
                    onPressed: () => setState(() => _subject = s),
                  ),
                ],
              ],
            ),
          ),
          if (entries.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: GpSpace.xxl),
              child: EmptyPanel(
                icon: GpIcons.activity,
                title: 'Nothing here yet',
                body:
                    'Every time someone uses the gate for you, it shows up '
                    'here with a photo.',
              ),
            )
          else
            for (final (label, list) in groups) ...[
              GroupLabel(label),
              TileGroup(children: [for (final e in list) EntryTile(entry: e)]),
            ],
        ],
      ),
    );
  }
}
