// ============ WebSocket 消息类型 ============

export type MessageType = 'TEXT' | 'IMAGE' | 'FILE' | 'AUDIO' | 'VIDEO' | 'CALL';

export interface WsChatMessage {
  messageId: number;
  senderId: number;
  senderName?: string;
  senderAvatar?: string;
  receiverId: number;
  content?: string;
  type: MessageType;
  replyTo?: number;
  createTime?: string;
  isRead?: boolean;
}

export interface WsGroupMessage {
  messageId: number;
  groupId: number;
  senderId: number;
  senderName?: string;
  senderAvatar?: string;
  content?: string;
  type: MessageType;
  replyTo?: number;
  createTime?: string;
  readCount?: number;
  memberCount?: number;
}

export interface ReadReceipt {
  senderId: number;
  readTime?: string;
}

export interface WsGroupReadReceipt {
  messageId: number;
  groupId: number;
  readerId: number;
  readerName?: string;
  readerAvatar?: string;
  totalReadCount: number;
  readTime?: string;
}

// ============ 通知类型 ============

export type NotificationType =
  | 'NEW_PRIVATE_MESSAGE'
  | 'PRIVATE_MESSAGE_READ'
  | 'NEW_GROUP_MESSAGE'
  | 'GROUP_MESSAGE_READ'
  | 'FRIEND_REQUEST_RECEIVED'
  | 'FRIEND_REQUEST_HANDLED'
  | 'NEW_FRIEND'
  | 'GROUP_JOIN_REQUEST_RECEIVED'
  | 'GROUP_INVITED'
  | 'GROUP_REMOVED'
  | 'UNREAD_COUNT_CHANGED'
  | 'SYSTEM_NOTIFICATION';

export interface NotificationEvent {
  type: NotificationType;
  data: Record<string, unknown>;
  timestamp?: string;
}

// ============ 未读数统计（与 Flutter NotificationService 对齐） ============

export interface UnreadCount {
  privateMessageCount: number;
  groupMessageCount: number;
  friendRequestCount: number;
  systemNotificationCount: number;
}

export const EMPTY_UNREAD: UnreadCount = {
  privateMessageCount: 0,
  groupMessageCount: 0,
  friendRequestCount: 0,
  systemNotificationCount: 0,
};

// ============ 连接状态 ============

export type ConnectionState = 'disconnected' | 'connecting' | 'connected' | 'error';

// ============ 事件回调 ============

export interface ChatEventHandlers {
  onChatMessage?: (message: WsChatMessage) => void;
  onGroupMessage?: (message: WsGroupMessage) => void;
  onNotification?: (event: NotificationEvent) => void;
  onReadReceipt?: (receipt: ReadReceipt) => void;
  onGroupReadReceipt?: (receipt: WsGroupReadReceipt) => void;
  onGroupMessageSent?: (message: WsGroupMessage) => void;
  onConnectionChange?: (state: ConnectionState) => void;
}
