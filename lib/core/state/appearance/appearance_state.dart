// Gatepass — appearance_state.dart. Created 2026-10-19.
part of 'appearance_bloc.dart';

@freezed
abstract class AppearanceState with _$AppearanceState {
  const factory AppearanceState({
    @Default(Appearance.system) Appearance appearance,
  }) = _AppearanceState;
}
