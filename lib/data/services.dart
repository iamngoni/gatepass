import 'package:flutter/foundation.dart';

enum ServiceKind { ride, food, groceries, parcel }

/// A delivery or ride app residents let in often. One tap on Home creates a
/// single-entry code that lasts [window].
@immutable
class DeliveryService {
  const DeliveryService(
    this.id,
    this.name,
    this.kind,
    this.window,
    this.iconAsset,
  );

  final String id;
  final String name;
  final ServiceKind kind;
  final Duration window;
  final String iconAsset;
}

const deliveryServices = [
  DeliveryService(
    'uber',
    'Uber',
    ServiceKind.ride,
    Duration(minutes: 45),
    'assets/icons/services/uber.jpg',
  ),
  DeliveryService(
    'bolt',
    'Bolt',
    ServiceKind.ride,
    Duration(minutes: 45),
    'assets/icons/services/bolt.jpg',
  ),
  DeliveryService(
    'uber-eats',
    'Uber Eats',
    ServiceKind.food,
    Duration(hours: 1),
    'assets/icons/services/uber-eats.jpg',
  ),
  DeliveryService(
    'mr-d',
    'Mr D',
    ServiceKind.food,
    Duration(hours: 1),
    'assets/icons/services/mr-d.jpg',
  ),
  DeliveryService(
    'sixty60',
    'Checkers Sixty60',
    ServiceKind.groceries,
    Duration(hours: 1),
    'assets/icons/services/sixty60.jpg',
  ),
  DeliveryService(
    'pnp-asap',
    'Pick n Pay asap!',
    ServiceKind.groceries,
    Duration(hours: 1),
    'assets/icons/services/pnp-asap.jpg',
  ),
  DeliveryService(
    'woolies-dash',
    'Woolies Dash',
    ServiceKind.groceries,
    Duration(hours: 1),
    'assets/icons/services/woolies-dash.jpg',
  ),
  DeliveryService(
    'takealot',
    'Takealot',
    ServiceKind.parcel,
    Duration(hours: 4),
    'assets/icons/services/takealot.jpg',
  ),
  DeliveryService(
    'courier-guy',
    'Courier Guy',
    ServiceKind.parcel,
    Duration(hours: 4),
    'assets/icons/services/courier-guy.jpg',
  ),
];

DeliveryService? serviceById(String? id) =>
    deliveryServices.where((s) => s.id == id).firstOrNull;

/// Matches a stored visitor name to a known service app. ATG stores the name
/// and surname separately, so this is checked after they are joined.
String? serviceIdForName(String name) {
  final wanted = name.trim().toLowerCase();
  for (final service in deliveryServices) {
    if (service.name.toLowerCase() == wanted) return service.id;
  }
  return null;
}
