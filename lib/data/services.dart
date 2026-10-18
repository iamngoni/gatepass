import 'package:flutter/foundation.dart';

enum ServiceKind { ride, food, groceries, parcel }

/// A delivery or ride service residents let in often. One tap on Home
/// creates a single-entry code that lasts [window].
@immutable
class DeliveryService {
  const DeliveryService(this.id, this.name, this.kind, this.window);

  final String id;
  final String name;
  final ServiceKind kind;
  final Duration window;
}

const deliveryServices = [
  DeliveryService('uber', 'Uber', ServiceKind.ride, Duration(minutes: 45)),
  DeliveryService('bolt', 'Bolt', ServiceKind.ride, Duration(minutes: 45)),
  DeliveryService(
    'uber-eats',
    'Uber Eats',
    ServiceKind.food,
    Duration(hours: 1),
  ),
  DeliveryService('mr-d', 'Mr D', ServiceKind.food, Duration(hours: 1)),
  DeliveryService(
    'sixty60',
    'Checkers Sixty60',
    ServiceKind.groceries,
    Duration(hours: 1),
  ),
  DeliveryService(
    'pnp-asap',
    'PnP asap!',
    ServiceKind.groceries,
    Duration(hours: 1),
  ),
  DeliveryService(
    'woolies-dash',
    'Woolies Dash',
    ServiceKind.groceries,
    Duration(hours: 1),
  ),
  DeliveryService(
    'takealot',
    'Takealot',
    ServiceKind.parcel,
    Duration(hours: 4),
  ),
  DeliveryService('courier', 'Courier', ServiceKind.parcel, Duration(hours: 4)),
];

DeliveryService? serviceById(String? id) =>
    deliveryServices.where((s) => s.id == id).firstOrNull;
