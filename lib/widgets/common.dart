import 'package:flutter/widgets.dart';

import '../data/models.dart';
import '../data/services.dart';
import '../ui/ui.dart';
import '../util/format.dart';

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.label, required this.tone});

  final String label;
  final Tone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.toneSoft(tone),
        borderRadius: BorderRadius.circular(GpRadius.pill),
      ),
      child: Text(
        label,
        maxLines: 1,
        style: context.type.chip.copyWith(color: colors.tone(tone)),
      ),
    );
  }
}

class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.name,
    this.size = GpSizes.avatar,
    this.tone = Tone.neutral,
  });

  final String name;
  final double size;
  final Tone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.toneSoft(tone),
        shape: BoxShape.circle,
      ),
      child: Text(
        initials(name),
        style: context.type.bodyStrong.copyWith(
          color: tone == Tone.neutral ? colors.ink : colors.tone(tone),
          fontSize: size * .34,
          height: 1,
        ),
      ),
    );
  }
}

/// An icon in a soft tinted circle.
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    this.tone = Tone.neutral,
    this.size = GpSizes.avatar,
  });

  final IconData icon;
  final Tone tone;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.toneSoft(tone),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: size * .44,
        color: tone == Tone.neutral ? colors.ink : colors.tone(tone),
      ),
    );
  }
}

/// Label and value on one line, for detail cards.
class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: GpSpace.lg,
        vertical: GpSpace.md + 2,
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colors.inkFaint),
          const SizedBox(width: GpSpace.md),
          Text(
            label,
            style: context.type.body.copyWith(color: colors.inkMuted),
          ),
          const SizedBox(width: GpSpace.lg),
          Expanded(
            child: Text(
              value,
              style: context.type.bodyStrong,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

extension InviteStatusUi on InviteStatus {
  String get label => switch (this) {
    InviteStatus.active => 'Active',
    InviteStatus.expired => 'Expired',
    InviteStatus.revoked => 'Revoked',
  };

  Tone get tone => switch (this) {
    InviteStatus.active => Tone.info,
    InviteStatus.revoked => Tone.danger,
    InviteStatus.expired => Tone.neutral,
  };
}

/// The real app icon for a delivery or ride service.
class ServiceIcon extends StatelessWidget {
  const ServiceIcon({super.key, required this.service, this.size = 48});

  final DeliveryService service;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: service.name,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * .24),
        child: Image.asset(
          service.iconAsset,
          width: size,
          height: size,
          fit: BoxFit.cover,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}

/// Service mark for delivery and ride invites, initials for people.
class InviteAvatar extends StatelessWidget {
  const InviteAvatar({
    super.key,
    required this.invite,
    this.size = GpSizes.avatar,
  });

  final Invite invite;
  final double size;

  @override
  Widget build(BuildContext context) {
    final service = serviceById(invite.serviceId);
    if (service != null) {
      return ServiceIcon(service: service, size: size);
    }
    return InitialsAvatar(
      name: invite.visitorName,
      size: size,
      tone: invite.status.isLive ? Tone.accent : Tone.neutral,
    );
  }
}
