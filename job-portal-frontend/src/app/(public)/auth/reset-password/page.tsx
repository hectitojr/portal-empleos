import { Suspense } from 'react';
import ResetPasswordClient from '@/app/(public)/auth/reset-password/ResetPasswordClient';

export default function Page() {
  return (
    <Suspense fallback={null}>
      <ResetPasswordClient />
    </Suspense>
  );
}
