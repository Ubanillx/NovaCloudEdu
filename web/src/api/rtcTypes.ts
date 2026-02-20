// ============ RTC 信令消息类型 ============

// 客户端 → 服务端
export type RtcClientMessageType =
  | 'invite'
  | 'answer'
  | 'ice'
  | 'bye'
  | 'reject'
  | 'busy'
  | 'fallback_sfu'
  | 'heartbeat';

// 服务端 → 客户端
export type RtcServerMessageType =
  | 'incoming_call'
  | 'call_answered'
  | 'ice_candidate'
  | 'call_rejected'
  | 'call_busy'
  | 'call_ended'
  | 'sfu_fallback'
  | 'error'
  | 'heartbeat_ack'
  | 'turn_config';

export type RtcMessageType = RtcClientMessageType | RtcServerMessageType;

// 通用信令消息
export interface RtcMessage<T = unknown> {
  type: RtcMessageType;
  data?: T;
}

// ============ 客户端消息数据 ============

export interface InviteData {
  callId: string;
  targetUserId: string;
  mediaType: 'audio' | 'video';
  sdp: string;
}

export interface AnswerData {
  callId: string;
  sdp: string;
}

export interface ICEData {
  callId: string;
  candidate: string;
}

export interface CallControlData {
  callId: string;
  reason?: string;
}

// ============ 服务端消息数据 ============

export interface IncomingCallData {
  callId: string;
  callerUserId: string;
  callerName: string;
  callerAvatar?: string;
  mediaType: 'audio' | 'video';
  sdp: string;
}

export interface CallEndedData {
  callId: string;
  reason: 'bye' | 'timeout' | 'rejected' | 'busy' | 'error' | 'offline' | 'unreachable';
}

export interface SFUFallbackData {
  callId: string;
  livekitUrl: string;
  token: string;
}

export interface TURNConfigData {
  urls: string[];
  username: string;
  credential: string;
}

export interface RtcErrorData {
  code: number;
  message: string;
}

// ============ 通话状态 ============

export type CallState = 'idle' | 'ringing_out' | 'ringing_in' | 'connecting' | 'connected' | 'ended';

export type MediaType = 'audio' | 'video';

export type CallMode = 'p2p' | 'sfu';

export interface CurrentCall {
  callId: string;
  peerId: string;
  peerName: string;
  peerAvatar?: string;
  mediaType: MediaType;
  mode: CallMode;
  startTime?: number;
}

// ============ 连接状态 ============

export type RtcConnectionState = 'disconnected' | 'connecting' | 'connected' | 'error';

// ============ 事件回调 ============

export interface RtcEventHandlers {
  onIncomingCall?: (data: IncomingCallData) => void;
  onCallAnswered?: (data: AnswerData) => void;
  onICECandidate?: (data: ICEData) => void;
  onCallRejected?: (data: CallControlData) => void;
  onCallBusy?: (data: CallControlData) => void;
  onCallEnded?: (data: CallEndedData) => void;
  onSFUFallback?: (data: SFUFallbackData) => void;
  onTURNConfig?: (data: TURNConfigData) => void;
  onError?: (data: RtcErrorData) => void;
  onConnectionChange?: (state: RtcConnectionState) => void;
}
