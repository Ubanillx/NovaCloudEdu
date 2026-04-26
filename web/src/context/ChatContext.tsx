import React, { createContext, useContext, useEffect, useState, useCallback, useRef } from 'react';
import WebSocketService from '../api/websocket';
import type {
  WsChatMessage,
  WsGroupMessage,
  WsGroupReadReceipt,
  NotificationEvent,
  ReadReceipt,
  ConnectionState,
  UnreadCount,
} from '../api/chatTypes';
import { EMPTY_UNREAD } from '../api/chatTypes';
import { getToken } from '../api';

// ============ Context 类型 ============

interface ChatContextValue {
  connectionState: ConnectionState;
  connect: () => void;
  disconnect: () => void;

  // 私聊
  sendPrivateMessage: (receiverId: number, content: string, type?: string, replyTo?: number) => void;
  markAsRead: (senderId: number) => void;
  chatMessages: WsChatMessage[];
  clearChatMessages: () => void;

  // 群聊
  sendGroupMessage: (groupId: number, content: string, type?: string, replyTo?: number) => void;
  subscribeToGroup: (groupId: number) => void;
  unsubscribeFromGroup: (groupId: number) => void;
  markGroupMessageAsRead: (groupId: number, messageId: number) => void;
  groupMessages: WsGroupMessage[];
  clearGroupMessages: () => void;

  // 通知
  notifications: NotificationEvent[];
  clearNotifications: () => void;
  refreshUnreadCount: () => void;

  // 未读数（服务端权威值）
  unreadCount: UnreadCount;
  totalUnread: number;
  markPrivateAsRead: (senderId: number) => void;
  markGroupAsRead: (groupId: number) => void;
  clearFriendRequestUnread: () => void;

  // 已读回执
  readReceipts: ReadReceipt[];

  // 群已读回执
  groupReadReceipts: WsGroupReadReceipt[];
  clearGroupReadReceipts: () => void;

  // 群消息发送确认
  groupMessagesSent: WsGroupMessage[];
}

const ChatContext = createContext<ChatContextValue | null>(null);

// ============ Provider ============

