package com.zoedatalab.empleos.persistence.jpa.entity;

import com.zoedatalab.empleos.iam.domain.Role;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "users")
@Getter @Setter @Builder
@NoArgsConstructor @AllArgsConstructor
public class UserEntity {

    @Id
    @Column(columnDefinition = "uuid", nullable = false, updatable = false)
    private UUID id;

    @Column(nullable = false, unique = true, columnDefinition = "citext")
    @JdbcTypeCode(SqlTypes.VARCHAR)
    private String email;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @Column(nullable = false)
    private boolean active;

    @Column(nullable = false)
    private boolean suspended;

    @Column(name = "created_at", nullable = false, insertable = false, updatable = false)
    private Instant createdAt;

    @Column(name = "updated_at", nullable = false, insertable = false, updatable = false)
    private Instant updatedAt;

    @Column(name = "created_by")
    private UUID createdBy;

    @Column(name = "updated_by")
    private UUID updatedBy;
}