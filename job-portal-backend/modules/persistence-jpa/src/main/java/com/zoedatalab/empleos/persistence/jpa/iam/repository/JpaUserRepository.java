package com.zoedatalab.empleos.persistence.jpa.iam.repository;

import com.zoedatalab.empleos.iam.domain.DocumentType;
import com.zoedatalab.empleos.persistence.jpa.iam.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface JpaUserRepository extends JpaRepository<UserEntity, UUID> {

    Optional<UserEntity> findByEmail(String email);

    boolean existsByDocumentTypeAndDocumentNumberIgnoreCaseAndIdNot(
            DocumentType documentType,
            String documentNumber,
            UUID id
    );
}
