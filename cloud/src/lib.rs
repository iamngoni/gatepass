//! Gatepass cloud backup: one end-to-end encrypted blob per ATG account.
//!
//! The app seals the blob on the phone with a key from the resident's
//! recovery phrase, so this Worker only ever stores ciphertext. Requests carry
//! the resident's ATG (Firebase) ID token; handlers below only run with a
//! [`auth::VerifiedAccount`], and storage (D1) is keyed by its hashed uid.

mod auth;
mod backup;
mod error;

use std::cell::RefCell;

use auth::{KeySet, VerifiedAccount};
use backup::{PutRequest, Stored, Write};
use error::ApiError;
use worker::{
    Context, D1Database, Date, Env, Fetch, Method, Request, Response, Result, event,
    wasm_bindgen::JsValue,
};

thread_local! {
    /// Google's keys and when they go stale (ms since epoch). Isolate-local.
    static KEYS: RefCell<Option<(KeySet, f64)>> = const { RefCell::new(None) };
}

#[event(fetch)]
pub async fn fetch(req: Request, env: Env, _ctx: Context) -> Result<Response> {
    console_error_panic_hook::set_once();
    match handle(req, &env).await {
        Ok(response) => Ok(response),
        Err(error) => respond(&error.body(), error.status()),
    }
}

async fn handle(mut req: Request, env: &Env) -> std::result::Result<Response, ApiError> {
    if req.path() != "/v1/backup" {
        return Err(ApiError::NotFound);
    }
    let ip = req
        .headers()
        .get("CF-Connecting-IP")
        .ok()
        .flatten()
        .unwrap_or_else(|| "unknown".into());
    limit(env, format!("ip:{ip}")).await?;

    // The security gate: nothing below runs without a verified token.
    let account = authenticate(&req, env).await?;
    limit(env, format!("uid:{}", account.storage_key())).await?;

    let db = env.d1("DB").map_err(internal("d1 binding"))?;
    match req.method() {
        Method::Get => get(&db, &account).await,
        Method::Put => {
            let body = req.bytes().await.map_err(|_| ApiError::BadJson)?;
            put(&db, &account, PutRequest::parse(&body)?).await
        }
        Method::Delete => delete(&db, &account).await,
        _ => Err(ApiError::MethodNotAllowed),
    }
}

async fn get(
    db: &D1Database,
    account: &VerifiedAccount,
) -> std::result::Result<Response, ApiError> {
    let stored = read(db, account).await?.ok_or(ApiError::NoBackup)?;
    respond(&stored, 200).map_err(internal("respond"))
}

/// Writes only if the stored version is still the one the phone read. The
/// condition is part of the statement, so two concurrent writes can't both
/// succeed.
async fn put(
    db: &D1Database,
    account: &VerifiedAccount,
    request: PutRequest,
) -> std::result::Result<Response, ApiError> {
    let now: String = worker::js_sys::Date::new_0().to_iso_string().into();
    let write = request.into_write(now);
    let key = JsValue::from(account.storage_key());
    let statement = match &write {
        Write::Insert { updated_at, blob } => {
            db.prepare(Write::INSERT_SQL)
                .bind(&[key, updated_at.into(), blob.into()])
        }
        Write::Update {
            expected,
            updated_at,
            blob,
        } => db.prepare(Write::UPDATE_SQL).bind(&[
            key,
            updated_at.into(),
            blob.into(),
            JsValue::from(*expected as f64),
        ]),
    }
    .map_err(internal("d1 bind"))?;
    let changes = statement
        .run()
        .await
        .map_err(internal("d1 write"))?
        .meta()
        .map_err(internal("d1 meta"))?
        .and_then(|m| m.changes)
        .unwrap_or(0);
    if changes == 0 {
        let version = read(db, account).await?.map_or(0, |s| s.version);
        return Err(ApiError::Conflict { version });
    }
    respond(
        &serde_json::json!({ "version": write.next_version(), "updatedAt": write.updated_at() }),
        200,
    )
    .map_err(internal("respond"))
}

