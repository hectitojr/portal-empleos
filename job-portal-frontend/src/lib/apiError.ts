import type { FieldValues, Path, UseFormSetError } from 'react-hook-form';
import { getErrorCode, humanize } from '@/lib/errors';
import type { ApiErrorResponse } from '@/lib/api/types';
import { tryParseApiError as tryParseApiErrorFromBff } from '@/lib/api/bffClient';

export type ApiFieldErrorItem = {
  field: string;
  code: string;
  message: string;
};

export type ApiViolationErrorItem = {
  param: string | null;
  code: string;
  message: string;
};

export type ApiErrorResponseCompat = {
  error: string;
  message: string;
  status: number;
  path?: string | null;
  traceId?: string | null;
  timestamp?: string;
  fieldErrors?: ApiFieldErrorItem[] | null;
  violations?: ApiViolationErrorItem[] | null;
};

export function tryParseApiError(bodyText?: string): ApiErrorResponseCompat | null {
  return tryParseApiErrorFromBff(bodyText) as unknown as ApiErrorResponseCompat | null;
}

export function applyApiErrorToForm<T extends FieldValues>(args: {
  err: unknown;
  setError: UseFormSetError<T>;
  fieldMap?: Record<string, Path<T>>;
}): string {
  const { err, setError, fieldMap } = args;

  const e = err as any;

  const apiFromError: ApiErrorResponse | null =
    e?.error && typeof e.error === 'object' && typeof e.error.error === 'string'
      ? (e.error as ApiErrorResponse)
      : null;

  const api = (apiFromError ?? tryParseApiError(e?.body)) as any;

  const code = getErrorCode(api ?? e) ?? api?.error ?? e?.code;
  const fallback = humanize(code);

  const fieldErrors = api?.fieldErrors ?? [];
  for (const fe of fieldErrors) {
    const rhfField = (fieldMap?.[fe.field] ?? fe.field) as Path<T>;
    if (typeof rhfField === 'string' && rhfField.length > 0) {
      setError(rhfField, { type: 'server', message: fe.message || 'Valor inválido.' });
    }
  }

  switch (code) {
    case 'COMPANY_TAX_ID_ALREADY_EXISTS':
      setError('taxId' as Path<T>, {
        type: 'server',
        message: 'El RUC ya está asociado a otra cuenta.',
      });
      return 'Revisa el RUC: ya existe una cuenta con ese RUC.';

    case 'DISTRICT_NOT_FOUND':
      setError('districtId' as Path<T>, { type: 'server', message: 'El distrito no existe.' });
      return 'Selecciona nuevamente tu ubicación (distrito).';

    case 'COMPANY_PROFILE_LOCKED':
      return 'Tu empresa ya tiene ofertas creadas, por eso no es posible dejar el perfil completamente vacío. Si necesitas cambiar datos, actualízalos sin eliminarlos por completo.';

    case 'UNAUTHENTICATED':
    case 'TOKEN_EXPIRED':
    case 'TOKEN_INVALID':
    case 'FORBIDDEN':
      return humanize(code as any);

    case 'VALIDATION_ERROR':
    case 'CONSTRAINT_VIOLATION':
      return 'Revisa los campos del formulario.';

    default:
      return api?.message || fallback;
  }
}
