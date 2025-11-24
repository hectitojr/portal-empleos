import type { Job } from './types';

export const featuredJobs: Job[] = [
  {
    id: 1,
    title: 'Desarrollador Full Stack',
    company: 'Tech Solutions',
    location: 'Lima, Miraflores',
    salary: 'S/. 5,000 - 7,000',
    employmentType: 'Tiempo completo',
    workMode: 'Híbrido',
    viewed: false,
    quickApply: 'Postúlate a la oferta rápidamente',
    isActive: true,
    isApplied: false,
    postedAt: '2025-01-20T10:00:00Z', // Hace 1 día
  },
  {
    id: 3,
    title: 'Analista de Datos',
    company: 'DataCorp',
    location: 'Lima, Surco',
    salary: 'S/. 4,000 - 6,000',
    employmentType: 'Tiempo completo',
    workMode: 'Híbrido',
    viewed: false,
    quickApply: 'Postúlate a la oferta rápidamente',
    isActive: true,
    isApplied: false,
    postedAt: '2025-01-18T09:00:00Z', // Hace 3 días
  },
  {
    id: 7,
    title: 'Enfermera Especialista',
    company: 'Clínica Internacional',
    location: 'Lima, San Borja',
    salary: 'S/. 2,200 - 3,500',
    employmentType: 'Tiempo completo',
    workMode: 'Presencial',
    viewed: false,
    quickApply: 'Postúlate a la oferta rápidamente',
    isActive: true,
    isApplied: false,
    postedAt: '2025-01-21T07:00:00Z', // Hace 8 horas
  },
  {
    id: 10,
    title: 'Asistente Administrativo',
    company: 'Corporación Legal del Sur',
    location: 'Arequipa, Cercado',
    salary: 'S/. 1,500 - 2,200',
    employmentType: 'Medio tiempo',
    workMode: 'Presencial',
    viewed: false,
    quickApply: 'Postúlate a la oferta rápidamente',
    isActive: false,
    isApplied: false,
    postedAt: '2024-12-15T10:00:00Z', // Hace 1 mes (oferta cerrada)
  },
];