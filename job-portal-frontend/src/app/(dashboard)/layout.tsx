import type { ReactNode } from 'react';
import DashboardHeader from '@/app/components/layout/DashboardHeader';

export default function DashboardLayout({ children }: { children: ReactNode }) {
  return (
    <div className="min-h-screen w-full flex flex-col bg-slate-50">

      {/* Header compartido */}
      <DashboardHeader />

      {/* Shell general: espacio para el header */}
      <main className="pt-16 flex-1 flex flex-col">
        {children}
      </main>
    </div>
  );
}
