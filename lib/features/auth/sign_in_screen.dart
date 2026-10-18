import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../state/app_state.dart';
import '../../ui/ui.dart';

/// A short, user-facing line for a sign-in failure (strips the exception
/// class prefix, so the backend's own message like "Login string too short"
/// shows plainly).
String _authError(Object e) {
  final s = e.toString().replaceFirst(
    RegExp(r'^[A-Za-z]+Exception(\([^)]*\))?:\s*'),
    '',
  );
  return s.isEmpty ? 'Could not sign in. Please try again.' : s;
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _phone = TextEditingController();
  final _code = TextEditingController();
  bool _codeSent = false;
  bool _busy = false;

  String get _fullPhone => '+27 ${_phone.text.trim()}';

  @override
  void initState() {
    super.initState();
    _phone.addListener(() => setState(() {}));
    _code.addListener(() {
      setState(() {});
      if (_code.text.length == 6 && !_busy) _verify();
    });
  }

  @override
  void dispose() {
    _phone.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    setState(() => _busy = true);
    try {
      await AppScope.read(context).requestCode(_fullPhone);
    } on Object catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        Toast.show(context, _authError(e));
      }
      return;
    }
    if (!mounted) return;
    setState(() {
      _busy = false;
      _codeSent = true;
    });
  }

  Future<void> _verify() async {
    if (_code.text.length != 6) return;
    setState(() => _busy = true);
    HapticFeedback.lightImpact();
    try {
      await AppScope.read(context).signIn(_fullPhone, _code.text);
    } on Object catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        Toast.show(context, _authError(e));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.type;
    final canContinue = _codeSent
        ? _code.text.length == 6
        : _phone.text.replaceAll(' ', '').length >= 9;

    return GpScreen(
      avoidKeyboard: true,
      bottomBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          GpSpace.gutter,
          0,
          GpSpace.gutter,
          GpSpace.lg,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_codeSent)
                Padding(
                  padding: const EdgeInsets.only(bottom: GpSpace.md),
                  child: Text(
                    'The code was sent by SMS. It can take a few seconds.',
                    style: type.caption,
                  ),
                ),
              GpButton(
                label: _codeSent ? 'Sign in' : 'Send code',
                size: GpButtonSize.large,
                loading: _busy,
                onPressed: canContinue
                    ? (_codeSent ? _verify : _sendCode)
                    : null,
              ),
            ],
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
        children: [
          const SizedBox(height: GpSpace.xxl),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: GpColors.brand,
                  borderRadius: BorderRadius.circular(GpRadius.md - 2),
                ),
                child: const Icon(
                  GpIcons.gate,
                  color: GpColors.onBrand,
                  size: 22,
                ),
              ),
              const SizedBox(width: GpSpace.md),
              Text('Gatepass', style: type.title),
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .14),
          Text(
            _codeSent ? 'Check your messages' : 'Get through the gate faster',
            style: type.display,
          ),
          const SizedBox(height: GpSpace.sm),
          Text(
            _codeSent
                ? 'Enter the 6-digit code we sent to ${_fullPhone.replaceAll(' ', ' ')}.'
                : 'Sign in with the mobile number your estate has on file.',
            style: type.lead.copyWith(color: colors.inkMuted),
          ),
          const SizedBox(height: GpSpace.xxl),
          if (!_codeSent)
            GpField(
              // Separate keys, so the code field gets fresh state and its
              // autofocus runs instead of reusing the phone field's.
              key: const ValueKey('phone'),
              controller: _phone,
              label: 'Mobile number',
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumberNational],
              prefix: Text(
                '+27',
                style: type.lead.copyWith(color: colors.inkFaint),
              ),
            )
          else ...[
            GpField(
              key: const ValueKey('code'),
              controller: _code,
              autofocus: true,
              enabled: !_busy,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              textAlign: TextAlign.center,
              hint: '••••••',
              style: type.code.copyWith(letterSpacing: 14),
            ),
            const SizedBox(height: GpSpace.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GpButton(
                  label: 'Change number',
                  variant: GpButtonVariant.text,
                  size: GpButtonSize.compact,
                  expand: false,
                  onPressed: _busy
                      ? null
                      : () => setState(() {
                          _codeSent = false;
                          _code.clear();
                        }),
                ),
                GpButton(
                  label: 'Resend code',
                  variant: GpButtonVariant.text,
                  size: GpButtonSize.compact,
                  expand: false,
                  onPressed: _busy ? null : _sendCode,
                ),
              ],
            ),
          ],
          const SizedBox(height: GpSpace.xxl),
        ],
      ),
    );
  }
}
