package com.zoedatalab.empleos.api.maintenance;

import com.zoedatalab.empleos.api.config.MaintenanceProperties;
import com.zoedatalab.empleos.iam.application.ports.out.RefreshTokenRepositoryPort;
import org.junit.jupiter.api.Test;

import static org.mockito.Mockito.*;

class RefreshTokenMaintenanceServiceTest {

    @Test
    void purge_callsRepositoryWithNow() {
        var repo = mock(RefreshTokenRepositoryPort.class);
        var props = new MaintenanceProperties();
        props.setEnabled(true);
        props.setCron("0 0 * * * *");

        when(repo.purgeExpired(any())).thenReturn(3L);

        var svc = new RefreshTokenMaintenanceService(repo, props);
        svc.purge();

        verify(repo, times(1)).purgeExpired(any());
    }
}