export const ChatProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [connectionState, setConnectionState] = useState<ConnectionState>('disconnected');
  const [chatMessages, setChatMessages] = useState<WsChatMessage[]>([]);
  const [groupMessages, setGroupMessages] = useState<WsGroupMessage[]>([]);
  const [notifications, setNotifications] = useState<NotificationEvent[]>([]);
  const [readReceipts, setReadReceipts] = useState<ReadReceipt[]>([]);
  const [groupReadReceipts, setGroupReadReceipts] = useState<WsGroupReadReceipt[]>([]);
  const [groupMessagesSent, setGroupMessagesSent] = useState<WsGroupMessage[]>([]);

  const [unreadCount, setUnreadCount] = useState<UnreadCount>(EMPTY_UNREAD);

  const wsRef = useRef(WebSocketService.getInstance());

  // 处理通知事件，更新未读数（与 Flutter NotificationService._handleNotification 对齐）
  const handleNotification = useCallback((evt: NotificationEvent) => {
    switch (evt.type) {
      case 'UNREAD_COUNT_CHANGED':
        // 服务器推送的权威未读数
        setUnreadCount({
          privateMessageCount: (evt.data.privateUnread as number) ?? 0,
          groupMessageCount: (evt.data.groupUnread as number) ?? 0,
          friendRequestCount: (evt.data.friendRequestCount as number) ?? 0,
          systemNotificationCount: (evt.data.systemNotificationCount as number) ?? 0,
        });
        break;
      case 'NEW_PRIVATE_MESSAGE':
        setUnreadCount((prev) => ({ ...prev, privateMessageCount: prev.privateMessageCount + 1 }));
        break;
      case 'NEW_GROUP_MESSAGE':
        setUnreadCount((prev) => ({ ...prev, groupMessageCount: prev.groupMessageCount + 1 }));
        break;
      case 'FRIEND_REQUEST_RECEIVED':
        setUnreadCount((prev) => ({ ...prev, friendRequestCount: prev.friendRequestCount + 1 }));
        break;
      case 'SYSTEM_NOTIFICATION':
        setUnreadCount((prev) => ({ ...prev, systemNotificationCount: prev.systemNotificationCount + 1 }));
        break;
      default:
        break;
    }
  }, []);

  // 注册事件监听
  useEffect(() => {
    const ws = wsRef.current;

    const removeListener = ws.addListener({
      onChatMessage: (msg: WsChatMessage) => {
        setChatMessages((prev) => [msg, ...prev]);
      },
      onGroupMessage: (msg: WsGroupMessage) => {
        setGroupMessages((prev) => [msg, ...prev]);
      },
      onNotification: (evt: NotificationEvent) => {
        setNotifications((prev) => [evt, ...prev]);
        handleNotification(evt);
      },
      onReadReceipt: (receipt: ReadReceipt) => {
        setReadReceipts((prev) => [receipt, ...prev]);
      },
      onGroupReadReceipt: (receipt: WsGroupReadReceipt) => {
        setGroupReadReceipts((prev) => [receipt, ...prev]);
      },
      onGroupMessageSent: (msg: WsGroupMessage) => {
        setGroupMessagesSent((prev) => [msg, ...prev]);
      },
      onConnectionChange: (state: ConnectionState) => {
        setConnectionState(state);
        // 连接成功后请求服务端刷新未读数（与 Flutter NotificationService.init 对齐）
        if (state === 'connected') {
          ws.refreshUnreadCount();
        }
      },
    });

    // 有 Token 时自动连接
    const token = getToken();
    if (token) {
      ws.connect();
    }

    return () => {
      removeListener();
    };
  }, [handleNotification]);

  const connect = useCallback(() => {
    wsRef.current.connect();
  }, []);

  const disconnect = useCallback(() => {
    wsRef.current.disconnect();
  }, []);

  const sendPrivateMessage = useCallback((receiverId: number, content: string, type = 'TEXT', replyTo?: number) => {
    wsRef.current.sendPrivateMessage(receiverId, content, type, replyTo);
  }, []);

  const markAsRead = useCallback((senderId: number) => {
    wsRef.current.markAsRead(senderId);
  }, []);

  const sendGroupMessage = useCallback((groupId: number, content: string, type = 'TEXT', replyTo?: number) => {
    wsRef.current.sendGroupMessage(groupId, content, type, replyTo);
  }, []);

  const subscribeToGroup = useCallback((groupId: number) => {
    wsRef.current.subscribeToGroup(groupId);
  }, []);

  const unsubscribeFromGroup = useCallback((groupId: number) => {
    wsRef.current.unsubscribeFromGroup(groupId);
  }, []);

  const markGroupMessageAsRead = useCallback((groupId: number, messageId: number) => {
    wsRef.current.markGroupMessageAsRead(groupId, messageId);
  }, []);

  const refreshUnreadCount = useCallback(() => {
    wsRef.current.refreshUnreadCount();
  }, []);

  // 未读数总计
  const totalUnread = unreadCount.privateMessageCount + unreadCount.groupMessageCount
    + unreadCount.friendRequestCount + unreadCount.systemNotificationCount;

  // 标记私聊已读（本地 -1 + 发 WS）
  const markPrivateAsRead = useCallback((senderId: number) => {
    wsRef.current.markAsRead(senderId);
    setUnreadCount((prev) => ({
      ...prev,
      privateMessageCount: Math.max(0, prev.privateMessageCount - 1),
    }));
  }, []);

  // 标记群已读（本地清零该群）
  const markGroupAsRead = useCallback((groupId: number) => {
    // 触发服务端刷新
    wsRef.current.refreshUnreadCount();
    void groupId; // 目前依赖服务端 UNREAD_COUNT_CHANGED 精确更新
  }, []);

  // 清除好友申请未读
  const clearFriendRequestUnread = useCallback(() => {
    setUnreadCount((prev) => ({ ...prev, friendRequestCount: 0 }));
  }, []);

  const clearChatMessages = useCallback(() => setChatMessages([]), []);
  const clearGroupMessages = useCallback(() => setGroupMessages([]), []);
  const clearNotifications = useCallback(() => setNotifications([]), []);
  const clearGroupReadReceipts = useCallback(() => setGroupReadReceipts([]), []);

  const value: ChatContextValue = {
    connectionState,
    connect,
    disconnect,
    sendPrivateMessage,
    markAsRead,
    chatMessages,
    clearChatMessages,
    sendGroupMessage,
    subscribeToGroup,
    unsubscribeFromGroup,
    markGroupMessageAsRead,
    groupMessages,
    clearGroupMessages,
    notifications,
    clearNotifications,
    refreshUnreadCount,
    unreadCount,
    totalUnread,
    markPrivateAsRead,
    markGroupAsRead,
    clearFriendRequestUnread,
    readReceipts,
    groupReadReceipts,
    clearGroupReadReceipts,
    groupMessagesSent,
  };

  return <ChatContext.Provider value={value}>{children}</ChatContext.Provider>;
};

// ============ Hook ============

export function useChat(): ChatContextValue {
  const ctx = useContext(ChatContext);
  if (!ctx) {
    throw new Error('useChat must be used within a ChatProvider');
  }
  return ctx;
}

export default ChatContext;
