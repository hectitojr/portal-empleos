import type { ReactNode } from 'react';
import DashboardHeader from '@/app/components/layout/DashboardHeader';
import DashboardFooter from '@/app/components/layout/DashboardFooter';

export default function DashboardLayout({ children }: { children: ReactNode }) {
  return (
    <div className="min-h-screen w-full flex flex-col bg-slate-50">
      <DashboardHeader />

      <main className="pt-16 flex-1 flex flex-col min-h-0" role="main">
        {children}
      </main>

      <DashboardFooter />
    </div>
  );
}
