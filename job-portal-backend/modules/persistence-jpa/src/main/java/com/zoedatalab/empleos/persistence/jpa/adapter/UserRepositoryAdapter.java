package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.iam.application.ports.out.UserRepositoryPort;
import com.zoedatalab.empleos.iam.domain.User;
import com.zoedatalab.empleos.persistence.jpa.mapper.UserJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.repository.JpaUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
    @Transactional
    public User save(User user) {
        var entity = mapper.toEntity(user);

        // Refuerzo: identidad y campos NOT NULL
        if (entity.getId() == null) {
            entity.setId(user.getId());            // dominio define la identidad
        }
        entity.setEmail(user.getEmail());
        entity.setPasswordHash(user.getPasswordHash());
        entity.setRole(user.getRole());

        var saved = repo.save(entity);
        return mapper.toDomain(saved);
    }
}