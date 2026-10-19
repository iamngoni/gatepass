// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Gatepass';

  @override
  String get commonBack => 'Back';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonCopy => 'Copy';

  @override
  String get commonCut => 'Cut';

  @override
  String get commonLoading => 'Loading';

  @override
  String get commonNextMonth => 'Next month';

  @override
  String get commonPaste => 'Paste';

  @override
  String get commonPreviousMonth => 'Previous month';

  @override
  String get commonRefresh => 'Refresh';

  @override
  String get commonRevoke => 'Revoke';

  @override
  String get commonSelectAll => 'Select all';

  @override
  String get commonSetTime => 'Set time';

  @override
  String get commonNoCode => 'No code';

  @override
  String get appearanceSystem => 'System';

  @override
  String get appearanceLight => 'Light';

  @override
  String get appearanceDark => 'Dark';

  @override
  String get otpChannelSms => 'SMS';

  @override
  String get otpChannelWhatsapp => 'WhatsApp';

  @override
  String get inviteStatusActive => 'Active';

  @override
  String get inviteStatusExpired => 'Expired';

  @override
  String get inviteStatusRevoked => 'Revoked';

  @override
  String get dayToday => 'Today';

  @override
  String get dayTomorrow => 'Tomorrow';

  @override
  String get dayYesterday => 'Yesterday';

  @override
  String windowSameDay(String day, String from, String until) {
    return '$day, $from – $until';
  }

  @override
  String windowAcrossDays(
    String fromDay,
    String from,
    String untilDay,
    String until,
  ) {
    return '$fromDay $from – $untilDay $until';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get inviteAlwaysValid => 'Always valid';

  @override
  String get errorConnection =>
      'Can’t reach ATG. Check your connection and try again.';

  @override
  String get errorTimeout =>
      'ATG is taking too long to answer. Try again in a moment.';

  @override
  String get errorServer => 'ATG couldn’t do that just now. Please try again.';

  @override
  String get errorNotSignedIn =>
      'You’ve been signed out. Sign in again to continue.';

  @override
  String get errorNoEstateAccount =>
      'No estate account is linked to this number.';

  @override
  String get errorBackupConflict =>
      'Another phone backed up at the same time. Try again.';

  @override
  String get errorBackupDecrypt =>
      'That recovery phrase doesn’t open this backup.';

  @override
  String get errorBackupUnavailable =>
      'The backup service couldn’t be reached. Try again later.';

  @override
  String get errorPhraseInvalid =>
      'Enter the 12 words of your recovery phrase.';

  @override
  String get errorStorage => 'This phone’s secure storage couldn’t be used.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get tabHome => 'Home';

  @override
  String get tabVisitors => 'Visitors';

  @override
  String get tabAccount => 'Account';

  @override
  String get tabInviteSomeone => 'Invite someone';

  @override
  String get signInTitle => 'Get through the gate faster';

  @override
  String get signInLead =>
      'Sign in with the mobile number your estate has on file.';

  @override
  String get signInCheckWhatsapp => 'Check WhatsApp';

  @override
  String get signInCheckMessages => 'Check your messages';

  @override
  String signInEnterCode(String phone) {
    return 'Enter the 6-digit code we sent to $phone.';
  }

  @override
  String get signInMobileNumber => 'Mobile number';

  @override
  String get signInChangeNumber => 'Change number';

  @override
  String get signInResendCode => 'Resend code';

  @override
  String signInSendInstead(String channel) {
    return 'Send by $channel instead';
  }

  @override
  String signInCodeSentBy(String channel) {
    return 'The code was sent by $channel. It can take a few seconds.';
  }

  @override
  String get signInSubmit => 'Sign in';

  @override
  String get signInSendBy => 'Send the code by';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMarkAllRead => 'Mark all read';

  @override
  String get notificationsEmptyTitle => 'You’re all caught up';

  @override
  String get notificationsEmptyBody =>
      'Arrivals, departures and estate notices show up here.';

  @override
  String get notificationsNew => 'New';

  @override
  String get notificationsEarlier => 'Earlier';

  @override
  String notificationsTime(String day, String time) {
    return '$day, $time';
  }

  @override
  String get commonDone => 'Done';

  @override
  String get accountProperty => 'Your property';

  @override
  String get accountBackup => 'Backup';

  @override
  String get accountBackupOn => 'On, end-to-end encrypted';

  @override
  String get accountOff => 'Off';

  @override
  String get accountAppearance => 'Appearance';

  @override
  String get accountAbout => 'About';

  @override
  String get accountAboutGatepass => 'About Gatepass';

  @override
  String get accountAboutBody =>
      'Gatepass signs in to your At The Gate account and uses its visitor invitation service. It shows the estate and invitations returned by that account. Gate entry history is not available to this account.';

  @override
  String get accountSignOut => 'Sign out';

  @override
  String get accountSignOutTitle => 'Sign out?';

  @override
  String get accountSignOutBody => 'You’ll need a new code to sign back in.';

  @override
  String get accountStaySignedIn => 'Stay signed in';

  @override
  String get backupTitle => 'Cloud backup';

  @override
  String get backupChecking => 'Checking for a backup…';

  @override
  String get backupIntro =>
      'Keep your visitors and invites if you change or reset your phone. They’re encrypted on this phone with a recovery phrase only you have, so nobody else can read them, not even Gatepass.';

  @override
  String get backupPhraseTitle => 'Your recovery phrase';

  @override
  String get backupPhraseBody =>
      'Write these 12 words down and keep them safe. You’ll need them to restore on another phone. Without them the backup can’t be opened.';

  @override
  String get backupRestoreTitle => 'Restore your backup';

  @override
  String get backupRestoreBody =>
      'This account already has a backup. Enter its 12-word recovery phrase to bring it to this phone.';

  @override
  String get backupOnTitle => 'Cloud backup is on';

  @override
  String get backupOnBody =>
      'Changes back up automatically, encrypted on this phone first.';

  @override
  String backupOnBodyLast(String day, String time) {
    return 'Last backed up $day at $time. Changes back up automatically.';
  }

  @override
  String get backupUnreachable =>
      'Couldn’t reach the backup. Check your connection.';

  @override
  String get backupWrongPhrase => 'That phrase doesn’t open this backup.';

  @override
  String get backupSomethingWrong => 'Something went wrong. Try again.';

  @override
  String get backupEnterAllWords => 'Enter all 12 words, separated by spaces.';

  @override
  String get backupRestored => 'Backup restored';

  @override
  String get backupIsOn => 'Cloud backup is on';

  @override
  String get backupBackedUp => 'Backed up';

  @override
  String get backupTurnedOff => 'Cloud backup turned off';

  @override
  String get backupStartOverTitle => 'Start a new backup?';

  @override
  String get backupStartOverBody =>
      'The old backup is replaced, and anything only it had is lost. Invites on this phone are kept.';

  @override
  String get backupStartOver => 'Start over';

  @override
  String get backupTurnOffTitle => 'Turn off cloud backup?';

  @override
  String get backupTurnOffBody =>
      'The backup is deleted from the cloud. Invites stay on this phone.';

  @override
  String get backupTurnOff => 'Turn off';

  @override
  String get backupKeepOn => 'Keep it on';

  @override
  String get backupCopyWords => 'Copy words';

  @override
  String get backupCopiedWords => 'Copied. Save them somewhere safe.';

  @override
  String get backupPhraseLabel => 'Recovery phrase';

  @override
  String get backupPhraseHint => '12 words';

  @override
  String get backupTurnOn => 'Turn on';

  @override
  String get backupSaved => 'I’ve saved them';

  @override
  String get backupRestore => 'Restore';

  @override
  String get backupLostPhrase => 'Lost the phrase? Start a new backup';

  @override
  String get backupBackUpNow => 'Back up now';

  @override
  String get backupTurnOffButton => 'Turn off cloud backup';

  @override
  String homeUnreadNotifications(int count) {
    return '$count unread notifications';
  }

  @override
  String homeGreeting(String greeting, String name) {
    return '$greeting, $name';
  }

  @override
  String get homeLiveInvites => 'Live invites';

  @override
  String get homeAllVisitors => 'All visitors';

  @override
  String get homeNoLiveTitle => 'No live invites';

  @override
  String get homeNoLiveBody => 'Tap a tile above to let someone in.';

  @override
  String get homeLetSomeoneIn => 'Let someone in';

  @override
  String get homeLetSomeoneInBody =>
      'One tap creates a gate code. Hold a tile to adjust it.';

  @override
  String get homeDeliveriesAndRides => 'Deliveries & rides';

  @override
  String homeCreateCodeFor(String name) {
    return 'Create a gate code for $name';
  }

  @override
  String get homePeopleInvited => 'People you’ve invited';

  @override
  String get homeSomeoneNew => 'Someone new';

  @override
  String get homeInviteSomeoneNew => 'Invite someone new';

  @override
  String homeAlreadyInvited(String name) {
    return '$name already has an invite';
  }

  @override
  String homeInviteAgain(String name) {
    return 'Invite $name again';
  }

  @override
  String get inviteNotFoundTitle => 'Invite not found';

  @override
  String get inviteNotFoundBody => 'It may belong to another property.';

  @override
  String get inviteDetailServiceCaption =>
      'The guard scans this, or the driver gives the code.';

  @override
  String inviteDetailPersonCaption(String name) {
    return 'Show this at the gate, or send $name the invite.';
  }

  @override
  String get inviteCopyCode => 'Copy code';

  @override
  String get inviteCodeCopied => 'Code copied';

  @override
  String get inviteShare => 'Share';

  @override
  String get inviteDetails => 'Details';

  @override
  String get inviteMobile => 'Mobile';

  @override
  String get inviteVehicle => 'Vehicle';

  @override
  String get inviteAdded => 'Added';

  @override
  String get inviteRevokeCode => 'Revoke code';

  @override
  String inviteRevokePerson(String name) {
    return 'Revoke $name’s invite';
  }

  @override
  String inviteServiceCanComeIn(String name) {
    return '$name can come in';
  }

  @override
  String invitePersonInvited(String name) {
    return '$name is invited';
  }

  @override
  String get inviteCreatedShare => 'Share invite';

  @override
  String get inviteCreatedTitle => 'Invite ready';

  @override
  String inviteCreatedBody(String name) {
    return 'Share it with $name: the code, the link or a picture of this QR all work at the gate.';
  }

  @override
  String get inviteCreatedValid => 'Valid';

  @override
  String get inviteFormTitle => 'New invite';

  @override
  String get inviteFormFullName => 'Full name';

  @override
  String get inviteFormMoreOptions => 'More options';

  @override
  String get inviteFormFewerOptions => 'Fewer options';

  @override
  String get inviteFormOptionsSummary =>
      'Another day, set hours, mobile number or car';

  @override
  String get inviteFormIncludesPhone => 'Includes mobile number';

  @override
  String get inviteFormIncludesCar => 'Includes car';

  @override
  String get inviteFormIncludesPhoneAndCar => 'Includes mobile number and car';

  @override
  String get inviteFormMobileOptional => 'Mobile number (optional)';

  @override
  String get inviteFormMobileHelper => 'Saved on their visitor profile.';

  @override
  String get inviteFormWhichDay => 'Which day?';

  @override
  String get inviteFormAnotherDay => 'Another day…';

  @override
  String get inviteFormHowLong => 'How long can they stay?';

  @override
  String get inviteFormArrivingFrom => 'Arriving from';

  @override
  String get inviteFormByCar => 'Coming by car';

  @override
  String get inviteFormByCarHelper =>
      'Guards can match the registration at the gate';

  @override
  String get inviteFormRegistration => 'Registration number';

  @override
  String get inviteFormRegistrationHint => 'e.g. HN 42 KP GP';

  @override
  String get inviteFormStartPassed =>
      'That start time has passed. Pick a later one.';

  @override
  String get inviteFormCreate => 'Create invite';

  @override
  String inviteFormValidAllDayToday(String time) {
    return 'Valid all day today, until $time';
  }

  @override
  String get inviteFormValidAllDayTomorrow => 'Valid all day tomorrow';

  @override
  String inviteFormValidAllDayOn(String day) {
    return 'Valid all day $day';
  }

  @override
  String inviteFormValid(String window) {
    return 'Valid $window';
  }

  @override
  String get stayAllDay => 'All day';

  @override
  String stayHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hours',
      one: '1 hour',
    );
    return '$_temp0';
  }

  @override
  String passSiteAndWindow(String site, String window) {
    return '$site · $window';
  }

  @override
  String get passCaption =>
      'Scan this at the gate, or give the guard the code.';

  @override
  String get quickFailed => 'Couldn’t create the code';

  @override
  String quickUntil(String time) {
    return 'Until $time';
  }

  @override
  String quickUntilOtherDay(String time, String day) {
    return '$time $day';
  }

  @override
  String get quickServiceCaption =>
      'Send the driver the code. The guard can also scan this.';

  @override
  String get quickCopied => 'Copied';

  @override
  String quickRevoked(String name) {
    return 'Code for $name revoked';
  }

  @override
  String revokeServiceTitle(String name) {
    return 'Revoke the $name code?';
  }

  @override
  String revokePersonTitle(String name) {
    return 'Revoke $name’s invite?';
  }

  @override
  String get revokeBody => 'The link and gate code stop working straight away.';

  @override
  String get revokeKeep => 'Keep it';

  @override
  String get shareSendDriver => 'Send the driver any of these.';

  @override
  String shareSendPerson(String name) {
    return 'Send $name any of these.';
  }

  @override
  String get shareCode => 'Code';

  @override
  String get shareLink => 'Link';

  @override
  String get shareImage => 'Image';

  @override
  String get shareImageSubtitle => 'The QR code and gate code as a picture';

  @override
  String get shareMessage => 'Invite message';

  @override
  String get shareMessageSubtitle => 'A note with the link and the code';

  @override
  String shareImageFileName(String code) {
    return 'Gate pass $code.png';
  }

  @override
  String get shareImageFailed =>
      'Couldn’t make the picture. Share the code or link instead.';

  @override
  String shareGateCode(String site, String code) {
    return 'Gate code for $site: $code';
  }

  @override
  String shareGateCodeUntil(String site, String code, String time) {
    return 'Gate code for $site: $code (valid until $time)';
  }

  @override
  String shareInviteMessage(
    String name,
    String site,
    String window,
    String link,
    String code,
  ) {
    return 'Hi $name, you’re invited to $site ($window). Show the QR code from this link at the gate: $link — or give the guard the access code $code.';
  }

  @override
  String get visitorsTitle => 'Visitors';

  @override
  String visitorsActive(int count) {
    return 'Active · $count';
  }

  @override
  String get visitorsPast => 'Past';

  @override
  String get visitorsSwipeHint => 'Swipe an invite left to revoke it.';

  @override
  String get visitorsNoneTitle => 'No visitors coming';

  @override
  String get visitorsNoneBody =>
      'Invite someone and they’ll get a link to use at the gate.';

  @override
  String get visitorsNoneAction => 'Invite a visitor';

  @override
  String get visitorsNoPastTitle => 'No past visits';

  @override
  String get visitorsNoPastBody => 'Expired and revoked invites end up here.';

  @override
  String get visitorsValidNow => 'Valid now';

  @override
  String get visitorsLaterToday => 'Later today';
}
