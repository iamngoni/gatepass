import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../data/models.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import 'invite_actions.dart';

/// [initial] prefills the form, e.g. from a held quick tile.
Future<void> openInviteForm(BuildContext context, {InviteDraft? initial}) =>
    pushPage<void>(
      context,
      (_) => InviteFormScreen(initial: initial),
      fullscreenDialog: true,
    );

enum _Day { today, tomorrow, other }

enum _Stay {
  h1('1 hour', Duration(hours: 1)),
  h2('2 hours', Duration(hours: 2)),
  h4('4 hours', Duration(hours: 4)),
  h8('8 hours', Duration(hours: 8)),
  allDay('All day', null);

  const _Stay(this.label, this.duration);
  final String label;
  final Duration? duration;
}

class InviteFormScreen extends StatefulWidget {
  const InviteFormScreen({super.key, this.initial});

  final InviteDraft? initial;

  @override
  State<InviteFormScreen> createState() => _InviteFormScreenState();
}

class _InviteFormScreenState extends State<InviteFormScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _reg = TextEditingController();

  _Day _day = _Day.today;
  late DateTime _date = dateOnly(DateTime.now());

  /// Arrival time, in minutes since midnight.
  late int _start = _nextQuarter();
  _Stay _stay = _Stay.h4;
  bool _byCar = false;
  bool _multiEntry = false;
  bool _prescreen = true;
  bool _saving = false;

  static int _nextQuarter() {
    final now = DateTime.now();
    final minutes = ((now.hour * 60 + now.minute) ~/ 15 + 1) * 15;
    return minutes >= 24 * 60 ? 23 * 60 + 45 : minutes;
  }

  DateTime get _from =>
      DateTime(_date.year, _date.month, _date.day, _start ~/ 60, _start % 60);

  DateTime get _until {
    final duration = _stay.duration;
    return duration == null
        ? DateTime(_date.year, _date.month, _date.day, 23, 59)
        : _from.add(duration);
  }

  bool get _valid =>
      _name.text.trim().isNotEmpty && (!_byCar || _reg.text.trim().isNotEmpty);

  @override
  void initState() {
    super.initState();
    final d = widget.initial;
    if (d != null) {
      _name.text = d.visitorName;
      _phone.text = d.phone ?? '';
      _reg.text = d.vehicleReg ?? '';
      _byCar = d.vehicleReg != null;
      _multiEntry = d.multiEntry;
      _prescreen = d.prescreenRequired;
      // Quick drafts start now (the driver may already be on the way), so
      // keep their start instead of rounding up to the next quarter hour.
      if (isSameDay(d.from, _date)) _start = d.from.hour * 60 + d.from.minute;
      final length = d.until.difference(d.from);
      _stay = _Stay.values.firstWhere(
        (s) => s.duration != null && length <= s.duration!,
        orElse: () => _Stay.allDay,
      );
    }
    _name.addListener(_onChanged);
    _reg.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _reg.dispose();
    super.dispose();
  }

  Future<void> _pickDay(_Day day) async {
    final today = dateOnly(DateTime.now());
    switch (day) {
      case _Day.today:
        if (_day == _Day.today) return;
        setState(() {
          _day = day;
          _date = today;
          final soonest = _nextQuarter();
          if (_start < soonest) _start = soonest;
        });
      case _Day.tomorrow:
        setState(() {
          _day = day;
          _date = addDays(today, 1);
        });
      case _Day.other:
        final picked = await pickDay(
          context,
          initial: _date.isBefore(today) ? today : _date,
          first: today,
          last: addDays(today, 90),
        );
        if (picked == null) return;
        setState(() {
          _date = picked;
          _day = isSameDay(picked, today)
              ? _Day.today
              : isSameDay(picked, addDays(today, 1))
              ? _Day.tomorrow
              : _Day.other;
        });
    }
  }

  Future<void> _pickTime() async {
    final picked = await pickTime(
      context,
      initialMinutes: _start,
      title: 'Arriving from',
    );
    if (picked != null) setState(() => _start = picked);
  }

  bool get _startsInPast =>
      _from.isBefore(DateTime.now().subtract(const Duration(minutes: 15)));

  Future<void> _submit() async {
    if (_startsInPast) return setState(() {});
    setState(() => _saving = true);
    try {
      final invite = await AppScope.read(context).createInvite(
        InviteDraft(
          visitorName: _name.text.trim(),
          serviceId: widget.initial?.serviceId,
          phone: _phone.text.trim().isEmpty ? null : _phone.text.trim(),
          vehicleReg: _byCar ? _reg.text.trim().toUpperCase() : null,
          from: _from,
          until: _until,
          multiEntry: _multiEntry,
          prescreenRequired: _prescreen,
        ),
      );
      if (!mounted) return;
      HapticFeedback.lightImpact();
      Navigator.of(context).pushReplacement(
        GpPageRoute<void>(builder: (_) => InviteCreatedScreen(invite: invite)),
      );
    } on Object catch (e) {
      if (mounted) Toast.show(context, describeError(e));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final startsInPast = _startsInPast;

    return PopScope(
      canPop: !_saving,
      child: GpScreen(
        avoidKeyboard: true,
        header: const GpHeader(title: 'New invite'),
        bottomBar: GpBottomBar(
          child: GpButton(
            label: 'Create invite',
            size: GpButtonSize.large,
            loading: _saving,
            onPressed: _valid && !startsInPast ? _submit : null,
          ),
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
              controller: _name,
              label: 'Visitor’s name',
              autofocus: widget.initial == null,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
            ),
            const SizedBox(height: GpSpace.lg),
            GpField(
              controller: _phone,
              label: 'Mobile number (optional)',
              helper: 'We’ll text them the invite link.',
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumber],
            ),
            const _Label('When are they coming?'),
            Wrap(
              spacing: GpSpace.sm,
              runSpacing: GpSpace.sm,
              children: [
                GpPill(
                  label: 'Today',
                  selected: _day == _Day.today,
                  onPressed: () => _pickDay(_Day.today),
                ),
                GpPill(
                  label: 'Tomorrow',
                  selected: _day == _Day.tomorrow,
                  onPressed: () => _pickDay(_Day.tomorrow),
                ),
                GpPill(
                  label: _day == _Day.other
                      ? DateFormat('EEE d MMM').format(_date)
                      : 'Another day…',
                  selected: _day == _Day.other,
                  onPressed: () => _pickDay(_Day.other),
                ),
              ],
            ),
            const SizedBox(height: GpSpace.md),
            GpSurface(
              padding: EdgeInsets.zero,
              child: GpRow(
                leading: Icon(GpIcons.clock, size: 20, color: colors.inkMuted),
                title: 'Arriving from',
                titleStyle: context.type.body,
                trailing: Text(
                  formatMinutes(_start),
                  style: context.type.section,
                ),
                chevron: true,
                onTap: _pickTime,
              ),
            ),
            const _Label('How long can they stay?'),
            Wrap(
              spacing: GpSpace.sm,
              runSpacing: GpSpace.sm,
              children: [
                for (final s in _Stay.values)
                  GpPill(
                    label: s.label,
                    selected: _stay == s,
                    onPressed: () => setState(() => _stay = s),
                  ),
              ],
            ),
            const SizedBox(height: GpSpace.lg),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: GpSpace.lg,
                vertical: GpSpace.md,
              ),
              decoration: BoxDecoration(
                color: startsInPast ? colors.warningSoft : colors.accentSoft,
                borderRadius: BorderRadius.circular(GpRadius.md),
              ),
              child: Row(
                children: [
                  Icon(
                    startsInPast ? GpIcons.alert : GpIcons.calendarCheck,
                    size: 18,
                    color: startsInPast ? colors.warning : colors.accent,
                  ),
                  const SizedBox(width: GpSpace.sm),
                  Expanded(
                    child: Text(
                      startsInPast
                          ? 'That start time has passed. Pick a later one.'
                          : 'Valid ${windowLabel(_from, _until)}',
                      style: context.type.bodyStrong.copyWith(
                        color: startsInPast ? colors.warning : colors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const _Label('Options'),
            GpSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  GpSwitchRow(
                    title: 'Coming by car',
                    subtitle: 'Guards can match the registration at the gate',
                    value: _byCar,
                    onChanged: (v) => setState(() => _byCar = v),
                  ),
                  if (_byCar)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        GpSpace.lg,
                        0,
                        GpSpace.lg,
                        GpSpace.lg,
                      ),
                      child: GpField(
                        controller: _reg,
                        label: 'Registration number',
                        hint: 'e.g. HN 42 KP GP',
                        textCapitalization: TextCapitalization.characters,
                      ),
                    ),
                  const GpSeparator(inset: GpSpace.lg),
                  GpSwitchRow(
                    title: 'Allow more than one entry',
                    subtitle: 'For contractors, carers and regular visitors',
                    value: _multiEntry,
                    onChanged: (v) => setState(() => _multiEntry = v),
                  ),
                  const GpSeparator(inset: GpSpace.lg),
                  GpSwitchRow(
                    title: 'Ask them to pre-screen',
                    subtitle:
                        'They add their ID and photo before arriving, so the '
                        'gate is quicker',
                    value: _prescreen,
                    onChanged: (v) => setState(() => _prescreen = v),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: GpSpace.xxl, bottom: GpSpace.md),
    child: Text(text, style: context.type.section),
  );
}

/// Shown right after creating an invite: the next job is sending it.
class InviteCreatedScreen extends StatelessWidget {
  const InviteCreatedScreen({super.key, required this.invite});

  final Invite invite;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final site = AppScope.read(context).site;
    final first = invite.firstName;

    return GpScreen(
      bottomBar: GpBottomBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GpButton(
              label: 'Send to $first',
              icon: GpIcons.share,
              size: GpButtonSize.large,
              onPressed: () => shareInvite(context, invite, site.name),
            ),
            const SizedBox(height: GpSpace.sm),
            GpButton(
              label: 'Done',
              variant: GpButtonVariant.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          GpSpace.gutter,
          GpSpace.xxxl * 2,
          GpSpace.gutter,
          GpSpace.xxl,
        ),
        children: [
          const Center(
            child: IconBadge(icon: GpIcons.check, tone: Tone.accent, size: 88),
          ),
          const SizedBox(height: GpSpace.xxl),
          Text(
            'Invite ready',
            style: context.type.display,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: GpSpace.sm),
          Text(
            invite.prescreenRequired
                ? 'Send $first the link. They’ll pre-screen first, then use it '
                      'at the gate.'
                : 'Send $first the link. They’ll use it at the gate.',
            textAlign: TextAlign.center,
            style: context.type.body.copyWith(color: colors.inkMuted),
          ),
          const SizedBox(height: GpSpace.xxl),
          GpGroup(
            inset: GpSpace.lg,
            children: [
              DetailRow(
                icon: GpIcons.clock,
                label: 'Valid',
                value: windowLabel(invite.from, invite.until),
              ),
              DetailRow(
                icon: GpIcons.keypad,
                label: 'Gate code',
                value: formatCode(invite.code),
              ),
              DetailRow(
                icon: GpIcons.link,
                label: 'Link',
                value: invite.link.replaceFirst('https://', ''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
