package com.zoedatalab.empleos.persistence.jpa.iam.adapter;

import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import com.zoedatalab.empleos.iam.domain.DocumentType;
import com.zoedatalab.empleos.iam.domain.User;
import com.zoedatalab.empleos.persistence.jpa.iam.entity.UserEntity;
import com.zoedatalab.empleos.persistence.jpa.iam.mapper.UserJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.iam.repository.JpaUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class UserRepositoryAdapter implements UserRepositoryPort {

    private final JpaUserRepository repo;
    private final UserJpaMapper mapper;

    @Override
    public Optional<User> findByEmail(String email) {
        return repo.findByEmail(email).map(mapper::toDomain);
    }

    @Override
    public Optional<User> findById(UUID id) {
        return repo.findById(id).map(mapper::toDomain);
    }

    @Override
    public User save(User user) {
        UserEntity entity = mapper.toEntity(user);
        UserEntity saved = repo.save(entity);
        return mapper.toDomain(saved);
    }

    @Override
    public boolean existsByDocumentTypeAndNumberForOtherUser(
            DocumentType type,
            String number,
            UUID currentUserId
    ) {
        return repo.existsByDocumentTypeAndDocumentNumberIgnoreCaseAndIdNot(
                type, number, currentUserId
        );
    }
}
