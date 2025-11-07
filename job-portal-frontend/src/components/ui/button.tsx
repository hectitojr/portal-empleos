import type { ButtonHTMLAttributes } from 'react';
import { cn } from '@/lib/cn';

export function Button({ className, ...props }: ButtonHTMLAttributes<HTMLButtonElement>) {
  return (
    <button
      className={cn('inline-flex items-center justify-center rounded-md border px-4 py-2 text-sm font-medium shadow-sm hover:opacity-90 disabled:opacity-50', className)}
      {...props}
    />
  );
}
