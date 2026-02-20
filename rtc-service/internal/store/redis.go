package store

import (
	"context"
	"fmt"
	"time"

	"github.com/redis/go-redis/v9"
)

const (
	// 用户在线状态 key 前缀
	keyUserOnline = "rtc:online:%d"
	// 通话房间 key 前缀
	keyCallRoom = "rtc:call:%s"
	// 在线状态过期时间
	onlineTTL = 5 * time.Minute
	// 通话房间过期时间
	callRoomTTL = 2 * time.Hour
)

// RedisStore Redis 存储
type RedisStore struct {
	client *redis.Client
}

// NewRedisStore 创建 Redis 存储
func NewRedisStore(addr, password string) (*RedisStore, error) {
	client := redis.NewClient(&redis.Options{
		Addr:     addr,
		Password: password,
		DB:       0,
	})
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	if err := client.Ping(ctx).Err(); err != nil {
		return nil, fmt.Errorf("redis connect failed: %w", err)
	}
	return &RedisStore{client: client}, nil
}

// SetUserOnline 设置用户在线
func (s *RedisStore) SetUserOnline(ctx context.Context, userID int64, serverAddr string) error {
	key := fmt.Sprintf(keyUserOnline, userID)
	return s.client.Set(ctx, key, serverAddr, onlineTTL).Err()
}

// RefreshUserOnline 刷新用户在线状态
func (s *RedisStore) RefreshUserOnline(ctx context.Context, userID int64) error {
	key := fmt.Sprintf(keyUserOnline, userID)
	return s.client.Expire(ctx, key, onlineTTL).Err()
}

// SetUserOffline 设置用户离线
func (s *RedisStore) SetUserOffline(ctx context.Context, userID int64) error {
	key := fmt.Sprintf(keyUserOnline, userID)
	return s.client.Del(ctx, key).Err()
}

// IsUserOnline 检查用户是否在线
func (s *RedisStore) IsUserOnline(ctx context.Context, userID int64) (bool, error) {
	key := fmt.Sprintf(keyUserOnline, userID)
	result, err := s.client.Exists(ctx, key).Result()
	if err != nil {
		return false, err
	}
	return result > 0, nil
}

// CallRoom 通话房间信息
type CallRoom struct {
	CallID     string `json:"callId"`
	CallerID   int64  `json:"callerId"`
	CalleeID   int64  `json:"calleeId"`
	MediaType  string `json:"mediaType"`
	Status     string `json:"status"`
	Mode       string `json:"mode"`
	CreatedAt  int64  `json:"createdAt"`
	AnsweredAt int64  `json:"answeredAt"` // 接通时间戳（unix秒）
}

// SaveCallRoom 保存通话房间
func (s *RedisStore) SaveCallRoom(ctx context.Context, room *CallRoom) error {
	key := fmt.Sprintf(keyCallRoom, room.CallID)
	data := map[string]interface{}{
		"callId":    room.CallID,
		"callerId":  room.CallerID,
		"calleeId":  room.CalleeID,
		"mediaType": room.MediaType,
		"status":    room.Status,
		"mode":      room.Mode,
		"createdAt": room.CreatedAt,
	}
	pipe := s.client.Pipeline()
	pipe.HSet(ctx, key, data)
	pipe.Expire(ctx, key, callRoomTTL)
	_, err := pipe.Exec(ctx)
	return err
}

// GetCallRoom 获取通话房间
func (s *RedisStore) GetCallRoom(ctx context.Context, callID string) (*CallRoom, error) {
	key := fmt.Sprintf(keyCallRoom, callID)
	result, err := s.client.HGetAll(ctx, key).Result()
	if err != nil {
		return nil, err
	}
	if len(result) == 0 {
		return nil, nil
	}
	var callerID, calleeID, createdAt, answeredAt int64
	fmt.Sscanf(result["callerId"], "%d", &callerID)
	fmt.Sscanf(result["calleeId"], "%d", &calleeID)
	fmt.Sscanf(result["createdAt"], "%d", &createdAt)
	fmt.Sscanf(result["answeredAt"], "%d", &answeredAt)
	return &CallRoom{
		CallID:     result["callId"],
		CallerID:   callerID,
		CalleeID:   calleeID,
		MediaType:  result["mediaType"],
		Status:     result["status"],
		Mode:       result["mode"],
		CreatedAt:  createdAt,
		AnsweredAt: answeredAt,
	}, nil
}

// UpdateCallRoomStatus 更新通话状态
func (s *RedisStore) UpdateCallRoomStatus(ctx context.Context, callID, status string) error {
	key := fmt.Sprintf(keyCallRoom, callID)
	return s.client.HSet(ctx, key, "status", status).Err()
}

// SetCallRoomAnsweredAt 记录接通时间
func (s *RedisStore) SetCallRoomAnsweredAt(ctx context.Context, callID string, ts int64) error {
	key := fmt.Sprintf(keyCallRoom, callID)
	return s.client.HSet(ctx, key, "answeredAt", ts).Err()
}

// UpdateCallRoomMode 更新通话模式
func (s *RedisStore) UpdateCallRoomMode(ctx context.Context, callID, mode string) error {
	key := fmt.Sprintf(keyCallRoom, callID)
	return s.client.HSet(ctx, key, "mode", mode).Err()
}

// DeleteCallRoom 删除通话房间
func (s *RedisStore) DeleteCallRoom(ctx context.Context, callID string) error {
	key := fmt.Sprintf(keyCallRoom, callID)
	return s.client.Del(ctx, key).Err()
}

// Close 关闭连接
func (s *RedisStore) Close() error {
	return s.client.Close()
}
