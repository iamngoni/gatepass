// Gatepass — invite_form_page.dart. Created 2026-10-19.
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/state/session/session_bloc.dart';
import '../../../core/utils/date_helpers.dart';
import '../../../core/utils/extensions/invites_bloc_extensions.dart';
import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/invite_day.dart';
import '../../models/data/invite_draft.dart';
import '../../models/data/invite_form_data.dart';
import '../../state/invites/invites_bloc.dart';
import '../widgets/invite_form_bar.dart';
import '../widgets/invite_form_options.dart';
import 'invite_created_page.dart';

/// [initial] prefills the form, e.g. from a held quick tile.
Future<void> openInviteForm(BuildContext context, {InviteDraft? initial}) =>
    pushPage<void>(
      context,
      (_) => InviteFormPage(initial: initial),
      fullscreenDialog: true,
    );

class InviteFormPage extends StatefulWidget {
  const InviteFormPage({this.initial, super.key});

  final InviteDraft? initial;

  @override
  State<InviteFormPage> createState() => _InviteFormPageState();
}

class _InviteFormPageState extends State<InviteFormPage> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final reg = TextEditingController();
  late final form = ValueNotifier(
    InviteFormData.initial(widget.initial, DateTime.now()),
  );

  bool get valid =>
      name.text.trim().isNotEmpty &&
      (!form.value.byCar || reg.text.trim().isNotEmpty);

  @override
  void initState() {
    super.initState();
    final d = widget.initial;
    if (d != null) {
      name.text = d.visitorName;
      phone.text = d.phone ?? '';
      reg.text = d.vehicleReg ?? '';
    }
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    reg.dispose();
    form.dispose();
    super.dispose();
  }

  void toggleAdvanced() {
    final data = form.value;
    final advanced = !data.advanced;
    form.value = data.copyWith(
      advanced: advanced,
      // A car with no registration would block Create from behind a closed
      // section, with nothing on screen to say why.
      byCar:
          !(!advanced && data.byCar && reg.text.trim().isEmpty) && data.byCar,
    );
  }

  Future<void> chooseDay(InviteDay day) async {
    final now = DateTime.now();
    final today = dateOnly(now);
    final data = form.value;
    switch (day) {
      case InviteDay.today:
        if (data.day == InviteDay.today) return;
        form.value = data.pickToday(now);
      case InviteDay.tomorrow:
        form.value = data.copyWith(
          day: InviteDay.tomorrow,
          date: addDays(today, 1),
        );
      case InviteDay.other:
        final session = context.read<SessionBloc>().state;
        final horizon = session is SessionSignedInState
            ? session.account.site.inviteHorizonDays
            : 30;
        final last = addDays(today, horizon);
        final date = data.date;
        final picked = await pickDay(
          context,
          initial: date.isBefore(today) || date.isAfter(last) ? today : date,
          first: today,
          last: last,
        );
        if (picked == null) return;
        form.value = form.value.pickDate(picked, now);
    }
  }

  Future<void> pickStart() async {
    final picked = await pickTime(
      context,
      initialMinutes: form.value.start,
      title: context.l10n.inviteFormArrivingFrom,
    );
    if (picked != null) form.value = form.value.copyWith(start: picked);
  }

  Future<void> submit() async {
    final now = DateTime.now();
    final data = form.value;
    if (data.startsInPast(now)) {
      // Rebuild the bar so it says why.
      form.value = data.copyWith();
      return;
    }
    form.value = data.copyWith(saving: true);
    final result = await context.read<InvitesBloc>().createAndWait(
      InviteDraft(
        visitorName: name.text.trim(),
        serviceId: widget.initial?.serviceId,
        phone: phone.text.trim().isEmpty ? null : phone.text.trim(),
        vehicleReg: data.byCar ? reg.text.trim().toUpperCase() : null,
        from: data.from(now),
        until: data.until(now),
      ),
    );
    if (!mounted) return;
    form.value = form.value.copyWith(saving: false);
    result.fold(
      (error) => Toast.show(context, error.describe(context.l10n)),
      (invite) {
        HapticFeedback.lightImpact();
        Navigator.of(context).pushReplacement(
          GpPageRoute<void>(builder: (_) => InviteCreatedPage(invite: invite)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return ValueListenableBuilder<InviteFormData>(
      valueListenable: form,
      builder: (context, data, _) {
        final options = InviteFormOptions(
          data: data,
          phone: phone,
          reg: reg,
          onPickDay: chooseDay,
          onPickStart: pickStart,
          onChanged: (next) => form.value = next,
        );
        return PopScope(
          canPop: !data.saving,
          child: GpScreen(
            avoidKeyboard: true,
            header: GpHeader(title: l10n.inviteFormTitle),
            bottomBar: ListenableBuilder(
              listenable: Listenable.merge([name, reg]),
              builder: (context, _) =>
                  InviteFormBar(data: data, valid: valid, onSubmit: submit),
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                GpSpace.gutter,
                GpSpace.sm,
                GpSpace.gutter,
                GpSpace.xxl,
              ),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                GpField(
                  controller: name,
                  label: l10n.inviteFormFullName,
                  autofocus: widget.initial == null,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.name],
                ),
                const SizedBox(height: GpSpace.lg),
                GpSurface(
                  padding: EdgeInsets.zero,
                  child: ListenableBuilder(
                    listenable: phone,
                    builder: (context, _) => GpRow(
                      leading: Icon(
                        GpIcons.options,
                        size: 20,
                        color: colors.inkMuted,
                      ),
                      title: data.advanced
                          ? l10n.inviteFormFewerOptions
                          : l10n.inviteFormMoreOptions,
                      titleStyle: context.type.body,
                      subtitle: data.advanced ? null : summary(context, data),
                      trailing: AnimatedRotation(
                        turns: data.advanced ? 0.5 : 0,
                        duration: GpMotion.base,
                        curve: GpMotion.curve,
                        child: Icon(
                          GpIcons.chevronDown,
                          size: 20,
                          color: colors.inkFaint,
                        ),
                      ),
                      onTap: toggleAdvanced,
                    ),
                  ),
                ),
                if (MediaQuery.disableAnimationsOf(context))
                  data.advanced ? options : const SizedBox.shrink()
                else
                  AnimatedSize(
                    duration: GpMotion.slow,
                    curve: GpMotion.curveInOut,
                    alignment: Alignment.topCenter,
                    child: data.advanced
                        ? options
                        : const SizedBox(width: double.infinity),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// What the closed options hold, so nothing is sent unseen.
  String summary(BuildContext context, InviteFormData data) {
    final l10n = context.l10n;
    final hasPhone = phone.text.trim().isNotEmpty;
    return switch ((hasPhone, data.byCar)) {
      (true, true) => l10n.inviteFormIncludesPhoneAndCar,
      (true, false) => l10n.inviteFormIncludesPhone,
      (false, true) => l10n.inviteFormIncludesCar,
      (false, false) => l10n.inviteFormOptionsSummary,
    };
  }
}
