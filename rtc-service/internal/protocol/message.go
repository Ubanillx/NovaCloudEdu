package protocol

import "encoding/json"

// 消息类型常量
const (
	// 客户端 -> 服务端
	TypeInvite      = "invite"
	TypeAnswer      = "answer"
	TypeICE         = "ice"
	TypeBye         = "bye"
	TypeReject      = "reject"
	TypeBusy        = "busy"
	TypeFallbackSFU = "fallback_sfu"
	TypeHeartbeat   = "heartbeat"

	// 服务端 -> 客户端
	TypeIncomingCall  = "incoming_call"
	TypeCallAnswered  = "call_answered"
	TypeICECandidate  = "ice_candidate"
	TypeCallRejected  = "call_rejected"
	TypeCallBusy      = "call_busy"
	TypeCallEnded     = "call_ended"
	TypeSFUFallback   = "sfu_fallback"
	TypeError         = "error"
	TypeHeartbeatAck  = "heartbeat_ack"
	TypeTURNConfig    = "turn_config"
)

// Message 通用信令消息
type Message struct {
	Type string          `json:"type"`
	Data json.RawMessage `json:"data,omitempty"`
}

// InviteData 呼叫邀请
type InviteData struct {
	CallID       string `json:"callId"`
	TargetUserID string `json:"targetUserId"`
	MediaType    string `json:"mediaType"` // audio / video
	SDP          string `json:"sdp"`
}

// AnswerData 呼叫应答
type AnswerData struct {
	CallID string `json:"callId"`
	SDP    string `json:"sdp"`
}

// ICEData ICE 候选
type ICEData struct {
	CallID    string `json:"callId"`
	Candidate string `json:"candidate"`
}

// CallControlData 呼叫控制（bye/reject/busy/fallback_sfu）
type CallControlData struct {
	CallID string `json:"callId"`
	Reason string `json:"reason,omitempty"`
}

// IncomingCallData 来电通知
type IncomingCallData struct {
	CallID       string `json:"callId"`
	CallerUserID string `json:"callerUserId"`
	CallerName   string `json:"callerName"`
	CallerAvatar string `json:"callerAvatar,omitempty"`
	MediaType    string `json:"mediaType"`
	SDP          string `json:"sdp"`
}

// CallEndedData 通话结束
type CallEndedData struct {
	CallID string `json:"callId"`
	Reason string `json:"reason"` // bye/timeout/rejected/busy/error
}

// SFUFallbackData LiveKit 降级信息
type SFUFallbackData struct {
	CallID     string `json:"callId"`
	LiveKitURL string `json:"livekitUrl"`
	Token      string `json:"token"`
}

// TURNConfigData TURN 服务器配置
type TURNConfigData struct {
	URLs       []string `json:"urls"`
	Username   string   `json:"username"`
	Credential string   `json:"credential"`
}

// ErrorData 错误消息
type ErrorData struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

// NewMessage 创建消息
func NewMessage(msgType string, data interface{}) (*Message, error) {
	raw, err := json.Marshal(data)
	if err != nil {
		return nil, err
	}
	return &Message{
		Type: msgType,
		Data: raw,
	}, nil
}

// ParseData 解析消息数据
func ParseData[T any](msg *Message) (*T, error) {
	var data T
	if err := json.Unmarshal(msg.Data, &data); err != nil {
		return nil, err
	}
	return &data, nil
}
