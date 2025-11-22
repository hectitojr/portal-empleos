'use client';

import type { ReactNode } from 'react';
import Footer from '@/app/components/layout/Footer';

export default function ApplicantLayout({ children }: { children: ReactNode }) {
  return (
    // Este layout controla solo el “rol applicant”
    <div className="min-h-[calc(100vh-4rem)] flex flex-col bg-slate-50">
      <main
        className="flex-1 min-h-0 overflow-y-auto flex flex-col"
        role="main"
      >
        {children}
      </main>

      <Footer />
    </div>
  );
}
