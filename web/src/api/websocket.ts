import { Client } from '@stomp/stompjs';
import type { IMessage, StompSubscription } from '@stomp/stompjs';
import JSONBig from 'json-bigint';
import { getToken } from './index';
import type {
  WsChatMessage,
  WsGroupMessage,
  WsGroupReadReceipt,
  NotificationEvent,
  ReadReceipt,
  ConnectionState,
  ChatEventHandlers,
} from './chatTypes';

const JSONBigString = JSONBig({ storeAsString: true });

const VITE_API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';

/**
 * WebSocket 聊天服务 - STOMP 协议
 * 单例模式，全局共享连接
 */
class WebSocketService {
  private static instance: WebSocketService | null = null;

  private client: Client | null = null;
  private _connectionState: ConnectionState = 'disconnected';
  private reconnectTimer: ReturnType<typeof setTimeout> | null = null;
  private reconnectAttempts = 0;
  private maxReconnectAttempts = 10;
  private reconnectDelay = 5000;

  // 群组订阅（每个群有消息+已读回执两个订阅）
  private groupSubscriptions = new Map<number, StompSubscription[]>();

  // 事件监听器
  private listeners = new Set<ChatEventHandlers>();

  private constructor() {}

  static getInstance(): WebSocketService {
    if (!WebSocketService.instance) {
      WebSocketService.instance = new WebSocketService();
    }
    return WebSocketService.instance;
  }

  // ============ 连接管理 ============

  get connectionState(): ConnectionState {
    return this._connectionState;
  }

  get isConnected(): boolean {
    return this._connectionState === 'connected';
  }

  connect(): void {
    const token = getToken();
    if (!token) {
      console.warn('[WS] 无 Token，跳过连接');
      return;
    }

    if (this.isConnected) {
      console.log('[WS] 已连接，跳过');
      return;
    }

    this.setConnectionState('connecting');
    console.log('[WS] 正在连接...');

    this.client = new Client({
      brokerURL: `${VITE_API_BASE_URL.replace(/^http/, 'ws')}/ws`,
      connectHeaders: {
        Authorization: `Bearer ${token}`,
      },
      debug: (str) => {
        if (import.meta.env.DEV) {
          // 只在开发环境输出关键日志，过滤心跳
          if (!str.includes('PING') && !str.includes('PONG') && !str.includes('heart-beat')) {
            console.log('[STOMP]', str);
          }
        }
      },
      reconnectDelay: this.reconnectDelay,
      heartbeatIncoming: 10000,
      heartbeatOutgoing: 10000,
      onConnect: () => this.onConnected(),
      onDisconnect: () => this.onDisconnected(),
      onStompError: (frame) => {
        console.error('[WS] STOMP 错误:', frame.headers['message'], frame.body);
        this.setConnectionState('error');
      },
      onWebSocketError: (event) => {
        console.error('[WS] WebSocket 错误:', event);
        this.setConnectionState('error');
      },
      onWebSocketClose: () => {
        console.log('[WS] WebSocket 关闭');
        if (this._connectionState !== 'disconnected') {
          this.setConnectionState('error');
          this.scheduleReconnect();
        }
      },
    });

    this.client.activate();
  }

  disconnect(): void {
    this.clearReconnectTimer();
    this.reconnectAttempts = 0;

    // 清理群组订阅
    this.groupSubscriptions.forEach((subs) => {
      subs.forEach((sub) => { try { sub.unsubscribe(); } catch { /* ignore */ } });
    });
    this.groupSubscriptions.clear();

    if (this.client) {
      try {
        this.client.deactivate();
      } catch {
        /* ignore */
      }
      this.client = null;
    }

    this.setConnectionState('disconnected');
    console.log('[WS] 已断开');
  }

  private onConnected(): void {
    console.log('[WS] 连接成功');
    this.reconnectAttempts = 0;
    this.setConnectionState('connected');
    this.setupSubscriptions();
  }

  private onDisconnected(): void {
    console.log('[WS] 已断开连接');
    if (this._connectionState !== 'disconnected') {
      this.setConnectionState('error');
      this.scheduleReconnect();
    }
  }

  private scheduleReconnect(): void {
    if (this.reconnectAttempts >= this.maxReconnectAttempts) {
      console.warn('[WS] 达到最大重连次数');
      return;
    }

    this.clearReconnectTimer();
    const delay = this.reconnectDelay * Math.min(this.reconnectAttempts + 1, 5);
    console.log(`[WS] ${delay / 1000}s 后重连 (第${this.reconnectAttempts + 1}次)`);

    this.reconnectTimer = setTimeout(() => {
      this.reconnectAttempts++;
      this.connect();
    }, delay);
  }

  private clearReconnectTimer(): void {
    if (this.reconnectTimer) {
      clearTimeout(this.reconnectTimer);
      this.reconnectTimer = null;
    }
  }

  // ============ 订阅 ============

