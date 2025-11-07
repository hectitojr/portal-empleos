import type { Job } from './types';

export const featuredJobs: Job[] = [
  {
    id: 1,
    title: 'Desarrollador Full Stack',
    company: 'Tech Solutions',
    location: 'Lima, Miraflores',
    type: 'Tiempo completo',
    salary: 'S/. 5,000 - 7,000',
    posted: 'Hace 2 días',
    tags: ['React', 'Java', 'Spring Boot'],
  },
  {
    id: 2,
    title: 'Diseñador UX/UI Senior',
    company: 'Creative Agency',
    location: 'Lima, San Isidro',
    type: 'Remoto',
    salary: 'S/. 4,500 - 6,500',
    posted: 'Hace 1 día',
    tags: ['Figma', 'Adobe XD', 'Diseño'],
  },
  {
    id: 3,
    title: 'Analista de Datos',
    company: 'DataCorp',
    location: 'Lima, Surco',
    type: 'Híbrido',
    salary: 'S/. 4,000 - 6,000',
    posted: 'Hace 3 días',
    tags: ['Python', 'SQL', 'Power BI'],
  },
];
