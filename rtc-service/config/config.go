package config

import (
	"os"
	"strconv"
)

// Config 应用配置
type Config struct {
	// WebSocket 服务端口
	WSPort int
	// JWT 密钥（与 Java 后端共享）
	JWTSecret string
	// Redis 地址
	RedisAddr string
	// Redis 密码
	RedisPassword string
	// Java 后端地址
	JavaBackendURL string
	// LiveKit 配置
	LiveKitURL       string
	LiveKitAPIKey    string
	LiveKitAPISecret string
	// TURN 配置
	TURNUrl      string
	TURNUser     string
	TURNPassword string
}

// Load 从环境变量加载配置
func Load() *Config {
	port, _ := strconv.Atoi(getEnv("WS_PORT", "8300"))
	return &Config{
		WSPort:           port,
		JWTSecret:        getEnv("JWT_SECRET", "NovaCloudEduSecretKey123456789012345678901234567890"),
		RedisAddr:        getEnv("REDIS_ADDR", "localhost:6379"),
		RedisPassword:    getEnv("REDIS_PASSWORD", ""),
		JavaBackendURL:   getEnv("JAVA_BACKEND_URL", "http://localhost:8080"),
		LiveKitURL:       getEnv("LIVEKIT_URL", "ws://localhost:7880"),
		LiveKitAPIKey:    getEnv("LIVEKIT_API_KEY", "devkey"),
		LiveKitAPISecret: getEnv("LIVEKIT_API_SECRET", "devsecret"),
		TURNUrl:          getEnv("TURN_URL", "turn:localhost:3478"),
		TURNUser:         getEnv("TURN_USER", "nova"),
		TURNPassword:     getEnv("TURN_PASSWORD", "changeme"),
	}
}

func getEnv(key, defaultValue string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return defaultValue
}
