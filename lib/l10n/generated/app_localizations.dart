import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Gatepass'**
  String get appTitle;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get commonCopy;

  /// No description provided for @commonCut.
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get commonCut;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get commonLoading;

  /// No description provided for @commonNextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get commonNextMonth;

  /// No description provided for @commonPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get commonPaste;

  /// No description provided for @commonPreviousMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get commonPreviousMonth;

  /// No description provided for @commonRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  /// No description provided for @commonRevoke.
  ///
  /// In en, this message translates to:
  /// **'Revoke'**
  String get commonRevoke;

  /// No description provided for @commonSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get commonSelectAll;

  /// No description provided for @commonSetTime.
  ///
  /// In en, this message translates to:
  /// **'Set time'**
  String get commonSetTime;

  /// No description provided for @commonNoCode.
  ///
  /// In en, this message translates to:
  /// **'No code'**
  String get commonNoCode;

  /// No description provided for @appearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get appearanceSystem;

  /// No description provided for @appearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceLight;

  /// No description provided for @appearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceDark;

  /// No description provided for @otpChannelSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get otpChannelSms;

  /// No description provided for @otpChannelWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get otpChannelWhatsapp;

  /// No description provided for @inviteStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get inviteStatusActive;

  /// No description provided for @inviteStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get inviteStatusExpired;

  /// No description provided for @inviteStatusRevoked.
  ///
  /// In en, this message translates to:
  /// **'Revoked'**
  String get inviteStatusRevoked;

  /// No description provided for @dayToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dayToday;

  /// No description provided for @dayTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get dayTomorrow;

  /// No description provided for @dayYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dayYesterday;

  /// No description provided for @windowSameDay.
  ///
  /// In en, this message translates to:
  /// **'{day}, {from} – {until}'**
  String windowSameDay(String day, String from, String until);

  /// No description provided for @windowAcrossDays.
  ///
  /// In en, this message translates to:
  /// **'{fromDay} {from} – {untilDay} {until}'**
  String windowAcrossDays(
    String fromDay,
    String from,
    String untilDay,
    String until,
  );

  /// No description provided for @durationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String durationMinutes(int minutes);

  /// No description provided for @durationHours.
  ///
  /// In en, this message translates to:
  /// **'{hours} h'**
  String durationHours(int hours);

  /// No description provided for @durationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} h {minutes} min'**
  String durationHoursMinutes(int hours, int minutes);

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @inviteAlwaysValid.
  ///
  /// In en, this message translates to:
  /// **'Always valid'**
  String get inviteAlwaysValid;

  /// No description provided for @errorConnection.
  ///
  /// In en, this message translates to:
  /// **'Can’t reach ATG. Check your connection and try again.'**
  String get errorConnection;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'ATG is taking too long to answer. Try again in a moment.'**
  String get errorTimeout;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'ATG couldn’t do that just now. Please try again.'**
  String get errorServer;

  /// No description provided for @errorNotSignedIn.
  ///
  /// In en, this message translates to:
  /// **'You’ve been signed out. Sign in again to continue.'**
  String get errorNotSignedIn;

  /// No description provided for @errorNoEstateAccount.
  ///
  /// In en, this message translates to:
  /// **'No estate account is linked to this number.'**
  String get errorNoEstateAccount;

  /// No description provided for @errorBackupConflict.
  ///
  /// In en, this message translates to:
  /// **'Another phone backed up at the same time. Try again.'**
  String get errorBackupConflict;

  /// No description provided for @errorBackupDecrypt.
  ///
  /// In en, this message translates to:
  /// **'That recovery phrase doesn’t open this backup.'**
  String get errorBackupDecrypt;

  /// No description provided for @errorBackupUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The backup service couldn’t be reached. Try again later.'**
  String get errorBackupUnavailable;

  /// No description provided for @errorPhraseInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter the 12 words of your recovery phrase.'**
  String get errorPhraseInvalid;

  /// No description provided for @errorStorage.
  ///
  /// In en, this message translates to:
  /// **'This phone’s secure storage couldn’t be used.'**
  String get errorStorage;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnknown;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabVisitors.
  ///
  /// In en, this message translates to:
  /// **'Visitors'**
  String get tabVisitors;

  /// No description provided for @tabAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get tabAccount;

  /// No description provided for @tabInviteSomeone.
  ///
  /// In en, this message translates to:
  /// **'Invite someone'**
  String get tabInviteSomeone;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Get through the gate faster'**
  String get signInTitle;

  /// No description provided for @signInLead.
  ///
  /// In en, this message translates to:
  /// **'Sign in with the mobile number your estate has on file.'**
  String get signInLead;

  /// No description provided for @signInCheckWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Check WhatsApp'**
  String get signInCheckWhatsapp;

  /// No description provided for @signInCheckMessages.
  ///
  /// In en, this message translates to:
  /// **'Check your messages'**
  String get signInCheckMessages;

  /// No description provided for @signInEnterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code we sent to {phone}.'**
  String signInEnterCode(String phone);

  /// No description provided for @signInMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get signInMobileNumber;

  /// No description provided for @signInChangeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get signInChangeNumber;

  /// No description provided for @signInResendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get signInResendCode;

  /// No description provided for @signInSendInstead.
  ///
  /// In en, this message translates to:
  /// **'Send by {channel} instead'**
  String signInSendInstead(String channel);

  /// No description provided for @signInCodeSentBy.
  ///
  /// In en, this message translates to:
  /// **'The code was sent by {channel}. It can take a few seconds.'**
  String signInCodeSentBy(String channel);

  /// No description provided for @signInSubmit.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInSubmit;

  /// No description provided for @signInSendBy.
  ///
  /// In en, this message translates to:
  /// **'Send the code by'**
  String get signInSendBy;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'You’re all caught up'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Arrivals, departures and estate notices show up here.'**
  String get notificationsEmptyBody;

  /// No description provided for @notificationsNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get notificationsNew;

  /// No description provided for @notificationsEarlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get notificationsEarlier;

  /// No description provided for @notificationsTime.
  ///
  /// In en, this message translates to:
  /// **'{day}, {time}'**
  String notificationsTime(String day, String time);

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @accountProperty.
  ///
  /// In en, this message translates to:
  /// **'Your property'**
  String get accountProperty;

  /// No description provided for @accountBackup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get accountBackup;

  /// No description provided for @accountBackupOn.
  ///
  /// In en, this message translates to:
  /// **'On, end-to-end encrypted'**
  String get accountBackupOn;

  /// No description provided for @accountOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get accountOff;

  /// No description provided for @accountAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get accountAppearance;

  /// No description provided for @accountAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get accountAbout;

  /// No description provided for @accountAboutGatepass.
  ///
  /// In en, this message translates to:
  /// **'About Gatepass'**
  String get accountAboutGatepass;

  /// No description provided for @accountAboutBody.
  ///
  /// In en, this message translates to:
  /// **'Gatepass signs in to your At The Gate account and uses its visitor invitation service. It shows the estate and invitations returned by that account. Gate entry history is not available to this account.'**
  String get accountAboutBody;

  /// No description provided for @accountSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get accountSignOut;

  /// No description provided for @accountSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get accountSignOutTitle;

  /// No description provided for @accountSignOutBody.
  ///
  /// In en, this message translates to:
  /// **'You’ll need a new code to sign back in.'**
  String get accountSignOutBody;

  /// No description provided for @accountStaySignedIn.
  ///
  /// In en, this message translates to:
  /// **'Stay signed in'**
  String get accountStaySignedIn;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup'**
  String get backupTitle;

  /// No description provided for @backupChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking for a backup…'**
  String get backupChecking;

  /// No description provided for @backupIntro.
  ///
  /// In en, this message translates to:
  /// **'Keep your visitors and invites if you change or reset your phone. They’re encrypted on this phone with a recovery phrase only you have, so nobody else can read them, not even Gatepass.'**
  String get backupIntro;

  /// No description provided for @backupPhraseTitle.
  ///
  /// In en, this message translates to:
  /// **'Your recovery phrase'**
  String get backupPhraseTitle;

  /// No description provided for @backupPhraseBody.
  ///
  /// In en, this message translates to:
  /// **'Write these 12 words down and keep them safe. You’ll need them to restore on another phone. Without them the backup can’t be opened.'**
  String get backupPhraseBody;

  /// No description provided for @backupRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore your backup'**
  String get backupRestoreTitle;

  /// No description provided for @backupRestoreBody.
  ///
  /// In en, this message translates to:
  /// **'This account already has a backup. Enter its 12-word recovery phrase to bring it to this phone.'**
  String get backupRestoreBody;

  /// No description provided for @backupOnTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup is on'**
  String get backupOnTitle;

  /// No description provided for @backupOnBody.
  ///
  /// In en, this message translates to:
  /// **'Changes back up automatically, encrypted on this phone first.'**
  String get backupOnBody;

  /// No description provided for @backupOnBodyLast.
  ///
  /// In en, this message translates to:
  /// **'Last backed up {day} at {time}. Changes back up automatically.'**
  String backupOnBodyLast(String day, String time);

  /// No description provided for @backupUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t reach the backup. Check your connection.'**
  String get backupUnreachable;

  /// No description provided for @backupWrongPhrase.
  ///
  /// In en, this message translates to:
  /// **'That phrase doesn’t open this backup.'**
  String get backupWrongPhrase;

  /// No description provided for @backupSomethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get backupSomethingWrong;

  /// No description provided for @backupEnterAllWords.
  ///
  /// In en, this message translates to:
  /// **'Enter all 12 words, separated by spaces.'**
  String get backupEnterAllWords;

  /// No description provided for @backupRestored.
  ///
  /// In en, this message translates to:
  /// **'Backup restored'**
  String get backupRestored;

  /// No description provided for @backupIsOn.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup is on'**
  String get backupIsOn;

  /// No description provided for @backupBackedUp.
  ///
  /// In en, this message translates to:
  /// **'Backed up'**
  String get backupBackedUp;

  /// No description provided for @backupTurnedOff.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup turned off'**
  String get backupTurnedOff;

  /// No description provided for @backupStartOverTitle.
  ///
  /// In en, this message translates to:
  /// **'Start a new backup?'**
  String get backupStartOverTitle;

  /// No description provided for @backupStartOverBody.
  ///
  /// In en, this message translates to:
  /// **'The old backup is replaced, and anything only it had is lost. Invites on this phone are kept.'**
  String get backupStartOverBody;

  /// No description provided for @backupStartOver.
  ///
  /// In en, this message translates to:
  /// **'Start over'**
  String get backupStartOver;

  /// No description provided for @backupTurnOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn off cloud backup?'**
  String get backupTurnOffTitle;

  /// No description provided for @backupTurnOffBody.
  ///
  /// In en, this message translates to:
  /// **'The backup is deleted from the cloud. Invites stay on this phone.'**
  String get backupTurnOffBody;

  /// No description provided for @backupTurnOff.
  ///
  /// In en, this message translates to:
  /// **'Turn off'**
  String get backupTurnOff;

  /// No description provided for @backupKeepOn.
  ///
  /// In en, this message translates to:
  /// **'Keep it on'**
  String get backupKeepOn;

  /// No description provided for @backupCopyWords.
  ///
  /// In en, this message translates to:
  /// **'Copy words'**
  String get backupCopyWords;

  /// No description provided for @backupCopiedWords.
  ///
  /// In en, this message translates to:
  /// **'Copied. Save them somewhere safe.'**
  String get backupCopiedWords;

  /// No description provided for @backupPhraseLabel.
  ///
  /// In en, this message translates to:
  /// **'Recovery phrase'**
  String get backupPhraseLabel;

  /// No description provided for @backupPhraseHint.
  ///
  /// In en, this message translates to:
  /// **'12 words'**
  String get backupPhraseHint;

  /// No description provided for @backupTurnOn.
  ///
  /// In en, this message translates to:
  /// **'Turn on'**
  String get backupTurnOn;

  /// No description provided for @backupSaved.
  ///
  /// In en, this message translates to:
  /// **'I’ve saved them'**
  String get backupSaved;

  /// No description provided for @backupRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get backupRestore;

  /// No description provided for @backupLostPhrase.
  ///
  /// In en, this message translates to:
  /// **'Lost the phrase? Start a new backup'**
  String get backupLostPhrase;

  /// No description provided for @backupBackUpNow.
  ///
  /// In en, this message translates to:
  /// **'Back up now'**
  String get backupBackUpNow;

  /// No description provided for @backupTurnOffButton.
  ///
  /// In en, this message translates to:
  /// **'Turn off cloud backup'**
  String get backupTurnOffButton;

  /// No description provided for @homeUnreadNotifications.
  ///
  /// In en, this message translates to:
  /// **'{count} unread notifications'**
  String homeUnreadNotifications(int count);

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'{greeting}, {name}'**
  String homeGreeting(String greeting, String name);

  /// No description provided for @homeLiveInvites.
  ///
  /// In en, this message translates to:
  /// **'Live invites'**
  String get homeLiveInvites;

  /// No description provided for @homeAllVisitors.
  ///
  /// In en, this message translates to:
  /// **'All visitors'**
  String get homeAllVisitors;

  /// No description provided for @homeNoLiveTitle.
  ///
  /// In en, this message translates to:
  /// **'No live invites'**
  String get homeNoLiveTitle;

  /// No description provided for @homeNoLiveBody.
  ///
  /// In en, this message translates to:
  /// **'Tap a tile above to let someone in.'**
  String get homeNoLiveBody;

  /// No description provided for @homeLetSomeoneIn.
  ///
  /// In en, this message translates to:
  /// **'Let someone in'**
  String get homeLetSomeoneIn;

  /// No description provided for @homeLetSomeoneInBody.
  ///
  /// In en, this message translates to:
  /// **'One tap creates a gate code. Hold a tile to adjust it.'**
  String get homeLetSomeoneInBody;

  /// No description provided for @homeDeliveriesAndRides.
  ///
  /// In en, this message translates to:
  /// **'Deliveries & rides'**
  String get homeDeliveriesAndRides;

  /// No description provided for @homeCreateCodeFor.
  ///
  /// In en, this message translates to:
  /// **'Create a gate code for {name}'**
  String homeCreateCodeFor(String name);

  /// No description provided for @homePeopleInvited.
  ///
  /// In en, this message translates to:
  /// **'People you’ve invited'**
  String get homePeopleInvited;

  /// No description provided for @homeSomeoneNew.
  ///
  /// In en, this message translates to:
  /// **'Someone new'**
  String get homeSomeoneNew;

  /// No description provided for @homeInviteSomeoneNew.
  ///
  /// In en, this message translates to:
  /// **'Invite someone new'**
  String get homeInviteSomeoneNew;

  /// No description provided for @homeAlreadyInvited.
  ///
  /// In en, this message translates to:
  /// **'{name} already has an invite'**
  String homeAlreadyInvited(String name);

  /// No description provided for @homeInviteAgain.
  ///
  /// In en, this message translates to:
  /// **'Invite {name} again'**
  String homeInviteAgain(String name);

  /// No description provided for @inviteNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite not found'**
  String get inviteNotFoundTitle;

  /// No description provided for @inviteNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'It may belong to another property.'**
  String get inviteNotFoundBody;

  /// No description provided for @inviteDetailServiceCaption.
  ///
  /// In en, this message translates to:
  /// **'The guard scans this, or the driver gives the code.'**
  String get inviteDetailServiceCaption;

  /// No description provided for @inviteDetailPersonCaption.
  ///
  /// In en, this message translates to:
  /// **'Show this at the gate, or send {name} the invite.'**
  String inviteDetailPersonCaption(String name);

  /// No description provided for @inviteCopyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get inviteCopyCode;

  /// No description provided for @inviteCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied'**
  String get inviteCodeCopied;

  /// No description provided for @inviteShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get inviteShare;

  /// No description provided for @inviteDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get inviteDetails;

  /// No description provided for @inviteMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get inviteMobile;

  /// No description provided for @inviteVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get inviteVehicle;

  /// No description provided for @inviteAdded.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get inviteAdded;

  /// No description provided for @inviteRevokeCode.
  ///
  /// In en, this message translates to:
  /// **'Revoke code'**
  String get inviteRevokeCode;

  /// No description provided for @inviteRevokePerson.
  ///
  /// In en, this message translates to:
  /// **'Revoke {name}’s invite'**
  String inviteRevokePerson(String name);

  /// No description provided for @inviteServiceCanComeIn.
  ///
  /// In en, this message translates to:
  /// **'{name} can come in'**
  String inviteServiceCanComeIn(String name);

  /// No description provided for @invitePersonInvited.
  ///
  /// In en, this message translates to:
  /// **'{name} is invited'**
  String invitePersonInvited(String name);

  /// No description provided for @inviteCreatedShare.
  ///
  /// In en, this message translates to:
  /// **'Share invite'**
  String get inviteCreatedShare;

  /// No description provided for @inviteCreatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite ready'**
  String get inviteCreatedTitle;

  /// No description provided for @inviteCreatedBody.
  ///
  /// In en, this message translates to:
  /// **'Share it with {name}: the code, the link or a picture of this QR all work at the gate.'**
  String inviteCreatedBody(String name);

  /// No description provided for @inviteCreatedValid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get inviteCreatedValid;

  /// No description provided for @inviteFormTitle.
  ///
  /// In en, this message translates to:
  /// **'New invite'**
  String get inviteFormTitle;

  /// No description provided for @inviteFormFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get inviteFormFullName;

  /// No description provided for @inviteFormMoreOptions.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get inviteFormMoreOptions;

  /// No description provided for @inviteFormFewerOptions.
  ///
  /// In en, this message translates to:
  /// **'Fewer options'**
  String get inviteFormFewerOptions;

  /// No description provided for @inviteFormOptionsSummary.
  ///
  /// In en, this message translates to:
  /// **'Another day, set hours, mobile number or car'**
  String get inviteFormOptionsSummary;

  /// No description provided for @inviteFormIncludesPhone.
  ///
  /// In en, this message translates to:
  /// **'Includes mobile number'**
  String get inviteFormIncludesPhone;

  /// No description provided for @inviteFormIncludesCar.
  ///
  /// In en, this message translates to:
  /// **'Includes car'**
  String get inviteFormIncludesCar;

  /// No description provided for @inviteFormIncludesPhoneAndCar.
  ///
  /// In en, this message translates to:
  /// **'Includes mobile number and car'**
  String get inviteFormIncludesPhoneAndCar;

  /// No description provided for @inviteFormMobileOptional.
  ///
  /// In en, this message translates to:
  /// **'Mobile number (optional)'**
  String get inviteFormMobileOptional;

  /// No description provided for @inviteFormMobileHelper.
  ///
  /// In en, this message translates to:
  /// **'Saved on their visitor profile.'**
  String get inviteFormMobileHelper;

  /// No description provided for @inviteFormWhichDay.
  ///
  /// In en, this message translates to:
  /// **'Which day?'**
  String get inviteFormWhichDay;

  /// No description provided for @inviteFormAnotherDay.
  ///
  /// In en, this message translates to:
  /// **'Another day…'**
  String get inviteFormAnotherDay;

  /// No description provided for @inviteFormHowLong.
  ///
  /// In en, this message translates to:
  /// **'How long can they stay?'**
  String get inviteFormHowLong;

  /// No description provided for @inviteFormArrivingFrom.
  ///
  /// In en, this message translates to:
  /// **'Arriving from'**
  String get inviteFormArrivingFrom;

  /// No description provided for @inviteFormByCar.
  ///
  /// In en, this message translates to:
  /// **'Coming by car'**
  String get inviteFormByCar;

  /// No description provided for @inviteFormByCarHelper.
  ///
  /// In en, this message translates to:
  /// **'Guards can match the registration at the gate'**
  String get inviteFormByCarHelper;

  /// No description provided for @inviteFormRegistration.
  ///
  /// In en, this message translates to:
  /// **'Registration number'**
  String get inviteFormRegistration;

  /// No description provided for @inviteFormRegistrationHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. HN 42 KP GP'**
  String get inviteFormRegistrationHint;

  /// No description provided for @inviteFormStartPassed.
  ///
  /// In en, this message translates to:
  /// **'That start time has passed. Pick a later one.'**
  String get inviteFormStartPassed;

  /// No description provided for @inviteFormCreate.
  ///
  /// In en, this message translates to:
  /// **'Create invite'**
  String get inviteFormCreate;

  /// No description provided for @inviteFormValidAllDayToday.
  ///
  /// In en, this message translates to:
  /// **'Valid all day today, until {time}'**
  String inviteFormValidAllDayToday(String time);

  /// No description provided for @inviteFormValidAllDayTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Valid all day tomorrow'**
  String get inviteFormValidAllDayTomorrow;

  /// No description provided for @inviteFormValidAllDayOn.
  ///
  /// In en, this message translates to:
  /// **'Valid all day {day}'**
  String inviteFormValidAllDayOn(String day);

  /// No description provided for @inviteFormValid.
  ///
  /// In en, this message translates to:
  /// **'Valid {window}'**
  String inviteFormValid(String window);

  /// No description provided for @stayAllDay.
  ///
  /// In en, this message translates to:
  /// **'All day'**
  String get stayAllDay;

  /// No description provided for @stayHours.
  ///
  /// In en, this message translates to:
  /// **'{hours, plural, =1{1 hour} other{{hours} hours}}'**
  String stayHours(int hours);

  /// No description provided for @passSiteAndWindow.
  ///
  /// In en, this message translates to:
  /// **'{site} · {window}'**
  String passSiteAndWindow(String site, String window);

  /// No description provided for @passCaption.
  ///
  /// In en, this message translates to:
  /// **'Scan this at the gate, or give the guard the code.'**
  String get passCaption;

  /// No description provided for @quickFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t create the code'**
  String get quickFailed;

  /// No description provided for @quickUntil.
  ///
  /// In en, this message translates to:
  /// **'Until {time}'**
  String quickUntil(String time);

  /// No description provided for @quickUntilOtherDay.
  ///
  /// In en, this message translates to:
  /// **'{time} {day}'**
  String quickUntilOtherDay(String time, String day);

  /// No description provided for @quickServiceCaption.
  ///
  /// In en, this message translates to:
  /// **'Send the driver the code. The guard can also scan this.'**
  String get quickServiceCaption;

  /// No description provided for @quickCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get quickCopied;

  /// No description provided for @quickRevoked.
  ///
  /// In en, this message translates to:
  /// **'Code for {name} revoked'**
  String quickRevoked(String name);

  /// No description provided for @revokeServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Revoke the {name} code?'**
  String revokeServiceTitle(String name);

  /// No description provided for @revokePersonTitle.
  ///
  /// In en, this message translates to:
  /// **'Revoke {name}’s invite?'**
  String revokePersonTitle(String name);

  /// No description provided for @revokeBody.
  ///
  /// In en, this message translates to:
  /// **'The link and gate code stop working straight away.'**
  String get revokeBody;

  /// No description provided for @revokeKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep it'**
  String get revokeKeep;

  /// No description provided for @shareSendDriver.
  ///
  /// In en, this message translates to:
  /// **'Send the driver any of these.'**
  String get shareSendDriver;

  /// No description provided for @shareSendPerson.
  ///
  /// In en, this message translates to:
  /// **'Send {name} any of these.'**
  String shareSendPerson(String name);

  /// No description provided for @shareCode.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get shareCode;

  /// No description provided for @shareLink.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get shareLink;

  /// No description provided for @shareImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get shareImage;

  /// No description provided for @shareImageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The QR code and gate code as a picture'**
  String get shareImageSubtitle;

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'Invite message'**
  String get shareMessage;

  /// No description provided for @shareMessageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A note with the link and the code'**
  String get shareMessageSubtitle;

  /// No description provided for @shareImageFileName.
  ///
  /// In en, this message translates to:
  /// **'Gate pass {code}.png'**
  String shareImageFileName(String code);

  /// No description provided for @shareImageFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t make the picture. Share the code or link instead.'**
  String get shareImageFailed;

  /// No description provided for @shareGateCode.
  ///
  /// In en, this message translates to:
  /// **'Gate code for {site}: {code}'**
  String shareGateCode(String site, String code);

  /// No description provided for @shareGateCodeUntil.
  ///
  /// In en, this message translates to:
  /// **'Gate code for {site}: {code} (valid until {time})'**
  String shareGateCodeUntil(String site, String code, String time);

  /// No description provided for @shareInviteMessage.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}, you’re invited to {site} ({window}). Show the QR code from this link at the gate: {link} — or give the guard the access code {code}.'**
  String shareInviteMessage(
    String name,
    String site,
    String window,
    String link,
    String code,
  );

  /// No description provided for @visitorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Visitors'**
  String get visitorsTitle;

  /// No description provided for @visitorsActive.
  ///
  /// In en, this message translates to:
  /// **'Active · {count}'**
  String visitorsActive(int count);

  /// No description provided for @visitorsPast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get visitorsPast;

  /// No description provided for @visitorsSwipeHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe an invite left to revoke it.'**
  String get visitorsSwipeHint;

  /// No description provided for @visitorsNoneTitle.
  ///
  /// In en, this message translates to:
  /// **'No visitors coming'**
  String get visitorsNoneTitle;

  /// No description provided for @visitorsNoneBody.
  ///
  /// In en, this message translates to:
  /// **'Invite someone and they’ll get a link to use at the gate.'**
  String get visitorsNoneBody;

  /// No description provided for @visitorsNoneAction.
  ///
  /// In en, this message translates to:
  /// **'Invite a visitor'**
  String get visitorsNoneAction;

  /// No description provided for @visitorsNoPastTitle.
  ///
  /// In en, this message translates to:
  /// **'No past visits'**
  String get visitorsNoPastTitle;

  /// No description provided for @visitorsNoPastBody.
  ///
  /// In en, this message translates to:
  /// **'Expired and revoked invites end up here.'**
  String get visitorsNoPastBody;

  /// No description provided for @visitorsValidNow.
  ///
  /// In en, this message translates to:
  /// **'Valid now'**
  String get visitorsValidNow;

  /// No description provided for @visitorsLaterToday.
  ///
  /// In en, this message translates to:
  /// **'Later today'**
  String get visitorsLaterToday;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
