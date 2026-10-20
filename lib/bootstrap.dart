//
//  Gatepass
//  bootstrap.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

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
