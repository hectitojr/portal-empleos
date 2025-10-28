package com.zoedatalab.empleos.applications.application.ports.in;

import com.zoedatalab.empleos.applications.application.dto.ApplicationView;
import java.util.List;
import java.util.UUID;

public interface ApplicationQueryService {
    // Para postulante autenticado:
    List<ApplicationView> myApplications(UUID applicantUserId, int page, int size);

    // Para empresa (dueña del job):
    List<ApplicationView> listForJob(UUID companyUserId, UUID jobId, int page, int size);
    ApplicationView getByIdAuthorizedForCompany(UUID companyUserId, UUID applicationId);
}
