import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../data/models.dart';
import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../util/format.dart';
import '../../widgets/common.dart';
import '../../widgets/gate_pass.dart';
import 'invite_actions.dart';
import 'share_invite.dart';

/// [initial] prefills the form, e.g. from a held quick tile.
Future<void> openInviteForm(BuildContext context, {InviteDraft? initial}) =>
    pushPage<void>(
      context,
      (_) => InviteFormScreen(initial: initial),
      fullscreenDialog: true,
    );

enum _Day { today, tomorrow, other }

enum _Stay {
  allDay('All day', null),
  h1('1 hour', Duration(hours: 1)),
  h2('2 hours', Duration(hours: 2)),
  h4('4 hours', Duration(hours: 4)),
  h8('8 hours', Duration(hours: 8));

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

  /// Arrival time for a set number of hours, in minutes since midnight.
  late int _start = _nextQuarter();
  _Stay _stay = _Stay.allDay;
  bool _byCar = false;
  bool _saving = false;

  /// The day, hours, mobile number and car. Closed by default, so the usual
  /// invite is a name and nothing else; a held tile opens it to adjust.
  late bool _advanced = widget.initial != null;

  static int _nextQuarter() {
    final now = DateTime.now();
    final minutes = ((now.hour * 60 + now.minute) ~/ 15 + 1) * 15;
    return minutes >= 24 * 60 ? 23 * 60 + 45 : minutes;
  }

  DateTime get _from {
    if (_stay.duration == null) {
      // All day runs from midnight, except today's, which starts now.
      final now = DateTime.now();
      return isSameDay(_date, now) ? now : _date;
    }
    return DateTime(
      _date.year,
      _date.month,
      _date.day,
      _start ~/ 60,
      _start % 60,
    );
  }

  DateTime get _until {
    final duration = _stay.duration;
    if (duration != null) return _from.add(duration);
    final end = DateTime(_date.year, _date.month, _date.day, 23, 59);
    // Late at night, the rest of today is minutes; give them at least an hour.
    final soonest = _from.add(const Duration(hours: 1));
    return end.isBefore(soonest) ? soonest : end;
  }

  String get _validity {
    final from = _from;
    final until = _until;
    if (_stay.duration == null && isSameDay(until, _date)) {
      final today = dateOnly(DateTime.now());
      if (isSameDay(_date, today)) {
        return 'Valid all day today, until ${formatTime(until)}';
      }
      if (isSameDay(_date, addDays(today, 1))) return 'Valid all day tomorrow';
      return 'Valid all day ${dayLabel(_date)}';
    }
    return 'Valid ${windowLabel(from, until)}';
  }

