'use client';
import { useId, useState } from 'react';
import { Eye, EyeOff, Lock } from 'lucide-react';

export default function PasswordField({
  name, label, value, onChange, placeholder, error,
}: {
  name: string; label: string; value: string;
  onChange: React.ChangeEventHandler<HTMLInputElement>;
  placeholder?: string; error?: string;
}) {
  const [show, setShow] = useState(false);
  const inputId = useId();
  const errId = `${inputId}-error`;

  return (
    <div>
      <label htmlFor={inputId} className="block text-sm font-medium text-slate-700 mb-2">
        {label}
      </label>
      <div className="relative">
        <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" aria-hidden="true" />
        <input
          id={inputId}
          type={show ? 'text' : 'password'}
          name={name}
          value={value}
          onChange={onChange}
          autoComplete={name === 'confirmPassword' ? 'new-password' : 'current-password'}
          aria-invalid={!!error || undefined}
          aria-describedby={error ? errId : undefined}
          className={`w-full pl-11 pr-12 py-3 border rounded-xl focus:outline-none focus-visible:ring-2 transition-all ${error ? 'border-red-300 focus-visible:ring-red-500' : 'border-slate-200 focus-visible:ring-blue-500'}`}
          placeholder={placeholder}
        />
        <button
          type="button"
          onClick={() => setShow(!show)}
          aria-label={show ? 'Ocultar contraseña' : 'Mostrar contraseña'}
          aria-pressed={show}
          className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 rounded"
        >
          {show ? <EyeOff className="w-5 h-5" aria-hidden="true" /> : <Eye className="w-5 h-5" aria-hidden="true" />}
        </button>
      </div>
      {error && <p id={errId} className="mt-1 text-sm text-red-600">{error}</p>}
    </div>
  );
}
