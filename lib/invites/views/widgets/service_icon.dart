//
//  Gatepass
//  service_icon.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../models/data/delivery_service.dart';

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
