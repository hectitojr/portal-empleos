'use client';
import { AlertCircle } from 'lucide-react';
import { useId, type ComponentProps, type ReactNode } from 'react';

type Props = {
  label: string;
  name: string;
  value: string;
  onChange: ComponentProps<'input'>['onChange'];
  placeholder?: string;
  icon?: ReactNode;
  type?: ComponentProps<'input'>['type'];
  error?: string;
  autoComplete?: string;
  inputMode?: ComponentProps<'input'>['inputMode'];
};

export default function TextField({
  label, name, value, onChange, placeholder, icon, type='text', error, autoComplete, inputMode
}: Props) {
  const inputId = useId();
  const errId = `${inputId}-error`;

  return (
    <div>
      <label htmlFor={inputId} className="block text-sm font-medium text-slate-700 mb-2">{label}</label>
      <div className="relative">
        {icon && <span aria-hidden="true">{icon}</span>}
        <input
          id={inputId}
          type={type}
          name={name}
          value={value}
          onChange={onChange}
          autoComplete={autoComplete}
          inputMode={inputMode}
          aria-invalid={!!error || undefined}
          aria-describedby={error ? errId : undefined}
          className={`w-full ${icon ? 'pl-11' : 'pl-4'} pr-4 py-3 border rounded-xl focus:outline-none focus-visible:ring-2 transition-all ${error ? 'border-red-300 focus-visible:ring-red-500' : 'border-slate-200 focus-visible:ring-blue-500'}`}
          placeholder={placeholder}
        />
      </div>
      {error && (
        <p id={errId} className="mt-1 text-sm text-red-600 flex items-center gap-1" role="alert" aria-live="assertive">
          <AlertCircle className="w-4 h-4" aria-hidden="true" />
          {error}
        </p>
      )}
    </div>
  );
}
