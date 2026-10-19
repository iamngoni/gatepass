// Gatepass — resident.dart. Created 2026-10-18.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resident.freezed.dart';

/// The signed-in resident. [id] is the estate account uid ATG's visitor
/// endpoints use, which is not the Firebase login uid.
@freezed
abstract class Resident with _$Resident {
  const factory Resident({
    required String id,
    required String name,
    required String phone,
    required String email,
  }) = _Resident;

  const Resident._();

  String get firstName => name.split(' ').first;
}
