# Gatepass

A resident-side redesign of At The Gate (ATG) estate access: one-tap visitor
invites for deliveries and known people, revoke, and the QR pass — with no
Bluetooth, and a zero-Material design system (Figtree/Bricolage Grotesque,
Lucide icons, hand-built controls).

## Status

- Zero-Material UI, complete flows with the live ATG backend.
- Live ATG client in `lib/data/atg/` (OTP sign-in, list/create/revoke invites).
- Visitor create/revoke are still `dryRunWrites = true` until the visitor JSON
  shapes are confirmed against a real response.
- Login shapes are recovered from ATG's own web client and confirmed by a live
  probe; see `lib/data/atg/README.md`.

## Run

```bash
flutter pub get
flutter run
```

Sign in with the mobile number your estate has on file; the OTP arrives by SMS.
