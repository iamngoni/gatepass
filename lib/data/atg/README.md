# Live At The Gate client

A `GateRepository` that talks to the real ATG Digital backend
(`api.atthegate.biz`) with your own account's Firebase token. This is the only
repository the app uses — there is no mock.

## Files
- `atg_config.dart` — every host, path, key and **inferred field name**, in one
  place. Start here. Confidence levels are marked.
- `atg_client.dart` — `AtgHttp` (JSON over `dart:io`, no new deps, **JWT values
  redacted in logs**) and `AtgAuth` (OTP sign-in + Firebase custom-token → ID-token
  exchange + refresh).
- `atg_gate_repository.dart` — maps ATG JSON ↔ the app's models.

## What's wired
Sign-in (OTP), **list invites**, **create invite**, **revoke invite**.
Not mapped yet (shapes unknown — these return empty or throw rather than fake
data): the QR pass, gate entries, notifications.

## Run it
```bash
flutter run
```
Sign in with the mobile number your estate has on file; the OTP comes by SMS.

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

The check response carries the Firebase custom token under `token`. A live probe
with this body returns `{"error":"Invalid verification code"}` rather than
`{"error":"Phone number or code missing"}`, confirming the field names.

## Visitor fields are still inferred
The visitor/invite JSON shapes are **inferred** — the AOT snapshot doesn't keep
field names next to their class. So:

1. Leave `AtgConfig.dryRunWrites = true`. Create/revoke will compose the exact
   request and **throw instead of sending**, so a wrong body can't put a junk
   invite into the real gate system.
2. With `debugLog` on, sign in and open **Visitors**. `fetchInvites` logs the
   real (token-redacted) JSON from your account.
3. Compare it to the `f*` constants in `atg_config.dart` and fix any that differ
   (e.g. `dateFrom` vs `date_from`, `uid` vs `id`).
4. Only then set `dryRunWrites = false` to let create/revoke actually send —
   test with one throwaway invite first, and watch the log.

## If nothing reaches `api.atthegate.biz`
Then the real app is certificate-pinning and so is your capture. The client code
is still correct; the responsible path at that point is to ask ATG for API access
rather than defeat the pinning.
