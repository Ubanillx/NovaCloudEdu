import React, { useState, useEffect, useCallback, useRef } from 'react';
import { ArrowLeft, Send, Loader2, MessageCircle, Check, CheckCheck } from 'lucide-react';
import { MessageBubble } from './MessageContent';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { ChatMessageResponse } from '../../api/generated/models';
import { useChat } from '../../context/ChatContext';
import toast from '../ui/Toast';
import { Avatar } from '../ui/Avatar';

const api = new DefaultApi(new Configuration(), '', apiClient);

const getCurrentUserId = (): string => {
  try {
    const stored = localStorage.getItem('user_info');
    if (stored) return String(JSON.parse(stored)?.id ?? '');
  } catch { /* ignore */ }
  return '';
};

interface ChatWindowProps {
  partnerId: number;
  partnerName?: string;
  partnerAvatar?: string;
  onBack: () => void;
}

const formatMessageTime = (dateStr?: string) => {
  if (!dateStr) return '';
  const time = new Date(dateStr);
  const hours = time.getHours().toString().padStart(2, '0');
  const mins = time.getMinutes().toString().padStart(2, '0');
  return `${hours}:${mins}`;
};

export const ChatWindow: React.FC<ChatWindowProps> = ({
  partnerId, partnerName, partnerAvatar, onBack,
}) => {
  const { sendPrivateMessage, markPrivateAsRead, chatMessages, readReceipts } = useChat();
  const [messages, setMessages] = useState<ChatMessageResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [inputValue, setInputValue] = useState('');
  const [sending, setSending] = useState(false);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const scrollContainerRef = useRef<HTMLDivElement>(null);
  const currentUserId = useRef<string>(getCurrentUserId());

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
    // 只处理与当前聊天对象相关的消息
    if (senderStr === partnerStr || receiverStr === partnerStr) {
      const newMsg: ChatMessageResponse = {
        messageId: latest.messageId,
        senderId: latest.senderId,
        senderName: latest.senderName,
        senderAvatar: latest.senderAvatar,
        receiverId: latest.receiverId,
        content: latest.content,
        type: latest.type,
        createTime: latest.createTime,
        read: latest.isRead,
      };

      // 如果是自己发的消息（服务器回传），替换乐观更新的占位消息，避免重复
      if (currentUserId.current && senderStr === currentUserId.current) {
        setMessages((prev) => {
          // 防重
          if (latest.messageId && prev.some((m) => String(m.messageId) === String(latest.messageId) && String(m.messageId) !== '-1')) return prev;
          let idx = -1;
          for (let i = prev.length - 1; i >= 0; i--) {
            if (String(prev[i].senderId) === '-1' && prev[i].content === latest.content) { idx = i; break; }
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
        setMessages((prev) => {
          // 防重：如果该 messageId 已存在则不追加
          if (latest.messageId && prev.some((m) => String(m.messageId) === String(latest.messageId))) {
            return prev;
          }
          return [...prev, newMsg];
        });
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
      createTime: new Date().toISOString(),
      read: false,
    };
    setMessages((prev) => [...prev, optimisticMsg]);

    try {
      sendPrivateMessage(partnerId, content, 'TEXT');
    } catch {
      toast.error('发送失败');
    } finally {
      setSending(false);
    }
  };

  // 判断是否是自己发送的消息（ID 全部转字符串比较，避免大整数精度丢失）
  const isSelf = (msg: ChatMessageResponse) =>
    msg.senderId === -1 || (currentUserId.current !== '' && String(msg.senderId) === currentUserId.current);

  return (
    <div className="flex flex-col h-full bg-white dark:bg-gray-900">
      {/* 头部 */}
      <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-100 dark:border-gray-800 bg-white/80 dark:bg-gray-900/80 backdrop-blur-sm z-10">
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
      </div>

      {/* 消息列表 */}
      <div
        ref={scrollContainerRef}
        className="flex-1 overflow-y-auto px-4 py-3 space-y-4 bg-gray-50 dark:bg-gray-950/30"
      >
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
                className={`flex gap-3 ${self ? 'flex-row-reverse' : ''} animate-in fade-in slide-in-from-bottom-2 duration-300`}
              >
                {!self && (
                  <Avatar
                    src={msg.senderAvatar || partnerAvatar}
                    name={msg.senderName || partnerName}
                    size="sm"
                    className="flex-shrink-0 mt-1"
                  />
                )}
                <div className={`max-w-[70%] flex flex-col ${self ? 'items-end' : 'items-start'}`}>
                  <MessageBubble content={msg.content || ''} type={msg.type || 'TEXT'} isSelf={self} />
                  <div className={`flex items-center gap-1 mt-1 px-1 ${self ? 'flex-row-reverse' : ''}`}>
                    <span className="text-[10px] text-gray-400">
                      {formatMessageTime(msg.createTime)}
                    </span>
                    {self && (
                      msg.read ? (
                        <CheckCheck size={12} className="text-brand-500" />
                      ) : (
                        <Check size={12} className="text-gray-300" />
                      )
                    )}
                  </div>
                </div>
              </div>
            );
          })
        )}
        <div ref={messagesEndRef} />
      </div>

      {/* 输入栏 */}
      <div className="px-4 py-4 border-t border-gray-100 dark:border-gray-800 bg-white dark:bg-gray-900">
        <div className="flex items-end gap-2 bg-gray-50 dark:bg-gray-800/50 p-2 rounded-2xl border border-gray-200 dark:border-gray-700 focus-within:ring-2 focus-within:ring-brand-100 dark:focus-within:ring-brand-900/30 focus-within:border-brand-400 transition-all">
          <textarea
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === 'Enter' && !e.shiftKey && !e.nativeEvent.isComposing) {
                e.preventDefault();
                handleSend();
              }
            }}
            placeholder="输入消息..."
            rows={1}
            className="flex-1 max-h-32 px-3 py-2 text-sm bg-transparent border-none outline-none resize-none placeholder-gray-400 dark:text-white"
            style={{ minHeight: '40px' }}
            onInput={(e) => {
              const target = e.target as HTMLTextAreaElement;
              target.style.height = 'auto';
              target.style.height = `${Math.min(target.scrollHeight, 128)}px`;
            }}
          />
          <button
            onClick={handleSend}
            disabled={sending || !inputValue.trim()}
            className="p-2 mb-0.5 bg-brand-500 hover:bg-brand-600 disabled:opacity-50 disabled:cursor-not-allowed text-white rounded-xl transition-all shadow-sm active:scale-95 flex-shrink-0"
          >
            {sending ? <Loader2 size={18} className="animate-spin" /> : <Send size={18} />}
          </button>
        </div>
      </div>
    </div>
  );
};
