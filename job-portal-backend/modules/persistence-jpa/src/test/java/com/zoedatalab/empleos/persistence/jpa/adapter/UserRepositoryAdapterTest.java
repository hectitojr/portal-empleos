package com.zoedatalab.empleos.persistence.jpa.adapter;

import com.zoedatalab.empleos.iam.domain.User;
import com.zoedatalab.empleos.persistence.jpa.iam.adapter.UserRepositoryAdapter;
import com.zoedatalab.empleos.persistence.jpa.iam.entity.UserEntity;
import com.zoedatalab.empleos.persistence.jpa.iam.mapper.UserJpaMapper;
import com.zoedatalab.empleos.persistence.jpa.iam.repository.JpaUserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class UserRepositoryAdapterTest {

    private JpaUserRepository repo;
    private UserJpaMapper mapper;
    private UserRepositoryAdapter sut;

    @BeforeEach
    void setUp() {
        repo = mock(JpaUserRepository.class);
        mapper = mock(UserJpaMapper.class);
        sut = new UserRepositoryAdapter(repo, mapper);
    }

    @Test
    void findByEmail_delegates_and_maps() {
        String email = "a@a.com";

        UserEntity entity = mock(UserEntity.class);
        User domain = mock(User.class);

        when(repo.findByEmail(email)).thenReturn(Optional.of(entity));
        when(mapper.toDomain(entity)).thenReturn(domain);

        Optional<User> out = sut.findByEmail(email);

        assertTrue(out.isPresent());
        assertSame(domain, out.get());
    }

    @Test
    void findById_delegates_and_maps() {
        UUID id = UUID.randomUUID();

        UserEntity entity = mock(UserEntity.class);
        User domain = mock(User.class);

        when(repo.findById(id)).thenReturn(Optional.of(entity));
        when(mapper.toDomain(entity)).thenReturn(domain);

        Optional<User> out = sut.findById(id);

        assertTrue(out.isPresent());
        assertSame(domain, out.get());
    }

    @Test
    void save_sets_fields_and_persists() {
        User user = mock(User.class);
        UUID id = UUID.randomUUID();

        when(user.getId()).thenReturn(id);
        when(user.getEmail()).thenReturn("a@a.com");
        when(user.getPasswordHash()).thenReturn("hash");
        when(user.getRole()).thenReturn(null);

        UserEntity entity = mock(UserEntity.class);
        UserEntity savedEntity = mock(UserEntity.class);
        User savedDomain = mock(User.class);

        when(mapper.toEntity(user)).thenReturn(entity);
        when(entity.getId()).thenReturn(null);
        when(repo.save(entity)).thenReturn(savedEntity);
        when(mapper.toDomain(savedEntity)).thenReturn(savedDomain);

        User out = sut.save(user);

        verify(entity).setId(id);
        verify(entity).setEmail("a@a.com");
        verify(entity).setPasswordHash("hash");
        verify(entity).setRole(null);

        verify(repo).save(entity);
        assertSame(savedDomain, out);
    }
}
