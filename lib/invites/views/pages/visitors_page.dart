//
//  Gatepass
//  visitors_page.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/date_helpers.dart';
import '../../../core/utils/gp_format.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/invite.dart';
import '../../state/invites/invites_bloc.dart';
import '../widgets/gate_refresh.dart';
import '../widgets/invite_tile.dart';
import '../widgets/visitors_empty.dart';
import 'invite_form_page.dart';

/// Active and past invites, grouped by when they're valid.
class VisitorsPage extends StatefulWidget {
  const VisitorsPage({super.key});

  @override
  State<VisitorsPage> createState() => _VisitorsPageState();
}

class _VisitorsPageState extends State<VisitorsPage> {
  /// Showing past invites rather than active ones.
  final past = ValueNotifier(false);

  @override
  void dispose() {
    past.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<InvitesBloc>().state;
    return ValueListenableBuilder<bool>(
      valueListenable: past,
      builder: (context, showPast, _) {
        final list = showPast ? state.past : state.upcoming;
        final groups = group(context.format, list, active: !showPast);
        return GpScreen(
          child: GpRefresh(
            onRefresh: () => refreshGate(context),
            child: ListView(
              physics: GpRefresh.physics,
              padding: EdgeInsets.only(bottom: scrollEnd(context)),
              children: [
                PageTitle(l10n.visitorsTitle),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: GpSpace.gutter,
                  ),
                  child: GpSegmented(
                    segments: [
                      l10n.visitorsActive(state.upcoming.length),
                      l10n.visitorsPast,
                    ],
                    selectedIndex: showPast ? 1 : 0,
                    onChanged: (i) => past.value = i == 1,
                  ),
                ),
                if (list.isNotEmpty && !showPast)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      GpSpace.gutter,
                      GpSpace.md,
                      GpSpace.gutter,
                      0,
                    ),
                    child: Text(
                      l10n.visitorsSwipeHint,
                      style: context.type.caption.copyWith(
                        color: context.colors.inkFaint,
                      ),
                    ),
                  ),
                if (list.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: GpSpace.xxl),
                    child: VisitorsEmpty(
                      past: showPast,
                      onInvite: () => openInviteForm(context),
                    ),
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
      },
    );
  }

  /// Active invites lead with the ones that work right now; an open-ended
  /// code belongs there whatever day it was made. Past ones go by day.
  List<(String, List<Invite>)> group(
    GpFormat format,
    List<Invite> invites, {
    required bool active,
  }) {
    final now = DateTime.now();
    final l10n = format.l10n;
    String label(Invite i) {
      if (!active) return format.day(i.from);
      if (i.openEnded || !i.from.isAfter(now)) return l10n.visitorsValidNow;
      return isToday(i.from) ? l10n.visitorsLaterToday : format.day(i.from);
    }

    final validNow = l10n.visitorsValidNow;
    final ordered = active
        ? [
            ...invites.where((i) => label(i) == validNow),
            ...invites.where((i) => label(i) != validNow),
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
