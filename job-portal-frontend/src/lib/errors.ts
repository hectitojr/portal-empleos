export type ApiErrorCode =
  | 'EMAIL_EXISTS'
  | 'BAD_CREDENTIALS'
  | 'USER_SUSPENDED'
  | 'TOKEN_INVALID'
  | 'TOKEN_EXPIRED'
  | 'UNAUTHENTICATED'
  | 'RESET_TOKEN_INVALID'
  | 'RESET_TOKEN_EXPIRED'
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
      return 'Ya existe una cuenta asociada a este correo. Inicia sesión o recupera tu contraseña para continuar.';
    case 'TOKEN_EXPIRED':
      return 'La sesión expiró. Vuelve a iniciar sesión.';
    case 'TOKEN_INVALID':
      return 'Token inválido. Vuelve a iniciar sesión.';
    case 'USER_SUSPENDED':
      return 'La cuenta está suspendida.';
    case 'RESET_TOKEN_INVALID':
      return 'El enlace de restablecimiento no es válido o ya fue usado.';
    case 'RESET_TOKEN_EXPIRED':
      return 'El enlace de restablecimiento ha expirado. Solicita uno nuevo.';
    case 'FORBIDDEN':
      return 'Acceso no permitido.';
    case 'JOB_NOT_FOUND':
      return 'La oferta de trabajo no existe o ya no está disponible.';
    case 'JOB_CLOSED':
      return 'Esta oferta ya no acepta postulaciones.';
    case 'DUPLICATE_APPLICATION':
      return 'Ya te postulaste a esta oferta.';
    case 'APPLICANT_INCOMPLETE':
      return 'Completa tu perfil de postulante para poder postular.';
    case 'VALIDATION_ERROR':
    case 'CONSTRAINT_VIOLATION':
      return 'Revisa los campos del formulario.';
    default:
      return 'Ocurrió un error. Intenta nuevamente.';
  }
}

export function getErrorCode(
  err: unknown
): ApiErrorCode | string | undefined {
  const e = err as any;

  return (
    e?.error?.error ??
    e?.error?.code ??
    e?.code ??
    e?.error
  );
}
