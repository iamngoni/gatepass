import 'package:flutter/widgets.dart';

import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import '../../widgets/gate_camera.dart';
import '../../widgets/tiles.dart';

class EntryDetailScreen extends StatelessWidget {
  const EntryDetailScreen({super.key, required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final entry = state.entryById(entryId);
    if (entry == null) {
      return const GpScreen(
        header: GpHeader(),
        child: Center(
          child: EmptyPanel(
            icon: GpIcons.activity,
            title: 'Entry not found',
            body: 'It may belong to another property.',
          ),
        ),
      );
    }
    final colors = context.colors;
    final invite = entry.inviteId == null
        ? null
        : state.inviteById(entry.inviteId!);

    return GpScreen(
      header: const GpHeader(),
      child: ListView(
        padding: EdgeInsets.only(bottom: scrollEnd(context)),
        children: [
          if (entry.hasPhoto)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                GpSpace.gutter,
                GpSpace.sm,
                GpSpace.gutter,
                0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(GpRadius.xl),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: GateCameraSnapshot(
                    seed: entry.id,
                    gateName: entry.gateName,
                    time: entry.time,
                    withVehicle: entry.vehicleReg != null,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              GpSpace.gutter,
              GpSpace.xl,
              GpSpace.gutter,
              0,
            ),
            child: Row(
              children: [
                if (!entry.hasPhoto) ...[
                  IconBadge(
                    icon: entry.isInbound
                        ? GpIcons.arrivals
                        : GpIcons.departures,
                    tone: entry.isInbound ? Tone.accent : Tone.neutral,
                    size: 56,
                  ),
                  const SizedBox(width: GpSpace.lg),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.headline, style: context.type.title),
                      const SizedBox(height: GpSpace.xs),
                      Text(
                        formatFull(entry.time),
                        style: context.type.body.copyWith(
                          color: colors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SectionHeading('Details'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
            child: GpGroup(
              inset: GpSpace.lg,
              children: [
                DetailRow(
                  icon: GpIcons.gate,
                  label: 'Gate',
                  value: entry.gateName,
                ),
                DetailRow(
                  icon: GpIcons.direction,
                  label: 'Direction',
                  value: entry.isInbound ? 'In' : 'Out',
                ),
                DetailRow(
                  icon: GpIcons.scan,
                  label: 'Let through by',
                  value: entry.method.label,
                ),
                if (entry.vehicleReg != null)
                  DetailRow(
                    icon: GpIcons.car,
                    label: 'Vehicle',
                    value: entry.vehicleReg!,
                  ),
              ],
            ),
          ),
          if (invite != null) ...[
            const SectionHeading('Invite'),
            TileGroup(children: [InviteTile(invite: invite)]),
          ],
          Padding(
            padding: const EdgeInsets.fromLTRB(
              GpSpace.gutter,
              GpSpace.xxl,
              GpSpace.gutter,
              0,
            ),
            child: GpButton(
              label: 'Something wrong? Tell security',
              icon: GpIcons.flag,
              variant: GpButtonVariant.secondary,
              onPressed: () => Toast.show(
                context,
                'Sent to estate security. They’ll be in touch.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
