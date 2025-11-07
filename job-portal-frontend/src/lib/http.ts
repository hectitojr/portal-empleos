export async function http<T>(path: string, init?: RequestInit): Promise<T> {
  if (!path.startsWith('/')) {
    throw new Error(`http(path): usar rutas relativas del BFF, ej.: "/api/..."`);
  }

  const res = await fetch(path, {
    ...init,
    headers: { 'Content-Type': 'application/json', ...(init?.headers || {}) },
    credentials: 'include',       // << Cookies viajan en fetch
    cache: 'no-store'             // << No SSR caching accidental
  });

  if (!res.ok) {
    const text = await res.text();
    throw new Error(text || `HTTP ${res.status}`);
  }

  return res.json() as Promise<T>;
}
