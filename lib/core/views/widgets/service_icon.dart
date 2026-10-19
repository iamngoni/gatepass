// Gatepass — service_icon.dart. Created 2026-10-18.
import 'package:flutter/widgets.dart';

import '../../../data/services.dart';

/// The real app icon for a delivery or ride service.
class ServiceIcon extends StatelessWidget {
  const ServiceIcon({required this.service, this.size = 48, super.key});

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
