export type ApiFieldErrorItem = {
  field: string | null;
  code: string;
  message: string;
};

export type ApiViolationErrorItem = {
  param: string | null;
  code: string;
  message: string;
};

export type ApiErrorResponse = {
  error: string; 
  message: string;
  status: number;
  path?: string | null;
  traceId?: string | null;
  timestamp?: string;
  fieldErrors?: ApiFieldErrorItem[] | null;
  violations?: ApiViolationErrorItem[] | null;
};

export type ApiResult<T> =
  | { ok: true; data: T; status: number; traceId?: string | null }
  | { ok: false; error: ApiErrorResponse | null; status: number; bodyText?: string; traceId?: string | null };
