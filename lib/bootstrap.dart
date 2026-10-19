// Gatepass — bootstrap.dart. Created 2026-10-19.
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'core/services/gatepass_bloc_observer.dart';
import 'injection.dart';
import 'providers.dart';

Future<void> bootstrap() async {
  Bloc.observer = const GatepassBlocObserver();
  configureDependencies();
  runApp(const GatepassProviders());
}
