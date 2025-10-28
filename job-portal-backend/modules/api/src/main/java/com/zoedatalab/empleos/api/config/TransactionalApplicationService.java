package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.applications.application.dto.*;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationCommandService;
import com.zoedatalab.empleos.applications.application.ports.in.ApplicationQueryService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

public class TransactionalApplicationService implements ApplicationCommandService, ApplicationQueryService {

    private final ApplicationCommandService cmd;
    private final ApplicationQueryService qry;

    public TransactionalApplicationService(ApplicationCommandService cmd, ApplicationQueryService qry) {
        this.cmd = cmd;
        this.qry = qry;
    }

    @Override @Transactional
    public ApplicationView apply(UUID applicantUserId, UUID jobId, ApplyToJobCommand c) {
        return cmd.apply(applicantUserId, jobId, c);
    }

    @Override @Transactional
    public ApplicationView updateStatus(UUID companyUserId, UUID applicationId, UpdateApplicationStatusCommand c) {
        return cmd.updateStatus(companyUserId, applicationId, c);
    }

    @Override @Transactional(readOnly = true)
    public List<ApplicationView> myApplications(UUID applicantUserId, int page, int size) {
        return qry.myApplications(applicantUserId, page, size);
    }

    @Override @Transactional(readOnly = true)
    public List<ApplicationView> listForJob(UUID companyUserId, UUID jobId, int page, int size) {
        return qry.listForJob(companyUserId, jobId, page, size);
    }

    @Override @Transactional(readOnly = true)
    public ApplicationView getByIdAuthorizedForCompany(UUID companyUserId, UUID applicationId) {
        return qry.getByIdAuthorizedForCompany(companyUserId, applicationId);
    }
}
