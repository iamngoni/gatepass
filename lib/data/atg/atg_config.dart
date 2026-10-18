/// Live "At The Gate" (ATG Digital) backend, as recovered by static analysis
/// of the official app (`net.atthegate.notification` v28.2.2, `libapp.so`),
/// gathered in one place so the uncertain parts are a one-line fix once a real
/// response confirms them.
///
/// CONFIDENCE
///  - Hosts, auth mechanism, header name, endpoint paths: HIGH — these are
///    literal strings in the app binary.
///  - Request/response JSON field names (the `f*` constants) and HTTP methods:
///    INFERRED. The AOT snapshot doesn't keep field names next to their class,
///    so these are best guesses from model strings and REST convention.
///
/// HOW TO FINALISE
///  1. Keep [dryRunWrites] = true (the default). Create/revoke will compose the
///     exact request and refuse to send it, so nothing touches your estate.
///  2. With [debugLog] on, sign in and open Visitors once. `fetchInvites` logs
///     the real (token-redacted) JSON from YOUR account.
///  3. Correct the `f*` field names + paths below to match that JSON.
///  4. Only then set [dryRunWrites] = false to let create/revoke actually send.
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
  static const createVisitorPath = '/api/visitor'; // POST: create invite
  static const shareVisitorPath = '/api/visitor/v4/share'; // POST: send invite
  static const deleteVisitorPath =
      '/api/visitor/profile/delete'; // POST: revoke (soft-delete)
  static const categoriesPath = '/api/visitor/categories'; // GET
  static const entriesFilterPath = '/api/entries/filter'; // POST/GET
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

  // --- INFERRED visitor request field names. Fix from the logged raw JSON. ---
  static const fMobile = 'mobile';
  static const fVisitorName = 'visitorName';
  static const fFirstName = 'firstName';
  static const fLastName = 'lastName';
  static const fCategoryId = 'categoryId';
  static const fDateFrom = 'dateFrom';
  static const fDateTo = 'dateTo';
  static const fValidFrom = 'validFrom';
  static const fAddress = 'address';
  static const fLicence = 'licence';
  static const fSingleEntry = 'single'; // true = one entry, false = multi
  static const fShareLink = 'shareLink';
  static const fProfileId = 'uid'; // id used by delete/share: maybe 'id'

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
  static const bool dryRunWrites = true;
}
