import React, { createContext, useContext, useEffect, useState, useCallback, useRef } from 'react';
import WebSocketService from '../api/websocket';
import type {
  WsChatMessage,
  WsGroupMessage,
  WsGroupReadReceipt,
  NotificationEvent,
  ReadReceipt,
  ConnectionState,
} from '../api/chatTypes';
import { getToken } from '../api';

// ============ Context 类型 ============

interface ChatContextValue {
  connectionState: ConnectionState;
  connect: () => void;
  disconnect: () => void;

  // 私聊
  sendPrivateMessage: (receiverId: number, content: string, type?: string) => void;
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

  const wsRef = useRef(WebSocketService.getInstance());

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
  }, []);

  const connect = useCallback(() => {
    wsRef.current.connect();
  }, []);

  const disconnect = useCallback(() => {
    wsRef.current.disconnect();
  }, []);

  const sendPrivateMessage = useCallback((receiverId: number, content: string, type = 'TEXT') => {
    wsRef.current.sendPrivateMessage(receiverId, content, type);
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
