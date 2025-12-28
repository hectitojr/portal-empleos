'use client';

import { useEffect, useRef } from 'react';

type ConfirmDialogProps = {
  open: boolean;
  title: string;
  description?: string;
  confirmText?: string;
  cancelText?: string;
  destructive?: boolean;
  busy?: boolean;
  onConfirm: () => void;
  onCancel: () => void;
};

export default function ConfirmDialog({
  open,
  title,
  description,
  confirmText = 'Aceptar',
  cancelText = 'Cancelar',
  destructive = false,
  busy = false,
  onConfirm,
  onCancel,
}: ConfirmDialogProps) {
  const confirmBtnRef = useRef<HTMLButtonElement | null>(null);

  useEffect(() => {
    if (!open) return;

    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = 'hidden';

    const t = window.setTimeout(() => confirmBtnRef.current?.focus(), 0);

    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onCancel();

      if (e.key === 'Enter') {
        e.preventDefault();
        if (!busy) onConfirm();
      }
    };

    window.addEventListener('keydown', onKeyDown);

    return () => {
      document.body.style.overflow = prevOverflow;
      window.clearTimeout(t);
      window.removeEventListener('keydown', onKeyDown);
    };
  }, [open, busy, onCancel, onConfirm]);

  if (!open) return null;

  return (
    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
      <div
        className="absolute inset-0 bg-black/40"
        aria-hidden="true"
        onClick={() => {
          if (!busy) onCancel();
        }}
      />

      <div
        role="dialog"
        aria-modal="true"
        aria-labelledby="confirm-dialog-title"
        className="relative w-full max-w-md rounded-2xl bg-white shadow-xl border border-slate-200"
      >
        <div className="p-5 sm:p-6">
          <h3 id="confirm-dialog-title" className="text-base sm:text-lg font-bold text-slate-900">
            {title}
          </h3>

          {description && <p className="mt-2 text-sm text-slate-600">{description}</p>}

          <div className="mt-5 flex flex-col-reverse sm:flex-row sm:justify-end gap-3">
            <button
              type="button"
              disabled={busy}
              onClick={onCancel}
              className="inline-flex items-center justify-center rounded-2xl bg-white px-4 py-2.5 text-slate-900 text-sm font-semibold border border-slate-200 hover:bg-slate-50 transition disabled:opacity-60 disabled:cursor-not-allowed"
            >
              {cancelText}
            </button>

            <button
              type="button"
              ref={confirmBtnRef}
              disabled={busy}
              onClick={onConfirm}
              className={[
                'inline-flex items-center justify-center rounded-2xl px-4 py-2.5 text-sm font-semibold transition disabled:opacity-60 disabled:cursor-not-allowed',
                destructive
                  ? 'bg-red-600 text-white hover:bg-red-700'
                  : 'bg-slate-900 text-white hover:bg-slate-800',
              ].join(' ')}
            >
              {confirmText}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
