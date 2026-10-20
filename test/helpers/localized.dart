//
//  Gatepass
//  localized.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';
import 'package:gatepass/core/utils/gp_format.dart';
import 'package:gatepass/l10n/generated/app_localizations.dart';

final englishL10n = lookupAppLocalizations(const Locale('en'));
final englishFormat = GpFormat(englishL10n);

/// [child] with English strings and left-to-right text, for widgets pumped
/// outside the app.
Widget localized(Widget child) => Localizations(
  locale: const Locale('en'),
  delegates: AppLocalizations.localizationsDelegates,
  child: Directionality(textDirection: TextDirection.ltr, child: child),
);
