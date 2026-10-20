//
//  Gatepass
//  gp_motion.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/animation.dart';

abstract final class GpMotion {
  static const fast = Duration(milliseconds: 120);
  static const base = Duration(milliseconds: 180);
  static const slow = Duration(milliseconds: 260);
  static const curve = Curves.easeOut;
  static const curveInOut = Curves.easeInOut;

  /// Something new arriving on screen.
  static const rise = Duration(milliseconds: 350);
  static const riseCurve = Cubic(.2, .8, .2, 1);
}
