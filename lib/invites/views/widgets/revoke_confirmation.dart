//
//  Gatepass
//  revoke_confirmation.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/extensions/invites_bloc_extensions.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/invite.dart';
import '../../state/invites/invites_bloc.dart';

/// Asks first, then revokes. Returns whether the invite was revoked.
Future<bool> confirmRevoke(BuildContext context, Invite invite) async {
  final l10n = context.l10n;
  final ok = await showGpConfirm(
    context,
    title: invite.isService
        ? l10n.revokeServiceTitle(invite.displayName)
        : l10n.revokePersonTitle(invite.firstName),
    body: l10n.revokeBody,
    confirmLabel: l10n.commonRevoke,
    cancelLabel: l10n.revokeKeep,
    danger: true,
  );
  if (!ok || !context.mounted) return false;
  final result = await context.read<InvitesBloc>().revoke(invite.id);
  return result.fold((error) {
    if (context.mounted) Toast.show(context, error.describe(l10n));
    return false;
  }, (_) => true);
}
