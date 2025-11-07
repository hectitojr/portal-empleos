import { z } from 'zod';

const envSchema = z.object({
  NEXT_PUBLIC_APP_URL: z.string().url(),
  BACKEND_BASE_URL: z.string().url(),
  AUTH_COOKIE_DOMAIN: z.string(),
  AUTH_COOKIE_SECURE: z.string().transform((v) => v === 'true'),
});

export const env = envSchema.parse({
  NEXT_PUBLIC_APP_URL: process.env.NEXT_PUBLIC_APP_URL,
  BACKEND_BASE_URL: process.env.BACKEND_BASE_URL,
  AUTH_COOKIE_DOMAIN: process.env.AUTH_COOKIE_DOMAIN,
  AUTH_COOKIE_SECURE: process.env.AUTH_COOKIE_SECURE ?? 'false',
});