  private setupSubscriptions(): void {
    if (!this.client?.connected) return;

    // 订阅私聊消息
    this.client.subscribe('/user/queue/messages', (message: IMessage) => {
      try {
        const data: WsChatMessage = JSONBigString.parse(message.body);
        console.log('[WS] 收到私聊消息:', data.content?.substring(0, 30));
        this.emit('onChatMessage', data);
      } catch (e) {
        console.error('[WS] 解析私聊消息失败:', e);
      }
    });

    // 订阅通知
    this.client.subscribe('/user/queue/notifications', (message: IMessage) => {
      try {
        const data: NotificationEvent = JSONBigString.parse(message.body);
        console.log('[WS] 收到通知:', data.type);
        this.emit('onNotification', data);
      } catch (e) {
        console.error('[WS] 解析通知失败:', e);
      }
    });

    // 订阅群消息（后端逐个推送，排除发送者）
    this.client.subscribe('/user/queue/group-messages', (message: IMessage) => {
      try {
        const data: WsGroupMessage = JSONBigString.parse(message.body);
        console.log('[WS] 收到群消息(user queue):', data.content?.substring(0, 30));
        this.emit('onGroupMessage', data);
      } catch (e) {
        console.error('[WS] 解析群消息失败:', e);
      }
    });

    // 订阅群消息发送确认（发送者专用，含服务端分配的 messageId）
    this.client.subscribe('/user/queue/group-message-sent', (message: IMessage) => {
      try {
        const data: WsGroupMessage = JSONBigString.parse(message.body);
        console.log('[WS] 群消息发送确认: messageId=', data.messageId);
        this.emit('onGroupMessageSent', data);
      } catch (e) {
        console.error('[WS] 解析群消息发送确认失败:', e);
      }
    });

    // 订阅已读回执
    this.client.subscribe('/user/queue/read-receipt', (message: IMessage) => {
      try {
        const data: ReadReceipt = JSONBigString.parse(message.body);
        console.log('[WS] 收到已读回执:', data.senderId);
        this.emit('onReadReceipt', data);
      } catch (e) {
        console.error('[WS] 解析已读回执失败:', e);
      }
    });

    // 重新订阅之前的群组
    const groupIds = [...this.groupSubscriptions.keys()];
    this.groupSubscriptions.clear();
    groupIds.forEach((id) => this.subscribeToGroup(id));
  }

  // ============ 群组订阅 ============

  subscribeToGroup(groupId: number): void {
    if (!this.client?.connected) {
      console.warn('[WS] 未连接，无法订阅群组', groupId);
      return;
    }

    if (this.groupSubscriptions.has(groupId)) {
      return;
    }

    const msgSub = this.client.subscribe(`/topic/group/${groupId}`, (message: IMessage) => {
      try {
        const data: WsGroupMessage = JSONBigString.parse(message.body);
        console.log('[WS] 收到群消息:', data.content?.substring(0, 30));
        this.emit('onGroupMessage', data);
      } catch (e) {
        console.error('[WS] 解析群消息失败:', e);
      }
    });

    const readSub = this.client.subscribe(`/topic/group/${groupId}/read-receipts`, (message: IMessage) => {
      try {
        const data: WsGroupReadReceipt = JSONBigString.parse(message.body);
        console.log('[WS] 收到群已读回执: messageId=', data.messageId, 'reader=', data.readerName);
        this.emit('onGroupReadReceipt', data);
      } catch (e) {
        console.error('[WS] 解析群已读回执失败:', e);
      }
    });

    this.groupSubscriptions.set(groupId, [msgSub, readSub]);
    console.log(`[WS] 已订阅群组 ${groupId} (消息+已读回执)`);
  }

  unsubscribeFromGroup(groupId: number): void {
    const subs = this.groupSubscriptions.get(groupId);
    if (subs) {
      subs.forEach((sub) => { try { sub.unsubscribe(); } catch { /* ignore */ } });
      this.groupSubscriptions.delete(groupId);
      console.log(`[WS] 已取消订阅群组 ${groupId}`);
    }
  }

  // ============ 发送消息 ============

  sendPrivateMessage(receiverId: number, content: string, type: string = 'TEXT', replyTo?: number): void {
    if (!this.client?.connected) {
      console.warn('[WS] 未连接，无法发送私聊消息');
      return;
    }
    this.client.publish({
      destination: '/app/chat.send',
      body: JSON.stringify({
        receiverId,
        content,
        type,
        ...(replyTo != null && { replyTo }),
      }),
    });
  }

  sendGroupMessage(groupId: number, content: string, type: string = 'TEXT', replyTo?: number): void {
    if (!this.client?.connected) {
      console.warn('[WS] 未连接，无法发送群消息');
      return;
    }
    this.client.publish({
      destination: '/app/group.send',
      body: JSON.stringify({
        groupId,
        content,
        type,
        ...(replyTo != null && { replyTo }),
      }),
    });
  }

  markAsRead(senderId: number): void {
    if (!this.client?.connected) return;
    this.client.publish({
      destination: '/app/chat.read',
      body: JSON.stringify({ senderId }),
    });
  }

  markGroupMessageAsRead(groupId: number, messageId: number): void {
    if (!this.client?.connected) return;
    this.client.publish({
      destination: '/app/group.read',
      body: JSON.stringify({ groupId, messageId }),
    });
  }

  refreshUnreadCount(): void {
    if (!this.client?.connected) return;
    this.client.publish({
      destination: '/app/notification.refreshUnread',
      body: JSON.stringify({}),
    });
  }

  acknowledgeNotification(notificationId: string): void {
    if (!this.client?.connected) return;
    this.client.publish({
      destination: '/app/notification.ack',
      body: JSON.stringify({ notificationId }),
    });
  }

  // ============ 事件系统 ============

  addListener(handlers: ChatEventHandlers): () => void {
    this.listeners.add(handlers);
    return () => this.listeners.delete(handlers);
  }

  removeListener(handlers: ChatEventHandlers): void {
    this.listeners.delete(handlers);
  }

  private emit<K extends keyof ChatEventHandlers>(
    event: K,
    ...args: Parameters<NonNullable<ChatEventHandlers[K]>>
  ): void {
    this.listeners.forEach((listener) => {
      const handler = listener[event];
      if (handler) {
        try {
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          (handler as (...a: any[]) => void)(...args);
        } catch (e) {
          console.error(`[WS] 事件处理器错误 (${event}):`, e);
        }
      }
    });
  }

  private setConnectionState(state: ConnectionState): void {
    if (this._connectionState === state) return;
    this._connectionState = state;
    this.emit('onConnectionChange', state);
  }
}

export default WebSocketService;
