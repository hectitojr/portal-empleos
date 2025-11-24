package com.zoedatalab.empleos.api.security;

import com.zoedatalab.empleos.iam.domain.Role;
import com.zoedatalab.empleos.iam.domain.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import org.junit.jupiter.api.Test;

import java.util.Base64;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class JwtTokenServiceAdapterTest {

    private static String base64Secret32Bytes() {
        byte[] key = new byte[32];
        for (int i = 0; i < key.length; i++) key[i] = (byte) i;
        return Base64.getEncoder().encodeToString(key);
    }

    @Test
    void constructor_throws_if_secret_less_than_32_bytes_after_decode() {
        byte[] shortKey = new byte[16];
        String shortB64 = Base64.getEncoder().encodeToString(shortKey);

        assertThrows(IllegalArgumentException.class,
                () -> new JwtTokenServiceAdapter(shortB64, 900, "job-portal"));
    }

    @Test
    void issueAccessToken_creates_signed_token_with_claims() {
        String secret = base64Secret32Bytes();
        JwtTokenServiceAdapter sut = new JwtTokenServiceAdapter(secret, 900, "job-portal");

        User user = mock(User.class);
        UUID id = UUID.randomUUID();
        when(user.getId()).thenReturn(id);
        when(user.getEmail()).thenReturn("a@a.com");
        when(user.getRole()).thenReturn(Role.APPLICANT);

        String token = sut.issueAccessToken(user);

        assertNotNull(token);

        Jws<Claims> jws = sut.parse(token);
        Claims c = jws.getPayload();

        assertEquals(id.toString(), c.getSubject());
        assertEquals("job-portal", c.getIssuer());
        assertEquals("a@a.com", c.get("email"));
        assertEquals("APPLICANT", c.get("role"));
        assertNotNull(c.getExpiration());
        assertNotNull(c.getIssuedAt());
    }

    @Test
    void parse_fails_with_wrong_issuer() {
        String secret = base64Secret32Bytes();
        JwtTokenServiceAdapter sut1 = new JwtTokenServiceAdapter(secret, 900, "issuer-1");
        JwtTokenServiceAdapter sut2 = new JwtTokenServiceAdapter(secret, 900, "issuer-2");

        User user = mock(User.class);
        when(user.getId()).thenReturn(UUID.randomUUID());
        when(user.getEmail()).thenReturn("a@a.com");
        when(user.getRole()).thenReturn(Role.COMPANY);

        String token = sut1.issueAccessToken(user);

        assertThrows(Exception.class, () -> sut2.parse(token));
    }
}
