# ATG Digital — API map (from static analysis)

Extracted from `libapp.so` (Flutter AOT Dart snapshot) in **ATG Digital v28.2.2**
(`net.atthegate.notification`, armeabi-v7a split). Static strings only — no account or
server was touched. Dart package name inside the app: `atg_user_app`. HTTP client: **Dio**.

> Confidence: **paths, hosts, header names and model field names are literal strings found in
> the binary** (high confidence they exist). **HTTP methods, which base URL each path hangs off,
> and exact JSON body shapes are inferred** from REST conventions and nearby code strings — verify
> with one authenticated capture before relying on them.

---

## Hosts / base URLs (literal)

| Host | Role |
|------|------|
| `https://api.atthegate.biz` | Main REST API. Dio `baseUrl`; `AuthInterceptor` attaches `x-id-token`. The `/api/...` paths below hang off this. |
| `https://atthegate.biz/v2/platform/...` | Platform config: `settings`, `assets`, `incident-settings` (query-string driven). |
| `https://new.atthegate.biz` | Image/CDN host: `/entry/image?uid=…`, `/image?url=…`. |
| `https://app.atthegate.biz` | Web app — almost certainly where generated invite `shareLink`s point. |

### Firebase project (auth + realtime + crash)
- Project: **`helpful-data-424`**
- Realtime DB: `helpful-data-424.firebaseio.com`  ·  Storage bucket: `helpful-data-424.appspot.com`
- Android app id: `960960248540:android:34d0735313c03587`
- Crash/perf: Sentry (`libsentry.so`) + Firebase Crashlytics
- Embedded Google API keys (client-side, public by design — see caveats): a Maps Static key and a Firebase Android key.

---

## Auth flow (confirmed strings: `createAccountWithCustomToken`, `IdTokenResult`, `AuthInterceptor`, `x-id-token`)

