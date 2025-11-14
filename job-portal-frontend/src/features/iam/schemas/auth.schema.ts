import { z } from 'zod';

export const registerSchema = z.object({
  email: z.string().email({ message: 'Email inválido' }),
  password: z.string().min(8, { message: 'La contraseña debe tener mínimo 8 caracteres.' }),
  role: z.enum(['APPLICANT', 'COMPANY']),
  acceptTerms: z.boolean().refine((v) => v === true, {
    message: 'Debes aceptar los términos y condiciones.',
  }),
  acceptDataPolicy: z.boolean().refine((v) => v === true, {
    message: 'Debes autorizar el tratamiento de tus datos personales.',
  }),
});

export type RegisterSchema = z.infer<typeof registerSchema>;
