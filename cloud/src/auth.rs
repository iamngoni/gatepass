//
//  Gatepass
//  auth.rs
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

//! Verifies ATG's Firebase ID tokens and turns them into a [`VerifiedAccount`].
//!
//! Only this module can construct a `VerifiedAccount`, so any handler that
//! takes one has passed the signature, audience, issuer, expiry and subject
//! checks Firebase's own Admin SDK applies. The raw Firebase uid never leaves
//! this module: callers only see the salted hash used as the storage key.

use base64::{Engine, engine::general_purpose::URL_SAFE_NO_PAD};
use rsa::{
    BigUint, RsaPublicKey,
    pkcs1v15::{Signature, VerifyingKey},
    signature::Verifier,
};
use serde::Deserialize;
use sha2::{Digest, Sha256};

/// Google's public keys for Firebase ID tokens.
pub const JWKS_URL: &str =
    "https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com";

/// Clock skew allowed on `exp` and `iat`, in seconds.
const EXPIRY_LEEWAY: i64 = 30;
const ISSUED_LEEWAY: i64 = 300;

#[derive(Debug, thiserror::Error, PartialEq, Eq)]
pub enum AuthError {
    #[error("missing bearer token")]
    Missing,
    #[error("malformed token")]
    Malformed,
    #[error("unsupported algorithm")]
    Algorithm,
    #[error("unknown signing key")]
    UnknownKey,
    #[error("bad signature")]
    Signature,
    #[error("wrong audience")]
    Audience,
    #[error("wrong issuer")]
    Issuer,
    #[error("token expired")]
    Expired,
    #[error("token issued in the future")]
    NotYetValid,
    #[error("token has no subject")]
    Subject,
}

/// One RSA key from Google's key set, as published (base64url `n` and `e`).
#[derive(Debug, Clone, Deserialize)]
pub struct Jwk {
    kid: String,
    n: String,
    e: String,
}

#[derive(Debug, Clone, Deserialize)]
pub struct KeySet {
    keys: Vec<Jwk>,
}

/// A caller whose Firebase ID token was verified for this project.
#[derive(Debug, PartialEq, Eq)]
pub struct VerifiedAccount {
    key: String,
}

impl VerifiedAccount {
    /// The KV key for this account's backup. Derived from the uid with a
    /// fixed prefix so stored keys never reveal it.
    pub fn storage_key(&self) -> &str {
        &self.key
    }
}

#[derive(Deserialize)]
struct Header {
    alg: String,
    kid: String,
}

#[derive(Deserialize)]
struct Claims {
    aud: String,
    iss: String,
    exp: i64,
    iat: i64,
    sub: String,
}

/// A token split and decoded, but not yet trusted.
pub struct UnverifiedToken<'a> {
    header: Header,
    claims: Claims,
    signing_input: &'a str,
    signature: Vec<u8>,
}

/// Reads `Authorization: Bearer <jwt>` into its parts.
pub fn parse_bearer(header: Option<&str>) -> Result<UnverifiedToken<'_>, AuthError> {
    let token = header
        .and_then(|h| h.strip_prefix("Bearer "))
        .filter(|t| !t.is_empty())
        .ok_or(AuthError::Missing)?;
    let (signing_input, signature) = token.rsplit_once('.').ok_or(AuthError::Malformed)?;
    let (header, claims) = signing_input.split_once('.').ok_or(AuthError::Malformed)?;
    Ok(UnverifiedToken {
        header: decode_json(header)?,
        claims: decode_json(claims)?,
        signing_input,
        signature: URL_SAFE_NO_PAD
            .decode(signature)
            .map_err(|_| AuthError::Malformed)?,
    })
}

fn decode_json<T: for<'de> Deserialize<'de>>(part: &str) -> Result<T, AuthError> {
    let bytes = URL_SAFE_NO_PAD
        .decode(part)
        .map_err(|_| AuthError::Malformed)?;
    serde_json::from_slice(&bytes).map_err(|_| AuthError::Malformed)
}

