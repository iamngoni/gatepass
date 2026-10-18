# Live At The Gate client

A `GateRepository` that talks to the real ATG Digital backend
(`api.atthegate.biz`) with your own account's Firebase token. This is the only
repository the app uses — there is no mock.

## Files

- `atg_config.dart` — every host, path, key and field name in one place.
  Confidence is marked per group.
- `atg_client.dart` — `AtgHttp` (JSON over `dart:io`, no new dependencies,
  credentials redacted in logs) and `AtgAuth` (OTP sign-in, Firebase custom-token
  exchange and refresh).
- `atg_gate_repository.dart` — maps ATG JSON to the app's models.

## What's wired

Sign-in, session restore, estate account resolution, invitation
list/create/revoke, and notifications. The app does not expose a resident QR
pass or a gate-entry history: the pass is not mapped, and this account's
entries endpoint returns `403`.

## Login (exact, recovered from ATG's web client)

ATG's own web app (`app.atthegate.biz`) is a Flutter web build, so its request
bodies are readable in `main.dart.js`. That gave the exact OTP shapes:

```jsonc
// POST /open/login/start
{"loginString":"+27…","channel":"sms","deviceId":"…",
 "appVersion":"28.2.2","appBuildNumber":"280202","platform":"android"}

// POST /open/login/check
{"contact":"+27…","code":"123456","deviceId":"…",
 "appVersion":"28.2.2","appBuildNumber":"280202","platform":"android"}
```

The check response carries the Firebase custom token under `token`.

## The Firebase uid is not the estate account uid

`x-id-token` authenticates with the Firebase uid, but visitor and settings
endpoints want a different `hostUid`. `_loadAccount()` resolves it:

```http
POST /api/sharedAccess/v11/getList
{"deviceType":"android","deviceId":"gatepass",
 "appVersion":"28.2.2","appBuildNumber":"280202"}
```

`sharedAccess[0].hostUid` is that account uid. `/api/profile/full` is a profile
*editor* endpoint (400/403 here) and is not used for resident metadata.

## Estate settings

`GET /api/user/v2/settings?uid=<hostUid>` returns the estate name, the
resident's name/unit and `userSettings.invitationMaxDaysFromToday`. The app uses
that value to limit the “Another day…” date picker; 30 days is only a fallback
while settings are unavailable.

## Verified invitation shapes

`GET /api/visitor/v3/profiles` returns `{"visitors":[…],"totalNumberFound":…}`.
A row has `id` (the invite record id), `uid` (the shared host uid), `name`,
`surname`, `code`, `link` / `linkInvitation`, `categoryId`, `dateCreated`,
`dateChanged`, `changeOrVisitDate`, `rememberTill`, `statuses`, `visitsAllowed`,
`carLic` and `deleted`.

There is **no** `dateFrom` / `dateTo` / `validFrom` / `validTill` on every row.
A profile without a validity window is open-ended: valid until used up or
revoked. `rememberTill` is the retention horizon (roughly ten years), not the
booking window, so the UI prints “Always valid” instead of inventing times.

`GET /api/notifications/getList` returns a bare list with `id`, `title`,
`customFields`, `dataAdded` and `entryId`. The title carries the
arrival/departure verb. ATG has no per-item read flag, so read state is stored
locally in `tmp/gatepass_notifications_seen.json` (first run seeds the existing
archive as already read). `entryId` is not turned into navigation because the
entries endpoint is forbidden for this account.

## Write shapes

- Create: `POST /api/v5/visitor/profile` with `name`, `surname`,
  `phoneNumber`, `carLic`, `categoryId`, `validFrom`, `validTill` (epoch ms),
  `visitsAllowed`, `notifyOn`, …
- Share: `POST /api/visitor/v4/share` with `id` + `email`.
- Revoke: `POST /api/visitor/profile/delete` with `id`.

Create and revoke were verified live against throwaway invitations, then
removed. The create body used `uid`, `name`, `surname`, `categoryId`,
`validFrom`, `validTill`, `visitsAllowed: 1` and `notifyOn: both`. A separate
throwaway confirmed that `carLic` round-trips as `carLicSet`.

Revoke ignores a JSON body (`500 id can't be null`) and wants `id` as a query or
form parameter. Share uses the same transport in ATG's client, but the app does
not call it: the create response already includes the code and link, and the UI
copies a ready-to-send message instead of claiming to send SMS.

`AtgConfig.dryRunWrites` is **off**: create and revoke were verified live. Set
it back to `true` whenever the request shape changes so a bad body cannot reach
the estate.
