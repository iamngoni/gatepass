// Gatepass — appearance_bloc.dart. Created 2026-10-19.
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
