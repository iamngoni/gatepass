//
//  Gatepass
//  appearance_event.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

part of 'appearance_bloc.dart';

@freezed
sealed class AppearanceEvent with _$AppearanceEvent {
  const factory AppearanceEvent.changed({required Appearance appearance}) =
      AppearanceChangedEvent;
}
