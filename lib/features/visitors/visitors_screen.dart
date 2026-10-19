import 'package:flutter/widgets.dart';

import '../../data/models.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/tiles.dart';
import 'invite_actions.dart';
import 'invite_form_screen.dart';

enum _Filter { upcoming, past }

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
      _Filter.past => state.past,
    };
    final groups = _group(list, active: _filter == _Filter.upcoming);

    return GpScreen(
      child: GpRefresh(
        onRefresh: () => refreshInvites(context),
        child: ListView(
          physics: GpRefresh.physics,
          padding: EdgeInsets.only(bottom: scrollEnd(context)),
          children: [
            const PageTitle('Visitors'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
              child: GpSegmented(
                segments: ['Active · ${state.upcoming.length}', 'Past'],
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
    _Filter.past => const EmptyPanel(
      icon: GpIcons.history,
      title: 'No past visits',
      body: 'Expired and revoked invites end up here.',
    ),
  };

  /// Active invites lead with the ones that work right now; an open-ended
  /// code belongs there whatever day it was made. Past ones go by day.
  List<(String, List<Invite>)> _group(
    List<Invite> invites, {
    required bool active,
  }) {
    final now = DateTime.now();
    String label(Invite i) {
      if (!active) return dayLabel(i.from);
      if (i.openEnded || !i.from.isAfter(now)) return 'Valid now';
      return isToday(i.from) ? 'Later today' : dayLabel(i.from);
    }

    final ordered = active
        ? [
            ...invites.where((i) => label(i) == 'Valid now'),
            ...invites.where((i) => label(i) != 'Valid now'),
          ]
        : invites;
    final groups = <(String, List<Invite>)>[];
    for (final invite in ordered) {
      final name = label(invite);
      if (groups.isEmpty || groups.last.$1 != name) {
        groups.add((name, [invite]));
      } else {
        groups.last.$2.add(invite);
      }
    }
    return groups;
  }
}
