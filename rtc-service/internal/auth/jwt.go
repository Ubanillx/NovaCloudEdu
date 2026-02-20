package auth

import (
	"fmt"
	"strconv"

	"github.com/golang-jwt/jwt/v5"
)

// Claims JWT 令牌声明
type Claims struct {
	UserAccount string `json:"userAccount"`
	UserRole    string `json:"userRole"`
	TokenType   string `json:"tokenType"`
	jwt.RegisteredClaims
}

// JWTValidator JWT 验证器
type JWTValidator struct {
	secret []byte
}

// NewJWTValidator 创建 JWT 验证器
func NewJWTValidator(secret string) *JWTValidator {
	return &JWTValidator{secret: []byte(secret)}
}

// ValidateToken 验证 JWT 令牌，返回用户ID
func (v *JWTValidator) ValidateToken(tokenString string) (int64, string, error) {
	token, err := jwt.ParseWithClaims(tokenString, &Claims{}, func(token *jwt.Token) (interface{}, error) {
		// 验证签名方法为 HMAC
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}
		return v.secret, nil
	})
	if err != nil {
		return 0, "", fmt.Errorf("token parse error: %w", err)
	}

	claims, ok := token.Claims.(*Claims)
	if !ok || !token.Valid {
		return 0, "", fmt.Errorf("invalid token claims")
	}

	// 验证是 access token
	if claims.TokenType != "access" {
		return 0, "", fmt.Errorf("not an access token")
	}

	// subject 是 userId（字符串形式的 snowflake ID）
	userIdStr := claims.Subject
	userId, err := strconv.ParseInt(userIdStr, 10, 64)
	if err != nil {
		return 0, "", fmt.Errorf("invalid userId in token: %w", err)
	}

	return userId, claims.UserRole, nil
}
