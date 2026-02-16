import React, { useState, useEffect, useCallback, useRef, useMemo } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import rehypeRaw from 'rehype-raw';
import {
  Bot, Plus, History, Trash2, Send, Square, Loader2,
  Sparkles, MessageSquarePlus, ChevronRight, Copy, Check,
  Image as ImageIcon, FileUp, X, ArrowDown,
} from 'lucide-react';
import { AIApi, Configuration, apiClient } from '../api';
import type { AiAssistantVO } from '../api/generated/models';
import { useAssistantChat } from '../hooks/useAssistantChat';
import type { AssistantChatSession } from '../hooks/useAssistantChat';
import toast from '../components/ui/Toast';

const aiApi = new AIApi(new Configuration(), '', apiClient);

// 当前用户信息（头像、昵称）
const getCurrentUserInfo = () => {
  try {
    const stored = localStorage.getItem('user_info');
    if (stored) {
      const parsed = JSON.parse(stored);
      return { avatar: parsed?.userAvatar || '', name: parsed?.userName || '' };
    }
  } catch { /* ignore */ }
  return { avatar: '', name: '' };
};

// ============ 工具函数 ============

const formatSessionTime = (dateStr?: string) => {
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
  return `${time.getMonth() + 1}/${time.getDate()}`;
};

// ============ 复制按钮（同 AiChatPanel） ============

const CopyButton: React.FC<{ text: string }> = ({ text }) => {
  const [copied, setCopied] = useState(false);
  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(text);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      toast.error('复制失败');
    }
  };
  return (
    <button
      onClick={handleCopy}
      className="p-1 rounded hover:bg-gray-200 dark:hover:bg-gray-700 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors"
      title="复制"
    >
      {copied ? <Check size={14} className="text-emerald-500" /> : <Copy size={14} />}
    </button>
  );
};

// ============ 会话列表侧边栏（复刻 AiChatPanel.SessionSidebar） ============

interface SessionSidebarProps {
  sessions: AssistantChatSession[];
  currentSessionId: string | null;
  isLoading: boolean;
  onSelect: (session: AssistantChatSession) => void;
  onDelete: (session: AssistantChatSession) => void;
  onNew: () => void;
  assistant: AiAssistantVO | null;
  assistants: AiAssistantVO[];
  assistantsLoading: boolean;
  selectedAssistantId?: string;
  onSelectAssistant: (a: AiAssistantVO) => void;
  showOverview: boolean;
  onShowOverview: () => void;
}

