import React from 'react';
import { CornerUpLeft, X } from 'lucide-react';

export interface ReplyMessage {
  messageId?: number;
  senderId?: number;
  senderName?: string;
  content?: string;
  type?: string;
}

export const getReplySummary = (message?: ReplyMessage | null): string => {
  if (!message) return '原消息不可见';
  const type = (message.type || 'TEXT').toUpperCase();
  if (type === 'IMAGE') return '图片消息';
  if (type === 'FILE') {
    const content = message.content || '';
    return content.includes('|') ? `文件：${content.split('|')[0] || '未知文件'}` : '文件消息';
  }
  if (type === 'CALL') return '通话记录';
  if (type === 'AUDIO') return '语音消息';
  if (type === 'VIDEO') return '视频消息';
  return message.content?.trim() || '空消息';
};

interface ReplyPreviewProps {
  message?: ReplyMessage | null;
  fallbackName?: string;
  onClick?: () => void;
  isSelf?: boolean;
  embedded?: boolean;
}

export const ReplyPreview: React.FC<ReplyPreviewProps> = ({
  message,
  fallbackName,
  onClick,
  isSelf = false,
  embedded = false,
}) => {
  const content = getReplySummary(message);
  const name = message ? (message.senderName || fallbackName || '未知用户') : '原消息';

  return (
    <button
      type="button"
      onClick={onClick}
      className={`${embedded ? 'mb-2 w-full' : 'mb-1.5 max-w-full'} text-left rounded-xl border px-3 py-2 transition-colors ${
        isSelf
          ? 'border-white/20 bg-white/[0.16] text-white/95 hover:bg-white/[0.22]'
          : 'border-gray-200 bg-gray-50 text-gray-700 hover:bg-gray-100 dark:border-gray-700 dark:bg-gray-900/50 dark:text-gray-200 dark:hover:bg-gray-900/70'
      }`}
    >
      <div className="flex min-w-0 items-center gap-2">
        <span
          className={`h-8 w-0.5 flex-shrink-0 rounded-full ${
            isSelf ? 'bg-white/65' : 'bg-brand-400 dark:bg-brand-500'
          }`}
        />
        <div className="min-w-0 flex-1">
          <div className={`flex items-center gap-1.5 text-[11px] font-semibold ${
            isSelf ? 'text-white/95' : 'text-gray-600 dark:text-gray-300'
          }`}>
            <CornerUpLeft size={12} className="flex-shrink-0 opacity-80" />
            <span className="truncate">{name}</span>
          </div>
          <p className={`mt-0.5 line-clamp-1 text-xs leading-5 ${
            isSelf ? 'text-white/80' : 'text-gray-500 dark:text-gray-400'
          }`}>
            {content}
          </p>
        </div>
      </div>
    </button>
  );
};

interface ReplyComposerBarProps {
  message: ReplyMessage;
  fallbackName?: string;
  onCancel: () => void;
}

export const ReplyComposerBar: React.FC<ReplyComposerBarProps> = ({ message, fallbackName, onCancel }) => (
  <div className="mb-2 flex items-center gap-2 rounded-xl border border-brand-100 dark:border-brand-900/40 bg-brand-50/80 dark:bg-brand-900/15 px-3 py-2">
    <CornerUpLeft size={16} className="text-brand-500 flex-shrink-0" />
    <div className="flex-1 min-w-0">
      <p className="text-xs font-medium text-brand-700 dark:text-brand-300 truncate">
        引用 {message.senderName || fallbackName || '未知用户'}
      </p>
      <p className="text-xs text-gray-500 dark:text-gray-400 truncate">{getReplySummary(message)}</p>
    </div>
    <button
      type="button"
      onClick={onCancel}
      className="p-1.5 rounded-lg text-gray-400 hover:text-gray-600 hover:bg-white/70 dark:hover:bg-gray-800 transition-colors"
      title="取消引用"
    >
      <X size={14} />
    </button>
  </div>
);
