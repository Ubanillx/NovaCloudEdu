import React from 'react';
import { Loader2, MessageCircle } from 'lucide-react';
import type { ChatSessionResponse } from '../../api/generated/models';
import { Avatar } from '../ui/Avatar';

interface SessionListProps {
  sessions: ChatSessionResponse[];
  loading: boolean;
  activePartnerId: number | null;
  onSelect: (session: ChatSessionResponse) => void;
}

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

const getCurrentUserId = (): string => {
  try {
    const stored = localStorage.getItem('user_info');
    if (stored) return String(JSON.parse(stored)?.id ?? '');
  } catch { /* ignore */ }
  return '';
};

const getSessionPreview = (session: ChatSessionResponse, currentUserId = getCurrentUserId()) => {
  const type = (session.lastMessageType || 'TEXT').toUpperCase();
  const prefix = currentUserId && String(session.lastMessageSenderId) === currentUserId ? '我：' : '';
  if (type === 'IMAGE') return `${prefix}[图片]`;
  if (type === 'FILE') {
    const content = session.lastMessage || '';
    return content.includes('|') ? `${prefix}[文件] ${content.split('|')[0] || '文件'}` : `${prefix}[文件]`;
  }
  if (type === 'AUDIO') return `${prefix}[语音]`;
  if (type === 'VIDEO') return `${prefix}[视频]`;
  if (type === 'CALL') return `${prefix}[通话]`;
  const text = session.lastMessage?.trim();
  return text ? `${prefix}${text}` : '暂无消息';
};

export const SessionList: React.FC<SessionListProps> = ({ sessions, loading, activePartnerId, onSelect }) => {
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
          key={session.partnerId}
          onClick={() => onSelect(session)}
          className={`w-full flex items-center gap-3 px-4 py-3 text-left transition-colors ${
            activePartnerId === session.partnerId
              ? 'bg-brand-50 dark:bg-brand-900/20 border-r-2 border-brand-500'
              : 'hover:bg-gray-50 dark:hover:bg-gray-800/50 border-r-2 border-transparent'
          }`}
        >
          <div className="relative">
            <Avatar src={session.partnerAvatar} name={session.partnerName} />
            {(session.unreadCount ?? 0) > 0 && (
              <span className="absolute -top-1 -right-1 inline-flex items-center justify-center min-w-[1.25rem] h-5 px-1 text-[10px] font-bold text-white bg-rose-500 rounded-full ring-2 ring-white dark:ring-gray-900">
                {session.unreadCount! > 99 ? '99+' : session.unreadCount}
              </span>
            )}
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center justify-between mb-0.5">
              <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
                {session.partnerName || '未知用户'}
              </p>
              <span className="text-[10px] text-gray-400 whitespace-nowrap ml-2">
                {formatTime(session.lastMessageTime)}
              </span>
            </div>
            <p className="text-xs text-gray-500 dark:text-gray-400 truncate">
              {getSessionPreview(session)}
            </p>
          </div>
        </button>
      ))}
    </div>
  );
};
