// Gatepass cloud backup. Each resident gets one blob that the app encrypts
// with a key from their recovery phrase before upload, so this Worker only
// ever sees ciphertext. Requests carry the resident's ATG (Firebase) ID token;
// its subject is the only identity used, and only as a hash.

interface Env {
  BACKUPS: KVNamespace;
  LIMITER: RateLimit;
  FIREBASE_PROJECT_ID: string;
}

interface Stored {
  version: number;
  updatedAt: string;
  blob: string;
}

const JWKS_URL =
  'https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com';
const MAX_BLOB = 2 * 1024 * 1024;

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    if (url.pathname !== '/v1/backup') return json({ error: 'not found' }, 404);

    const ip = request.headers.get('cf-connecting-ip') ?? 'unknown';
    if (!(await env.LIMITER.limit({ key: `ip:${ip}` })).success) {
      return json({ error: 'slow down' }, 429);
    }

    let uid: string;
    try {
      uid = await verify(request.headers.get('authorization'), env);
    } catch {
      return json({ error: 'unauthorized' }, 401);
    }
    const hashed = await sha256(uid);
    if (!(await env.LIMITER.limit({ key: `uid:${hashed}` })).success) {
      return json({ error: 'slow down' }, 429);
    }
    const key = `backup:${hashed}`;

    switch (request.method) {
      case 'GET': {
        const stored = await env.BACKUPS.get<Stored>(key, 'json');
        return stored ? json(stored) : json({ error: 'none' }, 404);
      }
      case 'PUT': {
        const length = Number(request.headers.get('content-length') ?? 0);
        if (length > MAX_BLOB + 1024) return json({ error: 'too large' }, 413);
        let body: { expectedVersion?: unknown; blob?: unknown };
        try {
          body = await request.json();
        } catch {
          return json({ error: 'bad json' }, 400);
        }
        const { expectedVersion, blob } = body;
        if (typeof blob !== 'string' || blob.length > MAX_BLOB) {
          return json({ error: 'bad blob' }, 400);
        }
        const current = await env.BACKUPS.get<Stored>(key, 'json');
        const currentVersion = current?.version ?? 0;
        // Another device backed up since this one last read: it must merge
        // that copy first.
        if (expectedVersion !== currentVersion) {
          return json({ error: 'conflict', version: currentVersion }, 409);
        }
        const next: Stored = {
          version: currentVersion + 1,
          updatedAt: new Date().toISOString(),
          blob,
        };
        await env.BACKUPS.put(key, JSON.stringify(next));
        return json({ version: next.version, updatedAt: next.updatedAt });
      }
      case 'DELETE':
        await env.BACKUPS.delete(key);
        return new Response(null, { status: 204 });
      default:
        return json({ error: 'method not allowed' }, 405);
    }
  },
} satisfies ExportedHandler<Env>;

/// Verifies a Firebase ID token as Firebase's own Admin SDK does: RS256 with
/// Google's current keys, this project's audience and issuer, unexpired, and
/// a non-empty subject. Returns the subject (the Firebase uid).
async function verify(header: string | null, env: Env): Promise<string> {
  const token = header?.match(/^Bearer (.+)$/)?.[1];
  if (!token) throw new Error('no token');
  const [h, p, s] = token.split('.');
  if (!h || !p || !s) throw new Error('malformed');
  const head = JSON.parse(text(b64url(h)));
  const claims = JSON.parse(text(b64url(p)));
  if (head.alg !== 'RS256' || typeof head.kid !== 'string') {
    throw new Error('alg');
  }

  const jwk = (await keys()).find((k) => k.kid === head.kid);
  if (!jwk) throw new Error('unknown key');
  const key = await crypto.subtle.importKey(
    'jwk',
    jwk,
    { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
    false,
    ['verify'],
  );
  const ok = await crypto.subtle.verify(
    'RSASSA-PKCS1-v1_5',
    key,
    b64url(s),
    new TextEncoder().encode(`${h}.${p}`),
  );
  if (!ok) throw new Error('signature');

  const now = Math.floor(Date.now() / 1000);
  const project = env.FIREBASE_PROJECT_ID;
  if (claims.aud !== project) throw new Error('aud');
  if (claims.iss !== `https://securetoken.google.com/${project}`) {
    throw new Error('iss');
  }
  if (typeof claims.exp !== 'number' || claims.exp < now - 30) {
    throw new Error('expired');
  }
  if (typeof claims.iat !== 'number' || claims.iat > now + 300) {
    throw new Error('iat');
  }
  if (typeof claims.sub !== 'string' || claims.sub.length === 0) {
    throw new Error('sub');
  }
  return claims.sub;
}

let cachedKeys: { keys: JsonWebKey[]; until: number } | undefined;

async function keys(): Promise<(JsonWebKey & { kid?: string })[]> {
  if (cachedKeys && cachedKeys.until > Date.now()) return cachedKeys.keys;
  const res = await fetch(JWKS_URL);
  if (!res.ok) throw new Error('jwks');
  const { keys } = (await res.json()) as { keys: JsonWebKey[] };
  const maxAge = Number(
    res.headers.get('cache-control')?.match(/max-age=(\d+)/)?.[1] ?? 3600,
  );
  cachedKeys = { keys, until: Date.now() + maxAge * 1000 };
  return keys;
}

function b64url(s: string): Uint8Array {
  const b64 = s.replace(/-/g, '+').replace(/_/g, '/');
  const bin = atob(b64 + '='.repeat((4 - (b64.length % 4)) % 4));
  return Uint8Array.from(bin, (c) => c.charCodeAt(0));
}

function text(bytes: Uint8Array): string {
  return new TextDecoder().decode(bytes);
}

async function sha256(s: string): Promise<string> {
  const digest = await crypto.subtle.digest(
    'SHA-256',
    new TextEncoder().encode(`gatepass:${s}`),
  );
  return [...new Uint8Array(digest)]
    .map((b) => b.toString(16).padStart(2, '0'))
    .join('');
}

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'content-type': 'application/json' },
  });
}
