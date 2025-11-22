/**
 * Calcula y retorna el tiempo transcurrido desde una fecha en formato legible
 * @param dateString - Fecha en formato ISO 8601 (ej: "2025-01-20T10:00:00Z")
 * @returns String formateado (ej: "Hace 2 días")
 */
export function getTimeAgo(dateString: string): string {
  const now = new Date();
  const posted = new Date(dateString);
  const diffInMs = now.getTime() - posted.getTime();
  
  const seconds = Math.floor(diffInMs / 1000);
  const minutes = Math.floor(seconds / 60);
  const hours = Math.floor(minutes / 60);
  const days = Math.floor(hours / 24);
  const weeks = Math.floor(days / 7);
  const months = Math.floor(days / 30);
  
  if (months > 0) return `hace ${months} ${months === 1 ? 'mes' : 'meses'}`;
  if (weeks > 0) return `hace ${weeks} ${weeks === 1 ? 'semana' : 'semanas'}`;
  if (days > 0) return `hace ${days} ${days === 1 ? 'día' : 'días'}`;
  if (hours > 0) return `hace ${hours} ${hours === 1 ? 'hora' : 'horas'}`;
  if (minutes > 0) return `hace ${minutes} ${minutes === 1 ? 'minuto' : 'minutos'}`;
  return 'hace un momento';
}