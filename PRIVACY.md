# Gatepass privacy policy

Last updated: 19 October 2026

Gatepass is an unofficial app for residents of estates that use At The Gate
(ATG). It is not made by or affiliated with ATG.

## What Gatepass handles

- **Your ATG sign-in.** You sign in with the mobile number your estate has on
  file, and ATG sends you a code by SMS or WhatsApp. Gatepass passes your number
  and the code to ATG and keeps the resulting sign-in token in your phone's
  Keychain (iOS) or encrypted storage (Android).
- **Your invites and visitors.** Gatepass creates, lists and revokes invites
  through your ATG account. It keeps a copy of your invites (visitor names,
  mobile numbers and car registrations you entered, times and gate codes) on
  your phone, in the same secure storage, so history isn't lost when ATG
  removes a revoked invite.
- **Sharing.** When you share a code, link or picture, it goes only where you
  choose in your phone's share sheet.

## Cloud backup (optional, off by default)

If you turn on cloud backup, your invite history is encrypted on your phone
before it is uploaded, with a key made from a 12-word recovery phrase that only
you have. The backup service (run on Cloudflare at `gatepass.antonlabs.cc`)
stores only that encrypted data, under a one-way hash of your account ID. It
cannot read your backup, and neither can anyone else without your phrase.
Turning backup off deletes the copy from the service.

The service checks your ATG sign-in token on each request and limits how often
it can be called. Cloudflare processes your IP address to deliver and
rate-limit requests.

## What Gatepass does not do

- No analytics, advertising or tracking.
- No selling or sharing of your data.
- No account with Gatepass itself: your ATG account is the only account.

## ATG

Your data in ATG is handled by ATG under its own terms and privacy policy.

## Contact

Ngonidzashe Mangudya, ngmangudya@codecraftsolutions.co.za
