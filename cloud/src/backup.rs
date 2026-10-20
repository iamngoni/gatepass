//
//  Gatepass
//  backup.rs
//
//  Created by Ngonidzashe Mangudya on 19/10/2026.
//  Copyright (c) 2026 Codecraft Solutions.
//

//! The backup record and the rules for replacing it.
//!
//! The blob is opaque ciphertext sealed on the phone; this module never looks
//! inside it, only bounds its size. A write must name the version it read, so
//! two phones can't silently overwrite each other: the second one gets a
//! conflict, merges, and retries. The check itself runs in SQL (see
//! [`Write`]) so it is atomic.

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

    /// The statement that stores this write, conditional on the version.
    pub fn into_write(self, updated_at: String) -> Write {
        match self.expected_version {
            0 => Write::Insert {
                updated_at,
                blob: self.blob.0,
            },
            expected => Write::Update {
                expected,
                updated_at,
                blob: self.blob.0,
            },
        }
    }
}

/// A conditional write. It changes no row when another device wrote first;
/// the caller then reports [`ApiError::Conflict`] with the current version.
#[derive(Debug, PartialEq, Eq)]
pub enum Write {
    /// The first backup for this account.
    Insert { updated_at: String, blob: String },
    /// Replaces version `expected`, and only that version.
    Update {
        expected: u64,
        updated_at: String,
        blob: String,
    },
}

impl Write {
    pub const INSERT_SQL: &str = "INSERT INTO backups (account, version, updated_at, blob) \
         VALUES (?1, 1, ?2, ?3) ON CONFLICT (account) DO NOTHING";
    pub const UPDATE_SQL: &str = "UPDATE backups SET version = version + 1, updated_at = ?2, blob = ?3 \
         WHERE account = ?1 AND version = ?4";

    /// The version the record has after this write succeeds.
    pub fn next_version(&self) -> u64 {
        match self {
            Self::Insert { .. } => 1,
            Self::Update { expected, .. } => expected + 1,
        }
    }

    pub fn updated_at(&self) -> &str {
        match self {
            Self::Insert { updated_at, .. } | Self::Update { updated_at, .. } => updated_at,
        }
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
    fn the_first_write_inserts_version_one() {
        let write = put(0, "sealed").into_write("t1".into());
        assert_eq!(
            write,
            Write::Insert {
                updated_at: "t1".into(),
                blob: "sealed".into()
            }
        );
        assert_eq!(write.next_version(), 1);
        assert_eq!(write.updated_at(), "t1");
    }

    #[test]
    fn later_writes_replace_only_the_version_they_read() {
        let write = put(4, "b").into_write("t2".into());
        assert_eq!(
            write,
            Write::Update {
                expected: 4,
                updated_at: "t2".into(),
                blob: "b".into()
            }
        );
        assert_eq!(write.next_version(), 5);
        assert_eq!(write.updated_at(), "t2");
        assert!(Write::UPDATE_SQL.contains("AND version = ?4"));
        assert!(Write::INSERT_SQL.contains("DO NOTHING"));
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
