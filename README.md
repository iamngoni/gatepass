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
- A new invite needs only a full name and is valid all day today. More
  options sets another day, a number of hours, a mobile number or a car.
- Notifications, with read state kept on the device because ATG has no per-item
  read flag.
- Quick invite shortcuts for Uber, Bolt, Uber Eats, Mr D, Checkers Sixty60,
  Pick n Pay asap!, Woolies Dash, Amazon, Takealot and Courier Guy.

## What is deliberately absent

- **No resident QR pass.** Invites have QR codes; the resident's own pass is
  a different ATG endpoint that is not mapped.
- **No Activity or gate-entry screen.** This account's gate-entry endpoint
  returns `403`; the app does not invent arrival history or camera photos.
- **No pre-screening, multi-entry or on-site timeline controls.** This create
  flow does not send those choices, so the app does not pretend they exist.
- **No SMS delivery.** The app stores the optional mobile number and copies a
  ready-to-send invitation message; it never claims to send an SMS.

See `lib/data/atg/README.md` for the verified API shapes and
`docs/atg-api-endpoints.md` for the wider endpoint research.

## Run

```bash
flutter pub get
flutter run
```

Sign in with the mobile number your estate has on file; the OTP arrives by SMS.
