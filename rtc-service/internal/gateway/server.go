package gateway

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/gorilla/websocket"
	"go.uber.org/zap"

	"github.com/novacloudedu/rtc-service/internal/auth"
	"github.com/novacloudedu/rtc-service/internal/protocol"
	"github.com/novacloudedu/rtc-service/internal/store"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  16384,
	WriteBufferSize: 16384,
	CheckOrigin: func(r *http.Request) bool {
		return true // 允许所有来源（生产环境应限制）
	},
}

// MessageHandler 消息处理接口
type MessageHandler interface {
	HandleMessage(conn *Conn, msg *protocol.Message)
}

// Server WebSocket 网关服务器
type Server struct {
	connMgr      *ConnManager
	jwtValidator *auth.JWTValidator
	redisStore   *store.RedisStore
	handler      MessageHandler
	logger       *zap.Logger
}

// NewServer 创建 WebSocket 服务器
func NewServer(connMgr *ConnManager, jwtValidator *auth.JWTValidator,
	redisStore *store.RedisStore, handler MessageHandler, logger *zap.Logger) *Server {
	return &Server{
		connMgr:      connMgr,
		jwtValidator: jwtValidator,
		redisStore:   redisStore,
		handler:      handler,
		logger:       logger,
	}
}

// HandleWebSocket 处理 WebSocket 连接
func (s *Server) HandleWebSocket(w http.ResponseWriter, r *http.Request) {
	// 从 query 参数或 header 中获取 JWT token
	token := r.URL.Query().Get("token")
	if token == "" {
		authHeader := r.Header.Get("Authorization")
		if strings.HasPrefix(authHeader, "Bearer ") {
			token = strings.TrimPrefix(authHeader, "Bearer ")
		}
	}
	if token == "" {
		http.Error(w, "missing token", http.StatusUnauthorized)
		return
	}

	// 验证 JWT
	userID, userRole, err := s.jwtValidator.ValidateToken(token)
	if err != nil {
		s.logger.Warn("jwt validation failed", zap.Error(err))
		http.Error(w, "invalid token", http.StatusUnauthorized)
		return
	}

	// 升级为 WebSocket
	ws, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		s.logger.Error("websocket upgrade failed", zap.Error(err))
		return
	}

	conn := &Conn{
		UserID:   userID,
		UserRole: userRole,
		WS:       ws,
	}

	// 注册连接
	s.connMgr.Add(conn)
	ctx := context.Background()
	_ = s.redisStore.SetUserOnline(ctx, userID, "local")

	s.logger.Info("user connected",
		zap.Int64("userId", userID),
		zap.String("role", userRole))

	// 设置读超时
	ws.SetReadDeadline(time.Now().Add(90 * time.Second))
	ws.SetPongHandler(func(string) error {
		ws.SetReadDeadline(time.Now().Add(90 * time.Second))
		return nil
	})

	// 消息读取循环
	defer func() {
		if s.connMgr.Remove(conn) {
			_ = s.redisStore.SetUserOffline(ctx, userID)
		}
		_ = ws.Close()
		s.logger.Info("user disconnected", zap.Int64("userId", userID))
	}()

	for {
		_, rawMsg, err := ws.ReadMessage()
		if err != nil {
			if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseNormalClosure) {
				s.logger.Warn("websocket read error", zap.Int64("userId", userID), zap.Error(err))
			}
			break
		}

		var msg protocol.Message
		if err := json.Unmarshal(rawMsg, &msg); err != nil {
			conn.SendError(4000, "invalid message format")
			continue
		}

		// 收到消息时刷新读超时
		ws.SetReadDeadline(time.Now().Add(90 * time.Second))

		// 分发消息
		s.handler.HandleMessage(conn, &msg)
	}
}

// Start 启动 HTTP 服务器
func (s *Server) Start(port int) error {
	mux := http.NewServeMux()
	mux.HandleFunc("/ws", s.HandleWebSocket)
	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		fmt.Fprintf(w, `{"status":"ok","connections":%d}`, s.connMgr.Count())
	})

	addr := fmt.Sprintf(":%d", port)
	s.logger.Info("rtc-service starting", zap.String("addr", addr))
	return http.ListenAndServe(addr, mux)
}
