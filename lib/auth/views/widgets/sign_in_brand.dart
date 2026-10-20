//
//  Gatepass
//  sign_in_brand.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/widgets.dart';

import '../../../core/views/widgets/gp_widgets.dart';

/// The Gatepass mark and name at the top of sign-in.
class SignInBrand extends StatelessWidget {
  const SignInBrand({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(GpRadius.md - 2),
        child: Image.asset(
          'assets/brand/gatepass-mark.png',
          width: 44,
          height: 44,
          semanticLabel: context.l10n.appTitle,
        ),
      ),
      const SizedBox(width: GpSpace.md),
      Text(context.l10n.appTitle, style: context.type.title),
    ],
  );
}
