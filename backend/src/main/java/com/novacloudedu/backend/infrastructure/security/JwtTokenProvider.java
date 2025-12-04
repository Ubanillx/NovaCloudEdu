package com.novacloudedu.backend.infrastructure.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

/**
 * JWT Token 工具类
 */
@Component
@Slf4j
public class JwtTokenProvider {

    @Value("${jwt.secret:NovaCloudEduSecretKey123456789012345678901234567890}")
    private String secret;

    @Value("${jwt.expiration:86400000}")
    private long expiration; // 默认24小时

    /**
     * 生成 Token
     */
    public String generateToken(Long userId, String userAccount, String userRole) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + expiration);

        return Jwts.builder()
                .subject(String.valueOf(userId))
                .claim("userAccount", userAccount)
                .claim("userRole", userRole)
                .issuedAt(now)
                .expiration(expiryDate)
                .signWith(getSigningKey())
                .compact();
    }

    /**
     * 从 Token 中获取用户ID
     */
    public Long getUserIdFromToken(String token) {
        Claims claims = parseToken(token);
        return Long.parseLong(claims.getSubject());
    }

    /**
     * 从 Token 中获取用户账号
     */
    public String getUserAccountFromToken(String token) {
        Claims claims = parseToken(token);
        return claims.get("userAccount", String.class);
    }

    /**
     * 从 Token 中获取用户角色
     */
    public String getUserRoleFromToken(String token) {
        Claims claims = parseToken(token);
        return claims.get("userRole", String.class);
    }

    /**
     * 验证 Token
     */
    public boolean validateToken(String token) {
        try {
            parseToken(token);
            return true;
        } catch (JwtException | IllegalArgumentException e) {
            log.error("Invalid JWT token: {}", e.getMessage());
            return false;
        }
    }

    /**
     * 解析 Token
     */
    private Claims parseToken(String token) {
        return Jwts.parser()
                .verifyWith(getSigningKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    /**
     * 获取签名密钥
     */
    private SecretKey getSigningKey() {
        byte[] keyBytes = secret.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(keyBytes);
    }
}
