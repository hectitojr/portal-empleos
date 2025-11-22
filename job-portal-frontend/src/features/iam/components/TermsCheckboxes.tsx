'use client';
import { AlertCircle } from 'lucide-react';
import { useId } from 'react';

export default function TermsCheckboxes({
  acceptTerms,
  acceptDataPolicy,
  onChange,
  errors,
}: {
  acceptTerms: boolean;
  acceptDataPolicy: boolean;
  onChange: React.ChangeEventHandler<HTMLInputElement>;
  errors: Record<string, string>;
}) {
  const termsId = useId();
  const dataId = useId();

  return (
    <>
      {/* Checkbox: Términos y Condiciones + Política de Privacidad */}
      <label htmlFor={termsId} className="flex items-start">
        <input
          id={termsId}
          type="checkbox"
          name="acceptTerms"
          checked={acceptTerms}
          onChange={onChange}
          aria-invalid={!!errors.acceptTerms || undefined}
          className={`w-4 h-4 text-blue-600 rounded border-slate-300 focus-visible:ring-blue-500 mt-1 ${
            errors.acceptTerms ? 'border-red-300' : ''
          }`}
        />
        <span className="ml-2 text-sm text-slate-600">
          Acepto los{' '}
          <a
            href="/terminos"
            className="text-blue-600 hover:text-blue-700 underline"
            target="_blank"
            rel="noopener noreferrer"
          >
            Términos y Condiciones
          </a>{' '}
          y la{' '}
          <a
            href="/privacidad"
            className="text-blue-600 hover:text-blue-700 underline"
            target="_blank"
            rel="noopener noreferrer"
          >
            Política de Privacidad
          </a>
          .
        </span>
      </label>
      {errors.acceptTerms && (
        <p
          className="mt-1 text-sm text-red-600 flex items-center gap-1"
          role="alert"
          aria-live="assertive"
        >
          <AlertCircle className="w-4 h-4" aria-hidden="true" />
          {errors.acceptTerms}
        </p>
      )}

      {/* Checkbox: Tratamiento de datos personales */}
      <label htmlFor={dataId} className="flex items-start">
        <input
          id={dataId}
          type="checkbox"
          name="acceptDataPolicy"
          checked={acceptDataPolicy}
          onChange={onChange}
          aria-invalid={!!errors.acceptDataPolicy || undefined}
          className={`w-4 h-4 text-blue-600 rounded border-slate-300 focus-visible:ring-blue-500 mt-1 ${
            errors.acceptDataPolicy ? 'border-red-300' : ''
          }`}
        />
        <span className="ml-2 text-sm text-slate-600">
          Autorizo el tratamiento de mis datos personales conforme a la{' '}
          <a
            href="/privacidad"
            className="text-blue-600 hover:text-blue-700 underline"
            target="_blank"
            rel="noopener noreferrer"
          >
            Política de Privacidad
          </a>
          .
        </span>
      </label>
      {errors.acceptDataPolicy && (
        <p
          className="mt-1 text-sm text-red-600 flex items-center gap-1"
          role="alert"
          aria-live="assertive"
        >
          <AlertCircle className="w-4 h-4" aria-hidden="true" />
          {errors.acceptDataPolicy}
        </p>
      )}
    </>
  );
}
