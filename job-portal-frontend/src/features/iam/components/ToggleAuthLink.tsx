'use client';

export default function ToggleAuthLink({
  isLogin, onToggle,
}: {
  isLogin: boolean;
  onToggle: () => void;
}) {
  return (
    <div className="mt-6 text-center">
      <p className="text-slate-600 text-sm">
        {isLogin ? '¿No tienes cuenta?' : '¿Ya tienes cuenta?'}{' '}
        <button type="button" onClick={onToggle} className="text-blue-600 hover:text-blue-700 font-semibold">
          {isLogin ? 'Regístrate aquí' : 'Inicia sesión'}
        </button>
      </p>
    </div>
  );
}
