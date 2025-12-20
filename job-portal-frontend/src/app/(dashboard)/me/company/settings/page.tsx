'use client';

import Link from 'next/link';
import { routes } from '@/lib/routes';

export default function CompanySettingsPage() {
  return (
    <section className="flex flex-col flex-1 min-h-0">
      <div className="max-w-4xl mx-auto w-full px-4 sm:px-6 py-8">
        <header className="mb-6">
          <Link
            href={routes.dashboard.company.home}
            className="text-sm font-semibold text-blue-700 hover:text-blue-800"
          >
            ← Volver al panel
          </Link>

          <h1 className="mt-3 text-2xl sm:text-3xl font-bold text-slate-900">
            Configuración
          </h1>
          <p className="mt-2 text-slate-600">
            Preferencias de la cuenta de empresa (próximamente).
          </p>
        </header>

        <div className="rounded-2xl border border-slate-100 bg-white p-6 shadow-sm">
          <p className="text-sm text-slate-700">
            Aquí agregaremos opciones como notificaciones, visibilidad, seguridad y más.
          </p>
        </div>
      </div>
    </section>
  );
}
