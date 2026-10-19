//! The backup record and the rules for replacing it.
//!
//! The blob is opaque ciphertext sealed on the phone; this module never looks
//! inside it, only bounds its size. A write must name the version it read, so
//! two phones can't silently overwrite each other: the second one gets a
//! conflict, merges, and retries.

use serde::{Deserialize, Serialize};

use crate::error::ApiError;

/// Largest sealed blob accepted, in bytes of its JSON string.
pub const MAX_BLOB: usize = 2 * 1024 * 1024;

/// Largest request body: the blob plus its small JSON envelope.
pub const MAX_BODY: usize = MAX_BLOB + 1024;

/// What KV holds for one account, and what `GET` returns.
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Stored {
    pub version: u64,
    /// RFC 3339, UTC.
    pub updated_at: String,
    pub blob: String,
}

/// A sealed blob that is non-empty and within [`MAX_BLOB`].
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct SealedBlob(String);

impl TryFrom<String> for SealedBlob {
    type Error = ApiError;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        if value.is_empty() || value.len() > MAX_BLOB {
            return Err(ApiError::BadBlob);
        }
        Ok(Self(value))
    }
}

/// A parsed `PUT` body.
#[derive(Debug)]
pub struct PutRequest {
    expected_version: u64,
    blob: SealedBlob,
}

#[derive(Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
struct PutBody {
    expected_version: u64,
    blob: String,
}

impl PutRequest {
    pub fn parse(body: &[u8]) -> Result<Self, ApiError> {
        if body.len() > MAX_BODY {
            return Err(ApiError::TooLarge);
        }
        let raw: PutBody = serde_json::from_slice(body).map_err(|_| ApiError::BadJson)?;
        Ok(Self {
            expected_version: raw.expected_version,
            blob: SealedBlob::try_from(raw.blob)?,
        })
    }

    /// The record to store next, or a conflict carrying the current version
    /// when another device wrote since this one read.
    pub fn apply(self, current: Option<&Stored>, now: String) -> Result<Stored, ApiError> {
        let version = current.map_or(0, |s| s.version);
        if self.expected_version != version {
            return Err(ApiError::Conflict { version });
        }
        Ok(Stored {
            version: version + 1,
            updated_at: now,
            blob: self.blob.0,
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn put(expected: u64, blob: &str) -> PutRequest {
        PutRequest::parse(
            serde_json::json!({ "expectedVersion": expected, "blob": blob })
                .to_string()
                .as_bytes(),
        )
        .expect("valid put")
    }

    #[test]
    fn the_first_write_starts_at_version_one() {
        let stored = put(0, "sealed").apply(None, "t1".into()).expect("ok");
        assert_eq!(
            stored,
            Stored {
                version: 1,
                updated_at: "t1".into(),
                blob: "sealed".into()
            }
        );
    }

    #[test]
    fn a_stale_write_is_a_conflict_with_the_current_version() {
        let current = put(0, "a").apply(None, "t1".into()).expect("ok");
        let next = put(1, "b").apply(Some(&current), "t2".into()).expect("ok");
        assert_eq!(next.version, 2);
        assert_eq!(
            put(1, "c").apply(Some(&next), "t3".into()).err(),
            Some(ApiError::Conflict { version: 2 })
        );
        assert_eq!(
            put(1, "c").apply(None, "t3".into()).err(),
            Some(ApiError::Conflict { version: 0 })
        );
    }

    #[test]
    fn bodies_are_parsed_strictly() {
        let bad = |body: &str| PutRequest::parse(body.as_bytes()).err();
        assert_eq!(bad("not json"), Some(ApiError::BadJson));
        assert_eq!(bad(r#"{"blob":"x"}"#), Some(ApiError::BadJson));
        assert_eq!(
            bad(r#"{"expectedVersion":-1,"blob":"x"}"#),
            Some(ApiError::BadJson)
        );
        assert_eq!(
            bad(r#"{"expectedVersion":0,"blob":"x","extra":1}"#),
            Some(ApiError::BadJson)
        );
        assert_eq!(
            bad(r#"{"expectedVersion":0,"blob":""}"#),
            Some(ApiError::BadBlob)
        );
    }

    #[test]
    fn oversized_blobs_and_bodies_are_refused() {
        let body = |len: usize| {
            serde_json::json!({ "expectedVersion": 0, "blob": "x".repeat(len) }).to_string()
        };
        // Just over the blob limit: fits the body allowance, fails the blob.
        assert_eq!(
            PutRequest::parse(body(MAX_BLOB + 1).as_bytes()).err(),
            Some(ApiError::BadBlob)
        );
        // Over the body limit: refused before parsing.
        assert_eq!(
            PutRequest::parse(body(MAX_BODY).as_bytes()).err(),
            Some(ApiError::TooLarge)
        );
        assert_eq!(
            SealedBlob::try_from("x".repeat(MAX_BLOB + 1)).err(),
            Some(ApiError::BadBlob)
        );
        assert!(SealedBlob::try_from("x".repeat(MAX_BLOB)).is_ok());
    }

    #[test]
    fn stored_records_use_the_app_s_field_names() {
        let json = serde_json::to_value(Stored {
            version: 3,
            updated_at: "t".into(),
            blob: "b".into(),
        })
        .expect("serialize");
        assert_eq!(
            json,
            serde_json::json!({ "version": 3, "updatedAt": "t", "blob": "b" })
        );
    }
}
