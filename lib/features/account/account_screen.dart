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
    final site = state.site;
    final propertyLine = [
      site.unit,
      site.area,
    ].where((part) => part.trim().isNotEmpty).join(' · ');

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
                        if (resident.phone.isNotEmpty) ...[
                          const SizedBox(height: GpSpace.xxs),
                          Text(resident.phone, style: context.type.caption),
                        ],
                        if (resident.email.isNotEmpty)
                          Text(resident.email, style: context.type.caption),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SectionHeading('Your property'),
          padded(
            GpGroup(
              children: [
                GpRow(
                  leading: const IconBadge(
                    icon: GpIcons.property,
                    size: 40,
                    tone: Tone.accent,
                  ),
                  title: site.name,
                  subtitle: propertyLine.isEmpty ? null : propertyLine,
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
          const SectionHeading('About'),
          padded(
            GpGroup(
              inset: 52,
              children: [
                GpRow(
                  leading: Icon(GpIcons.info, color: colors.inkMuted),
                  title: 'About Gatepass',
                  chevron: true,
                  onTap: () => showGpInfo(
                    context,
                    title: 'About Gatepass',
                    body:
                        'Gatepass signs in to your At The Gate account and '
                        'uses its visitor invitation service. It shows the '
                        'estate and invitations returned by that account. '
                        'Gate entry history is not available to this account.',
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
