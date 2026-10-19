// Gatepass — delivery_services.dart. Created 2026-10-18.
import 'package:collection/collection.dart';

import 'delivery_service.dart';
import 'service_kind.dart';

/// Every quick invite Home offers, in catalogue order. Icons are each app's
/// App Store artwork (see assets/icons/services/SOURCES.md).
const deliveryServices = [
  DeliveryService(
    id: 'uber',
    name: 'Uber',
    kind: ServiceKind.ride,
    window: Duration(minutes: 45),
    iconAsset: 'assets/icons/services/uber.jpg',
  ),
  DeliveryService(
    id: 'bolt',
    name: 'Bolt',
    kind: ServiceKind.ride,
    window: Duration(minutes: 45),
    iconAsset: 'assets/icons/services/bolt.jpg',
  ),
  DeliveryService(
    id: 'indrive',
    name: 'inDrive',
    kind: ServiceKind.ride,
    window: Duration(minutes: 45),
    iconAsset: 'assets/icons/services/indrive.jpg',
  ),
  DeliveryService(
    id: 'uber-eats',
    name: 'Uber Eats',
    kind: ServiceKind.food,
    window: Duration(hours: 1),
    iconAsset: 'assets/icons/services/uber-eats.jpg',
  ),
  DeliveryService(
    id: 'mr-d',
    name: 'Mr D',
    kind: ServiceKind.food,
    window: Duration(hours: 1),
    iconAsset: 'assets/icons/services/mr-d.jpg',
  ),
  DeliveryService(
    id: 'kfc',
    name: 'KFC',
    kind: ServiceKind.food,
    window: Duration(hours: 1),
    iconAsset: 'assets/icons/services/kfc.jpg',
  ),
  DeliveryService(
    id: 'debonairs',
    name: 'Debonairs Pizza',
    kind: ServiceKind.food,
    window: Duration(hours: 1),
    iconAsset: 'assets/icons/services/debonairs.jpg',
    tileName: 'Debonairs',
  ),
  DeliveryService(
    id: 'sixty60',
    name: 'Checkers Sixty60',
    kind: ServiceKind.groceries,
    window: Duration(hours: 1),
    iconAsset: 'assets/icons/services/sixty60.jpg',
    tileName: 'Sixty60',
  ),
  DeliveryService(
    id: 'pnp-asap',
    name: 'Pick n Pay asap!',
    kind: ServiceKind.groceries,
    window: Duration(hours: 1),
    iconAsset: 'assets/icons/services/pnp-asap.jpg',
    tileName: 'PnP asap!',
  ),
  DeliveryService(
    id: 'woolies-dash',
    name: 'Woolies Dash',
    kind: ServiceKind.groceries,
    window: Duration(hours: 1),
    iconAsset: 'assets/icons/services/woolies-dash.jpg',
    tileName: 'Woolies',
  ),
  DeliveryService(
    id: 'zulzi',
    name: 'Zulzi',
    kind: ServiceKind.groceries,
    window: Duration(hours: 1),
    iconAsset: 'assets/icons/services/zulzi.jpg',
  ),
  DeliveryService(
    id: 'clicks',
    name: 'Clicks',
    kind: ServiceKind.groceries,
    window: Duration(hours: 2),
    iconAsset: 'assets/icons/services/clicks.jpg',
  ),
  DeliveryService(
    id: 'dis-chem',
    name: 'Dis-Chem',
    kind: ServiceKind.groceries,
    window: Duration(hours: 2),
    iconAsset: 'assets/icons/services/dischem.jpg',
  ),
  DeliveryService(
    id: 'amazon',
    name: 'Amazon',
    kind: ServiceKind.parcel,
    window: Duration(hours: 4),
    iconAsset: 'assets/icons/services/amazon.jpg',
  ),
  DeliveryService(
    id: 'takealot',
    name: 'Takealot',
    kind: ServiceKind.parcel,
    window: Duration(hours: 4),
    iconAsset: 'assets/icons/services/takealot.jpg',
  ),
  DeliveryService(
    id: 'makro',
    name: 'Makro',
    kind: ServiceKind.parcel,
    window: Duration(hours: 4),
    iconAsset: 'assets/icons/services/makro.jpg',
  ),
  DeliveryService(
    id: 'shein',
    name: 'SHEIN',
    kind: ServiceKind.parcel,
    window: Duration(hours: 4),
    iconAsset: 'assets/icons/services/shein.jpg',
  ),
  DeliveryService(
    id: 'temu',
    name: 'Temu',
    kind: ServiceKind.parcel,
    window: Duration(hours: 4),
    iconAsset: 'assets/icons/services/temu.jpg',
  ),
  DeliveryService(
    id: 'superbalist',
    name: 'Superbalist',
    kind: ServiceKind.parcel,
    window: Duration(hours: 4),
    iconAsset: 'assets/icons/services/superbalist.jpg',
  ),
  DeliveryService(
    id: 'courier-guy',
    name: 'Courier Guy',
    kind: ServiceKind.parcel,
    window: Duration(hours: 4),
    iconAsset: 'assets/icons/services/courier-guy.jpg',
  ),
  DeliveryService(
    id: 'dhl',
    name: 'DHL',
    kind: ServiceKind.parcel,
    window: Duration(hours: 4),
    iconAsset: 'assets/icons/services/dhl.jpg',
  ),
  DeliveryService(
    id: 'aramex',
    name: 'Aramex',
    kind: ServiceKind.parcel,
    window: Duration(hours: 4),
    iconAsset: 'assets/icons/services/aramex.jpg',
  ),
];

DeliveryService? serviceById(String? id) =>
    deliveryServices.firstWhereOrNull((s) => s.id == id);

/// Matches a stored visitor name to a known service app. ATG stores the name
/// and surname separately, so this is checked after they are joined.
String? serviceIdForName(String name) {
  final wanted = name.trim().toLowerCase();
  return deliveryServices
      .firstWhereOrNull((s) => s.name.toLowerCase() == wanted)
      ?.id;
}
