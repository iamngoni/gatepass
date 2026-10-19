// Gatepass — estate_heading.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/state/session/session_bloc.dart';
import '../../../core/views/widgets/gp_widgets.dart';

/// The estate's name, with the resident's unit and area beneath.
class EstateHeading extends StatelessWidget {
  const EstateHeading({super.key});

  @override
  Widget build(BuildContext context) {
    final site = context.select(
      (SessionBloc bloc) => bloc.state.signedInAccount?.site,
    );
    if (site == null) return const SizedBox.shrink();
    final detail = [
      site.unit,
      site.area,
    ].where((part) => part.trim().isNotEmpty).join(' · ');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: GpSpace.sm,
        vertical: GpSpace.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            site.name,
            style: context.type.section,
            overflow: TextOverflow.ellipsis,
          ),
          if (detail.isNotEmpty) Text(detail, style: context.type.caption),
        ],
      ),
    );
  }
}
