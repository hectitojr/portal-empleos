'use client';
import { Briefcase } from 'lucide-react';

export default function AuthHeader({ title, subtitle }: { title: string; subtitle: string }) {
  return (
    <header className="text-center mb-6" aria-labelledby="auth-title">
      <div className="flex items-center justify-center mb-3">
        <Briefcase className="w-12 h-12 text-blue-600" aria-hidden="true" />
      </div>
      <h1 id="auth-title" className="text-2xl sm:text-3xl lg:text-4xl font-bold text-slate-900">{title}</h1>
      <p className="text-slate-600 mt-1">{subtitle}</p>
    </header>
  );
}