impl UnverifiedToken<'_> {
    /// Checks the token against `keys` for `project` at `now` (Unix seconds).
    pub fn verify(
        self,
        keys: &KeySet,
        project: &str,
        now: i64,
    ) -> Result<VerifiedAccount, AuthError> {
        if self.header.alg != "RS256" {
            return Err(AuthError::Algorithm);
        }
        let jwk = keys
            .keys
            .iter()
            .find(|k| k.kid == self.header.kid)
            .ok_or(AuthError::UnknownKey)?;
        verify_signature(jwk, self.signing_input, &self.signature)?;

        let c = self.claims;
        if c.aud != project {
            return Err(AuthError::Audience);
        }
        if c.iss != format!("https://securetoken.google.com/{project}") {
            return Err(AuthError::Issuer);
        }
        if c.exp < now - EXPIRY_LEEWAY {
            return Err(AuthError::Expired);
        }
        if c.iat > now + ISSUED_LEEWAY {
            return Err(AuthError::NotYetValid);
        }
        if c.sub.is_empty() {
            return Err(AuthError::Subject);
        }
        Ok(VerifiedAccount {
            key: storage_key(&c.sub),
        })
    }
}

fn verify_signature(jwk: &Jwk, signing_input: &str, signature: &[u8]) -> Result<(), AuthError> {
    let component = |b64: &str| {
        URL_SAFE_NO_PAD
            .decode(b64)
            .map(|bytes| BigUint::from_bytes_be(&bytes))
            .map_err(|_| AuthError::UnknownKey)
    };
    let key = RsaPublicKey::new(component(&jwk.n)?, component(&jwk.e)?)
        .map_err(|_| AuthError::UnknownKey)?;
    let signature = Signature::try_from(signature).map_err(|_| AuthError::Signature)?;
    VerifyingKey::<Sha256>::new(key)
        .verify(signing_input.as_bytes(), &signature)
        .map_err(|_| AuthError::Signature)
}

/// Matches the earlier TypeScript Worker, so existing backups keep their keys.
fn storage_key(uid: &str) -> String {
    let digest = Sha256::digest(format!("gatepass:{uid}").as_bytes());
    let hex: String = digest.iter().map(|b| format!("{b:02x}")).collect();
    format!("backup:{hex}")
}

/// Seconds to cache Google's keys, from `Cache-Control: max-age`, else an hour.
pub fn max_age(cache_control: Option<&str>) -> u64 {
    cache_control
        .and_then(|v| {
            v.split(',')
                .find_map(|part| part.trim().strip_prefix("max-age="))
        })
        .and_then(|s| s.parse().ok())
        .unwrap_or(3600)
}

#[cfg(test)]
mod tests {
    use super::*;
    use rsa::{
        RsaPrivateKey,
        pkcs1v15::SigningKey,
        signature::{SignatureEncoding, Signer},
        traits::PublicKeyParts,
    };

    const PROJECT: &str = "helpful-data-424";
    const NOW: i64 = 1_800_000_000;

    struct Fixture {
        signer: SigningKey<Sha256>,
        keys: KeySet,
    }

    fn fixture() -> Fixture {
        let private = RsaPrivateKey::new(&mut rand::thread_rng(), 2048).expect("test key");
        let public = private.to_public_key();
        let jwk = Jwk {
            kid: "k1".into(),
            n: URL_SAFE_NO_PAD.encode(public.n().to_bytes_be()),
            e: URL_SAFE_NO_PAD.encode(public.e().to_bytes_be()),
        };
        Fixture {
            signer: SigningKey::<Sha256>::new(private),
            keys: KeySet { keys: vec![jwk] },
        }
    }

    fn token(f: &Fixture, header: &str, claims: &str) -> String {
        let input = format!(
            "{}.{}",
            URL_SAFE_NO_PAD.encode(header),
            URL_SAFE_NO_PAD.encode(claims)
        );
        let sig = f.signer.sign(input.as_bytes()).to_bytes();
        format!("Bearer {input}.{}", URL_SAFE_NO_PAD.encode(sig))
    }

