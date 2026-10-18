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

## Verify-first workflow (important)
The endpoints, auth and headers are recovered from the app binary with high
confidence. The **JSON request/response shapes are inferred** — the AOT snapshot
doesn't keep field names next to their class. So:

1. Leave `AtgConfig.dryRunWrites = true`. Create/revoke will compose the exact
   request and **throw instead of sending**, so a wrong body can't put a junk
   invite into the real gate system.
2. With `debugLog` on, sign in and open **Visitors**. `fetchInvites` logs the
   real (token-redacted) JSON from your account.
3. Compare it to the `f*` constants in `atg_config.dart` and fix any that differ
   (e.g. `dateFrom` vs `date_from`, `uid` vs `id`).
4. Only then set `dryRunWrites = false` to let create/revoke actually send —
   test with one throwaway invite first, and watch the log.

If sign-in itself fails, read the logged `login/check` response: the Firebase
custom token is under some key — add it to `AtgConfig.customTokenKeys`, and
check whether `/open/login/start` wants `mobile` or `phoneNumber`.

## If nothing reaches `api.atthegate.biz`
Then the real app is certificate-pinning and so is your capture. The client code
is still correct; the responsible path at that point is to ask ATG for API access
rather than defeat the pinning.
