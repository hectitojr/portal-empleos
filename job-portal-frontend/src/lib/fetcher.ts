import { http } from './http';

export const api = {
  get:   <T>(path: string, init?: RequestInit) => http<T>(path, { ...init, method: 'GET' }),
  post:  <T>(path: string, body?: unknown, init?: RequestInit) =>
            http<T>(path, { ...init, method: 'POST', body: body ? JSON.stringify(body) : undefined }),
  put:   <T>(path: string, body?: unknown, init?: RequestInit) =>
            http<T>(path, { ...init, method: 'PUT', body: body ? JSON.stringify(body) : undefined }),
  patch: <T>(path: string, body?: unknown, init?: RequestInit) =>
            http<T>(path, { ...init, method: 'PATCH', body: body ? JSON.stringify(body) : undefined }),
  delete:<T>(path: string, init?: RequestInit) =>
            http<T>(path, { ...init, method: 'DELETE' })
};
