//
//  Gatepass
//  gatepass_bloc_observer.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

/// Logs every error that escapes a BLoC handler, with its stack. Gatepass
/// has no crash reporting, by design: nothing leaves the phone.
class GatepassBlocObserver extends BlocObserver {
  const GatepassBlocObserver();

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    debugPrint('[Gatepass] ${bloc.runtimeType} failed: $error\n$stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
