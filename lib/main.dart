//
//  Gatepass
//  main.dart
//
//  Created by Ngonidzashe Mangudya on 18/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import 'bootstrap.dart';

/// Live only: the app talks to the real At The Gate backend with the
/// signed-in resident's own account. See `core/configs/atg_config.dart`.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
}