const SessionSidebar: React.FC<SessionSidebarProps> = ({
  sessions, currentSessionId, isLoading,
  onSelect, onDelete, onNew,
  assistant, assistants, assistantsLoading, selectedAssistantId, onSelectAssistant,
  showOverview, onShowOverview,
}) => {
  const [deletingId, setDeletingId] = useState<string | null>(null);

  const handleDelete = async (e: React.MouseEvent, session: AssistantChatSession) => {
    e.stopPropagation();
    setDeletingId(String(session.sessionId));
    await onDelete(session);
    setDeletingId(null);
  };

  return (
    <div className="w-72 flex-shrink-0 flex flex-col border-r border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-900/30">
      {/* 头部 */}
      <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <div className="flex items-center justify-between mb-2">
          <h3 className="text-sm font-semibold text-gray-900 dark:text-white">
            {assistant?.name || '智慧助手'}
          </h3>
          <button
            onClick={onNew}
            className="p-1.5 rounded-lg bg-brand-500 hover:bg-brand-600 text-white transition-colors shadow-sm"
            title="新建对话"
          >
            <Plus size={14} />
          </button>
        </div>
        {/* 助手切换入口 */}
        <button
          onClick={onShowOverview}
          className={`w-full flex items-center gap-2 px-3 py-2 text-sm rounded-lg transition-colors ${
            showOverview
              ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
              : 'text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800/50'
          }`}
        >
          <Sparkles size={15} />
          <span>智慧助手中心</span>
        </button>
      </div>

      {/* 助手快速切换列表 */}
      {!assistantsLoading && assistants.length > 1 && (
        <div className="px-2 py-2 border-b border-gray-100 dark:border-gray-800">
          <div className="space-y-0.5">
            {assistants.map(a => {
              const isActive = String(a.id) === selectedAssistantId;
              return (
                <button
                  key={String(a.id)}
                  onClick={() => onSelectAssistant(a)}
                  className={`w-full flex items-center gap-2 px-2.5 py-1.5 text-sm rounded-lg transition-all ${
                    isActive
                      ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300 font-medium'
                      : 'text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800/50'
                  }`}
                >
                  {a.avatarUrl ? (
                    <img src={a.avatarUrl} alt="" className="w-6 h-6 rounded-lg object-cover flex-shrink-0" />
                  ) : (
                    <div className={`w-6 h-6 rounded-lg flex-shrink-0 flex items-center justify-center text-[10px] font-bold ${
                      isActive ? 'bg-brand-500 text-white' : 'bg-brand-100 dark:bg-brand-900/50 text-brand-600 dark:text-brand-400'
                    }`}>
                      {a.name?.[0] || '?'}
                    </div>
                  )}
                  <span className="truncate text-xs">{a.name}</span>
                  {isActive && <div className="w-1.5 h-1.5 rounded-full bg-brand-500 ml-auto flex-shrink-0" />}
                </button>
              );
            })}
          </div>
        </div>
      )}

      {/* 会话列表 */}
      <div className="flex-1 overflow-y-auto custom-scrollbar">
        <div className="p-2">
          <p className="px-2 py-1 text-xs font-medium text-gray-400 dark:text-gray-500 flex items-center gap-1">
            <History size={12} />
            对话历史
          </p>
          {isLoading ? (
            <div className="flex items-center justify-center py-8 text-gray-400">
              <Loader2 size={20} className="animate-spin" />
            </div>
          ) : sessions.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-8 text-gray-400">
              <MessageSquarePlus size={28} className="mb-2 opacity-40" />
              <p className="text-xs">暂无对话</p>
            </div>
          ) : (
            <div className="space-y-0.5 mt-1">
              {sessions.map(session => {
                const isActive = !showOverview && String(session.sessionId) === currentSessionId;
                return (
                  <div
                    key={String(session.sessionId)}
                    onClick={() => onSelect(session)}
                    className={`group flex items-center gap-2 px-3 py-2.5 rounded-lg cursor-pointer transition-all ${
                      isActive
                        ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300 shadow-sm'
                        : 'text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800/50'
                    }`}
                  >
                    <Bot size={14} className={`flex-shrink-0 ${isActive ? 'text-brand-500' : 'text-gray-400'}`} />
                    <div className="flex-1 min-w-0">
                      <p className="text-sm truncate font-medium">
                        {session.title || '新对话'}
                      </p>
                      <p className="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5">
                        {formatSessionTime(session.updateTime || session.createTime)}
                        {session.messageCount > 0 && ` · ${session.messageCount} 条消息`}
                      </p>
                    </div>
                    <button
                      onClick={(e) => handleDelete(e, session)}
                      className={`p-1 rounded opacity-0 group-hover:opacity-100 transition-opacity ${
                        deletingId === String(session.sessionId)
                          ? 'opacity-100'
                          : 'hover:bg-red-50 dark:hover:bg-red-900/20 text-gray-400 hover:text-red-500'
                      }`}
                      title="删除"
                    >
                      {deletingId === String(session.sessionId)
                        ? <Loader2 size={13} className="animate-spin text-red-500" />
                        : <Trash2 size={13} />
                      }
                    </button>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

// ============ 智慧助手概览页（复刻 AiChatPanel.IntelligenceOverview） ============

interface OverviewProps {
  assistant: AiAssistantVO | null;
  assistants: AiAssistantVO[];
  onStartChat: () => void;
  onViewHistory: () => void;
  onSelectAssistant: (a: AiAssistantVO) => void;
}

const AssistantOverview: React.FC<OverviewProps> = ({
  assistant, assistants, onStartChat, onViewHistory, onSelectAssistant,
}) => (
  <div className="flex-1 overflow-y-auto custom-scrollbar">
    <div className="max-w-3xl mx-auto p-6 space-y-6">
      {/* 当前助手 Hero Card */}
      {assistant && (
        <div
          onClick={onStartChat}
          className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-brand-500 to-brand-600 p-6 cursor-pointer group shadow-lg shadow-brand-500/20 hover:shadow-brand-500/30 transition-all"
        >
          <div className="absolute -top-10 -right-10 w-40 h-40 bg-white/10 rounded-full blur-2xl" />
          <div className="absolute -bottom-10 -left-10 w-32 h-32 bg-brand-300/20 rounded-full blur-xl" />
          <div className="relative z-10 flex items-center gap-5">
            {assistant.avatarUrl ? (
              <img src={assistant.avatarUrl} alt="" className="w-16 h-16 rounded-2xl object-cover shadow-inner" />
            ) : (
              <div className="w-16 h-16 rounded-2xl bg-white/20 backdrop-blur-sm flex items-center justify-center shadow-inner">
                <Bot size={32} className="text-white" />
              </div>
            )}
            <div className="flex-1">
              <h2 className="text-xl font-bold text-white mb-1">{assistant.name}</h2>
              <p className="text-white/80 text-sm">{assistant.description || '智能问答 · 学习辅导 · 知识探索'}</p>
            </div>
            <div className="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center group-hover:bg-white/30 transition-colors">
              <ChevronRight size={20} className="text-white" />
            </div>
          </div>
        </div>
      )}

      {/* 快捷操作 */}
      <div className="grid grid-cols-2 gap-3">
        <button
          onClick={onViewHistory}
          className="flex items-center justify-center gap-2.5 px-4 py-4 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-700 hover:shadow-md transition-all group"
        >
          <History size={20} className="text-brand-500 group-hover:scale-110 transition-transform" />
          <span className="text-sm font-semibold text-gray-700 dark:text-gray-200">对话历史</span>
        </button>
        <button
          onClick={onStartChat}
          className="flex items-center justify-center gap-2.5 px-4 py-4 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-700 hover:shadow-md transition-all group"
        >
          <MessageSquarePlus size={20} className="text-brand-500 group-hover:scale-110 transition-transform" />
          <span className="text-sm font-semibold text-gray-700 dark:text-gray-200">新建对话</span>
        </button>
      </div>

      {/* 更多助手 */}
      {assistants.length > 1 && (
        <div>
          <div className="flex items-center justify-between mb-3">
            <h3 className="text-base font-bold text-gray-800 dark:text-gray-200">更多智慧助手</h3>
          </div>
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
            {assistants.map(a => (
              <div
                key={String(a.id)}
                onClick={() => onSelectAssistant(a)}
                className="flex flex-col items-center p-4 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 hover:shadow-md transition-all cursor-pointer"
              >
                {a.avatarUrl ? (
                  <img src={a.avatarUrl} alt="" className="w-12 h-12 rounded-full object-cover mb-2.5 ring-2 ring-brand-100 dark:ring-brand-800" />
                ) : (
                  <div className="w-12 h-12 rounded-full bg-brand-50 dark:bg-brand-900/30 flex items-center justify-center text-xl font-bold mb-2.5 ring-2 ring-brand-100 dark:ring-brand-800 text-brand-600 dark:text-brand-400">
                    {a.name?.[0] || '?'}
                  </div>
                )}
                <p className="text-sm font-semibold text-gray-800 dark:text-gray-200 text-center truncate w-full">
                  {a.name}
                </p>
                <p className="text-xs text-gray-400 text-center mt-1 line-clamp-2">{a.description || '暂无描述'}</p>
                <button className="mt-3 px-4 py-1.5 text-xs font-medium text-brand-500 bg-brand-50 dark:bg-brand-900/20 rounded-full hover:bg-brand-100 dark:hover:bg-brand-900/40 transition-colors">
                  开始对话
                </button>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  </div>
);

// ============ AI 对话区域（复刻 AiChatPanel.ChatArea） ============

interface ChatAreaProps {
  assistant: AiAssistantVO;
  messages: { role: 'user' | 'assistant'; content: string; isStreaming?: boolean }[];
  streamingContent: string;
  isLoading: boolean;
  isInitializing: boolean;
  ragStatus: string;
  onSend: (content: string) => void;
  onCancel: () => void;
  onNewSession: () => void;
}

const ChatArea: React.FC<ChatAreaProps> = ({
  assistant, messages, streamingContent, isLoading, isInitializing,
  ragStatus, onSend, onCancel, onNewSession,
}) => {
  const currentUser = useMemo(() => getCurrentUserInfo(), []);
  const [input, setInput] = useState('');
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const messagesContainerRef = useRef<HTMLDivElement>(null);
  const textareaRef = useRef<HTMLTextAreaElement>(null);
  const [showScrollBtn, setShowScrollBtn] = useState(false);
  const [pendingImages, setPendingImages] = useState<File[]>([]);
  const [pendingDocs, setPendingDocs] = useState<File[]>([]);
  const [isUploading, setIsUploading] = useState(false);
  const imageInputRef = useRef<HTMLInputElement>(null);
  const docInputRef = useRef<HTMLInputElement>(null);

  const scrollToBottom = useCallback(() => {
    const container = messagesContainerRef.current;
    if (container) {
      container.scrollTo({ top: container.scrollHeight, behavior: 'smooth' });
    }
  }, []);

  useEffect(() => { scrollToBottom(); }, [messages, streamingContent, scrollToBottom]);

  useEffect(() => {
    const container = messagesContainerRef.current;
    if (!container) return;
    const handleScroll = () => {
      const { scrollTop, scrollHeight, clientHeight } = container;
      setShowScrollBtn(scrollHeight - scrollTop - clientHeight > 100);
    };
    container.addEventListener('scroll', handleScroll);
    return () => container.removeEventListener('scroll', handleScroll);
  }, []);

  useEffect(() => {
    const el = textareaRef.current;
    if (el) {
      el.style.height = 'auto';
      el.style.height = Math.min(el.scrollHeight, 160) + 'px';
    }
  }, [input]);

  const handleSend = async () => {
    const content = input.trim();
    if (!content || isLoading) return;
    setInput('');
    if (textareaRef.current) textareaRef.current.style.height = 'auto';

    // 上传附件（如有）
    if (pendingImages.length > 0 || pendingDocs.length > 0) {
      setIsUploading(true);
      try {
        for (const img of pendingImages) {
          const formData = new FormData();
          formData.append('file', img);
          await apiClient.post('/api/file/upload/chat/ai', formData, {
            headers: { 'Content-Type': undefined },
          });
        }
        for (const doc of pendingDocs) {
          const formData = new FormData();
          formData.append('file', doc);
          await apiClient.post('/api/file/upload/chat/ai', formData, {
            headers: { 'Content-Type': undefined },
          });
        }
      } catch (e) {
        console.error('附件上传失败:', e);
        toast.error('附件上传失败');
      } finally {
        setIsUploading(false);
        setPendingImages([]);
        setPendingDocs([]);
      }
    }

    onSend(content);
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (e.key === 'Enter' && !e.shiftKey && !e.nativeEvent.isComposing) {
      e.preventDefault();
      handleSend();
    }
  };

  const removeImage = (index: number) => setPendingImages(prev => prev.filter((_, i) => i !== index));
  const removeDoc = (index: number) => setPendingDocs(prev => prev.filter((_, i) => i !== index));

  const allMessages = [
    ...messages,
    ...(streamingContent ? [{ role: 'assistant' as const, content: streamingContent, isStreaming: true }] : []),
  ];

  if (isInitializing) {
    return (
      <div className="flex-1 flex items-center justify-center">
        <div className="flex flex-col items-center gap-3 text-gray-400">
          <Loader2 size={28} className="animate-spin text-brand-500" />
          <span className="text-sm">正在加载对话...</span>
        </div>
      </div>
    );
  }

  return (
    <div className="flex-1 flex flex-col min-w-0">
      {/* 头部 */}
      <div className="flex items-center justify-between px-5 py-3 border-b border-gray-200/60 dark:border-gray-700/40 bg-white/80 dark:bg-gray-900/80 backdrop-blur-sm">
        <div className="flex items-center gap-2.5 min-w-0">
          {assistant.avatarUrl ? (
            <img src={assistant.avatarUrl} alt="" className="w-8 h-8 rounded-lg object-cover shadow-sm" />
          ) : (
            <div className="w-8 h-8 rounded-lg bg-brand-500 flex items-center justify-center shadow-sm">
              <Bot size={16} className="text-white" />
            </div>
          )}
          <div className="min-w-0">
            <h3 className="text-sm font-bold text-gray-800 dark:text-gray-200 truncate">{assistant.name}</h3>
            <p className="text-[11px] text-gray-400">AI 智能助手</p>
          </div>
        </div>
        <button
          onClick={onNewSession}
          className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/40 rounded-lg transition-colors"
          title="新对话"
        >
          <Plus size={14} />
          新对话
        </button>
      </div>

      {/* RAG 状态提示 */}
      {ragStatus === 'searching' && (
        <div className="flex items-center gap-2 px-5 py-2 bg-brand-50 dark:bg-brand-900/10 border-b border-brand-100 dark:border-brand-800/30">
          <Loader2 size={12} className="animate-spin text-brand-500" />
          <span className="text-[11px] text-brand-600 dark:text-brand-400">正在检索知识库...</span>
        </div>
      )}

      {/* 消息列表 */}
      <div ref={messagesContainerRef} className="flex-1 overflow-y-auto custom-scrollbar relative">
        {allMessages.length === 0 ? (
          /* 空状态 - 同通用AI */
          <div className="flex items-center justify-center h-full">
            <div className="text-center px-8 max-w-lg">
              {assistant.avatarUrl ? (
                <img src={assistant.avatarUrl} alt="" className="w-20 h-20 mx-auto mb-6 rounded-2xl object-cover shadow-lg shadow-brand-500/20" />
              ) : (
                <div className="w-20 h-20 mx-auto mb-6 rounded-2xl bg-brand-500 flex items-center justify-center shadow-lg shadow-brand-500/20">
                  <Bot size={40} className="text-white" />
                </div>
              )}
              <h2 className="text-xl font-bold text-gray-800 dark:text-gray-200 mb-2">
                你好，我是{assistant.name}
              </h2>
              <p className="text-gray-400 text-sm mb-6">
                {assistant.openingMessage || '有什么我可以帮助你的吗？'}
              </p>
            </div>
          </div>
        ) : (
          <div className="max-w-4xl mx-auto px-4 py-6 space-y-6">
            {allMessages.map((msg, index) => (
              <div key={index} className={`flex gap-3 ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
                {msg.role === 'assistant' && (
                  assistant.avatarUrl ? (
                    <img src={assistant.avatarUrl} alt="" className="w-8 h-8 rounded-lg object-cover flex-shrink-0 shadow-sm mt-0.5" />
                  ) : (
                    <div className="w-8 h-8 rounded-lg bg-brand-500 flex items-center justify-center flex-shrink-0 shadow-sm mt-0.5">
                      <Bot size={16} className="text-white" />
                    </div>
                  )
                )}
                <div className="max-w-[75%]">
                  <div className={`rounded-2xl px-4 py-3 ${
                    msg.role === 'user'
                      ? 'bg-brand-500 text-white rounded-tr-sm'
                      : 'bg-white dark:bg-gray-800 text-gray-800 dark:text-gray-200 rounded-tl-sm border border-gray-100 dark:border-gray-700 shadow-sm'
                  }`}>
                    {msg.role === 'user' ? (
                      <p className="text-sm leading-relaxed whitespace-pre-wrap">{msg.content}</p>
                    ) : (
                      <div className="prose prose-sm dark:prose-invert max-w-none prose-p:my-1 prose-pre:my-2 prose-headings:my-2 prose-ul:my-1 prose-ol:my-1 prose-li:my-0.5 prose-code:text-brand-600 dark:prose-code:text-brand-400 prose-code:bg-brand-50 dark:prose-code:bg-brand-900/30 prose-code:px-1 prose-code:py-0.5 prose-code:rounded prose-code:before:content-none prose-code:after:content-none">
                        <ReactMarkdown
                          remarkPlugins={[remarkGfm]}
                          rehypePlugins={[rehypeRaw]}
                          components={{
                            video: (props: React.ComponentProps<'video'>) => (
                              <video
                                {...props}
                                controls
                                className="rounded-xl border border-gray-200 dark:border-gray-700 shadow-md max-w-full not-prose"
                                style={{ maxHeight: 320, maxWidth: '100%', borderRadius: 12 }}
                              />
                            ),
                            a: ({ children, href, ...rest }: React.ComponentProps<'a'>) => {
                              const text = typeof children === 'string' ? children : '';
                              if (text === '点击播放 AI 生成视频' && href) {
                                return (
                                  <video
                                    controls
                                    src={href}
                                    className="rounded-xl border border-gray-200 dark:border-gray-700 shadow-md max-w-full not-prose"
                                    style={{ maxHeight: 320, maxWidth: '100%', borderRadius: 12 }}
                                  />
                                );
                              }
                              return <a href={href} {...rest} target="_blank" rel="noopener noreferrer">{children}</a>;
                            },
                          }}
                        >
                          {msg.content}
                        </ReactMarkdown>
                        {msg.isStreaming && (
                          <span className="inline-block w-2 h-4 bg-brand-500 animate-pulse rounded-sm ml-0.5 align-middle" />
                        )}
                      </div>
                    )}
                  </div>
                  {msg.role === 'assistant' && !msg.isStreaming && (
                    <div className="flex items-center gap-1 mt-1 ml-1">
                      <CopyButton text={msg.content} />
                    </div>
                  )}
                </div>
                {msg.role === 'user' && (
                  currentUser.avatar ? (
                    <img
                      src={currentUser.avatar}
                      alt={currentUser.name || '我'}
                      className="w-8 h-8 rounded-lg object-cover flex-shrink-0 shadow-sm mt-0.5"
                    />
                  ) : (
                    <div className="w-8 h-8 rounded-lg bg-gray-200 dark:bg-gray-700 flex items-center justify-center flex-shrink-0 shadow-sm mt-0.5">
                      <span className="text-xs font-bold text-gray-600 dark:text-gray-300">{currentUser.name?.[0] || '我'}</span>
                    </div>
                  )
                )}
              </div>
            ))}
            <div ref={messagesEndRef} />
          </div>
        )}

        {showScrollBtn && (
          <button
            onClick={scrollToBottom}
            className="absolute bottom-4 right-4 p-2 rounded-full bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 shadow-lg hover:shadow-xl transition-all text-gray-500 hover:text-brand-500"
          >
            <ArrowDown size={18} />
          </button>
        )}
      </div>

      {/* 输入区域 */}
      <div className="border-t border-gray-200/60 dark:border-gray-700/40 bg-white/80 dark:bg-gray-900/80 backdrop-blur-sm">
        {/* 附件预览 */}
        {(pendingImages.length > 0 || pendingDocs.length > 0) && (
          <div className="px-4 pt-3 flex flex-wrap gap-2">
            {pendingImages.map((img, i) => (
              <div key={i} className="relative group">
                <img
                  src={URL.createObjectURL(img)}
                  alt={img.name}
                  className="w-20 h-20 object-cover rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm"
                />
                <button
                  onClick={() => removeImage(i)}
                  className="absolute -top-1.5 -right-1.5 w-5 h-5 rounded-full bg-red-500 text-white flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity shadow-sm"
                >
                  <X size={10} />
                </button>
              </div>
            ))}
            {pendingDocs.map((doc, i) => (
              <div key={i} className="relative group flex items-center gap-2 px-3 py-2 bg-gray-50 dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm">
                <FileUp size={16} className="text-gray-400" />
                <span className="text-xs text-gray-600 dark:text-gray-300 truncate max-w-[120px]">{doc.name}</span>
                <button
                  onClick={() => removeDoc(i)}
                  className="p-0.5 rounded text-gray-400 hover:text-red-500 transition-colors"
                >
                  <X size={12} />
                </button>
              </div>
            ))}
          </div>
        )}

        <div className="p-3 flex items-end gap-2">
          {/* 附件按钮 */}
          <div className="flex items-center gap-1 pb-1">
            <button
              onClick={() => imageInputRef.current?.click()}
              className="p-2 rounded-lg text-gray-400 hover:text-brand-500 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
              title="上传图片"
            >
              <ImageIcon size={18} />
            </button>
            <button
              onClick={() => docInputRef.current?.click()}
              className="p-2 rounded-lg text-gray-400 hover:text-brand-500 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
              title="上传文档"
            >
              <FileUp size={18} />
            </button>
          </div>

          {/* 隐藏的 file input */}
          <input
            ref={imageInputRef}
            type="file"
            accept="image/*"
            multiple
            className="hidden"
            onChange={e => {
              if (e.target.files) {
                setPendingImages(prev => [...prev, ...Array.from(e.target.files!)].slice(0, 3));
              }
              e.target.value = '';
            }}
          />
          <input
            ref={docInputRef}
            type="file"
            accept=".pdf,.docx,.txt,.md,.csv,.html,.json,.xml,.epub"
            className="hidden"
            onChange={e => {
              if (e.target.files) {
                setPendingDocs(prev => [...prev, ...Array.from(e.target.files!)].slice(0, 3));
              }
              e.target.value = '';
            }}
          />

          {/* 输入框 */}
          <div className="flex-1 relative">
            <textarea
              ref={textareaRef}
              value={input}
              onChange={e => setInput(e.target.value)}
              onKeyDown={handleKeyDown}
              placeholder="输入消息，Shift+Enter 换行..."
              rows={1}
              disabled={isLoading || isUploading}
              className="w-full px-4 py-2.5 text-sm bg-gray-50 dark:bg-gray-800/80 border border-gray-200 dark:border-gray-700 rounded-xl outline-none focus:border-brand-400 focus:ring-2 focus:ring-brand-100 dark:focus:ring-brand-900/30 resize-none transition-all disabled:opacity-50 text-gray-800 dark:text-gray-200 placeholder-gray-400"
              style={{ maxHeight: 160, minHeight: 40 }}
            />
          </div>

          {/* 发送/停止按钮 */}
          <div className="pb-0.5">
            {isLoading ? (
              <button
                onClick={onCancel}
                className="p-2.5 rounded-xl bg-red-500 hover:bg-red-600 text-white transition-colors shadow-sm"
                title="停止生成"
              >
                <Square size={16} fill="currentColor" />
              </button>
            ) : (
              <button
                onClick={handleSend}
                disabled={!input.trim() || isUploading}
                className="p-2.5 rounded-xl bg-brand-500 hover:bg-brand-600 disabled:opacity-40 disabled:cursor-not-allowed text-white transition-colors shadow-sm"
                title="发送"
              >
                {isUploading ? <Loader2 size={16} className="animate-spin" /> : <Send size={16} />}
              </button>
            )}
          </div>
        </div>

        <p className="px-4 pb-2 text-[11px] text-gray-400 text-center">
          AI 助手可能会犯错，请核实重要信息
        </p>
      </div>
    </div>
  );
};

// ============ 主页面 ============

const AiAssistantChatPage: React.FC = () => {
  const { assistantId } = useParams<{ assistantId?: string }>();
  const navigate = useNavigate();

  const [assistants, setAssistants] = useState<AiAssistantVO[]>([]);
  const [assistantsLoading, setAssistantsLoading] = useState(true);
  const [selectedAssistant, setSelectedAssistant] = useState<AiAssistantVO | null>(null);
  const [showOverview, setShowOverview] = useState(!assistantId);

  const {
    sessions, messages, currentSessionId, isLoading,
    isLoadingSessions, isInitializing, streamingContent, ragStatus,
    loadSessions, loadSessionDetail, deleteSession, startNewSession,
    sendMessage, cancelStream, refreshSessionTitle,
  } = useAssistantChat(assistantId);

  const hasInitRef = useRef(false);

  // 加载公开助手列表
  useEffect(() => {
    let mounted = true;
    setAssistantsLoading(true);
    aiApi.assistantListPublic({ page: 0, size: 20 })
      .then(res => {
        if (!mounted) return;
        if (res.data?.code === 0 && Array.isArray(res.data.data)) {
          setAssistants(res.data.data);
          if (assistantId) {
            const found = res.data.data.find((a: AiAssistantVO) => String(a.id) === assistantId);
            if (found) setSelectedAssistant(found);
          }
        }
      })
      .catch(err => console.error('获取助手列表失败:', err))
      .finally(() => { if (mounted) setAssistantsLoading(false); });
    return () => { mounted = false; };
  }, [assistantId]);

  // 加载会话列表
  useEffect(() => {
    if (assistantId && !hasInitRef.current) {
      hasInitRef.current = true;
      loadSessions();
    }
  }, [assistantId, loadSessions]);

  // assistantId 变化时重置
  useEffect(() => {
    hasInitRef.current = false;
  }, [assistantId]);

  // 消息数 ≤ 4 时自动刷新标题
  useEffect(() => {
    if (messages.length > 0 && messages.length <= 4 && !isLoading) {
      refreshSessionTitle();
      loadSessions();
    }
  }, [messages.length, isLoading, refreshSessionTitle, loadSessions]);

  const handleSelectAssistant = useCallback((assistant: AiAssistantVO) => {
    setSelectedAssistant(assistant);
    setShowOverview(false);
    navigate(`/ai-chat/${String(assistant.id)}`, { replace: true });
  }, [navigate]);

  const handleSelectSession = useCallback(async (session: AssistantChatSession) => {
    setShowOverview(false);
    await loadSessionDetail(String(session.sessionId));
  }, [loadSessionDetail]);

  const handleDeleteSession = useCallback(async (session: AssistantChatSession) => {
    const success = await deleteSession(String(session.sessionId));
    if (success) {
      toast.success('已删除');
      loadSessions();
    } else {
      toast.error('删除失败');
    }
  }, [deleteSession, loadSessions]);

  const handleNewSession = useCallback(() => {
    startNewSession();
    setShowOverview(false);
  }, [startNewSession]);

  const handleSend = useCallback((content: string) => {
    sendMessage(content);
  }, [sendMessage]);

  return (
    <div className="flex h-[calc(100vh-7.5rem)] bg-white/50 dark:bg-gray-900/50 backdrop-blur-sm rounded-2xl ring-1 ring-gray-200/40 dark:ring-gray-700/30 overflow-hidden">
      {/* 左侧会话列表 */}
      <SessionSidebar
        sessions={sessions}
        currentSessionId={currentSessionId}
        isLoading={isLoadingSessions}
        onSelect={handleSelectSession}
        onDelete={handleDeleteSession}
        onNew={handleNewSession}
        assistant={selectedAssistant}
        assistants={assistants}
        assistantsLoading={assistantsLoading}
        selectedAssistantId={assistantId}
        onSelectAssistant={handleSelectAssistant}
        showOverview={showOverview}
        onShowOverview={() => setShowOverview(true)}
      />

      {/* 右侧内容区 */}
      {showOverview ? (
        <AssistantOverview
          assistant={selectedAssistant}
          assistants={assistants}
          onStartChat={handleNewSession}
          onViewHistory={() => setShowOverview(false)}
          onSelectAssistant={handleSelectAssistant}
        />
      ) : selectedAssistant ? (
        <ChatArea
          assistant={selectedAssistant}
          messages={messages}
          streamingContent={streamingContent}
          isLoading={isLoading}
          isInitializing={isInitializing}
          ragStatus={ragStatus}
          onSend={handleSend}
          onCancel={cancelStream}
          onNewSession={handleNewSession}
        />
      ) : (
        <AssistantOverview
          assistant={null}
          assistants={assistants}
          onStartChat={handleNewSession}
          onViewHistory={() => setShowOverview(false)}
          onSelectAssistant={handleSelectAssistant}
        />
      )}
    </div>
  );
};

export default AiAssistantChatPage;
