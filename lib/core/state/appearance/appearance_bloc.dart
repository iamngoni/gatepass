//
//  Gatepass
//  appearance_bloc.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../configs/appearance.dart';

part 'appearance_bloc.freezed.dart';
part 'appearance_event.dart';
part 'appearance_state.dart';

/// Light, dark or system. Kept for the session only, as before.
@lazySingleton
class AppearanceBloc extends Bloc<AppearanceEvent, AppearanceState> {
  AppearanceBloc() : super(const AppearanceState()) {
    on<AppearanceChangedEvent>(
      (event, emit) => emit(AppearanceState(appearance: event.appearance)),
    );
  }
}
