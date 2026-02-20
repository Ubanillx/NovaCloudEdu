import { getToken } from './index';
import type {
  RtcMessage,
  RtcEventHandlers,
  RtcConnectionState,
  InviteData,
  AnswerData,
  ICEData,
  CallControlData,
  IncomingCallData,
  CallEndedData,
  SFUFallbackData,
  TURNConfigData,
  RtcErrorData,
} from './rtcTypes';

const RTC_WS_URL = import.meta.env.VITE_RTC_WS_URL || 'ws://localhost:8300';

/**
 * RTC 信令服务 - 原生 WebSocket
 * 单例模式，独立于 STOMP 聊天连接
 */
class RtcSignalingService {
  private static instance: RtcSignalingService | null = null;

  private ws: WebSocket | null = null;
  private _connectionState: RtcConnectionState = 'disconnected';
  private heartbeatTimer: ReturnType<typeof setInterval> | null = null;
  private reconnectTimer: ReturnType<typeof setTimeout> | null = null;
  private reconnectAttempts = 0;
  private maxReconnectAttempts = 5;
  private reconnectDelay = 3000;
  private intentionalClose = false;

  private listeners = new Set<RtcEventHandlers>();

  private constructor() {}

  static getInstance(): RtcSignalingService {
    if (!RtcSignalingService.instance) {
      RtcSignalingService.instance = new RtcSignalingService();
    }
    return RtcSignalingService.instance;
  }

  // ============ 连接管理 ============

  get connectionState(): RtcConnectionState {
    return this._connectionState;
  }

  connect(): void {
    if (this.ws && (this.ws.readyState === WebSocket.OPEN || this.ws.readyState === WebSocket.CONNECTING)) {
      return;
    }

    const token = getToken();
    if (!token) {
      console.warn('[RTC] No token, skip connect');
      return;
    }

    this.intentionalClose = false;
    this.setConnectionState('connecting');

    const url = `${RTC_WS_URL}/ws?token=${encodeURIComponent(token)}`;
    this.ws = new WebSocket(url);

    this.ws.onopen = () => {
      console.log('[RTC] WebSocket connected');
      this.setConnectionState('connected');
      this.reconnectAttempts = 0;
      this.startHeartbeat();
    };

    this.ws.onmessage = (event) => {
      try {
        const msg: RtcMessage = JSON.parse(event.data);
        this.handleMessage(msg);
      } catch (e) {
        console.error('[RTC] Parse message error:', e);
      }
    };

    this.ws.onclose = (event) => {
      console.log('[RTC] WebSocket closed:', event.code, event.reason);
      this.stopHeartbeat();
      this.setConnectionState('disconnected');

      if (!this.intentionalClose) {
        this.scheduleReconnect();
      }
    };

    this.ws.onerror = (event) => {
      console.error('[RTC] WebSocket error:', event);
      this.setConnectionState('error');
    };
  }

  disconnect(): void {
    this.intentionalClose = true;
    this.stopHeartbeat();
    this.clearReconnectTimer();
    if (this.ws) {
      this.ws.close(1000, 'user disconnect');
      this.ws = null;
    }
    this.setConnectionState('disconnected');
  }

  // ============ 发送信令 ============

  sendInvite(data: InviteData): void {
    this.send({ type: 'invite', data });
  }

  sendAnswer(data: AnswerData): void {
    this.send({ type: 'answer', data });
  }

  sendICE(data: ICEData): void {
    this.send({ type: 'ice', data });
  }

  sendBye(callId: string): void {
    this.send({ type: 'bye', data: { callId } as CallControlData });
  }

  sendReject(callId: string): void {
    this.send({ type: 'reject', data: { callId } as CallControlData });
  }

  sendBusy(callId: string): void {
    this.send({ type: 'busy', data: { callId } as CallControlData });
  }

  sendFallbackSFU(callId: string): void {
    this.send({ type: 'fallback_sfu', data: { callId } as CallControlData });
  }

  // ============ 事件监听 ============

  addListener(handler: RtcEventHandlers): () => void {
    this.listeners.add(handler);
    return () => {
      this.listeners.delete(handler);
    };
  }

  // ============ 内部方法 ============

  private send(msg: RtcMessage): void {
    if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      this.ws.send(JSON.stringify(msg));
    } else {
      console.warn('[RTC] WebSocket not connected, cannot send:', msg.type);
    }
  }

  private handleMessage(msg: RtcMessage): void {
    switch (msg.type) {
      case 'heartbeat_ack':
        break;

      case 'incoming_call':
        this.emit('onIncomingCall', msg.data as IncomingCallData);
        break;

      case 'call_answered':
        this.emit('onCallAnswered', msg.data as AnswerData);
        break;

      case 'ice_candidate':
        this.emit('onICECandidate', msg.data as ICEData);
        break;

      case 'call_rejected':
        this.emit('onCallRejected', msg.data as CallControlData);
        break;

      case 'call_busy':
        this.emit('onCallBusy', msg.data as CallControlData);
        break;

      case 'call_ended':
        this.emit('onCallEnded', msg.data as CallEndedData);
        break;

      case 'sfu_fallback':
        this.emit('onSFUFallback', msg.data as SFUFallbackData);
        break;

      case 'turn_config':
        this.emit('onTURNConfig', msg.data as TURNConfigData);
        break;

      case 'error':
        this.emit('onError', msg.data as RtcErrorData);
        break;

      default:
        console.warn('[RTC] Unknown message type:', msg.type);
    }
  }

  private emit<K extends keyof RtcEventHandlers>(event: K, data: Parameters<NonNullable<RtcEventHandlers[K]>>[0]): void {
    this.listeners.forEach((handler) => {
      const fn = handler[event];
      if (fn) {
        try {
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          (fn as (d: any) => void)(data);
        } catch (e) {
          console.error(`[RTC] Listener error on ${event}:`, e);
        }
      }
    });
  }

  private setConnectionState(state: RtcConnectionState): void {
    this._connectionState = state;
    this.emit('onConnectionChange', state);
  }

  private startHeartbeat(): void {
    this.stopHeartbeat();
    this.heartbeatTimer = setInterval(() => {
      this.send({ type: 'heartbeat' });
    }, 30_000);
  }

  private stopHeartbeat(): void {
    if (this.heartbeatTimer) {
      clearInterval(this.heartbeatTimer);
      this.heartbeatTimer = null;
    }
  }

  private scheduleReconnect(): void {
    this.clearReconnectTimer();
    if (this.reconnectAttempts >= this.maxReconnectAttempts) {
      console.warn('[RTC] Max reconnect attempts reached');
      this.setConnectionState('error');
      return;
    }
    const delay = this.reconnectDelay * Math.pow(1.5, this.reconnectAttempts);
    this.reconnectAttempts++;
    console.log(`[RTC] Reconnecting in ${Math.round(delay)}ms (attempt ${this.reconnectAttempts})`);
    this.reconnectTimer = setTimeout(() => this.connect(), delay);
  }

  private clearReconnectTimer(): void {
    if (this.reconnectTimer) {
      clearTimeout(this.reconnectTimer);
      this.reconnectTimer = null;
    }
  }
}

export default RtcSignalingService;
