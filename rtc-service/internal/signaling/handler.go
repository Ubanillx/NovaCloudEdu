package signaling

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"time"

	"go.uber.org/zap"

	"github.com/novacloudedu/rtc-service/config"
	"github.com/novacloudedu/rtc-service/internal/gateway"
	"github.com/novacloudedu/rtc-service/internal/protocol"
	"github.com/novacloudedu/rtc-service/internal/sfu"
	"github.com/novacloudedu/rtc-service/internal/store"
)

const (
	callTimeout = 30 * time.Second // 呼叫超时
)

// Handler 信令处理器
type Handler struct {
	connMgr    *gateway.ConnManager
	redisStore *store.RedisStore
	sfuClient  *sfu.LiveKitClient
	cfg        *config.Config
	logger     *zap.Logger
}

// NewHandler 创建信令处理器
func NewHandler(connMgr *gateway.ConnManager, redisStore *store.RedisStore,
	sfuClient *sfu.LiveKitClient, cfg *config.Config, logger *zap.Logger) *Handler {
	return &Handler{
		connMgr:    connMgr,
		redisStore: redisStore,
		sfuClient:  sfuClient,
		cfg:        cfg,
		logger:     logger,
	}
}

// HandleMessage 处理信令消息
func (h *Handler) HandleMessage(conn *gateway.Conn, msg *protocol.Message) {
	switch msg.Type {
	case protocol.TypeHeartbeat:
		h.handleHeartbeat(conn)
	case protocol.TypeInvite:
		h.handleInvite(conn, msg)
	case protocol.TypeAnswer:
		h.handleAnswer(conn, msg)
	case protocol.TypeICE:
		h.handleICE(conn, msg)
	case protocol.TypeBye:
		h.handleBye(conn, msg)
	case protocol.TypeReject:
		h.handleReject(conn, msg)
	case protocol.TypeBusy:
		h.handleBusy(conn, msg)
	case protocol.TypeFallbackSFU:
		h.handleFallbackSFU(conn, msg)
	default:
		conn.SendError(4000, "unknown message type: "+msg.Type)
	}
}

func (h *Handler) handleHeartbeat(conn *gateway.Conn) {
	ctx := context.Background()
	_ = h.redisStore.RefreshUserOnline(ctx, conn.UserID)
	ack, _ := protocol.NewMessage(protocol.TypeHeartbeatAck, nil)
	_ = conn.SendMessage(ack)
}

func (h *Handler) handleInvite(conn *gateway.Conn, msg *protocol.Message) {
	data, err := protocol.ParseData[protocol.InviteData](msg)
	if err != nil {
		conn.SendError(4001, "invalid invite data")
		return
	}

	targetUserID, err := strconv.ParseInt(data.TargetUserID, 10, 64)
	if err != nil {
		conn.SendError(4001, "invalid targetUserId")
		return
	}

	ctx := context.Background()

	// 调用 Java 后端校验权限（同时获取主叫方用户信息）
	permResult := h.checkPermission(conn.UserID, targetUserID)
	if !permResult.Allowed {
		conn.SendError(4003, permResult.Reason)
		return
	}

	// 检查被叫是否在线
	online, _ := h.redisStore.IsUserOnline(ctx, targetUserID)
	if !online {
		// 被叫不在线
		endMsg, _ := protocol.NewMessage(protocol.TypeCallEnded, &protocol.CallEndedData{
			CallID: data.CallID,
			Reason: "offline",
		})
		_ = conn.SendMessage(endMsg)
		return
	}

	// 保存通话房间到 Redis
	room := &store.CallRoom{
		CallID:    data.CallID,
		CallerID:  conn.UserID,
		CalleeID:  targetUserID,
		MediaType: data.MediaType,
		Status:    "inviting",
		Mode:      "p2p",
		CreatedAt: time.Now().Unix(),
	}
	_ = h.redisStore.SaveCallRoom(ctx, room)

	// 转发来电通知给被叫
	incomingCall := &protocol.IncomingCallData{
		CallID:       data.CallID,
		CallerUserID: strconv.FormatInt(conn.UserID, 10),
		CallerName:   permResult.CallerName,
		CallerAvatar: permResult.CallerAvatar,
		MediaType:    data.MediaType,
		SDP:          data.SDP,
	}
	sent := h.connMgr.SendToUser(targetUserID, protocol.TypeIncomingCall, incomingCall)
	if !sent {
		endMsg, _ := protocol.NewMessage(protocol.TypeCallEnded, &protocol.CallEndedData{
			CallID: data.CallID,
			Reason: "unreachable",
		})
		_ = conn.SendMessage(endMsg)
		return
	}

	// 发送 TURN 配置给双方
	h.sendTURNConfig(conn)
	if targetConn := h.connMgr.Get(targetUserID); targetConn != nil {
		h.sendTURNConfig(targetConn)
	}

	// 启动呼叫超时定时器
	go h.callTimeoutTimer(data.CallID, conn.UserID, targetUserID)

	h.logger.Info("call invite",
		zap.String("callId", data.CallID),
		zap.Int64("caller", conn.UserID),
		zap.Int64("callee", targetUserID),
		zap.String("mediaType", data.MediaType),
		zap.Int("sdpLen", len(data.SDP)))
}

