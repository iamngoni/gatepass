// Gatepass — resident_card.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../auth/models/data/resident.dart';
import '../../../core/views/widgets/gp_widgets.dart';

/// The signed-in resident: initials, name, phone and email.
class ResidentCard extends StatelessWidget {
  const ResidentCard({required this.resident, super.key});

  final Resident resident;

  @override
  Widget build(BuildContext context) => GpSurface(
    child: Row(
      children: [
        InitialsAvatar(name: resident.name, size: 56, tone: Tone.accent),
        const SizedBox(width: GpSpace.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(resident.name, style: context.type.cardTitle),
              if (resident.phone.isNotEmpty) ...[
                const SizedBox(height: GpSpace.xxs),
                Text(resident.phone, style: context.type.caption),
              ],
              if (resident.email.isNotEmpty)
                Text(resident.email, style: context.type.caption),
            ],
          ),
        ),
      ],
    ),
  );
}