async fn delete(
    db: &D1Database,
    account: &VerifiedAccount,
) -> std::result::Result<Response, ApiError> {
    db.prepare("DELETE FROM backups WHERE account = ?1")
        .bind(&[account.storage_key().into()])
        .map_err(internal("d1 bind"))?
        .run()
        .await
        .map_err(internal("d1 delete"))?;
    Ok(Response::empty()
        .map_err(internal("respond"))?
        .with_status(204))
}

async fn read(
    db: &D1Database,
    account: &VerifiedAccount,
) -> std::result::Result<Option<Stored>, ApiError> {
    db.prepare("SELECT version, updated_at AS updatedAt, blob FROM backups WHERE account = ?1")
        .bind(&[account.storage_key().into()])
        .map_err(internal("d1 bind"))?
        .first::<Stored>(None)
        .await
        .map_err(internal("d1 read"))
}

async fn authenticate(req: &Request, env: &Env) -> std::result::Result<VerifiedAccount, ApiError> {
    let header = req.headers().get("Authorization").ok().flatten();
    let token = auth::parse_bearer(header.as_deref()).map_err(unauthorized)?;
    let project = env
        .var("FIREBASE_PROJECT_ID")
        .map_err(internal("FIREBASE_PROJECT_ID"))?
        .to_string();
    let keys = google_keys().await?;
    let now = (Date::now().as_millis() / 1000) as i64;
    token.verify(&keys, &project, now).map_err(unauthorized)
}

fn unauthorized(error: auth::AuthError) -> ApiError {
    worker::console_log!("auth.rejected reason={error}");
    ApiError::Unauthorized
}

async fn google_keys() -> std::result::Result<KeySet, ApiError> {
    let now = Date::now().as_millis() as f64;
    if let Some(keys) = KEYS.with_borrow(|cached| {
        cached
            .as_ref()
            .filter(|(_, until)| *until > now)
            .map(|(keys, _)| keys.clone())
    }) {
        return Ok(keys);
    }
    let url = auth::JWKS_URL.parse().map_err(internal("jwks url"))?;
    let mut response = Fetch::Url(url)
        .send()
        .await
        .map_err(internal("jwks fetch"))?;
    if response.status_code() != 200 {
        return Err(internal("jwks status")(response.status_code()));
    }
    let max_age = auth::max_age(
        response
            .headers()
            .get("Cache-Control")
            .ok()
            .flatten()
            .as_deref(),
    );
    let keys: KeySet = response.json().await.map_err(internal("jwks json"))?;
    KEYS.with_borrow_mut(|cached| *cached = Some((keys.clone(), now + max_age as f64 * 1000.0)));
    Ok(keys)
}

/// Rate limiting fails open when the binding is missing, and says so in the
/// logs: losing the limiter must not take backups down.
async fn limit(env: &Env, key: String) -> std::result::Result<(), ApiError> {
    let limiter = match env.rate_limiter("LIMITER") {
        Ok(limiter) => limiter,
        Err(error) => {
            worker::console_log!("rate_limit.unbound error={error} (failing open)");
            return Ok(());
        }
    };
    match limiter.limit(key).await {
        Ok(outcome) if !outcome.success => Err(ApiError::SlowDown),
        Ok(_) => Ok(()),
        Err(error) => {
            worker::console_log!("rate_limit.failed error={error} (failing open)");
            Ok(())
        }
    }
}

fn internal<E: std::fmt::Display>(context: &'static str) -> impl Fn(E) -> ApiError {
    move |error| {
        worker::console_error!("internal context={context} error={error}");
        ApiError::Internal
    }
}

fn respond<T: serde::Serialize>(body: &T, status: u16) -> Result<Response> {
    let mut response = Response::from_json(body)?.with_status(status);
    response.headers_mut().set("Cache-Control", "no-store")?;
    Ok(response)
}
