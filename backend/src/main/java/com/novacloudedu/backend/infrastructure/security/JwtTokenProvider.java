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

    @Value("${jwt.refresh-expiration:604800000}")
    private long refreshExpiration; // 默认7天

    /**
     * 生成 Access Token
     */
    public String generateToken(Long userId, String userAccount, String userRole) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + expiration);

        return Jwts.builder()
                .subject(String.valueOf(userId))
                .claim("userAccount", userAccount)
                .claim("userRole", userRole)
                .claim("tokenType", "access")
                .issuedAt(now)
                .expiration(expiryDate)
                .signWith(getSigningKey())
                .compact();
    }

    /**
     * 生成 Refresh Token
     */
    public String generateRefreshToken(Long userId) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + refreshExpiration);

        return Jwts.builder()
                .subject(String.valueOf(userId))
                .claim("tokenType", "refresh")
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
            Claims claims = parseToken(token);
            // 验证是否为access token
            String tokenType = claims.get("tokenType", String.class);
            return "access".equals(tokenType);
        } catch (JwtException | IllegalArgumentException e) {
            log.error("Invalid JWT token: {}", e.getMessage());
            return false;
        }
    }

    /**
     * 验证 Refresh Token
     */
    public boolean validateRefreshToken(String refreshToken) {
        try {
            Claims claims = parseToken(refreshToken);
            // 验证是否为refresh token
            String tokenType = claims.get("tokenType", String.class);
            return "refresh".equals(tokenType);
        } catch (JwtException | IllegalArgumentException e) {
            log.error("Invalid refresh token: {}", e.getMessage());
            return false;
        }
    }

    /**
     * 从 Refresh Token 中获取用户ID
     */
    public Long getUserIdFromRefreshToken(String refreshToken) {
        Claims claims = parseToken(refreshToken);
        return Long.parseLong(claims.getSubject());
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