  /// What the closed options hold, so nothing is sent unseen.
  String get _optionsSummary {
    final added = [
      if (_phone.text.trim().isNotEmpty) 'mobile number',
      if (_byCar) 'car',
    ];
    return added.isEmpty
        ? 'Another day, set hours, mobile number or car'
        : 'Includes ${added.join(' and ')}';
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
      final today = dateOnly(DateTime.now());
      final todayDate = dateOnly(d.from);
      _date = todayDate.isBefore(today) ? today : todayDate;
      _day = isSameDay(_date, today)
          ? _Day.today
          : isSameDay(_date, addDays(today, 1))
          ? _Day.tomorrow
          : _Day.other;
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

  void _toggleAdvanced() {
    setState(() {
      _advanced = !_advanced;
      // A car with no registration would block Create from behind a closed
      // section, with nothing on screen to say why.
      if (!_advanced && _byCar && _reg.text.trim().isEmpty) _byCar = false;
    });
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
        final horizon = AppScope.read(context).site.inviteHorizonDays;
        final last = addDays(today, horizon);
        final picked = await pickDay(
          context,
          initial: _date.isBefore(today) || _date.isAfter(last) ? today : _date,
          first: today,
          last: last,
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
    final tone = startsInPast ? colors.warning : colors.accent;

    final options = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: GpSpace.xl),
        GpField(
          controller: _phone,
          label: 'Mobile number (optional)',
          helper: 'Saved on their visitor profile.',
          keyboardType: TextInputType.phone,
          autofillHints: const [AutofillHints.telephoneNumber],
        ),
        const _Label('Which day?'),
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
        if (_stay.duration != null) ...[
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
        ],
        const SizedBox(height: GpSpace.xxl),
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
            ],
          ),
        ),
      ],
    );

    return PopScope(
      canPop: !_saving,
      child: GpScreen(
        avoidKeyboard: true,
        header: const GpHeader(title: 'New invite'),
        bottomBar: GpBottomBar(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    startsInPast ? GpIcons.alert : GpIcons.calendarCheck,
                    size: 16,
                    color: tone,
                  ),
                  const SizedBox(width: GpSpace.sm),
                  Flexible(
                    child: Text(
                      startsInPast
                          ? 'That start time has passed. Pick a later one.'
                          : _validity,
                      style: context.type.small
                          .weighted(FontWeight.w600)
                          .copyWith(color: tone),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: GpSpace.md),
              GpButton(
                label: 'Create invite',
                size: GpButtonSize.large,
                loading: _saving,
                onPressed: _valid && !startsInPast ? _submit : null,
              ),
            ],
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
              label: 'Full name',
              autofocus: widget.initial == null,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.name],
            ),
            const SizedBox(height: GpSpace.lg),
            GpSurface(
              padding: EdgeInsets.zero,
              child: GpRow(
                leading: Icon(
                  GpIcons.options,
                  size: 20,
                  color: colors.inkMuted,
                ),
                title: _advanced ? 'Fewer options' : 'More options',
                titleStyle: context.type.body,
                subtitle: _advanced ? null : _optionsSummary,
                trailing: AnimatedRotation(
                  turns: _advanced ? 0.5 : 0,
                  duration: GpMotion.base,
                  curve: GpMotion.curve,
                  child: Icon(
                    GpIcons.chevronDown,
                    size: 20,
                    color: colors.inkFaint,
                  ),
                ),
                onTap: _toggleAdvanced,
              ),
            ),
            if (MediaQuery.disableAnimationsOf(context))
              _advanced ? options : const SizedBox.shrink()
            else
              AnimatedSize(
                duration: GpMotion.slow,
                curve: GpMotion.curveInOut,
                alignment: Alignment.topCenter,
                child: _advanced
                    ? options
                    : const SizedBox(width: double.infinity),
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

/// Shown right after creating an invite: the next job is sharing it.
class InviteCreatedScreen extends StatelessWidget {
  const InviteCreatedScreen({super.key, required this.invite});

  final Invite invite;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final first = invite.firstName;

    return GpScreen(
      bottomBar: GpBottomBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GpButton(
              label: 'Share invite',
              icon: GpIcons.share,
              size: GpButtonSize.large,
              onPressed: invite.code.isEmpty
                  ? null
                  : () => showShareOptions(context, invite),
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
          GpSpace.xxxl,
          GpSpace.gutter,
          GpSpace.xxl,
        ),
        children: [
          Row(
            children: [
              const IconBadge(icon: GpIcons.check, tone: Tone.accent, size: 44),
              const SizedBox(width: GpSpace.md),
              Expanded(
                child: Text('Invite ready', style: context.type.display),
              ),
            ],
          ),
          const SizedBox(height: GpSpace.sm),
          Text(
            'Share it with $first: the code, the link or a picture of this '
            'QR all work at the gate.',
            style: context.type.body.copyWith(color: colors.inkMuted),
          ),
          const SizedBox(height: GpSpace.xl),
          GatePass(code: invite.code),
          const SizedBox(height: GpSpace.lg),
          GpGroup(
            inset: GpSpace.lg,
            children: [
              DetailRow(
                icon: GpIcons.clock,
                label: 'Valid',
                value: inviteValidityLabel(invite),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
