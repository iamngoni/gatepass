/// Live "At The Gate" (ATG Digital) backend, as recovered by static analysis
/// of the official app (`net.atthegate.notification` v28.2.2, `libapp.so`),
/// gathered in one place so the uncertain parts are a one-line fix once a real
/// response confirms them.
///
/// CONFIDENCE
///  - Hosts, auth mechanism, header name, endpoint paths: HIGH — literal
///    strings in the app binary, and confirmed by live calls.
///  - Visitor and notification read shapes: VERIFIED against the live API on
///    2026-10-19.
///  - Create body: VERIFIED live (`POST /api/v5/visitor/profile`).
///  - Revoke transport: VERIFIED live — the id must be a form/query parameter,
///    a JSON body is ignored.
///
/// [dryRunWrites] is OFF: create and revoke were each verified live against a
/// throwaway invite and then reverted. Set it back to `true` if the API shapes
/// change, so a wrong body cannot reach the estate.
library;

class AtgConfig {
  const AtgConfig._();

  // --- Hosts (HIGH confidence) ---
  static const apiBase = 'https://api.atthegate.biz';
  static const platformBase = 'https://atthegate.biz/v2';
  static const imageBase = 'https://new.atthegate.biz';
  static const webBase = 'https://app.atthegate.biz';

  // --- Firebase project (HIGH confidence). These keys ship inside every copy
  // of the app, so they are not secret; account access is gated by the Firebase
  // ID token, not by the key. Do NOT reuse the separate Maps Static key. ---
  static const firebaseApiKey = 'AIzaSyAumPPASGBxizO3lf5pbEUlbO-aPGUlu1k';
  static const firebaseProjectId = 'helpful-data-424';

  /// Google Identity Toolkit + Secure Token REST — what the Firebase SDK calls
  /// under the hood to turn a custom token into an ID token, then to refresh it.
  /// (Both were visible in your HAR capture.)
  static String get signInWithCustomTokenUrl =>
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken'
      '?key=$firebaseApiKey';
  static String get secureTokenUrl =>
      'https://securetoken.googleapis.com/v1/token?key=$firebaseApiKey';

  // --- Auth header the ATG API expects, added by the app's Dio AuthInterceptor
  // (HIGH confidence). ---
  static const authHeader = 'x-id-token';

  // --- Endpoint paths (HIGH confidence they exist; methods INFERRED). ---
  static const loginStartPath = '/open/login/start'; // POST: send OTP
  static const loginCheckPath = '/open/login/check'; // POST: verify OTP
  static const sharedAccessPath =
      '/api/sharedAccess/v11/getList'; // POST: estates/accounts for this login
  static const userSettingsPath =
      '/api/user/v2/settings'; // GET: estate metadata for a hostUid
  static const profileFullPath = '/api/profile/full'; // GET: profile editor
  static const invitesListPath =
      '/api/visitor/v3/profiles'; // GET: list visitor profiles
  static const visitorDetailPath = '/api/v5/visitor/profile'; // GET: one invite
  static const createVisitorPath =
      '/api/v5/visitor/profile'; // POST: create/update a visitor profile
  static const shareVisitorPath = '/api/visitor/v4/share'; // POST: send invite
  static const deleteVisitorPath =
      '/api/visitor/profile/delete'; // POST: revoke (soft-delete)
  static const categoriesPath = '/api/visitor/categories'; // GET
  static const entriesListPath = '/api/entries/v2/getList'; // GET
  static const entriesFilterPath = '/api/entries/filter'; // POST/GET
  static const notificationsListPath = '/api/notifications/getList'; // GET
  static const notificationAckPath = '/api/notification/acknowledge'; // POST

  // --- Login. Recovered verbatim from ATG's own web client
  // (app.atthegate.biz/main.dart.js, version 28.2.5) — exact, not inferred:
  //   /open/login/start → {loginString, channel?, captchaToken?, deviceId,
  //                       appVersion, appBuildNumber, platform}
  //   /open/login/check → {contact, code, deviceId, appVersion,
  //                       appBuildNumber, platform}
  // A live probe with this check body returns "Invalid verification code"
  // instead of "Phone number or code missing", confirming the field names.
  static const fLoginString = 'loginString';
  static const fChannel = 'channel';
  static const fContact = 'contact';
  static const fCode = 'code';
  static const fDeviceId = 'deviceId';
  static const fAppVersion = 'appVersion';
  static const fAppBuildNumber = 'appBuildNumber';
  static const fPlatform = 'platform';

  static const loginChannelSms = 'sms';

  /// Identity the OTP calls report. These match the current ATG Android build
  /// (manifest versionName 28.2.2 / versionCode 280202).
  static const appVersion = '28.2.2';
  static const appBuildNumber = '280202';
  static const platform = 'android';

  // --- Visitor request field names. Confirmed against ATG's own web client
  // (`main.dart.js`, v28.2.5): POST /api/v5/visitor/profile sends
  // id, uid, name, surname, email, company, photo, idNumber, carLic,
  // phoneNumber, allowDuplication, nfc, field1..3, categoryId, defaultDeletion,
  // forgetVisitor, forgetVisitorDays, leeway, visitorFields, defaultLimitation,
  // validFrom, validTill, visitsAllowed, weekdayLimit, weekdays, notifyOn,
  // regeneratePinCode, resetDate, resetVisits. ---
  static const fMobile = 'phoneNumber';
  static const fVisitorName = 'name';
  static const fFirstName = 'name';
  static const fLastName = 'surname';
  static const fCategoryId = 'categoryId';
  static const fDateFrom = 'validFrom';
  static const fDateTo = 'validTill';
  static const fValidFrom = 'validFrom';
  static const fValidTill = 'validTill';
  static const fVisitsAllowed = 'visitsAllowed';
  static const fNotifyOn = 'notifyOn';
  static const fAddress = 'address'; // not part of the profile create body
  static const fLicence = 'carLic';
  static const fSingleEntry = 'single'; // not part of the create body
  static const fShareLink = 'linkInvitation';

  /// Share (`/api/visitor/v4/share`) and delete
  /// (`/api/visitor/profile/delete`) both take this key — the visitor record
  /// id, not the host uid.
  static const fProfileId = 'id';

  /// `/open/login/check` returns the Firebase custom token under `token`
  /// (ATG's web client passes it straight to signInWithCustomToken). The other
  /// keys are fallbacks for a renamed envelope.
  static const customTokenKeys = [
    'token',
    'customToken',
    'custom_token',
    'authToken',
    'firebaseToken',
    'jwt',
  ];

  // --- Behaviour ---
  /// Print redacted requests/responses to the console (for schema discovery).
  static const bool debugLog = true;

  /// When true, create/revoke compose the request and THROW instead of sending,
  /// so a wrong body can't put a junk invite into the real estate system.
  static const bool dryRunWrites = false;
}