func (h *Handler) handleAnswer(conn *gateway.Conn, msg *protocol.Message) {
	data, err := protocol.ParseData[protocol.AnswerData](msg)
	if err != nil {
		conn.SendError(4001, "invalid answer data")
		return
	}

	ctx := context.Background()
	room, _ := h.redisStore.GetCallRoom(ctx, data.CallID)
	if room == nil {
		conn.SendError(4004, "call not found")
		return
	}

	// 更新状态并记录接通时间
	_ = h.redisStore.UpdateCallRoomStatus(ctx, data.CallID, "connected")
	_ = h.redisStore.SetCallRoomAnsweredAt(ctx, data.CallID, time.Now().Unix())

	// 转发 SDP answer 给主叫
	h.connMgr.SendToUser(room.CallerID, protocol.TypeCallAnswered, &protocol.AnswerData{
		CallID: data.CallID,
		SDP:    data.SDP,
	})

	h.logger.Info("call answered", zap.String("callId", data.CallID), zap.Int("sdpLen", len(data.SDP)))
}

func (h *Handler) handleICE(conn *gateway.Conn, msg *protocol.Message) {
	data, err := protocol.ParseData[protocol.ICEData](msg)
	if err != nil {
		return
	}

	ctx := context.Background()
	room, _ := h.redisStore.GetCallRoom(ctx, data.CallID)
	if room == nil {
		return
	}

	// 转发 ICE candidate 给对方
	var targetID int64
	if conn.UserID == room.CallerID {
		targetID = room.CalleeID
	} else {
		targetID = room.CallerID
	}
	h.connMgr.SendToUser(targetID, protocol.TypeICECandidate, data)
}

func (h *Handler) handleBye(conn *gateway.Conn, msg *protocol.Message) {
	data, err := protocol.ParseData[protocol.CallControlData](msg)
	if err != nil {
		return
	}

	ctx := context.Background()
	room, _ := h.redisStore.GetCallRoom(ctx, data.CallID)
	if room == nil {
		return
	}

	// 通知对方通话结束
	var targetID int64
	if conn.UserID == room.CallerID {
		targetID = room.CalleeID
	} else {
		targetID = room.CallerID
	}
	h.connMgr.SendToUser(targetID, protocol.TypeCallEnded, &protocol.CallEndedData{
		CallID: data.CallID,
		Reason: "bye",
	})

	// 保存通话记录到 Java
	h.saveCallRecord(room, "completed")

	// 清理
	_ = h.redisStore.DeleteCallRoom(ctx, data.CallID)

	h.logger.Info("call bye", zap.String("callId", data.CallID))
}

func (h *Handler) handleReject(conn *gateway.Conn, msg *protocol.Message) {
	data, err := protocol.ParseData[protocol.CallControlData](msg)
	if err != nil {
		return
	}

	ctx := context.Background()
	room, _ := h.redisStore.GetCallRoom(ctx, data.CallID)
	if room == nil {
		return
	}

	h.connMgr.SendToUser(room.CallerID, protocol.TypeCallRejected, &protocol.CallControlData{
		CallID: data.CallID,
	})

	h.saveCallRecord(room, "rejected")
	_ = h.redisStore.DeleteCallRoom(ctx, data.CallID)

	h.logger.Info("call rejected", zap.String("callId", data.CallID))
}

func (h *Handler) handleBusy(conn *gateway.Conn, msg *protocol.Message) {
	data, err := protocol.ParseData[protocol.CallControlData](msg)
	if err != nil {
		return
	}

	ctx := context.Background()
	room, _ := h.redisStore.GetCallRoom(ctx, data.CallID)
	if room == nil {
		return
	}

	h.connMgr.SendToUser(room.CallerID, protocol.TypeCallBusy, &protocol.CallControlData{
		CallID: data.CallID,
	})

	h.saveCallRecord(room, "busy")
	_ = h.redisStore.DeleteCallRoom(ctx, data.CallID)

	h.logger.Info("call busy", zap.String("callId", data.CallID))
}

