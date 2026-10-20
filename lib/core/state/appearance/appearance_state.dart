//
//  Gatepass
//  appearance_state.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

part of 'appearance_bloc.dart';

@freezed
abstract class AppearanceState with _$AppearanceState {
  const factory AppearanceState({
    @Default(Appearance.system) Appearance appearance,
  }) = _AppearanceState;
}
