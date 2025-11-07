export const routes = {
public: {
home: '/',
jobs: '/jobs',
job: (id: string) => `/jobs/${id}`,
login: '/auth/login',
register: '/auth/register'
},
dashboard: {
me: '/me',
applications: '/applications',
company: {
jobs: '/company/jobs',
jobApplications: (id: string) => `/company/jobs/${id}/applications`
}
}
};