func (h *Handler) handleFallbackSFU(conn *gateway.Conn, msg *protocol.Message) {
	data, err := protocol.ParseData[protocol.CallControlData](msg)
	if err != nil {
		conn.SendError(4001, "invalid fallback data")
		return
	}

	ctx := context.Background()
	room, _ := h.redisStore.GetCallRoom(ctx, data.CallID)
	if room == nil {
		conn.SendError(4004, "call not found")
		return
	}

	// 创建 LiveKit 房间并签发 token
	callerToken, err := h.sfuClient.CreateRoomAndGetTokens(data.CallID, room.CallerID)
	if err != nil {
		h.logger.Error("livekit create room failed", zap.Error(err))
		conn.SendError(5001, "SFU fallback failed")
		return
	}
	calleeToken, err := h.sfuClient.GenerateToken(data.CallID, room.CalleeID)
	if err != nil {
		h.logger.Error("livekit generate token failed", zap.Error(err))
		conn.SendError(5001, "SFU fallback failed")
		return
	}

	// 更新通话模式
	_ = h.redisStore.UpdateCallRoomMode(ctx, data.CallID, "sfu")

	// 通知双方切换到 LiveKit
	sfuData := &protocol.SFUFallbackData{
		CallID:     data.CallID,
		LiveKitURL: h.cfg.LiveKitURL,
	}

	callerData := *sfuData
	callerData.Token = callerToken
	h.connMgr.SendToUser(room.CallerID, protocol.TypeSFUFallback, &callerData)

	calleeData := *sfuData
	calleeData.Token = calleeToken
	h.connMgr.SendToUser(room.CalleeID, protocol.TypeSFUFallback, &calleeData)

	h.logger.Info("call fallback to SFU", zap.String("callId", data.CallID))
}

// sendTURNConfig 发送 TURN 服务器配置
func (h *Handler) sendTURNConfig(conn *gateway.Conn) {
	turnData := &protocol.TURNConfigData{
		URLs:       []string{h.cfg.TURNUrl},
		Username:   h.cfg.TURNUser,
		Credential: h.cfg.TURNPassword,
	}
	msg, _ := protocol.NewMessage(protocol.TypeTURNConfig, turnData)
	_ = conn.SendMessage(msg)
}

// callTimeoutTimer 呼叫超时定时器
func (h *Handler) callTimeoutTimer(callID string, callerID, calleeID int64) {
	time.Sleep(callTimeout)

	ctx := context.Background()
	room, _ := h.redisStore.GetCallRoom(ctx, callID)
	if room == nil || room.Status != "inviting" {
		return // 已接听或已结束
	}

	// 超时，通知双方
	endData := &protocol.CallEndedData{
		CallID: callID,
		Reason: "timeout",
	}
	h.connMgr.SendToUser(callerID, protocol.TypeCallEnded, endData)
	h.connMgr.SendToUser(calleeID, protocol.TypeCallEnded, endData)

	h.saveCallRecord(room, "missed")
	_ = h.redisStore.DeleteCallRoom(ctx, callID)

	h.logger.Info("call timeout", zap.String("callId", callID))
}

// checkPermission 调用 Java 后端校验通话权限
// permissionResult 权限校验返回
type permissionResult struct {
	Allowed      bool   `json:"allowed"`
	Reason       string `json:"reason"`
	CallerName   string `json:"callerName"`
	CallerAvatar string `json:"callerAvatar"`
}

func (h *Handler) checkPermission(callerID, calleeID int64) permissionResult {
	url := fmt.Sprintf("%s/api/internal/rtc/check-permission", h.cfg.JavaBackendURL)
	body := fmt.Sprintf(`{"callerId":%d,"calleeId":%d}`, callerID, calleeID)

	resp, err := http.Post(url, "application/json", strings.NewReader(body))
	if err != nil {
		h.logger.Error("check permission failed", zap.Error(err))
		return permissionResult{Allowed: false, Reason: "permission check failed"}
	}
	defer resp.Body.Close()

	var result permissionResult
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return permissionResult{Allowed: false, Reason: "permission check decode error"}
	}
	return result
}

// saveCallRecord 保存通话记录到 Java 后端
func (h *Handler) saveCallRecord(room *store.CallRoom, status string) {
	url := fmt.Sprintf("%s/api/internal/rtc/call-record", h.cfg.JavaBackendURL)

	// 计算通话时长（仅接通的通话才有时长）
	now := time.Now()
	duration := 0
	if status == "completed" && room.AnsweredAt > 0 {
		duration = int(now.Unix() - room.AnsweredAt)
	}

	body := fmt.Sprintf(`{
		"callId":"%s",
		"callerId":%d,
		"calleeId":%d,
		"mediaType":"%s",
		"status":"%s",
		"mode":"%s",
		"duration":%d
	}`, room.CallID, room.CallerID, room.CalleeID, room.MediaType, status, room.Mode, duration)

	go func() {
		resp, err := http.Post(url, "application/json", strings.NewReader(body))
		if err != nil {
			h.logger.Error("save call record failed", zap.Error(err))
			return
		}
		defer resp.Body.Close()
	}()
}
