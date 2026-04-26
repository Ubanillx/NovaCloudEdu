import React, { useState, useEffect, useCallback, useRef } from 'react';
import {
  ArrowLeft, Send, User, Loader2, MessageCircle, Check, CheckCheck,
  Image, Paperclip, Upload, Phone, Video, Reply, UsersRound,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { ChatSessionResponse, ChatMessageResponse, GroupResponse } from '../../api/generated/models';
import { useChat } from '../../context/ChatContext';
import { useRtc } from '../../context/RtcContext';
import toast from '../ui/Toast';
import { MessageBubble } from './MessageContent';
import { ReplyComposerBar, ReplyPreview } from './MessageReply';
import { useChatUpload } from './useChatUpload';
import GroupChatWindow from './GroupChatWindow';

const api = new DefaultApi(new Configuration(), '', apiClient);

// ============ 工具函数 ============

const formatTime = (dateStr?: string) => {
  if (!dateStr) return '';
  const now = new Date();
  const time = new Date(dateStr);
  const diff = now.getTime() - time.getTime();
  const minutes = Math.floor(diff / 60000);
  if (minutes < 1) return '刚刚';
  if (minutes < 60) return `${minutes}分钟前`;
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours}小时前`;
  const days = Math.floor(hours / 24);
  if (days < 7) return `${days}天前`;
  return `${time.getMonth() + 1}月${time.getDate()}日`;
};

const formatMessageTime = (dateStr?: string) => {
  if (!dateStr) return '';
  const time = new Date(dateStr);
  const hours = time.getHours().toString().padStart(2, '0');
  const mins = time.getMinutes().toString().padStart(2, '0');
  return `${hours}:${mins}`;
};

const getCurrentUserId = (): string => {
  try {
    const stored = localStorage.getItem('user_info');
    if (stored) return String(JSON.parse(stored)?.id ?? '');
  } catch { /* ignore */ }
  return '';
};

type ConversationItem = {
  id: string;
  type: 'private' | 'group';
  targetId: number;
  title?: string;
  avatar?: string;
  preview?: string;
  lastMessageType?: string;
  lastMessageTime?: string;
  unreadCount?: number;
  lastMessageSenderId?: number;
  lastMessageSenderName?: string;
  memberCount?: number;
};

const formatPreviewContent = (content?: string, messageType?: string, prefix = '') => {
  const type = (messageType || 'TEXT').toUpperCase();
  if (type === 'IMAGE') return `${prefix}[图片]`;
  if (type === 'FILE') {
    const value = content || '';
    return value.includes('|') ? `${prefix}[文件] ${value.split('|')[0] || '文件'}` : `${prefix}[文件]`;
  }
  if (type === 'AUDIO') return `${prefix}[语音]`;
  if (type === 'VIDEO') return `${prefix}[视频]`;
  if (type === 'CALL') return `${prefix}[通话]`;
  const text = content?.trim();
  return text ? `${prefix}${text}` : '暂无消息';
};

const getSessionPreview = (session: ConversationItem, currentUserId = getCurrentUserId()) => {
  const senderIsMe = currentUserId && String(session.lastMessageSenderId) === currentUserId;
  const prefix = senderIsMe
    ? '我：'
    : session.type === 'group' && session.lastMessageSenderName
      ? `${session.lastMessageSenderName}：`
      : '';
  return formatPreviewContent(session.preview, session.lastMessageType, prefix);
};

const toPrivateConversation = (session: ChatSessionResponse): ConversationItem | null => {
  if (!session.partnerId) return null;
  return {
    id: `private:${session.partnerId}`,
    type: 'private',
    targetId: session.partnerId,
    title: session.partnerName,
    avatar: session.partnerAvatar,
    preview: session.lastMessage,
    lastMessageType: session.lastMessageType,
    lastMessageTime: session.lastMessageTime,
    unreadCount: session.unreadCount,
    lastMessageSenderId: session.lastMessageSenderId,
  };
};

const toGroupConversation = (group: GroupResponse): ConversationItem | null => {
  if (!group.id) return null;
  return {
    id: `group:${group.id}`,
    type: 'group',
    targetId: group.id,
    title: group.groupName,
    avatar: group.avatar,
    preview: group.lastMessage,
    lastMessageType: group.lastMessageType,
    lastMessageTime: group.lastMessageTime || group.createTime,
    unreadCount: group.unreadCount,
    lastMessageSenderId: group.lastMessageSenderId,
    lastMessageSenderName: group.lastMessageSenderName,
    memberCount: group.memberCount,
  };
};

// ============ 头像组件 ============

const Avatar: React.FC<{ src?: string; name?: string; size?: 'sm' | 'md' | 'lg' }> = ({
  src, name, size = 'md',
}) => {
  const sizeMap = { sm: 'w-9 h-9', md: 'w-11 h-11', lg: 'w-14 h-14' };
  const textSize = { sm: 'text-sm', md: 'text-base', lg: 'text-lg' };
  if (src) {
    return <img src={src} alt={name || ''} className={`${sizeMap[size]} rounded-xl object-cover ring-2 ring-white dark:ring-gray-800 shadow-sm`} />;
  }
  const initial = name?.[0];
  return (
    <div className={`${sizeMap[size]} rounded-xl bg-gradient-to-br from-brand-100 to-brand-50 dark:from-brand-900/40 dark:to-brand-800/20 text-brand-600 dark:text-brand-400 flex items-center justify-center shadow-inner`}>
      {initial ? <span className={`font-semibold ${textSize[size]}`}>{initial}</span> : <User size={size === 'sm' ? 16 : 20} />}
    </div>
  );
};

// ============ 会话列表 ============

interface SessionListProps {
  sessions: ConversationItem[];
  loading: boolean;
  activeSessionId: string | null;
  onSelect: (session: ConversationItem) => void;
}

const SessionList: React.FC<SessionListProps> = ({ sessions, loading, activeSessionId, onSelect }) => {
  if (loading) {
    return (
      <div className="flex items-center justify-center py-16 text-gray-400">
        <Loader2 size={24} className="animate-spin" />
      </div>
    );
  }

  if (sessions.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-gray-400">
        <MessageCircle size={40} className="mb-3 opacity-40" />
        <p className="text-sm">暂无聊天会话</p>
        <p className="text-xs mt-1">添加好友后即可开始聊天</p>
      </div>
    );
  }

  return (
    <div className="divide-y divide-gray-100 dark:divide-gray-800">
      {sessions.map((session) => (
        <button
          key={session.id}
          onClick={() => onSelect(session)}
          className={`w-full flex items-center gap-3 px-4 py-3 text-left transition-colors ${
            activeSessionId === session.id
              ? 'bg-brand-50 dark:bg-brand-900/20'
              : 'hover:bg-gray-50 dark:hover:bg-gray-800/50'
          }`}
        >
          <div className="relative">
            <Avatar src={session.avatar} name={session.title} />
            {(session.unreadCount ?? 0) > 0 && (
              <span className="absolute -top-1 -right-1 inline-flex min-w-5 items-center justify-center h-5 px-1 text-[10px] font-bold text-white bg-rose-500 rounded-full ring-2 ring-white dark:ring-gray-900">
                {session.unreadCount! > 99 ? '99+' : session.unreadCount}
              </span>
            )}
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-1.5 min-w-0">
                <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                  {session.title || (session.type === 'group' ? '未知群聊' : '未知用户')}
                </p>
                {session.type === 'group' && (
                  <span className="shrink-0 rounded bg-gray-100 dark:bg-gray-800 px-1.5 py-0.5 text-[10px] font-medium text-gray-500 dark:text-gray-400">
                    群聊
                  </span>
                )}
              </div>
              <span className="text-[10px] text-gray-400 whitespace-nowrap ml-2">
                {formatTime(session.lastMessageTime)}
              </span>
            </div>
            <p className="mt-0.5 text-xs text-gray-500 dark:text-gray-400 truncate">
              {getSessionPreview(session)}
            </p>
          </div>
        </button>
      ))}
    </div>
  );
};

// ============ 聊天窗口 ============

interface ChatWindowProps {
  partnerId: number;
  partnerName?: string;
  partnerAvatar?: string;
  onBack: () => void;
}

const ChatWindow: React.FC<ChatWindowProps> = ({
  partnerId, partnerName, partnerAvatar, onBack,
}) => {
  const { sendPrivateMessage, markPrivateAsRead, chatMessages, readReceipts } = useChat();
  const { startCall } = useRtc();
  const [messages, setMessages] = useState<ChatMessageResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [inputValue, setInputValue] = useState('');
  const [sending, setSending] = useState(false);
  const [replyingTo, setReplyingTo] = useState<ChatMessageResponse | null>(null);
  const [highlightedMessageId, setHighlightedMessageId] = useState<number | null>(null);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const scrollContainerRef = useRef<HTMLDivElement>(null);
  const messageRefs = useRef<Record<string, HTMLDivElement | null>>({});
  const currentUserId = useRef<string>(getCurrentUserId());

  // 上传功能
  const handleUploadSend = useCallback((content: string, type: string) => {
    const userInfo = (() => { try { return JSON.parse(localStorage.getItem('user_info') || '{}'); } catch { return {}; } })();
    const replyTo = replyingTo?.messageId;
    setReplyingTo(null);
    const optimisticMsg: ChatMessageResponse = {
      messageId: Date.now(),
      senderId: -1,
      senderName: userInfo.userName,
      senderAvatar: userInfo.userAvatar,
      receiverId: partnerId,
      content,
      type,
      replyTo,
      createTime: new Date().toISOString(),
      read: false,
    };
    setMessages((prev) => [...prev, optimisticMsg]);
    sendPrivateMessage(partnerId, content, type, replyTo);
  }, [partnerId, replyingTo, sendPrivateMessage]);

  const {
    uploading, isDragging, imageInputRef, fileInputRef,
    triggerImagePick, triggerFilePick, handleInputChange,
    handleDragEnter, handleDragLeave, handleDragOver, handleDrop,
  } = useChatUpload({ onSend: handleUploadSend });

  // 加载历史消息
  const loadMessages = useCallback(async () => {
    setLoading(true);
    try {
      const res = await api.getChatHistory({
        chatHistoryRequestDTO: { partnerId, page: 1, size: 50 },
      });
      const msgs = res.data?.data?.messages || [];
      setMessages(msgs.reverse());
    } catch {
      toast.error('加载消息失败');
    } finally {
      setLoading(false);
    }
  }, [partnerId]);

  useEffect(() => {
    loadMessages();
    markPrivateAsRead(partnerId);
  }, [loadMessages, markPrivateAsRead, partnerId]);

  // 监听 WebSocket 新消息
  useEffect(() => {
    if (chatMessages.length === 0) return;
    const latest = chatMessages[0];
    const partnerStr = String(partnerId);
    const senderStr = String(latest.senderId);
    const receiverStr = String(latest.receiverId);
    if (senderStr === partnerStr || receiverStr === partnerStr) {
      const newMsg: ChatMessageResponse = {
        messageId: latest.messageId,
        senderId: latest.senderId,
        senderName: latest.senderName,
        senderAvatar: latest.senderAvatar,
        receiverId: latest.receiverId,
        content: latest.content,
        type: latest.type,
        replyTo: latest.replyTo,
        createTime: latest.createTime,
        read: latest.isRead,
      };

      // 自己发的消息（服务器回传），替换乐观更新占位消息
      if (currentUserId.current && senderStr === currentUserId.current) {
        setMessages((prev) => {
          // 防重
          if (prev.some((m) => String(m.messageId) === String(newMsg.messageId) && String(m.messageId) !== '-1')) return prev;
          let idx = -1;
          for (let i = prev.length - 1; i >= 0; i--) {
            if (prev[i].senderId === -1 && prev[i].content === latest.content) { idx = i; break; }
          }
          if (idx !== -1) {
            const updated = [...prev];
            updated[idx] = newMsg;
            return updated;
          }
          // 没有乐观占位（如 CALL 通话记录由后端生成），直接追加
          return [...prev, newMsg];
        });
      } else {
        setMessages((prev) => [...prev, newMsg]);
        markPrivateAsRead(partnerId);
      }
    }
  }, [chatMessages, partnerId, markPrivateAsRead]);

  // 监听已读回执
  useEffect(() => {
    if (readReceipts.length === 0) return;
    const latest = readReceipts[0];
    if (String(latest.senderId) === String(partnerId)) {
      setMessages((prev) =>
        prev.map((msg) =>
          String(msg.receiverId) === String(partnerId) ? { ...msg, read: true } : msg,
        ),
      );
    }
  }, [readReceipts, partnerId]);

  // 滚动到底部（仅滚动消息容器，不影响页面）
  useEffect(() => {
    const container = scrollContainerRef.current;
    if (container) {
      container.scrollTop = container.scrollHeight;
    }
  }, [messages]);

  // 发送消息
  const handleSend = async () => {
    const content = inputValue.trim();
    if (!content) return;

    setSending(true);
    setInputValue('');
    const replyTo = replyingTo?.messageId;
    setReplyingTo(null);

    // 乐观更新（senderId 用 -1 作为占位标记，后续 WebSocket 回传时替换）
    const userInfo = (() => { try { return JSON.parse(localStorage.getItem('user_info') || '{}'); } catch { return {}; } })();
    const optimisticMsg: ChatMessageResponse = {
      messageId: Date.now(),
      senderId: -1,
      senderName: userInfo.userName,
      senderAvatar: userInfo.userAvatar,
      receiverId: partnerId,
      content,
      type: 'TEXT',
      replyTo,
      createTime: new Date().toISOString(),
      read: false,
    };
    setMessages((prev) => [...prev, optimisticMsg]);

    try {
      sendPrivateMessage(partnerId, content, 'TEXT', replyTo);
    } catch {
      toast.error('发送失败');
    } finally {
      setSending(false);
    }
  };

  // 判断是否是自己发送的消息（ID 转字符串比较，避免大整数精度丢失）
  const isSelf = (msg: ChatMessageResponse) =>
    msg.senderId === -1 || (currentUserId.current !== '' && String(msg.senderId) === currentUserId.current);

  const findReplyMessage = (replyTo?: number) =>
    replyTo ? messages.find((msg) => String(msg.messageId) === String(replyTo)) || null : null;

  const scrollToMessage = (messageId?: number) => {
    if (!messageId) return;
    const node = messageRefs.current[String(messageId)];
    if (!node) {
      toast.info('引用的消息不在当前记录中');
      return;
    }
    node.scrollIntoView({ behavior: 'smooth', block: 'center' });
    setHighlightedMessageId(messageId);
    window.setTimeout(() => setHighlightedMessageId((current) => (current === messageId ? null : current)), 1400);
  };

  return (
    <div className="flex flex-col h-full">
      {/* 头部 */}
      <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-100 dark:border-gray-800 bg-white/80 dark:bg-gray-900/80 backdrop-blur-sm">
        <button
          onClick={onBack}
          className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors lg:hidden"
        >
          <ArrowLeft size={18} className="text-gray-500" />
        </button>
        <Avatar src={partnerAvatar} name={partnerName} size="sm" />
        <div className="flex-1 min-w-0">
          <p className="text-sm font-semibold text-gray-900 dark:text-white truncate">
            {partnerName || '未知用户'}
          </p>
        </div>
        <div className="flex items-center gap-1">
          <button
            onClick={() => startCall(String(partnerId), partnerName || '未知用户', partnerAvatar, 'audio')}
            className="p-2 rounded-lg text-gray-400 hover:text-brand-500 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-colors"
            title="语音通话"
          >
            <Phone size={18} />
          </button>
          <button
            onClick={() => startCall(String(partnerId), partnerName || '未知用户', partnerAvatar, 'video')}
            className="p-2 rounded-lg text-gray-400 hover:text-brand-500 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-colors"
            title="视频通话"
          >
            <Video size={18} />
          </button>
        </div>
      </div>

      {/* 消息列表（支持拖拽上传） */}
      <div
        ref={scrollContainerRef}
        className="flex-1 overflow-y-auto px-4 py-3 space-y-3 bg-gray-50/50 dark:bg-gray-950/50 relative"
        onDragEnter={handleDragEnter}
        onDragLeave={handleDragLeave}
        onDragOver={handleDragOver}
        onDrop={handleDrop}
      >
        {/* 拖拽遮罩 */}
        {isDragging && (
          <div className="absolute inset-0 z-20 flex flex-col items-center justify-center bg-brand-50/90 dark:bg-brand-950/90 border-2 border-dashed border-brand-400 rounded-xl backdrop-blur-sm">
            <Upload size={40} className="text-brand-500 mb-2" />
            <p className="text-sm font-medium text-brand-600 dark:text-brand-400">释放以发送文件</p>
            <p className="text-xs text-brand-400 mt-1">支持图片和文件</p>
          </div>
        )}
        {loading ? (
          <div className="flex items-center justify-center py-16 text-gray-400">
            <Loader2 size={24} className="animate-spin" />
          </div>
        ) : messages.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 text-gray-400">
            <MessageCircle size={40} className="mb-3 opacity-40" />
            <p className="text-sm">暂无消息，开始聊天吧</p>
          </div>
        ) : (
          messages.map((msg) => {
            const self = isSelf(msg);
            return (
              <div
                key={msg.messageId}
                ref={(node) => { if (msg.messageId) messageRefs.current[String(msg.messageId)] = node; }}
                className={`group flex gap-2 rounded-2xl transition-shadow ${self ? 'flex-row-reverse' : ''} ${
                  highlightedMessageId && String(highlightedMessageId) === String(msg.messageId)
                    ? 'ring-2 ring-brand-300 ring-offset-2 ring-offset-gray-50 dark:ring-offset-gray-950'
                    : ''
                }`}
              >
                <Avatar
                  src={self ? (msg.senderAvatar || undefined) : (msg.senderAvatar || partnerAvatar)}
                  name={self ? (msg.senderName || undefined) : (msg.senderName || partnerName)}
                  size="sm"
                />
                <div className={`max-w-[70%] ${self ? 'items-end' : 'items-start'} flex flex-col`}>
                  <MessageBubble
                    content={msg.content || ''}
                    type={msg.type || 'TEXT'}
                    isSelf={self}
                    replyPreview={msg.replyTo ? (
                      <ReplyPreview
                        message={findReplyMessage(msg.replyTo)}
                        fallbackName={partnerName}
                        isSelf={self}
                        embedded
                        onClick={() => scrollToMessage(msg.replyTo)}
                      />
                    ) : undefined}
                  />
                  <div className={`flex items-center gap-1 mt-1 ${self ? 'flex-row-reverse' : ''}`}>
                    <span className="text-[10px] text-gray-400">
                      {formatMessageTime(msg.createTime)}
                    </span>
                    {self && (
                      msg.read ? (
                        <CheckCheck size={12} className="text-brand-400" />
                      ) : (
                        <Check size={12} className="text-gray-300" />
                      )
                    )}
                  </div>
                </div>
                {msg.messageId && msg.senderId !== -1 && (
                  <button
                    type="button"
                    onClick={() => setReplyingTo(msg)}
                    className="self-center p-1.5 rounded-lg text-gray-300 hover:text-brand-500 hover:bg-white dark:hover:bg-gray-800 opacity-0 group-hover:opacity-100 focus:opacity-100 transition-all"
                    title="引用回复"
                  >
                    <Reply size={14} />
                  </button>
                )}
              </div>
            );
          })
        )}
        <div ref={messagesEndRef} />
      </div>

      {/* 隐藏的文件输入 */}
      <input ref={imageInputRef} type="file" accept="image/*" multiple className="hidden" onChange={handleInputChange} />
      <input ref={fileInputRef} type="file" multiple className="hidden" onChange={handleInputChange} />

      {/* 上传进度提示 */}
      {uploading && (
        <div className="px-4 py-2 bg-brand-50 dark:bg-brand-900/20 border-t border-brand-100 dark:border-brand-800 flex items-center gap-2">
          <Loader2 size={14} className="animate-spin text-brand-500" />
          <span className="text-xs text-brand-600 dark:text-brand-400">正在上传...</span>
        </div>
      )}

      {/* 输入栏 */}
      <div className="px-4 py-3 border-t border-gray-100 dark:border-gray-800 bg-white dark:bg-gray-900">
        {replyingTo && (
          <ReplyComposerBar
            message={replyingTo}
            fallbackName={partnerName}
            onCancel={() => setReplyingTo(null)}
          />
        )}
        <div className="flex items-center gap-1.5">
          {/* 图片按钮 */}
          <button
            onClick={triggerImagePick}
            disabled={uploading}
            className="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 disabled:opacity-50 transition-colors text-gray-400 hover:text-brand-500"
            title="发送图片"
          >
            <Image size={20} />
          </button>
          {/* 文件按钮 */}
          <button
            onClick={triggerFilePick}
            disabled={uploading}
            className="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 disabled:opacity-50 transition-colors text-gray-400 hover:text-brand-500"
            title="发送文件"
          >
            <Paperclip size={20} />
          </button>
          <input
            type="text"
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === 'Enter' && !e.shiftKey && !e.nativeEvent.isComposing) {
                e.preventDefault();
                handleSend();
              }
            }}
            placeholder="输入消息..."
            className="flex-1 px-4 py-2.5 text-sm bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl outline-none focus:border-brand-400 focus:ring-2 focus:ring-brand-100 dark:focus:ring-brand-900/30 transition-all"
          />
          <button
            onClick={handleSend}
            disabled={sending || !inputValue.trim()}
            className="p-2.5 bg-brand-500 hover:bg-brand-600 disabled:opacity-50 disabled:cursor-not-allowed text-white rounded-xl transition-colors shadow-sm"
          >
            {sending ? <Loader2 size={18} className="animate-spin" /> : <Send size={18} />}
          </button>
        </div>
      </div>
    </div>
  );
};

// ============ 私聊面板 ============

interface PrivateChatPanelProps {
  initialPartnerId?: number;
  initialPartnerName?: string;
  initialPartnerAvatar?: string;
  initialGroupId?: number;
  initialGroupName?: string;
  initialGroupAvatar?: string;
}

const PrivateChatPanel: React.FC<PrivateChatPanelProps> = ({
  initialPartnerId,
  initialPartnerName,
  initialPartnerAvatar,
  initialGroupId,
  initialGroupName,
  initialGroupAvatar,
}) => {
  const [sessions, setSessions] = useState<ConversationItem[]>([]);
  const [loadingSessions, setLoadingSessions] = useState(true);
  const [activeSession, setActiveSession] = useState<{
    type: 'private' | 'group';
    targetId: number;
    title?: string;
    avatar?: string;
  } | null>(
    initialPartnerId
      ? { type: 'private', targetId: initialPartnerId, title: initialPartnerName, avatar: initialPartnerAvatar }
      : initialGroupId
        ? { type: 'group', targetId: initialGroupId, title: initialGroupName, avatar: initialGroupAvatar }
      : null,
  );

  const { chatMessages, groupMessages, groupMessagesSent } = useChat();

  // 加载会话列表
  const loadSessions = useCallback(async () => {
    setLoadingSessions(true);
    try {
      const [privateRes, groupRes] = await Promise.all([
        api.getSessionList(),
        api.getMyGroups(),
      ]);
      const privateSessions = (privateRes.data?.data || [])
        .map(toPrivateConversation)
        .filter((item): item is ConversationItem => item !== null);
      const groupSessions = (groupRes.data?.data || [])
        .map(toGroupConversation)
        .filter((item): item is ConversationItem => item !== null);
      setSessions([...privateSessions, ...groupSessions].sort((a, b) => {
        const aTime = a.lastMessageTime ? new Date(a.lastMessageTime).getTime() : 0;
        const bTime = b.lastMessageTime ? new Date(b.lastMessageTime).getTime() : 0;
        return bTime - aTime;
      }));
    } catch {
      toast.error('加载会话列表失败');
    } finally {
      setLoadingSessions(false);
    }
  }, []);

  useEffect(() => { loadSessions(); }, [loadSessions]);

  useEffect(() => {
    if (initialPartnerId) {
      setActiveSession({
        type: 'private',
        targetId: initialPartnerId,
        title: initialPartnerName,
        avatar: initialPartnerAvatar,
      });
      return;
    }
    if (initialGroupId) {
      setActiveSession({
        type: 'group',
        targetId: initialGroupId,
        title: initialGroupName,
        avatar: initialGroupAvatar,
      });
    }
  }, [initialGroupAvatar, initialGroupId, initialGroupName, initialPartnerAvatar, initialPartnerId, initialPartnerName]);

  // 新消息时刷新会话列表
  useEffect(() => {
    if (chatMessages.length > 0 || groupMessages.length > 0 || groupMessagesSent.length > 0) {
      loadSessions();
    }
  }, [chatMessages, groupMessages, groupMessagesSent, loadSessions]);

  const handleSelectSession = (session: ConversationItem) => {
    setActiveSession({
      type: session.type,
      targetId: session.targetId,
      title: session.title,
      avatar: session.avatar,
    });
    if ((session.unreadCount ?? 0) > 0) {
      setSessions((prev) => prev.map((item) => (
        item.id === session.id ? { ...item, unreadCount: 0 } : item
      )));
    }
  };

  const activeSessionId = activeSession ? `${activeSession.type}:${activeSession.targetId}` : null;

  return (
    <div className="flex h-full">
      {/* 会话列表（左） */}
      <div
        className={`w-full lg:w-80 lg:min-w-[320px] border-r border-gray-100 dark:border-gray-800 flex flex-col ${
          activeSession ? 'hidden lg:flex' : 'flex'
        }`}
      >
        <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-sm font-semibold text-gray-900 dark:text-white">消息</h3>
        </div>
        <div className="flex-1 overflow-y-auto">
          <SessionList
            sessions={sessions}
            loading={loadingSessions}
            activeSessionId={activeSessionId}
            onSelect={handleSelectSession}
          />
        </div>
      </div>

      {/* 聊天窗口（右） */}
      <div className={`flex-1 flex flex-col ${activeSession ? 'flex' : 'hidden lg:flex'}`}>
        {activeSession?.type === 'private' ? (
          <ChatWindow
            key={`private:${activeSession.targetId}`}
            partnerId={activeSession.targetId}
            partnerName={activeSession.title}
            partnerAvatar={activeSession.avatar}
            onBack={() => setActiveSession(null)}
          />
        ) : activeSession?.type === 'group' ? (
          <GroupChatWindow
            key={`group:${activeSession.targetId}`}
            groupId={activeSession.targetId}
            groupName={activeSession.title}
            groupAvatar={activeSession.avatar}
            onBack={() => setActiveSession(null)}
            onGroupUpdated={loadSessions}
          />
        ) : (
          <div className="flex-1 flex flex-col items-center justify-center text-gray-400">
            <div className="mb-4 flex items-center gap-3 opacity-30">
              <MessageCircle size={42} />
              <UsersRound size={42} />
            </div>
            <p className="text-sm">选择一个会话开始聊天</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default PrivateChatPanel;