    fn claims(aud: &str, iss: &str, exp: i64, iat: i64, sub: &str) -> String {
        format!(r#"{{"aud":"{aud}","iss":"{iss}","exp":{exp},"iat":{iat},"sub":"{sub}"}}"#)
    }

    fn good_claims() -> String {
        claims(
            PROJECT,
            &format!("https://securetoken.google.com/{PROJECT}"),
            NOW + 3600,
            NOW - 10,
            "uid-1",
        )
    }

    const HEADER: &str = r#"{"alg":"RS256","kid":"k1"}"#;

    fn check(f: &Fixture, bearer: &str) -> Result<VerifiedAccount, AuthError> {
        parse_bearer(Some(bearer))?.verify(&f.keys, PROJECT, NOW)
    }

    #[test]
    fn a_valid_token_yields_the_hashed_account_key() {
        let f = fixture();
        let account = check(&f, &token(&f, HEADER, &good_claims())).expect("valid");
        assert_eq!(account.storage_key(), storage_key("uid-1"));
        assert!(!account.storage_key().contains("uid-1"));
        assert!(account.storage_key().starts_with("backup:"));
        assert_eq!(account.storage_key().len(), "backup:".len() + 64);
    }

    #[test]
    fn missing_and_malformed_tokens_are_rejected() {
        assert_eq!(parse_bearer(None).err(), Some(AuthError::Missing));
        assert_eq!(
            parse_bearer(Some("Basic x")).err(),
            Some(AuthError::Missing)
        );
        assert_eq!(
            parse_bearer(Some("Bearer ")).err(),
            Some(AuthError::Missing)
        );
        assert_eq!(
            parse_bearer(Some("Bearer abc")).err(),
            Some(AuthError::Malformed)
        );
        assert_eq!(
            parse_bearer(Some("Bearer a.b")).err(),
            Some(AuthError::Malformed)
        );
        assert_eq!(
            parse_bearer(Some("Bearer a.b.c")).err(),
            Some(AuthError::Malformed)
        );
        let header = URL_SAFE_NO_PAD.encode(HEADER);
        let claims = URL_SAFE_NO_PAD.encode(good_claims());
        assert_eq!(
            parse_bearer(Some(&format!("Bearer {header}.{claims}.!!"))).err(),
            Some(AuthError::Malformed)
        );
    }

    #[test]
    fn a_forged_or_foreign_signature_is_rejected() {
        let f = fixture();
        let other = fixture();
        let forged = token(&other, HEADER, &good_claims());
        assert_eq!(check(&f, &forged).err(), Some(AuthError::Signature));

        let unknown = token(&f, r#"{"alg":"RS256","kid":"nope"}"#, &good_claims());
        assert_eq!(check(&f, &unknown).err(), Some(AuthError::UnknownKey));

        let none = token(&f, r#"{"alg":"none","kid":"k1"}"#, &good_claims());
        assert_eq!(check(&f, &none).err(), Some(AuthError::Algorithm));

        let short = format!("{}.{}", forged.rsplit_once('.').expect("dot").0, "AA");
        assert_eq!(check(&f, &short).err(), Some(AuthError::Signature));
    }

    #[test]
    fn claims_must_match_this_project_and_be_current() {
        let f = fixture();
        let iss = format!("https://securetoken.google.com/{PROJECT}");
        let cases = [
            (
                claims("other", &iss, NOW + 60, NOW, "u"),
                AuthError::Audience,
            ),
            (
                claims(PROJECT, "https://evil.example", NOW + 60, NOW, "u"),
                AuthError::Issuer,
            ),
            (
                claims(PROJECT, &iss, NOW - 31, NOW - 3600, "u"),
                AuthError::Expired,
            ),
            (
                claims(PROJECT, &iss, NOW + 3600, NOW + 301, "u"),
                AuthError::NotYetValid,
            ),
            (claims(PROJECT, &iss, NOW + 60, NOW, ""), AuthError::Subject),
        ];
        for (body, expected) in cases {
            assert_eq!(check(&f, &token(&f, HEADER, &body)).err(), Some(expected));
        }
        // Within the leeways.
        let edge = claims(PROJECT, &iss, NOW - 30, NOW + 300, "u");
        assert!(check(&f, &token(&f, HEADER, &edge)).is_ok());
    }

    #[test]
    fn a_bad_published_key_is_treated_as_unknown() {
        let f = fixture();
        let keys = KeySet {
            keys: vec![Jwk {
                kid: "k1".into(),
                n: "!!".into(),
                e: "AQAB".into(),
            }],
        };
        let bearer = token(&f, HEADER, &good_claims());
        let result = parse_bearer(Some(&bearer)).and_then(|t| t.verify(&keys, PROJECT, NOW));
        assert_eq!(result.err(), Some(AuthError::UnknownKey));
    }

    #[test]
    fn key_cache_lifetime_comes_from_cache_control() {
        assert_eq!(
            max_age(Some("public, max-age=19800, must-revalidate")),
            19800
        );
        assert_eq!(max_age(Some("no-cache")), 3600);
        assert_eq!(max_age(Some("max-age=x")), 3600);
        assert_eq!(max_age(None), 3600);
    }

    #[test]
    fn the_storage_key_matches_the_typescript_worker() {
        // sha256("gatepass:abc"), as the earlier Worker computed it.
        let expected = format!(
            "backup:{}",
            Sha256::digest(b"gatepass:abc")
                .iter()
                .map(|b| format!("{b:02x}"))
                .collect::<String>()
        );
        assert_eq!(storage_key("abc"), expected);
    }
}
