# Live At The Gate client

A `GateRepository` that talks to the real ATG Digital backend
(`api.atthegate.biz`) with your own account's Firebase token. This is the only
repository the app uses — there is no mock.

## Files
- `atg_config.dart` — every host, path, key and field name, in one place.
  Confidence is marked per group.
- `atg_client.dart` — `AtgHttp` (JSON over `dart:io`, no new deps, credentials
  redacted in logs) and `AtgAuth` (OTP sign-in + Firebase custom-token → ID-token
  exchange + refresh).
- `atg_gate_repository.dart` — maps ATG JSON ↔ the app's models.

## What's wired
Sign-in (OTP), session restore, estate account resolution, **list invites**,
**notifications**, and the dry-run create / share / revoke requests. The QR pass
is not mapped yet and throws rather than showing fake data. Gate entries are
unavailable to this account (the API returns `403`), so Activity stays empty.

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

## Verified response shapes
`GET /api/visitor/v3/profiles` returns `{"visitors":[…],"totalNumberFound":…}`.
A row has `id` (the invite record id), `uid` (the shared host uid), `name`,
`code`, `link` / `linkInvitation`, `categoryId`, `dateCreated`, `dateChanged`,
`changeOrVisitDate`, `rememberTill`, `statuses`, `visitsAllowed` and `deleted`.

There is **no** `dateFrom` / `dateTo` / `validFrom` / `validTill` on that row.
A profile without a validity window is open-ended: valid until used up or
revoked. `rememberTill` is the retention horizon (roughly ten years), not the
booking window, so the UI prints "Always valid" instead of inventing times.

`GET /api/notifications/getList` returns a bare list with `id`, `title`,
`customFields`, `dataAdded` and `entryId`. The title carries the
arrival/departure verb. ATG has no per-item read flag, so read state is stored
locally in `tmp/gatepass_notifications_seen.json` (first run seeds the existing
archive as already read).

## Write shapes (confirmed in ATG's web client)
- Create/update: `POST /api/v5/visitor/profile` with `name`, `surname`,
  `phoneNumber`, `carLic`, `categoryId`, `validFrom`, `validTill` (epoch ms),
  `visitsAllowed`, `notifyOn`, …
- Share: `POST /api/visitor/v4/share` with `id` + `email`
- Revoke: `POST /api/visitor/profile/delete` with `id`

Revoke was verified live: this endpoint ignores a JSON body (`500 id can't be
null`) and wants `id` as a query or form parameter. Share uses the same
transport in ATG's client but has not been exercised from this app.

Share and delete take the visitor record `id`, not the host `uid`.

Writes are still guarded by `AtgConfig.dryRunWrites = true`: the request is
composed and logged, then the call throws instead of sending. Flip it only when
you are ready to create one throwaway invite and revoke it straight away.
