import 'package:flutter/widgets.dart';

import '../../data/models.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/tiles.dart';
import 'invite_form_screen.dart';

enum _Filter { upcoming, onSite, past }

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  _Filter _filter = _Filter.upcoming;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final list = switch (_filter) {
      _Filter.upcoming => state.upcoming,
      _Filter.onSite => state.onSite,
      _Filter.past => state.past,
    };
    final groups = _filter == _Filter.onSite
        ? [('On site now', list)]
        : _groupByDay(list);

    return GpScreen(
      child: ListView(
        padding: EdgeInsets.only(bottom: scrollEnd(context)),
        children: [
          const PageTitle('Visitors'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
            child: GpSegmented(
              segments: [
                'Upcoming · ${state.upcoming.length}',
                'On site · ${state.onSite.length}',
                'Past',
              ],
              selectedIndex: _filter.index,
              onChanged: (i) => setState(() => _filter = _Filter.values[i]),
            ),
          ),
          if (list.isNotEmpty && _filter != _Filter.past)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                GpSpace.gutter,
                GpSpace.md,
                GpSpace.gutter,
                0,
              ),
              child: Text(
                'Swipe an invite left to revoke it.',
                style: context.type.caption.copyWith(
                  color: context.colors.inkFaint,
                ),
              ),
            ),
          if (list.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: GpSpace.xxl),
              child: _empty(context),
            )
          else
            for (final (label, invites) in groups) ...[
              GroupLabel(label),
              TileGroup(
                children: [
                  for (final i in invites)
                    InviteTile(invite: i, revocable: true),
                ],
              ),
            ],
        ],
      ),
    );
  }

  Widget _empty(BuildContext context) => switch (_filter) {
    _Filter.upcoming => EmptyPanel(
      icon: GpIcons.calendarCheck,
      title: 'No visitors coming',
      body: 'Invite someone and they’ll get a link to use at the gate.',
      action: 'Invite a visitor',
      onAction: () => openInviteForm(context),
    ),
    _Filter.onSite => const EmptyPanel(
      icon: GpIcons.visitors,
      title: 'No one on site',
      body: 'Visitors show up here when they come through the gate.',
    ),
    _Filter.past => const EmptyPanel(
      icon: GpIcons.activity,
      title: 'No past visits',
      body: 'Finished, expired and revoked invites end up here.',
    ),
  };

  List<(String, List<Invite>)> _groupByDay(List<Invite> invites) {
    final groups = <(String, List<Invite>)>[];
    for (final invite in invites) {
      final label = dayLabel(invite.from);
      if (groups.isEmpty || groups.last.$1 != label) {
        groups.add((label, [invite]));
      } else {
        groups.last.$2.add(invite);
      }
    }
    return groups;
  }
}
