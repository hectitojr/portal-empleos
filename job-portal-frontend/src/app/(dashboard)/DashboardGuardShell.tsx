'use client';

import NavigationGuardProvider from '@/app/components/navigation/NavigationGuardProvider';

export default function DashboardGuardShell({ children }: { children: React.ReactNode }) {
  return <NavigationGuardProvider>{children}</NavigationGuardProvider>;
}
