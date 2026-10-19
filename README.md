# Gatepass

A resident-side client for At The Gate (ATG) estates. It creates single-entry
visitor invitations in one tap, keeps the real gate code and share link handy,
and shows the visitor notifications ATG returns for the signed-in resident.

The UI is built without Material, using the Gatepass component kit, Figtree,
Bricolage Grotesque and Lucide icons. Delivery and ride shortcuts use each
service's actual app icon. The app icon's source is `design/app-icon.svg`.

## What works

- ATG OTP sign-in and session restore.
- Estate account resolution, including the estate's
  `invitationMaxDaysFromToday` limit.
- List, create and revoke visitor invitations through the live ATG API.
- A scannable QR code on every live invite. It encodes the raw ATG access
  code, which is exactly what ATG's own visitor page encodes, so the guard's
  scanner reads it the same way.
- Share any invite as the code, ATG's visitor link, a picture of the gate
  pass, or (for people) a full invite message, through the phone's share
  sheet.
- A new invite needs only a full name and is valid all day today. More
  options sets another day, a number of hours, a mobile number or a car.
- Notifications, with read state kept on the device because ATG has no per-item
  read flag.
- Quick invite shortcuts for rides (Uber, Bolt, inDrive), food (Uber Eats,
  Mr D, KFC, Debonairs), groceries and pharmacy (Checkers Sixty60, Pick n Pay
  asap!, Woolies Dash, Zulzi, Clicks, Dis-Chem) and parcels (Amazon, Takealot,
  Makro, SHEIN, Temu, Superbalist, Courier Guy, DHL, Aramex).

## History and backup

ATG deletes a visitor profile on revoke and lists only the latest 50, so the
app keeps every invite it sees in the Keychain (iOS) or Keystore-backed storage
(Android), per ATG account.

Cloud backup is optional and end-to-end encrypted. Turning it on shows a
12-word recovery phrase (BIP39 English words, 132 bits). The phone derives a key
from it with Argon2id (19 MiB, 2 passes), seals the archive with AES-256-GCM
bound to the account, and keeps only the derived key. The Worker in `cloud/`
(`gatepass-backup` on Cloudflare at `gatepass.antonlabs.cc`, backed by KV) verifies the ATG Firebase ID
token, stores one sealed blob per hashed uid, and rejects stale writes so
phones merge before they upload. Without the phrase a backup can't be opened.

```bash
cd cloud && npm install && npx wrangler deploy
```

## What is deliberately absent

- **No resident QR pass.** Invites have QR codes; the resident's own pass is
  a different ATG endpoint that is not mapped.
- **No Activity or gate-entry screen.** This account's gate-entry endpoint
  returns `403`; the app does not invent arrival history or camera photos.
- **No pre-screening, multi-entry or on-site timeline controls.** This create
  flow does not send those choices, so the app does not pretend they exist.
- **No SMS delivery.** The app stores the optional mobile number and hands
  the invite to the share sheet; it never claims to send an SMS itself.

See `lib/data/atg/README.md` for the verified API shapes and
`docs/atg-api-endpoints.md` for the wider endpoint research.

## Run

```bash
flutter pub get
flutter run
```

Sign in with the mobile number your estate has on file; the OTP arrives by SMS
or WhatsApp.

## Release

Pushing a `v*` tag that matches the `version` in `pubspec.yaml` runs
`.github/workflows/release.yml` on a self-hosted Linux x64 runner (labels
`self-hosted`, `linux`, `x64`). It analyzes, tests, builds a signed APK and
attaches it with its SHA-256 to the GitHub release.

```bash
git tag v0.1.0 && git push origin v0.1.0
```

Signing needs the `ANDROID_KEYSTORE_BASE64` and `ANDROID_KEYSTORE_PASSWORD`
repository secrets (key alias `gatepass`). Local release builds read
`android/key.properties` (gitignored) with `storeFile`, `storePassword`,
`keyAlias` and `keyPassword`, and fall back to the debug key without it. Keep a
backup of the keystore (it lives in the private `iamngoni/keys` repo as
`gatepass.jks`): Android only installs updates signed with the same key.
