//
//  Gatepass
//  gate_refresh.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/extensions/invites_bloc_extensions.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../../notifications/state/notifications/notifications_bloc.dart';
import '../../state/invites/invites_bloc.dart';

/// Pull-to-refresh: reloads invites and notifications, and says so when the
/// network lets it down instead of failing silently.
Future<void> refreshGate(BuildContext context) async {
  final l10n = context.l10n;
  final error = await GateRefresh.run(
    context.read<InvitesBloc>(),
    context.read<NotificationsBloc>(),
  );
  if (error != null && context.mounted) {
    Toast.show(context, error.describe(l10n), tone: ToastTone.error);
  }
}
