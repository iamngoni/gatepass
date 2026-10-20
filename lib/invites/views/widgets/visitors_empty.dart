//
//  Gatepass
//  visitors_empty.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';

/// What Visitors says when a tab has no invites.
class VisitorsEmpty extends StatelessWidget {
  const VisitorsEmpty({required this.past, required this.onInvite, super.key});

  final bool past;
  final VoidCallback onInvite;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (past) {
      return EmptyPanel(
        icon: GpIcons.history,
        title: l10n.visitorsNoPastTitle,
        body: l10n.visitorsNoPastBody,
      );
    }
    return EmptyPanel(
      icon: GpIcons.calendarCheck,
      title: l10n.visitorsNoneTitle,
      body: l10n.visitorsNoneBody,
      action: l10n.visitorsNoneAction,
      onAction: onInvite,
    );
  }
}
