package main

import (
	"log"

	"go.uber.org/zap"

	"github.com/novacloudedu/rtc-service/config"
	"github.com/novacloudedu/rtc-service/internal/auth"
	"github.com/novacloudedu/rtc-service/internal/gateway"
	"github.com/novacloudedu/rtc-service/internal/sfu"
	"github.com/novacloudedu/rtc-service/internal/signaling"
	"github.com/novacloudedu/rtc-service/internal/store"
)

func main() {
	// 初始化日志
	logger, err := zap.NewProduction()
	if err != nil {
		log.Fatalf("failed to init logger: %v", err)
	}
	defer logger.Sync()

	// 加载配置
	cfg := config.Load()

	// 初始化 Redis
	redisStore, err := store.NewRedisStore(cfg.RedisAddr, cfg.RedisPassword)
	if err != nil {
		logger.Fatal("failed to connect redis", zap.Error(err))
	}
	defer redisStore.Close()

	// 初始化 JWT 验证器
	jwtValidator := auth.NewJWTValidator(cfg.JWTSecret)

	// 初始化 LiveKit 客户端
	sfuClient := sfu.NewLiveKitClient(cfg.LiveKitURL, cfg.LiveKitAPIKey, cfg.LiveKitAPISecret)

	// 初始化连接管理器
	connMgr := gateway.NewConnManager(logger)

	// 初始化信令处理器
	handler := signaling.NewHandler(connMgr, redisStore, sfuClient, cfg, logger)

	// 启动 WebSocket 服务器
	server := gateway.NewServer(connMgr, jwtValidator, redisStore, handler, logger)
	logger.Info("rtc-service starting",
		zap.Int("port", cfg.WSPort),
		zap.String("redis", cfg.RedisAddr),
		zap.String("javaBackend", cfg.JavaBackendURL))

	if err := server.Start(cfg.WSPort); err != nil {
		logger.Fatal("server failed", zap.Error(err))
	}
}
