import type { Route } from 'next';

export const routes = {
  public: {
    home: '/' as Route,
    jobs: '/jobs' as Route,
    job: (id: string) => `/jobs/${id}` as Route,

    login: '/auth/login' as Route,
    register: '/auth/register' as Route,

    // Páginas informativas del footer
    help: '/ayuda' as Route,
    contact: '/contacto' as Route,
    about: '/acerca' as Route,
    accessibility: '/accesibilidad' as Route,
    terms: '/terminos' as Route,
  },

  dashboard: {
    me: '/me' as Route,

    applicant: {
      home: '/applicant' as Route,
      profileSetup: '/me/applicant/profile/setup' as Route,
    },

    company: {
      home: '/company' as Route,
      profileSetup: '/me/company/profile/setup' as Route,

      jobs: '/company/jobs' as Route,
      jobNew: '/company/jobs/new' as Route,

      applications: '/company/applications' as Route,
      notifications: '/company/notifications' as Route,

      settings: '/me/company/settings' as Route,

      jobApplications: (id: string) =>
        `/company/jobs/${id}/applications` as Route,
    },
  },
} as const;
