"use client";

import * as React from "react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { Eye, EyeOff, Mail, Lock, Briefcase, CheckCircle, AlertCircle, ArrowLeft } from "lucide-react";

const LoginSchema = z.object({
  email: z.string().min(1, "El email es requerido").email("Email inválido"),
  password: z.string().min(8, "La contraseña debe tener al menos 8 caracteres"),
  remember: z.boolean().optional(),
});

type LoginInput = z.infer<typeof LoginSchema>;

export default function LoginCard() {
  const [showPassword, setShowPassword] = useState(false);
  const [success, setSuccess] = useState<string | null>(null);
  const [serverError, setServerError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const { register, handleSubmit, formState: { errors } } = useForm<LoginInput>({
    resolver: zodResolver(LoginSchema),
    defaultValues: { email: "", password: "", remember: false },
  });

  const onSubmit = async (values: LoginInput) => {
    setLoading(true);
    setServerError(null);
    setSuccess(null);
    try {
      const res = await fetch("/api/auth/login", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(values),
      });

      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        // Espera { code: "BAD_CREDENTIALS" | "USER_SUSPENDED" | ... , message?: string }
        setServerError(body?.message ?? "No se pudo iniciar sesión");
        setLoading(false);
        return;
      }

      // El BFF ya setea cookies HttpOnly y responde con { role, next? }
      const body = await res.json();
      setSuccess("¡Inicio de sesión exitoso! Redirigiendo...");
      // Redirige según rol o query ?next
      const nextUrl = body?.next ?? (body?.role === "COMPANY" ? "/company/me" : "/(dashboard)/applications");
      window.location.assign(nextUrl);
    } catch {
      setServerError("Error de red. Inténtalo nuevamente.");
      setLoading(false);
    }
  };

  return (
    <>
      <div className="text-center mb-8">
        <div className="flex items-center justify-center mb-4">
          <Briefcase className="w-12 h-12 text-blue-600" />
        </div>
        <h1 className="text-3xl font-bold text-slate-900 mb-2">Bienvenido de nuevo</h1>
        <p className="text-slate-600">Ingresa tus credenciales para continuar</p>
      </div>

      {success && (
        <div className="mb-6 p-4 bg-green-50 border border-green-200 rounded-xl flex items-center gap-3">
          <CheckCircle className="w-5 h-5 text-green-600 flex-shrink-0" />
          <p className="text-green-800 text-sm">{success}</p>
        </div>
      )}

      {serverError && (
        <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-xl flex items-center gap-3">
          <AlertCircle className="w-5 h-5 text-red-600 flex-shrink-0" />
          <p className="text-red-800 text-sm">{serverError}</p>
        </div>
      )}

      <div className="bg-white rounded-2xl shadow-xl p-8">
        <form onSubmit={handleSubmit(onSubmit)} className="space-y-5" noValidate>
          <div>
            <label htmlFor="email" className="block text-sm font-medium text-slate-700 mb-2">
              Correo Electrónico
            </label>
            <div className="relative">
              <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
              <input
                id="email"
                type="email"
                autoComplete="email"
                {...register("email")}
                className={`w-full pl-11 pr-4 py-3 border rounded-xl focus:outline-none focus:ring-2 transition-all ${
                  errors.email ? "border-red-300 focus:ring-red-500" : "border-slate-200 focus:ring-blue-500"
                }`}
                placeholder="tu@email.com"
              />
            </div>
            {errors.email && (
              <p className="mt-1 text-sm text-red-600 flex items-center gap-1">
                <AlertCircle className="w-4 h-4" />
                {errors.email.message}
              </p>
            )}
          </div>

          <div>
            <label htmlFor="password" className="block text-sm font-medium text-slate-700 mb-2">
              Contraseña
            </label>
            <div className="relative">
              <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
              <input
                id="password"
                type={showPassword ? "text" : "password"}
                autoComplete="current-password"
                {...register("password")}
                className={`w-full pl-11 pr-12 py-3 border rounded-xl focus:outline-none focus:ring-2 transition-all ${
                  errors.password ? "border-red-300 focus:ring-red-500" : "border-slate-200 focus:ring-blue-500"
                }`}
                placeholder="Mínimo 8 caracteres"
              />
              <button
                type="button"
                aria-label={showPassword ? "Ocultar contraseña" : "Mostrar contraseña"}
                onClick={() => setShowPassword(!showPassword)}
                className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
              >
                {showPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
              </button>
            </div>
            {errors.password && (
              <p className="mt-1 text-sm text-red-600 flex items-center gap-1">
                <AlertCircle className="w-4 h-4" />
                {errors.password.message}
              </p>
            )}
          </div>

          <div className="flex items-center justify-between text-sm">
            <label className="flex items-center">
              <input
                type="checkbox"
                {...register("remember")}
                className="w-4 h-4 text-blue-600 rounded border-slate-300 focus:ring-blue-500"
              />
              <span className="ml-2 text-slate-600">Recordarme</span>
            </label>
            <button type="button" className="text-blue-600 hover:text-blue-700 font-medium">
              ¿Olvidaste tu contraseña?
            </button>
          </div>

          <button
            type="submit"
            disabled={loading}
            className={`w-full py-3 rounded-xl font-semibold transition-all shadow-lg hover:shadow-xl ${
              loading
                ? "bg-slate-400 cursor-not-allowed"
                : "bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white"
            }`}
          >
            {loading ? (
              <span className="flex items-center justify-center gap-2">
                <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                Procesando...
              </span>
            ) : (
              "Iniciar Sesión"
            )}
          </button>
        </form>

        <div className="mt-6 text-center">
          <p className="text-slate-600 text-sm">
            ¿No tienes cuenta?{" "}
            <a href="/auth/register" className="text-blue-600 hover:text-blue-700 font-semibold">
              Regístrate aquí
            </a>
          </p>
        </div>
      </div>

      <div className="mt-6 text-center">
        <a
          href="/"
          className="text-slate-600 hover:text-slate-900 text-sm inline-flex items-center gap-2 transition-colors"
        >
          <ArrowLeft className="w-4 h-4" />
          Volver al inicio
        </a>
      </div>
    </>
  );
}
