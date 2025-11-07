export type ApiErrorCode =
  | 'EMAIL_EXISTS'
  | 'BAD_CREDENTIALS'
  | 'USER_SUSPENDED'
  | 'TOKEN_INVALID'
  | 'TOKEN_EXPIRED'
  | 'UNAUTHENTICATED'
  | 'FORBIDDEN'
  | 'COMPANY_NOT_FOUND'
  | 'COMPANY_TAX_ID_ALREADY_EXISTS'
  | 'DISTRICT_NOT_FOUND'
  | 'COMPANY_INCOMPLETE'
  | 'APPLICANT_NOT_FOUND'
  | 'JOB_NOT_FOUND'
  | 'JOB_CLOSED'
  | 'APPLICATION_NOT_FOUND'
  | 'DUPLICATE_APPLICATION'
  | 'APPLICANT_INCOMPLETE'
  | 'VALIDATION_ERROR'
  | 'CONSTRAINT_VIOLATION'
  | 'MALFORMED_JSON'
  | 'MISSING_PARAMETER'
  | 'TYPE_MISMATCH'
  | 'UNSUPPORTED_MEDIA_TYPE'
  | 'DATA_INTEGRITY_VIOLATION'
  | 'INTERNAL_ERROR';

export function humanize(code?: ApiErrorCode | string): string {
  switch (code) {
    case 'BAD_CREDENTIALS':
      return 'Credenciales inválidas.';
    case 'EMAIL_EXISTS':
      return 'El correo ya está registrado.';
    case 'TOKEN_EXPIRED':
      return 'La sesión expiró. Vuelve a iniciar sesión.';
    case 'TOKEN_INVALID':
      return 'Token inválido. Vuelve a iniciar sesión.';
    case 'USER_SUSPENDED':
      return 'La cuenta está suspendida.';
    case 'FORBIDDEN':
      return 'Acceso no permitido.';
    case 'VALIDATION_ERROR':
    case 'CONSTRAINT_VIOLATION':
      return 'Revisa los campos del formulario.';
    default:
      return 'Ocurrió un error. Intenta nuevamente.';
  }
}
