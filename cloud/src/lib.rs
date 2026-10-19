//! Gatepass cloud backup: one end-to-end encrypted blob per ATG account.
//!
//! The app seals the blob on the phone with a key from the resident's
//! recovery phrase, so this Worker only ever stores ciphertext. Requests carry
//! the resident's ATG (Firebase) ID token; handlers below only run with a
//! [`auth::VerifiedAccount`], and storage is keyed by its hashed uid.

mod auth;
mod backup;
mod error;

use std::cell::RefCell;

use auth::{KeySet, VerifiedAccount};
use backup::{PutRequest, Stored};
use error::ApiError;
use worker::{Context, Date, Env, Fetch, Method, Request, Response, Result, event, kv::KvStore};

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

    let kv = env.kv("BACKUPS").map_err(internal("kv binding"))?;
    match req.method() {
        Method::Get => get(&kv, &account).await,
        Method::Put => {
            let body = req.bytes().await.map_err(|_| ApiError::BadJson)?;
            put(&kv, &account, PutRequest::parse(&body)?).await
        }
        Method::Delete => delete(&kv, &account).await,
        _ => Err(ApiError::MethodNotAllowed),
    }
}

async fn get(kv: &KvStore, account: &VerifiedAccount) -> std::result::Result<Response, ApiError> {
    let stored = read(kv, account).await?.ok_or(ApiError::NoBackup)?;
    respond(&stored, 200).map_err(internal("respond"))
}

async fn put(
    kv: &KvStore,
    account: &VerifiedAccount,
    request: PutRequest,
) -> std::result::Result<Response, ApiError> {
    let current = read(kv, account).await?;
    let now = Date::now().to_string();
    let next: Stored = request.apply(current.as_ref(), now)?;
    kv.put(account.storage_key(), &next)
        .map_err(internal("kv put"))?
        .execute()
        .await
        .map_err(internal("kv put"))?;
    respond(
        &serde_json::json!({ "version": next.version, "updatedAt": next.updated_at }),
        200,
    )
    .map_err(internal("respond"))
}

async fn delete(
    kv: &KvStore,
    account: &VerifiedAccount,
) -> std::result::Result<Response, ApiError> {
    kv.delete(account.storage_key())
        .await
        .map_err(internal("kv delete"))?;
    Ok(Response::empty()
        .map_err(internal("respond"))?
        .with_status(204))
}

async fn read(
    kv: &KvStore,
    account: &VerifiedAccount,
) -> std::result::Result<Option<Stored>, ApiError> {
    kv.get(account.storage_key())
        .json::<Stored>()
        .await
        .map_err(internal("kv get"))
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
