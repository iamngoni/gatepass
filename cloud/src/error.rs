//! The API's error shape: a stable status and a short, non-sensitive code.
//!
//! The app relies on 401, 404 (no backup yet), 409 (stale version) and 429.
//! Internal failures never echo their cause to the caller; they are logged.

use serde_json::{Value, json};

#[derive(Debug, thiserror::Error, PartialEq, Eq)]
pub enum ApiError {
    #[error("not found")]
    NotFound,
    #[error("no backup")]
    NoBackup,
    #[error("method not allowed")]
    MethodNotAllowed,
    #[error("unauthorized")]
    Unauthorized,
    #[error("slow down")]
    SlowDown,
    #[error("too large")]
    TooLarge,
    #[error("bad json")]
    BadJson,
    #[error("bad blob")]
    BadBlob,
    #[error("conflict")]
    Conflict { version: u64 },
    #[error("internal")]
    Internal,
}

impl ApiError {
    pub fn status(&self) -> u16 {
        match self {
            Self::NotFound | Self::NoBackup => 404,
            Self::MethodNotAllowed => 405,
            Self::Unauthorized => 401,
            Self::SlowDown => 429,
            Self::TooLarge => 413,
            Self::BadJson | Self::BadBlob => 400,
            Self::Conflict { .. } => 409,
            Self::Internal => 500,
        }
    }

    pub fn body(&self) -> Value {
        match self {
            Self::Conflict { version } => json!({ "error": "conflict", "version": version }),
            Self::NoBackup => json!({ "error": "none" }),
            other => json!({ "error": other.to_string() }),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn each_error_has_the_status_the_app_expects() {
        let cases = [
            (ApiError::NotFound, 404, json!({ "error": "not found" })),
            (ApiError::NoBackup, 404, json!({ "error": "none" })),
            (
                ApiError::MethodNotAllowed,
                405,
                json!({ "error": "method not allowed" }),
            ),
            (
                ApiError::Unauthorized,
                401,
                json!({ "error": "unauthorized" }),
            ),
            (ApiError::SlowDown, 429, json!({ "error": "slow down" })),
            (ApiError::TooLarge, 413, json!({ "error": "too large" })),
            (ApiError::BadJson, 400, json!({ "error": "bad json" })),
            (ApiError::BadBlob, 400, json!({ "error": "bad blob" })),
            (
                ApiError::Conflict { version: 4 },
                409,
                json!({ "error": "conflict", "version": 4 }),
            ),
            (ApiError::Internal, 500, json!({ "error": "internal" })),
        ];
        for (error, status, body) in cases {
            assert_eq!(error.status(), status);
            assert_eq!(error.body(), body);
        }
    }
}
