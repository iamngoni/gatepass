// Gatepass — notification_group.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/app_notification.dart';
import 'notification_tile.dart';

class NotificationGroup extends StatelessWidget {
  const NotificationGroup({required this.items, super.key});

  final List<AppNotification> items;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
    child: GpGroup(
      inset: 68,
      children: [
        for (final n in items) NotificationTile(notification: n),
      ],
    ),
  );
}
