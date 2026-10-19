// Gatepass — localization_extensions.dart. Created 2026-10-19.
import 'package:flutter/widgets.dart';

import '../../../auth/models/data/otp_channel.dart';
import '../../../invites/models/data/invite_status.dart';
import '../../../invites/models/data/invite_stay.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../configs/appearance.dart';
import '../../models/data/application_error.dart';
import '../gp_format.dart';

extension LocalizationContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  GpFormat get format => GpFormat(AppLocalizations.of(this));
}

extension ApplicationErrorText on ApplicationError {
  /// What to tell the resident. ATG's own text wins: it is written for them.
  String describe(AppLocalizations l10n) {
    final text = message?.trim();
    if (code == ApplicationErrorCode.atg && text != null && text.isNotEmpty) {
      return text;
    }
    return switch (code) {
      ApplicationErrorCode.connection => l10n.errorConnection,
      ApplicationErrorCode.timeout => l10n.errorTimeout,
      ApplicationErrorCode.server ||
      ApplicationErrorCode.atg => l10n.errorServer,
      ApplicationErrorCode.notSignedIn => l10n.errorNotSignedIn,
      ApplicationErrorCode.noEstateAccount => l10n.errorNoEstateAccount,
      ApplicationErrorCode.backupConflict => l10n.errorBackupConflict,
      ApplicationErrorCode.backupDecrypt => l10n.errorBackupDecrypt,
      ApplicationErrorCode.backupUnavailable => l10n.errorBackupUnavailable,
      ApplicationErrorCode.phraseInvalid => l10n.errorPhraseInvalid,
      ApplicationErrorCode.storage => l10n.errorStorage,
      ApplicationErrorCode.unknown => l10n.errorUnknown,
    };
  }
}

extension AppearanceText on Appearance {
  String label(AppLocalizations l10n) => switch (this) {
    Appearance.system => l10n.appearanceSystem,
    Appearance.light => l10n.appearanceLight,
    Appearance.dark => l10n.appearanceDark,
  };
}

extension OtpChannelText on OtpChannel {
  String label(AppLocalizations l10n) => switch (this) {
    OtpChannel.sms => l10n.otpChannelSms,
    OtpChannel.whatsapp => l10n.otpChannelWhatsapp,
  };
}

extension InviteStatusText on InviteStatus {
  String label(AppLocalizations l10n) => switch (this) {
    InviteStatus.active => l10n.inviteStatusActive,
    InviteStatus.expired => l10n.inviteStatusExpired,
    InviteStatus.revoked => l10n.inviteStatusRevoked,
  };
}

extension InviteStayText on InviteStay {
  String label(AppLocalizations l10n) => switch (this) {
    InviteStay.allDay => l10n.stayAllDay,
    InviteStay.h1 => l10n.stayHours(1),
    InviteStay.h2 => l10n.stayHours(2),
    InviteStay.h4 => l10n.stayHours(4),
    InviteStay.h8 => l10n.stayHours(8),
  };
}
