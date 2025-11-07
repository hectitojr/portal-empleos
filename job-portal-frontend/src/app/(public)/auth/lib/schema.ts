import { z } from 'zod';

export const registerSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  confirmPassword: z.string().optional(),
  role: z.enum(['APPLICANT','COMPANY']),
  fullName: z.string().optional(),
  companyName: z.string().optional(),
  acceptTerms: z.boolean().optional(),
  acceptDataPolicy: z.boolean().optional(),
});

export type RegisterSchema = z.infer<typeof registerSchema>;
