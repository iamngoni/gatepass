// Gatepass — delivery_service.dart. Created 2026-10-18.
import 'package:freezed_annotation/freezed_annotation.dart';

import 'service_kind.dart';

part 'delivery_service.freezed.dart';

/// A delivery or ride app residents let in often. One tap on Home creates a
/// single-entry code that lasts [window].
@freezed
abstract class DeliveryService with _$DeliveryService {
  const factory DeliveryService({
    required String id,
    required String name,
    required ServiceKind kind,
    required Duration window,
    required String iconAsset,

    /// A shorter label for a quick tile, when [name] doesn't fit.
    String? tileName,
  }) = _DeliveryService;

  const DeliveryService._();

  /// What fits under a quick tile on Home.
  String get shortName => tileName ?? name;
}
