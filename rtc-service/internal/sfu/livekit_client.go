package sfu

import (
	"fmt"
	"strconv"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

// LiveKitClient LiveKit SFU 客户端
type LiveKitClient struct {
	url       string
	apiKey    string
	apiSecret string
}

// NewLiveKitClient 创建 LiveKit 客户端
func NewLiveKitClient(url, apiKey, apiSecret string) *LiveKitClient {
	return &LiveKitClient{
		url:       url,
		apiKey:    apiKey,
		apiSecret: apiSecret,
	}
}

// CreateRoomAndGetTokens 创建房间并返回主叫的 token
func (c *LiveKitClient) CreateRoomAndGetTokens(callID string, callerID int64) (string, error) {
	return c.GenerateToken(callID, callerID)
}

// GenerateToken 为指定用户生成 LiveKit 加入 token
func (c *LiveKitClient) GenerateToken(roomName string, userID int64) (string, error) {
	identity := strconv.FormatInt(userID, 10)

	claims := jwt.MapClaims{
		"iss": c.apiKey,
		"exp": time.Now().Add(6 * time.Hour).Unix(),
		"nbf": time.Now().Unix(),
		"sub": identity,
		"video": map[string]interface{}{
			"roomJoin": true,
			"room":     roomName,
		},
		"metadata": fmt.Sprintf(`{"userId":%d}`, userID),
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString([]byte(c.apiSecret))
}

// GetURL 获取 LiveKit 服务器地址
func (c *LiveKitClient) GetURL() string {
	return c.url
}
