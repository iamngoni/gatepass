import 'package:flutter/widgets.dart';

import '../../state/app_state.dart';
import '../../ui/ui.dart';
import '../../widgets/common.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final resident = state.resident!;
    final colors = context.colors;

    Widget padded(Widget child) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: GpSpace.gutter),
      child: child,
    );

    return GpScreen(
      child: ListView(
        padding: EdgeInsets.only(bottom: scrollEnd(context)),
        children: [
          const PageTitle('Account'),
          padded(
            GpSurface(
              child: Row(
                children: [
                  InitialsAvatar(
                    name: resident.name,
                    size: 56,
                    tone: Tone.accent,
                  ),
                  const SizedBox(width: GpSpace.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(resident.name, style: context.type.cardTitle),
                        const SizedBox(height: GpSpace.xxs),
                        Text(resident.phone, style: context.type.caption),
                        Text(resident.email, style: context.type.caption),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeading('Your properties'),
          padded(
            GpGroup(
              children: [
                for (final s in state.sites)
                  GpRow(
                    leading: IconBadge(
                      icon: GpIcons.property,
                      size: 40,
                      tone: s.id == state.site.id ? Tone.accent : Tone.neutral,
                    ),
                    title: s.name,
                    subtitle: '${s.unit} · ${s.area}',
                    trailing: s.id == state.site.id
                        ? Icon(GpIcons.check, color: colors.accent, size: 20)
                        : null,
                    onTap: () => state.selectSite(s),
                  ),
              ],
            ),
          ),
          const SectionHeading('Notify me when'),
          padded(
            GpGroup(
              inset: GpSpace.lg,
              children: [
                for (final pref in NotifyPref.values)
                  GpSwitchRow(
                    title: pref.label,
                    value: state.prefs[pref]!,
                    onChanged: (v) => state.setPref(pref, v),
                  ),
              ],
            ),
          ),
          const SectionHeading('Appearance'),
          padded(
            GpSegmented(
              segments: [for (final a in Appearance.values) a.label],
              selectedIndex: state.appearance.index,
              onChanged: (i) => state.setAppearance(Appearance.values[i]),
            ),
          ),
          const SectionHeading('Help'),
          padded(
            GpGroup(
              inset: 52,
              children: [
                GpRow(
                  leading: Icon(GpIcons.security, color: colors.inkMuted),
                  title: 'Contact estate security',
                  chevron: true,
                  onTap: () {},
                ),
                GpRow(
                  leading: Icon(GpIcons.info, color: colors.inkMuted),
                  title: 'About this prototype',
                  chevron: true,
                  onTap: () => showGpInfo(
                    context,
                    title: 'Gatepass prototype',
                    body:
                        'A redesign of the resident side of an estate access '
                        'app. All data is made up; nothing talks to a real '
                        'gate.',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              GpSpace.gutter,
              GpSpace.xxxl,
              GpSpace.gutter,
              0,
            ),
            child: GpButton(
              label: 'Sign out',
              variant: GpButtonVariant.danger,
              onPressed: () => _confirmSignOut(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmed = await showGpConfirm(
      context,
      title: 'Sign out?',
      body: 'You’ll need a new code to sign back in.',
      confirmLabel: 'Sign out',
      cancelLabel: 'Stay signed in',
      danger: true,
    );
    if (confirmed && context.mounted) AppScope.read(context).signOut();
  }
}
