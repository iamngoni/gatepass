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
  static const profileFullPath = '/api/profile/full'; // GET: resident + sites
  static const invitesListPath = '/api/visitor/v3/profiles'; // GET: list invites
  static const visitorDetailPath = '/api/v5/visitor/profile'; // GET: one invite
  static const createVisitorPath = '/api/visitor'; // POST: create invite
  static const shareVisitorPath = '/api/visitor/v4/share'; // POST: send invite
  static const deleteVisitorPath =
      '/api/visitor/profile/delete'; // POST: revoke (soft-delete)
  static const categoriesPath = '/api/visitor/categories'; // GET
  static const entriesFilterPath = '/api/entries/filter'; // POST/GET
  static const notificationAckPath = '/api/notification/acknowledge'; // POST

  // --- Login request. CONFIRMED from a live 400 ("Login string too short"):
  // the field is `loginString` (not `mobile`), and the number is E.164 like
  // +27XXXXXXXXX (the binary uses `phoneE164` / `isValidPhoneE164`).
  // `loginType` and `channel` are seen in the binary; their exact values are
  // inferred — if the backend rejects them, the error log will say so. ---
  static const fLoginString = 'loginString';
  static const fLoginType = 'loginType';
  static const fChannel = 'channel';
  static const fSmsCode = 'smsCode'; //         /open/login/check code field (CONFIRMED)
  static const fLoginAttempt =
      'loginAttempt'; //                         id from /start, echoed to /check
  static const loginTypeMobile = 'mobile'; //   /start accepts this; server echoes 'phone'
  static const loginChannelSms = 'sms'; //      the app also offers 'whatsapp'

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

  /// The login-check response carries a Firebase custom token; its key is
  /// unknown, so [AtgAuth] searches these candidates for a JWT-looking value.
  static const customTokenKeys = [
    'customToken',
    'custom_token',
    'token',
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
