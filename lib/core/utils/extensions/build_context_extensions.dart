//
//  Gatepass
//  build_context_extensions.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../configs/gp_colors.dart';
import '../../configs/gp_theme_data.dart';
import '../../configs/gp_type.dart';
import '../../views/widgets/gp_theme.dart';

extension GpThemeContext on BuildContext {
  GpThemeData get gp => GpTheme.of(this);
  GpColors get colors => GpTheme.of(this).colors;
  GpType get type =>
      GpType(GpTheme.of(this).colors, boldText: MediaQuery.boldTextOf(this));
}
