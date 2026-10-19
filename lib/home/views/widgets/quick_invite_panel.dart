// Gatepass — quick_invite_panel.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/invite_drafts.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../../invites/state/invites/invites_bloc.dart';
import '../../../invites/views/pages/invite_form_page.dart';
import '../../../invites/views/widgets/quick_invite_sheet.dart';
import '../../../invites/views/widgets/service_icon.dart';
import 'person_quick_tile.dart';
import 'quick_tile.dart';
import 'quick_tile_label.dart';
import 'quick_tile_row.dart';

/// Delivery services and people from past invites, on the forest brand
/// surface. Tap creates a code straight away; hold opens the full form,
/// prefilled.
class QuickInvitePanel extends StatelessWidget {
  const QuickInvitePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final l10n = context.l10n;
    final state = context.watch<InvitesBloc>().state;

    return Container(
      padding: const EdgeInsets.only(top: GpSpace.xl, bottom: GpSpace.md),
      decoration: BoxDecoration(
        color: GpColors.brand,
        borderRadius: BorderRadius.circular(GpRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GpSpace.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.homeLetSomeoneIn,
                  style: type.title.copyWith(color: GpColors.onBrand),
                ),
                const SizedBox(height: GpSpace.xs),
                Text(
                  l10n.homeLetSomeoneInBody,
                  style: type.small.copyWith(color: GpColors.onBrandMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: GpSpace.xl),
          QuickTileLabel(l10n.homeDeliveriesAndRides),
          QuickTileRow(
            children: [
              for (final s in state.servicesByUse)
                QuickTile(
                  label: s.shortName,
                  semantics: l10n.homeCreateCodeFor(s.name),
                  onTap: () =>
                      quickInvite(context, serviceDraft(s, DateTime.now())),
                  onLongPress: () => openInviteForm(
                    context,
                    initial: serviceDraft(s, DateTime.now()),
                  ),
                  child: ServiceIcon(service: s, size: 54),
                ),
            ],
          ),
          const SizedBox(height: GpSpace.sm),
          QuickTileLabel(l10n.homePeopleInvited),
          QuickTileRow(
            children: [
              QuickTile(
                label: l10n.homeSomeoneNew,
                semantics: l10n.homeInviteSomeoneNew,
                outlined: true,
                onTap: () => openInviteForm(context),
                child: const Icon(
                  GpIcons.add,
                  color: GpColors.onBrand,
                  size: 22,
                ),
              ),
              for (final last in state.recentPeople)
                PersonQuickTile(
                  last: last,
                  live: state.liveInviteFor(last.visitorName),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
