//
//  Gatepass
//  sign_in_code_step.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/otp_channel.dart';
import '../../state/sign_in/sign_in_bloc.dart';

/// The code field, with changing the number and resending.
class SignInCodeStep extends StatelessWidget {
  const SignInCodeStep({
    required this.code,
    required this.onChangeNumber,
    required this.onResend,
    super.key,
  });

  final TextEditingController code;
  final VoidCallback onChangeNumber;
  final ValueChanged<OtpChannel> onResend;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<SignInBloc>().state;
    final busy = state.busy;
    final other = state.channel == OtpChannel.sms
        ? OtpChannel.whatsapp
        : OtpChannel.sms;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GpField(
          key: const ValueKey('code'),
          controller: code,
          autofocus: true,
          enabled: !busy,
          keyboardType: TextInputType.number,
          autofillHints: const [AutofillHints.oneTimeCode],
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          textAlign: TextAlign.center,
          hint: '••••••',
          style: context.type.code.copyWith(letterSpacing: 14),
        ),
        const SizedBox(height: GpSpace.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GpButton(
              label: l10n.signInChangeNumber,
              variant: GpButtonVariant.text,
              size: GpButtonSize.compact,
              expand: false,
              onPressed: busy ? null : onChangeNumber,
            ),
            GpButton(
              label: l10n.signInResendCode,
              variant: GpButtonVariant.text,
              size: GpButtonSize.compact,
              expand: false,
              onPressed: busy ? null : () => onResend(state.channel),
            ),
          ],
        ),
        Center(
          child: GpButton(
            label: l10n.signInSendInstead(other.label(l10n)),
            variant: GpButtonVariant.text,
            size: GpButtonSize.compact,
            expand: false,
            onPressed: busy ? null : () => onResend(other),
          ),
        ),
      ],
    );
  }
}
