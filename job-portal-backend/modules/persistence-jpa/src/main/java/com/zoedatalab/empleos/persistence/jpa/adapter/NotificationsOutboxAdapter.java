package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zoedatalab.empleos.iam.application.ports.out.NotificationsOutboxPort;
import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.Map;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class NotificationsOutboxAdapter implements NotificationsOutboxPort {

    private final EntityManager em;
    private final ObjectMapper om;

    @Override
    public void enqueue(Type type, Map<String, Object> payload) {
        var id = UUID.randomUUID();
        var now = Instant.now();
        var json = om.valueToTree(payload).toString();

        em.createNativeQuery("""
           INSERT INTO notifications_outbox (id, type, payload, status, attempts, created_at, updated_at)
           VALUES (:id, :type, cast(:payload as jsonb), 'PENDING', 0, :now, :now)
        """)
                .setParameter("id", id)
                .setParameter("type", type.name())
                .setParameter("payload", json)
                .setParameter("now", now)
                .executeUpdate();
    }
}
