//
//  Gatepass
//  invite_form_options.dart
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../core/views/widgets/gp_widgets.dart';
import '../../models/data/invite_day.dart';
import '../../models/data/invite_form_data.dart';
import '../../models/data/invite_stay.dart';
import 'form_label.dart';

/// The day, hours, mobile number and car, behind "More options".
class InviteFormOptions extends StatelessWidget {
  const InviteFormOptions({
    required this.data,
    required this.phone,
    required this.reg,
    required this.onPickDay,
    required this.onPickStart,
    required this.onChanged,
    super.key,
  });

  final InviteFormData data;
  final TextEditingController phone;
  final TextEditingController reg;
  final ValueChanged<InviteDay> onPickDay;
  final VoidCallback onPickStart;
  final ValueChanged<InviteFormData> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: GpSpace.xl),
        GpField(
          controller: phone,
          label: l10n.inviteFormMobileOptional,
          helper: l10n.inviteFormMobileHelper,
          keyboardType: TextInputType.phone,
          autofillHints: const [AutofillHints.telephoneNumber],
        ),
        FormLabel(l10n.inviteFormWhichDay),
        Wrap(
          spacing: GpSpace.sm,
          runSpacing: GpSpace.sm,
          children: [
            GpPill(
              label: l10n.dayToday,
              selected: data.day == InviteDay.today,
              onPressed: () => onPickDay(InviteDay.today),
            ),
            GpPill(
              label: l10n.dayTomorrow,
              selected: data.day == InviteDay.tomorrow,
              onPressed: () => onPickDay(InviteDay.tomorrow),
            ),
            GpPill(
              label: data.day == InviteDay.other
                  ? DateFormat('EEE d MMM', l10n.localeName).format(data.date)
                  : l10n.inviteFormAnotherDay,
              selected: data.day == InviteDay.other,
              onPressed: () => onPickDay(InviteDay.other),
            ),
          ],
        ),
        FormLabel(l10n.inviteFormHowLong),
        Wrap(
          spacing: GpSpace.sm,
          runSpacing: GpSpace.sm,
          children: [
            for (final s in InviteStay.values)
              GpPill(
                label: s.label(l10n),
                selected: data.stay == s,
                onPressed: () => onChanged(data.copyWith(stay: s)),
              ),
          ],
        ),
        if (data.stay.duration != null) ...[
          const SizedBox(height: GpSpace.md),
          GpSurface(
            padding: EdgeInsets.zero,
            child: GpRow(
              leading: Icon(GpIcons.clock, size: 20, color: colors.inkMuted),
              title: l10n.inviteFormArrivingFrom,
              titleStyle: context.type.body,
              trailing: Text(
                context.format.minutes(data.start),
                style: context.type.section,
              ),
              chevron: true,
              onTap: onPickStart,
            ),
          ),
        ],
        const SizedBox(height: GpSpace.xxl),
        GpSurface(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              GpSwitchRow(
                title: l10n.inviteFormByCar,
                subtitle: l10n.inviteFormByCarHelper,
                value: data.byCar,
                onChanged: (v) => onChanged(data.copyWith(byCar: v)),
              ),
              if (data.byCar)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    GpSpace.lg,
                    0,
                    GpSpace.lg,
                    GpSpace.lg,
                  ),
                  child: GpField(
                    controller: reg,
                    label: l10n.inviteFormRegistration,
                    hint: l10n.inviteFormRegistrationHint,
                    textCapitalization: TextCapitalization.characters,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
