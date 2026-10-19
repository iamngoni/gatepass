// Gatepass — sign_in_actions.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/otp_channel.dart';
import '../../state/sign_in/sign_in_bloc.dart';

/// The bottom bar: send the code by SMS or WhatsApp, then sign in.
class SignInActions extends StatelessWidget {
  const SignInActions({
    required this.phone,
    required this.code,
    required this.onSend,
    required this.onVerify,
    super.key,
  });

  final TextEditingController phone;
  final TextEditingController code;
  final ValueChanged<OtpChannel> onSend;
  final VoidCallback onVerify;

  @override
  Widget build(BuildContext context) {
    final type = context.type;
    final l10n = context.l10n;
    final state = context.watch<SignInBloc>().state;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        GpSpace.gutter,
        0,
        GpSpace.gutter,
        GpSpace.lg,
      ),
      child: SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: Listenable.merge([phone, code]),
          builder: (context, _) {
            final canSend =
                phone.text.replaceAll(' ', '').length >= 9 && !state.busy;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.codeSent) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: GpSpace.md),
                    child: Text(
                      l10n.signInCodeSentBy(state.channel.label(l10n)),
                      style: type.caption,
                    ),
                  ),
                  GpButton(
                    label: l10n.signInSubmit,
                    size: GpButtonSize.large,
                    loading: state.verifying,
                    onPressed: code.text.length == 6 ? onVerify : null,
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: GpSpace.md),
                    child: Text(l10n.signInSendBy, style: type.caption),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GpButton(
                          label: l10n.otpChannelSms,
                          icon: GpIcons.sms,
                          variant: GpButtonVariant.secondary,
                          size: GpButtonSize.large,
                          loading: state.sending == OtpChannel.sms,
                          onPressed: canSend
                              ? () => onSend(OtpChannel.sms)
                              : null,
                        ),
                      ),
                      const SizedBox(width: GpSpace.sm),
                      Expanded(
                        child: GpButton(
                          label: l10n.otpChannelWhatsapp,
                          icon: GpIcons.chat,
                          size: GpButtonSize.large,
                          loading: state.sending == OtpChannel.whatsapp,
                          onPressed: canSend
                              ? () => onSend(OtpChannel.whatsapp)
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