1. `POST /open/login/start` — body: `loginString`, optional `channel`/`captchaToken`, `deviceId`, `appVersion`, `appBuildNumber`, `platform`. Triggers the OTP SMS.
2. `POST /open/login/check` — body: `contact`, `code`, `deviceId`, `appVersion`, `appBuildNumber`, `platform`. Returns `{"token": "<firebase custom token>"}`. (Both shapes are exact, from ATG's Flutter web client at `app.atthegate.biz`.)
3. App calls Firebase Auth `signInWithCustomToken` (project `helpful-data-424`) → gets a
   **Firebase ID token** + refresh token.
4. Every `/api/...` request carries header **`x-id-token: <firebase id token>`**
   (added by Dio's `AuthInterceptor`). An `Authorization` header also appears in the binary.
5. Token refresh goes through `securetoken.googleapis.com` — **this is the only ATG-related call
   that showed up in your HAR capture**, which is why the business API looked "missing": the
   capture caught the auth layer, not `api.atthegate.biz`.

---

## Visitor / invite endpoints (your target)

In ATG's vocabulary an "invite" is a **visitor profile** you create and then **share**.

| Method (inferred) | Path | What it does |
|---|---|---|
| GET  | `/api/visitor/v3/profiles` | List your visitor profiles (your invites). |
| GET  | `/api/v5/visitor/profile` | Single visitor profile detail. |
| POST | `/api/visitor` | **Create a visitor / invite** (`VisitorCreateState`). |
| POST | `/api/visitor/v4/share` | **Share/send one invite** — generates the `shareLink`. |
| POST | `/api/visitor/v2/share/multi` | Share several at once. |
| GET  | `/visitor/v2/sharedText` | The share message text template. |
| GET  | `/api/visitor/categories` | Visitor categories (delivery, guest, contractor…). |
| GET  | `/api/visitor/image` | Visitor photo. |
| GET  | `/api/visitor/history` | History for a visitor. |
| POST | `/api/visiting/update` | Update an active visit. |
| POST | `/api/visitor/profile/approve` · `/api/visitor/profiles/approve` | Approve (single / multi). |
| POST | `/api/visitor/profile/delete` · `/api/visitor/profiles/delete` | **Revoke = delete** (single / multi). |
| POST | `/api/visitor/profile/restore` · `/api/visitor/profiles/restore` | Undo a delete. |
| POST | `/api/visitor/profiles/move` · `/reset` · `/registered` | Move / reset / mark registered. |
| —    | `/api/visitors/import/*` | Bulk import (list, validate, create, records, override, delete). |

> **There is no `/revoke` endpoint.** Revoking an invite is a **delete** (`/api/visitor/profile/delete`),
> with `/restore` as the undo. That matches the app's soft-delete model.

### Likely create/share body fields (model strings found)
`visitorName`, `firstName`, `lastName`, `mobile`, `category` / `categoryId`,
`dateFrom`, `dateTo`, `validFrom`, `address`, `licence` (vehicle/driver licence),
`single` (single- vs multi-entry). Response includes `shareLink`.

---

## Other endpoints (context)

**Gate entries (arrivals)**
`/api/entries/filter` · `/api/entries/totals` · `/api/entries/v3/totals/counts` ·
`/api/entry/details` · `/api/entry/history` · `/api/entry/comment` · `/create-entry` ·
entry images via `https://new.atthegate.biz/entry/image?uid=…`

**Profile / settings**
`/api/profile/full` · `/api/profiles/light` · `/api/user/v2/settings` ·
`/api/settings/get` · `/api/settings/edit` · `/agree/version` (ToS)

**Notifications**
`/api/notification/acknowledge` · `/api/notification/delete`

**Also present (guard/admin side, not resident):** assets, attendance, devices/IoT,
incidents, CSV/scheduled reports. These need elevated roles and aren't part of the resident flow.

> Note: strings like `/registered-list/:uid`, `/attendance/:uid`, `/dashboard-plus/:uid` are the
> app's **internal navigation routes**, not HTTP endpoints. The real API calls are the `/api/...` ones.

---

## Feasibility for connecting Gatepass to your own account

- **No App Check / Play Integrity / SafetyNet / reCAPTCHA strings were found** in the binary.
  That strongly suggests the API accepts any valid Firebase ID token for your account, regardless
  of which client sends it — so Gatepass could, in principle:
  1. Run the OTP login (`/open/login/start` → `/open/login/check`),
  2. Exchange the returned custom token via the Firebase Auth SDK against project `helpful-data-424`,
  3. Call `api.atthegate.biz` with `x-id-token`.
- **Confirm before trusting the shapes.** Static strings give the map, not the exact method +
  base-path pairing + JSON body. One authenticated capture of the real app doing *list → create →
  delete* nails those down. (If that capture still shows nothing on `api.atthegate.biz`, the app is
  certificate-pinning and the responsible path is to ask ATG for API access.)
- **Stay read-only first.** `GET /api/visitor/v3/profiles` is the safe first call — it only reads
  your own invites. Add create/delete only after the read works, one request at a time, no polling
  loops. It's your account; don't hammer it.

## Caveats
- APKs here came from **APKPure** (a third-party mirror). Fine for reading; don't install on a real
  device without checking the signing cert against Google Play.
- The embedded Google/Firebase API keys are shipped in every copy of the app (public by design).
  Don't reuse the **Maps Static** key — it's billable and tied to ATG's account. The Firebase keys
  only identify the project; account access is gated by the Firebase ID token, not the key.
- This is interop research on an app you have a legitimate account for. Keep it to your own account
  and your own data.

---

## Verified against the live API (resident account, 2026-10-19)

These were confirmed by calling the API with the signed-in resident's own
Firebase token. Nothing here is inferred.

### Firebase uid ≠ estate account uid

The Firebase login uid that authenticates `x-id-token` is **not** the uid the
visitor and settings endpoints expect. Resolve the estate account first:

```http
POST /api/sharedAccess/v11/getList
x-id-token: <Firebase ID token>
Content-Type: application/json

{"deviceType":"android","deviceId":"gatepass",
 "appVersion":"28.2.2","appBuildNumber":"280202"}
```

The response is `{"sharedAccess":[{...}]}`. Its `hostUid` is the estate account
uid, and the row also carries `accountName`, `invitationsUserName`,
`invitationsUserUnit`, `email` and — sensitive — `hostSharedKey`.

`GET` on this path returns `405`; it must be `POST`.

With `hostUid`, these return `200`:

- `GET /api/visitor/v3/profiles?uid=<hostUid>&limit=50`
- `GET /api/user/v2/settings?uid=<hostUid>`
- `GET /api/visitor/categories?uid=<hostUid>`

### `/api/profile/full` is not resident metadata

It is the profile **editor** endpoint and returns `400`/`403` for this flow.
Do not use it to recover the resident's name or unit; use
`/api/sharedAccess/v11/getList` and `/api/user/v2/settings`.

### Visitor list response (verified)

`GET /api/visitor/v3/profiles` returns an object, not a bare list:

```jsonc
{"visitors":[{ ... }], "totalNumberFound":1, "loadMore":false,
 "notifyOnEntrance":true, "notifyOnExit":true}
```

A visitor row:

```jsonc
{
  "id": 5219924235255808,          // per-invite record id (number)
  "uid": "…",                       // estate hostUid, shared by every row
  "name": "…",
  "code": "ATG…",
  "link": "https://…",
  "linkInvitation": "https://…",
  "categoryId": 5219924235255808,
  "dateCreated": 1792339708895,     // epoch ms
  "dateChanged": 1792339708895,
  "changeOrVisitDate": 1792339708895,
  "rememberTill": 2107699708895,    // retention horizon, ~10 years
  "statuses": [],
  "visitsAllowed": 1,
  "deleted": false,
  "type": "profile"
}
```

There is no `dateFrom`, `dateTo`, `validFrom` or `validTill` on this row. A
profile with no `validFrom`/`validTill` is **open-ended**: it stays valid until
it is used up or revoked. `rememberTill` is retention, not the booking window —
never render it as "valid until" without saying what it is.

### Visitor create / share / delete (confirmed in ATG's web client)

The web client (`app.atthegate.biz/main.dart.js`, v28.2.5) shows the real calls:

| Method | Path | Body |
|---|---|---|
| POST | `/api/v5/visitor/profile` | `id, uid, name, surname, email, company, photo, idNumber, carLic, phoneNumber, allowDuplication, nfc, field1..3, categoryId, defaultDeletion, forgetVisitor, forgetVisitorDays, leeway, visitorFields, defaultLimitation, validFrom, validTill, visitsAllowed, weekdayLimit, weekdays, notifyOn, regeneratePinCode, resetDate, resetVisits` |
| POST | `/api/visitor/v4/share` | `{"id": <visitor id>, "email": <recipient>}` |
| POST | `/api/visitor/profile/delete` | `{"id": <visitor id>}` |
| POST | `/api/visitor/profiles/delete` | form: `uid=<hostUid>&ids=[…]` |

`validFrom` / `validTill` are epoch milliseconds. Share and delete take the
**visitor record id**, not the host uid.

### Notifications (verified)

`GET /api/notifications/getList` returns a bare JSON list of 50 items:

```jsonc
{"id":"…","title":"<visitor> using invitation … has just Entered <estate>",
 "customFields":["Name and Surname: …"],
 "dataAdded":1792339708895,
 "entryId":"<uid>-<hash>",
 "notificationType":"CUSTOM_NOTIFICATION",
 "profileName":"Pedestrian", "deviceName":"Device 1", "importance":0}
```

The `title` carries the arrival/departure verb, so it is the reliable place to
derive the notification kind. There is no per-item read flag; read state is
tracked locally by the app.

### Gate entries are not available to this account

`GET /api/entries/v2/getList?...` returns `403`, and the account's
`accessPermissions` show entries disabled. The app therefore has no Activity
screen and does not fabricate entry history, camera photos, or on-site status.

### Write verification (one throwaway invite, live account)

Exercised end to end with the repository code on 2026-10-19, then removed:

- `POST /api/v5/visitor/profile` with a JSON body **succeeded** (`200`) and
  returned the created record: numeric `id`, `code`, `link`, `linkInvitation`,
  `validFrom`, `validTill`, `validFromDateText`, `validTillDateText`.
  The composed body was:
  `{uid, name, surname, categoryId, validFrom, validTill, visitsAllowed, notifyOn}`.
  `categoryId` came from `GET /api/visitor/categories` — this estate's usable
  category is `Invitation` (`Blocked` is the other one). The id is per-estate,
  so it must be read, not hardcoded.
- `POST /api/visitor/profile/delete` with the id in a **JSON body fails** with
  `500 java.io.IOException: id can't be null`. The same call with the id as a
  **query parameter or form field** returns `200`. The endpoint ignores JSON.
- A separate throwaway create with `carLic` succeeded, and the next profile
  read returned the normalized plate in `carLicSet`, so the vehicle field can be
  surfaced in the app.
- After the form/query delete, `GET /api/visitor/v3/profiles` returned only the
  original invite, so the throwaway record was really gone.

`/api/visitor/v4/share` is called by ATG's web client through the same transport
helper as the delete call, so expect it to want form/query parameters too; it
has not been exercised from this app. The app does not auto-share on create —
the created profile already returns its code and link.
