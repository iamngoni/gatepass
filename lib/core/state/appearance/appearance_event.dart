// Gatepass — appearance_event.dart. Created 2026-10-19.
part of 'appearance_bloc.dart';

@freezed
sealed class AppearanceEvent with _$AppearanceEvent {
  const factory AppearanceEvent.changed({required Appearance appearance}) =
      AppearanceChangedEvent;
}
