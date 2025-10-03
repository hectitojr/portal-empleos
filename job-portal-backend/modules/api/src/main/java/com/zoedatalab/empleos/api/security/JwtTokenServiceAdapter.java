package com.zoedatalab.empleos.api.security;

import com.zoedatalab.empleos.iam.application.ports.out.TokenServicePort;
import com.zoedatalab.empleos.iam.domain.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.time.Instant;
import java.util.Date;

@Component
public class JwtTokenServiceAdapter implements TokenServicePort {

    private final SecretKey key;
    private final long accessTtlSeconds;
    private final String issuer;

    public JwtTokenServiceAdapter(
            @Value("${security.jwt.secret}") String secretBase64,
            @Value("${security.jwt.access-ttl-seconds:900}") long accessTtlSeconds,
            @Value("${security.jwt.issuer:job-portal}") String issuer
    ) {
        // Recomendado: secret en BASE64, al menos 256 bits para HS256
        this.key = Keys.hmacShaKeyFor(secretBase64.getBytes(java.nio.charset.StandardCharsets.UTF_8));
        this.accessTtlSeconds = accessTtlSeconds;
        this.issuer = issuer;
    }

    @Override
    public String issueAccessToken(User u) {
        Instant now = Instant.now();
        return Jwts.builder()
                .subject(u.getId().toString())
                .issuer(issuer)
                .claim("email", u.getEmail())
                .claim("role", u.getRole().name())
                .issuedAt(Date.from(now))
                .expiration(Date.from(now.plusSeconds(accessTtlSeconds)))
                .signWith(key)
                .compact();
    }

    @Override
    public long accessTokenTtlSeconds() {
        return accessTtlSeconds;
    }

    /** Utilidad para el filtro: parsea y valida el token firmado */
    public Jws<Claims> parse(String jwt) {
        return Jwts.parser().verifyWith(key).build().parseSignedClaims(jwt);
    }
}
