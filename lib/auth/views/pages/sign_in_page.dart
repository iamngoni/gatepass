// Gatepass — sign_in_page.dart. Created 2026-10-19.
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../../injection.dart';
import '../../models/data/otp_channel.dart';
import '../../state/session/session_bloc.dart';
import '../../state/sign_in/sign_in_bloc.dart';
import '../widgets/sign_in_actions.dart';
import '../widgets/sign_in_brand.dart';
import '../widgets/sign_in_code_step.dart';

/// Sign in with the mobile number the estate has on file and a code ATG
/// sends by SMS or WhatsApp.
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final bloc = getIt<SignInBloc>();
  final phone = TextEditingController();
  final code = TextEditingController();

  String get fullPhone => '+27 ${phone.text.trim()}';

  @override
  void initState() {
    super.initState();
    code.addListener(() {
      if (code.text.length == 6 && !bloc.state.busy) verify();
    });
  }

  @override
  void dispose() {
    phone.dispose();
    code.dispose();
    bloc.close();
    super.dispose();
  }

  void send(OtpChannel channel) => bloc.add(
    SignInEvent.codeRequested(phone: fullPhone, channel: channel),
  );

  void verify() {
    if (code.text.length != 6) return;
    HapticFeedback.lightImpact();
    bloc.add(SignInEvent.codeSubmitted(phone: fullPhone, code: code.text));
  }

  void changeNumber() {
    code.clear();
    bloc.add(const SignInEvent.numberChangeRequested());
  }

  void resend(OtpChannel channel) {
    code.clear();
    send(channel);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final l10n = context.l10n;
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<SignInBloc, SignInState>(
        listenWhen: (previous, current) =>
            previous.errorRevision != current.errorRevision ||
            previous.account != current.account,
        listener: (context, state) {
          final account = state.account;
          if (account != null) {
            context.read<SessionBloc>().add(
              SessionEvent.signedIn(account: account),
            );
            return;
          }
          final error = state.error;
          if (error != null) Toast.show(context, error.describe(l10n));
        },
        builder: (context, state) => GpScreen(
          avoidKeyboard: true,
          bottomBar: SignInActions(
            phone: phone,
            code: code,
            onSend: send,
            onVerify: verify,
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
            children: [
              const SizedBox(height: GpSpace.xxl),
              const SignInBrand(),
              SizedBox(height: MediaQuery.sizeOf(context).height * .14),
              Text(
                state.codeSent
                    ? state.channel == OtpChannel.whatsapp
                          ? l10n.signInCheckWhatsapp
                          : l10n.signInCheckMessages
                    : l10n.signInTitle,
                style: type.display,
              ),
              const SizedBox(height: GpSpace.sm),
              Text(
                state.codeSent
                    // Non-breaking, so the number never wraps mid-way.
                    ? l10n.signInEnterCode(fullPhone.replaceAll(' ', '\u00a0'))
                    : l10n.signInLead,
                style: type.lead.copyWith(color: colors.inkMuted),
              ),
              const SizedBox(height: GpSpace.xxl),
              if (!state.codeSent)
                GpField(
                  // Separate keys, so the code field gets fresh state and its
                  // autofocus runs instead of reusing the phone field's.
                  key: const ValueKey('phone'),
                  controller: phone,
                  label: l10n.signInMobileNumber,
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.telephoneNumberNational],
                  prefix: Text(
                    '+27',
                    style: type.lead.copyWith(color: colors.inkFaint),
                  ),
                )
              else
                SignInCodeStep(
                  code: code,
                  onChangeNumber: changeNumber,
                  onResend: resend,
                ),
              const SizedBox(height: GpSpace.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
