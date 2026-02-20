package gateway

import (
	"encoding/json"
	"sync"

	"github.com/gorilla/websocket"
	"go.uber.org/zap"

	"github.com/novacloudedu/rtc-service/internal/protocol"
)

// Conn 用户连接
type Conn struct {
	UserID   int64
	UserRole string
	WS       *websocket.Conn
	mu       sync.Mutex
}

// SendMessage 线程安全地发送消息
func (c *Conn) SendMessage(msg *protocol.Message) error {
	c.mu.Lock()
	defer c.mu.Unlock()
	return c.WS.WriteJSON(msg)
}

// SendError 发送错误消息
func (c *Conn) SendError(code int, message string) {
	msg, _ := protocol.NewMessage(protocol.TypeError, &protocol.ErrorData{
		Code:    code,
		Message: message,
	})
	_ = c.SendMessage(msg)
}

// ConnManager 连接管理器
type ConnManager struct {
	// userID -> *Conn
	conns  map[int64]*Conn
	mu     sync.RWMutex
	logger *zap.Logger
}

// NewConnManager 创建连接管理器
func NewConnManager(logger *zap.Logger) *ConnManager {
	return &ConnManager{
		conns:  make(map[int64]*Conn),
		logger: logger,
	}
}

// Add 添加连接
func (m *ConnManager) Add(conn *Conn) {
	m.mu.Lock()
	defer m.mu.Unlock()

	// 如果用户已有连接，关闭旧连接
	if old, ok := m.conns[conn.UserID]; ok {
		m.logger.Info("closing old connection", zap.Int64("userId", conn.UserID))
		_ = old.WS.Close()
	}
	m.conns[conn.UserID] = conn
	m.logger.Info("connection added", zap.Int64("userId", conn.UserID))
}

// Remove 移除连接
func (m *ConnManager) Remove(userID int64) {
	m.mu.Lock()
	defer m.mu.Unlock()
	delete(m.conns, userID)
	m.logger.Info("connection removed", zap.Int64("userId", userID))
}

// Get 获取连接
func (m *ConnManager) Get(userID int64) *Conn {
	m.mu.RLock()
	defer m.mu.RUnlock()
	return m.conns[userID]
}

// SendToUser 向指定用户发送消息
func (m *ConnManager) SendToUser(userID int64, msgType string, data interface{}) bool {
	conn := m.Get(userID)
	if conn == nil {
		return false
	}
	raw, err := json.Marshal(data)
	if err != nil {
		m.logger.Error("marshal error", zap.Error(err))
		return false
	}
	msg := &protocol.Message{Type: msgType, Data: raw}
	if err := conn.SendMessage(msg); err != nil {
		m.logger.Error("send error", zap.Int64("userId", userID), zap.Error(err))
		return false
	}
	return true
}

// Count 在线连接数
func (m *ConnManager) Count() int {
	m.mu.RLock()
	defer m.mu.RUnlock()
	return len(m.conns)
}
