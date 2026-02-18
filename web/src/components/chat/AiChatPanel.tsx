import React, { useState, useEffect, useCallback, useRef, useMemo } from 'react';
import {
  Bot, Plus, History, Trash2, Send, Square, Loader2,
  Sparkles, MessageSquarePlus, ChevronRight, Copy, Check,
  Image as ImageIcon, FileUp, X, ArrowDown, Palette, Video,
  FileText, FileCode, FileSpreadsheet, Globe, Braces, BookOpen, Paperclip, ChevronLeft,
} from 'lucide-react';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import rehypeRaw from 'rehype-raw';
import { useAiChat } from './useAiChat';
import type { AiChatSession, ImageGeneration, VideoGeneration } from './useAiChat';
import { apiClient, AIApi, Configuration } from '../../api';
import type { AiAssistantVO } from '../../api/generated/models';
import toast from '../ui/Toast';

const aiApi = new AIApi(new Configuration(), '', apiClient);

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

// ============ 快捷提示 ============

const QUICK_PROMPTS = [
  '帮我解释一道数学题',
  '英语语法有什么技巧？',
  '帮我制定学习计划',
  '推荐一些学习方法',
  '写一篇作文给我参考',
  '帮我梳理知识点',
];

// ============ 智慧体卡片数据（已废弃，改用后端真实数据） ============

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

// ============ 复制按钮 ============

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

// ============ 会话列表侧边栏 ============

interface SessionSidebarProps {
  sessions: AiChatSession[];
  currentSessionId: number | null;
  isLoading: boolean;
  onSelect: (session: AiChatSession) => void;
  onDelete: (session: AiChatSession) => void;
  onNew: () => void;
  showOverview: boolean;
  onShowOverview: () => void;
}

const SessionSidebar: React.FC<SessionSidebarProps> = ({
  sessions, currentSessionId, isLoading,
  onSelect, onDelete, onNew, showOverview, onShowOverview,
}) => {
  const [deletingId, setDeletingId] = useState<number | null>(null);

  const handleDelete = async (e: React.MouseEvent, session: AiChatSession) => {
    e.stopPropagation();
    setDeletingId(session.sessionId);
    await onDelete(session);
    setDeletingId(null);
  };

  return (
    <div className="w-72 flex-shrink-0 flex flex-col border-r border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-900/30">
      {/* 头部 */}
      <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800">
        <div className="flex items-center justify-between mb-2">
          <h3 className="text-sm font-semibold text-gray-900 dark:text-white">智慧体</h3>
          <button
            onClick={onNew}
            className="p-1.5 rounded-lg bg-brand-500 hover:bg-brand-600 text-white transition-colors shadow-sm"
            title="新建对话"
          >
            <Plus size={14} />
          </button>
        </div>
        {/* 概览入口 */}
        <button
          onClick={onShowOverview}
          className={`w-full flex items-center gap-2 px-3 py-2 text-sm rounded-lg transition-colors ${
            showOverview
              ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 font-medium'
              : 'text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800/50'
          }`}
        >
          <Sparkles size={15} />
          <span>智慧体中心</span>
        </button>
      </div>

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
                const isActive = !showOverview && String(session.sessionId) === String(currentSessionId);
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
                        String(deletingId) === String(session.sessionId)
                          ? 'opacity-100'
                          : 'hover:bg-red-50 dark:hover:bg-red-900/20 text-gray-400 hover:text-red-500'
                      }`}
                      title="删除"
                    >
                      {String(deletingId) === String(session.sessionId)
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

// ============ 智慧体概览页 ============

interface OverviewProps {
  onStartChat: () => void;
  onViewHistory: () => void;
  assistants: AiAssistantVO[];
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
  isLoadingMore: boolean;
  onSelectAssistant: (assistant: AiAssistantVO) => void;
}

const IntelligenceOverview: React.FC<OverviewProps> = ({ 
  onStartChat, onViewHistory, assistants, currentPage, totalPages, onPageChange, isLoadingMore, onSelectAssistant 
}) => {
  return (
    <div className="flex-1 overflow-y-auto custom-scrollbar">
      <div className="max-w-3xl mx-auto p-6 space-y-6">
        {/* 通用 AI 助手入口 - Hero Card */}
        <div
          onClick={onStartChat}
          className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-brand-500 to-brand-600 p-6 cursor-pointer group shadow-lg shadow-brand-500/20 hover:shadow-brand-500/30 transition-all"
        >
          <div className="absolute -top-10 -right-10 w-40 h-40 bg-white/10 rounded-full blur-2xl" />
          <div className="absolute -bottom-10 -left-10 w-32 h-32 bg-brand-300/20 rounded-full blur-xl" />
          <div className="relative z-10 flex items-center gap-5">
            <div className="w-16 h-16 rounded-2xl bg-white/20 backdrop-blur-sm flex items-center justify-center shadow-inner">
              <Bot size={32} className="text-white" />
            </div>
            <div className="flex-1">
              <h2 className="text-xl font-bold text-white mb-1">通用 AI 助手</h2>
              <p className="text-white/80 text-sm">智能问答 · 学习辅导 · 知识探索</p>
            </div>
            <div className="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center group-hover:bg-white/30 transition-colors">
              <ChevronRight size={20} className="text-white" />
            </div>
          </div>
        </div>

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

        {/* 智慧体列表 */}
        {assistants.length > 0 && (
          <div>
            <div className="flex items-center justify-between mb-3">
              <h3 className="text-base font-bold text-gray-800 dark:text-gray-200">智慧助手</h3>
              <div className="text-xs text-gray-400">
                第 {currentPage + 1} 页 / 共 {totalPages} 页
              </div>
            </div>
            
            {isLoadingMore ? (
              <div className="flex items-center justify-center py-12">
                <Loader2 size={24} className="animate-spin text-brand-500" />
              </div>
            ) : (
              <>
                <div className="grid grid-cols-2 lg:grid-cols-3 gap-3">
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
                
                {/* 分页控件 */}
                {totalPages > 1 && (
                  <div className="flex items-center justify-center gap-2 mt-6">
                    <button
                      onClick={() => onPageChange(currentPage - 1)}
                      disabled={currentPage === 0}
                      className="p-2 rounded-lg border border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                      title="上一页"
                    >
                      <ChevronLeft size={16} className="text-gray-600 dark:text-gray-400" />
                    </button>
                    
                    <div className="flex items-center gap-1">
                      {Array.from({ length: totalPages }, (_, i) => (
                        <button
                          key={i}
                          onClick={() => onPageChange(i)}
                          className={`w-8 h-8 rounded-lg text-sm font-medium transition-all ${
                            i === currentPage
                              ? 'bg-brand-500 text-white shadow-sm'
                              : 'text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800'
                          }`}
                        >
                          {i + 1}
                        </button>
                      ))}
                    </div>
                    
                    <button
                      onClick={() => onPageChange(currentPage + 1)}
                      disabled={currentPage >= totalPages - 1}
                      className="p-2 rounded-lg border border-gray-200 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                      title="下一页"
                    >
                      <ChevronRight size={16} className="text-gray-600 dark:text-gray-400" />
                    </button>
                  </div>
                )}
              </>
            )}
          </div>
        )}
      </div>
    </div>
  );
};

// ============ 附件工具函数 ============

const getFileNameFromUrl = (url: string): string => {
  try {
    const path = new URL(url).pathname;
    const name = decodeURIComponent(path.split('/').pop() || '');
    return name || '未命名文件';
  } catch {
    const parts = url.split('/');
    return decodeURIComponent(parts[parts.length - 1] || '未命名文件');
  }
};

const getFileExtension = (name: string): string => {
  const ext = name.split('.').pop()?.toLowerCase() || '';
  return ext;
};

const FILE_TYPE_MAP: Record<string, { Icon: React.ElementType; color: string; label: string }> = {
  pdf: { Icon: FileText, color: 'text-red-500 bg-red-50 dark:bg-red-900/20', label: 'PDF' },
  docx: { Icon: FileText, color: 'text-blue-500 bg-blue-50 dark:bg-blue-900/20', label: 'Word' },
  doc: { Icon: FileText, color: 'text-blue-500 bg-blue-50 dark:bg-blue-900/20', label: 'Word' },
  txt: { Icon: FileText, color: 'text-gray-500 bg-gray-50 dark:bg-gray-800', label: 'TXT' },
  md: { Icon: FileCode, color: 'text-gray-500 bg-gray-50 dark:bg-gray-800', label: 'Markdown' },
  csv: { Icon: FileSpreadsheet, color: 'text-green-500 bg-green-50 dark:bg-green-900/20', label: 'CSV' },
  html: { Icon: Globe, color: 'text-orange-500 bg-orange-50 dark:bg-orange-900/20', label: 'HTML' },
  json: { Icon: Braces, color: 'text-yellow-600 bg-yellow-50 dark:bg-yellow-900/20', label: 'JSON' },
  xml: { Icon: FileCode, color: 'text-yellow-600 bg-yellow-50 dark:bg-yellow-900/20', label: 'XML' },
  epub: { Icon: BookOpen, color: 'text-purple-500 bg-purple-50 dark:bg-purple-900/20', label: 'ePub' },
};

const DEFAULT_FILE_TYPE = { Icon: Paperclip, color: 'text-gray-500 bg-gray-50 dark:bg-gray-800' };

const getFileTypeInfo = (name: string) => {
  const ext = getFileExtension(name);
  return FILE_TYPE_MAP[ext] || { ...DEFAULT_FILE_TYPE, label: ext.toUpperCase() || '文件' };
};

const IMAGE_EXTENSIONS = new Set(['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'svg', 'ico', 'heic', 'heif', 'avif']);

/** 通过 URL 扩展名判断是否为图片 */
const isImageUrl = (url: string): boolean => {
  // 去掉 doc: 前缀和查询参数
  const clean = url.replace(/^doc:/, '').split('?')[0].split('#')[0];
  const ext = clean.split('.').pop()?.toLowerCase() || '';
  return IMAGE_EXTENSIONS.has(ext);
};

/** 解析附件列表，智能区分图片和文档 */
const classifyAttachments = (attachments: string[]) => {
  const images: string[] = [];
  const docs: string[] = [];
  for (const a of attachments) {
    const url = a.startsWith('doc:') ? a.slice(4) : a;
    if (isImageUrl(url)) {
      images.push(url);
    } else {
      docs.push(url);
    }
  }
  return { images, docs };
};

/** 已发送消息中的图片附件 */
const ImageAttachment: React.FC<{ url: string }> = ({ url }) => (
  <a href={url} target="_blank" rel="noopener noreferrer" className="block">
    <img
      src={url}
      alt="图片"
      className="max-w-[200px] max-h-[160px] object-cover rounded-xl border border-gray-200 dark:border-gray-700 hover:opacity-90 transition-opacity cursor-pointer shadow-sm"
      loading="lazy"
    />
  </a>
);

/** 已发送消息中的文档附件 */
const DocAttachment: React.FC<{ url: string }> = ({ url }) => {
  const fileName = getFileNameFromUrl(url);
  const typeInfo = getFileTypeInfo(fileName);
  return (
    <a
      href={url}
      target="_blank"
      rel="noopener noreferrer"
      className="flex items-center gap-2.5 px-3 py-2.5 rounded-xl border border-gray-200 dark:border-gray-700 bg-white/80 dark:bg-gray-800/80 hover:bg-gray-50 dark:hover:bg-gray-700/80 transition-colors shadow-sm max-w-[260px] group"
    >
      <div className={`w-9 h-9 rounded-lg flex items-center justify-center flex-shrink-0 ${typeInfo.color}`}>
        <typeInfo.Icon size={18} />
      </div>
      <div className="min-w-0 flex-1">
        <p className="text-xs font-medium text-gray-700 dark:text-gray-300 truncate group-hover:text-brand-500 transition-colors">
          {fileName}
        </p>
        <p className="text-[10px] text-gray-400 mt-0.5">{typeInfo.label} 文件</p>
      </div>
    </a>
  );
};

/** 待发送的图片预览 */
const PendingImagePreview: React.FC<{ file: File; onRemove: () => void }> = ({ file, onRemove }) => (
  <div className="relative group">
    <img
      src={URL.createObjectURL(file)}
      alt={file.name}
      className="w-20 h-20 object-cover rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm"
    />
    <div className="absolute inset-0 bg-black/0 group-hover:bg-black/10 rounded-xl transition-colors" />
    <button
      onClick={onRemove}
      className="absolute -top-1.5 -right-1.5 w-5 h-5 rounded-full bg-red-500 text-white flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity shadow-sm"
    >
      <X size={10} />
    </button>
    <span className="absolute bottom-1 left-1 right-1 text-[9px] text-white bg-black/50 backdrop-blur-sm rounded px-1 py-0.5 truncate opacity-0 group-hover:opacity-100 transition-opacity">
      {file.name}
    </span>
  </div>
);

/** 待发送的文档预览 */
const PendingDocPreview: React.FC<{ file: File; onRemove: () => void }> = ({ file, onRemove }) => {
  const typeInfo = getFileTypeInfo(file.name);
  const sizeStr = file.size < 1024 ? `${file.size} B`
    : file.size < 1024 * 1024 ? `${(file.size / 1024).toFixed(1)} KB`
    : `${(file.size / (1024 * 1024)).toFixed(1)} MB`;
  return (
    <div className="relative group flex items-center gap-2.5 px-3 py-2.5 bg-gray-50 dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm">
      <div className={`w-8 h-8 rounded-lg flex items-center justify-center flex-shrink-0 ${typeInfo.color}`}>
        <typeInfo.Icon size={16} />
      </div>
      <div className="min-w-0">
        <p className="text-xs font-medium text-gray-700 dark:text-gray-300 truncate max-w-[130px]">{file.name}</p>
        <p className="text-[10px] text-gray-400">{typeInfo.label} · {sizeStr}</p>
      </div>
      <button
        onClick={onRemove}
        className="ml-1 p-0.5 rounded text-gray-400 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors"
      >
        <X size={12} />
      </button>
    </div>
  );
};

// ============ 文生图状态卡片 ============

const ImageGenerationCard: React.FC<{ generation: ImageGeneration }> = ({ generation }) => {
  const [expanded, setExpanded] = useState(false);

  if (generation.status === 'generating') {
    return (
      <div className="max-w-sm">
        <button
          onClick={() => setExpanded(v => !v)}
          className="w-full flex items-center gap-3 px-4 py-3 bg-brand-50 dark:bg-brand-900/20 rounded-xl border border-brand-100 dark:border-brand-800/40 animate-pulse text-left"
        >
          <div className="w-8 h-8 rounded-lg bg-brand-100 dark:bg-brand-800/40 flex items-center justify-center flex-shrink-0">
            <Palette size={16} className="text-brand-500 animate-spin" style={{ animationDuration: '3s' }} />
          </div>
          <p className="text-xs font-medium text-brand-700 dark:text-brand-300 flex-1">正在生成图片...</p>
          <ChevronRight size={14} className={`text-brand-400 transition-transform ${expanded ? 'rotate-90' : ''}`} />
        </button>
        {expanded && (
          <p className="text-[11px] text-brand-500/70 dark:text-brand-400/60 mt-1.5 px-2 break-all">{generation.prompt}</p>
        )}
      </div>
    );
  }

  if (generation.status === 'done' && generation.url) {
    return (
      <div className="max-w-sm">
        <a href={generation.url} target="_blank" rel="noopener noreferrer" className="block group">
          <img
            src={generation.url}
            alt={`AI生成: ${generation.prompt}`}
            className="rounded-xl border border-gray-200 dark:border-gray-700 shadow-md hover:shadow-lg transition-shadow max-w-full"
            loading="lazy"
          />
        </a>
        <button onClick={() => setExpanded(v => !v)} className="flex items-center gap-1 mt-1.5 px-1 text-[11px] text-gray-400 hover:text-gray-500 transition-colors">
          <Palette size={10} />
          <span>图片提示词</span>
          <ChevronRight size={10} className={`transition-transform ${expanded ? 'rotate-90' : ''}`} />
        </button>
        {expanded && (
          <p className="text-[11px] text-gray-400 mt-1 px-1 break-all">{generation.prompt}</p>
        )}
      </div>
    );
  }

  if (generation.status === 'error') {
    return (
      <div className="max-w-sm">
        <button
          onClick={() => setExpanded(v => !v)}
          className="w-full flex items-center gap-3 px-4 py-3 bg-red-50 dark:bg-red-900/20 rounded-xl border border-red-100 dark:border-red-800/40 text-left"
        >
          <div className="w-8 h-8 rounded-lg bg-red-100 dark:bg-red-800/30 flex items-center justify-center flex-shrink-0">
            <Palette size={16} className="text-red-500" />
          </div>
          <div className="min-w-0 flex-1">
            <p className="text-xs font-medium text-red-700 dark:text-red-300">图片生成失败</p>
            <p className="text-[11px] text-red-500/70 dark:text-red-400/60 truncate">{generation.error || '未知错误'}</p>
          </div>
          <ChevronRight size={14} className={`text-red-400 transition-transform ${expanded ? 'rotate-90' : ''}`} />
        </button>
        {expanded && (
          <p className="text-[11px] text-gray-400 mt-1.5 px-2 break-all">{generation.prompt}</p>
        )}
      </div>
    );
  }

  return null;
};

// ============ 文生视频状态卡片 ============

const VideoGenerationCard: React.FC<{ generation: VideoGeneration }> = ({ generation }) => {
  const [expanded, setExpanded] = useState(false);

  if (generation.status === 'generating') {
    return (
      <div className="max-w-sm">
        <button
          onClick={() => setExpanded(v => !v)}
          className="w-full flex items-center gap-3 px-4 py-3 bg-purple-50 dark:bg-purple-900/20 rounded-xl border border-purple-100 dark:border-purple-800/40 animate-pulse text-left"
        >
          <div className="w-8 h-8 rounded-lg bg-purple-100 dark:bg-purple-800/40 flex items-center justify-center flex-shrink-0">
            <Video size={16} className="text-purple-500 animate-spin" style={{ animationDuration: '3s' }} />
          </div>
          <p className="text-xs font-medium text-purple-700 dark:text-purple-300 flex-1">正在生成视频...</p>
          <ChevronRight size={14} className={`text-purple-400 transition-transform ${expanded ? 'rotate-90' : ''}`} />
        </button>
        {expanded && (
          <p className="text-[11px] text-purple-500/70 dark:text-purple-400/60 mt-1.5 px-2 break-all">{generation.prompt}</p>
        )}
      </div>
    );
  }

  if (generation.status === 'done' && generation.url) {
    return (
      <div className="max-w-sm">
        <video
          controls
          src={generation.url}
          className="rounded-xl border border-gray-200 dark:border-gray-700 shadow-md max-w-full"
          style={{ maxHeight: 320 }}
        />
        <button onClick={() => setExpanded(v => !v)} className="flex items-center gap-1 mt-1.5 px-1 text-[11px] text-gray-400 hover:text-gray-500 transition-colors">
          <Video size={10} />
          <span>视频提示词</span>
          <ChevronRight size={10} className={`transition-transform ${expanded ? 'rotate-90' : ''}`} />
        </button>
        {expanded && (
          <p className="text-[11px] text-gray-400 mt-1 px-1 break-all">{generation.prompt}</p>
        )}
      </div>
    );
  }

  if (generation.status === 'error') {
    return (
      <div className="max-w-sm">
        <button
          onClick={() => setExpanded(v => !v)}
          className="w-full flex items-center gap-3 px-4 py-3 bg-red-50 dark:bg-red-900/20 rounded-xl border border-red-100 dark:border-red-800/40 text-left"
        >
          <div className="w-8 h-8 rounded-lg bg-red-100 dark:bg-red-800/30 flex items-center justify-center flex-shrink-0">
            <Video size={16} className="text-red-500" />
          </div>
          <div className="min-w-0 flex-1">
            <p className="text-xs font-medium text-red-700 dark:text-red-300">视频生成失败</p>
            <p className="text-[11px] text-red-500/70 dark:text-red-400/60 truncate">{generation.error || '未知错误'}</p>
          </div>
          <ChevronRight size={14} className={`text-red-400 transition-transform ${expanded ? 'rotate-90' : ''}`} />
        </button>
        {expanded && (
          <p className="text-[11px] text-gray-400 mt-1.5 px-2 break-all">{generation.prompt}</p>
        )}
      </div>
    );
  }

  return null;
};

// ============ AI 对话区域 ============

interface ChatAreaProps {
  messages: { role: 'user' | 'assistant'; content: string; isStreaming?: boolean; attachments?: string[] }[];
  streamingContent: string;
  isLoading: boolean;
  isInitializing: boolean;
  sessionTitle: string;
  imageGenerations: ImageGeneration[];
  videoGenerations: VideoGeneration[];
  onSend: (content: string, options?: { imageUrls?: string[]; documentUrls?: string[] }) => void;
  onCancel: () => void;
  onNewSession: () => void;
}

const ChatArea: React.FC<ChatAreaProps> = ({
  messages, streamingContent, isLoading, isInitializing,
  sessionTitle, imageGenerations, videoGenerations, onSend, onCancel, onNewSession,
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

  // 自动滚动
  useEffect(() => {
    scrollToBottom();
  }, [messages, streamingContent, scrollToBottom]);

  // 检测是否需要显示滚动按钮
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

  // 自动调整 textarea 高度
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

    // 上传附件
    let imageUrls: string[] | undefined;
    let documentUrls: string[] | undefined;

    if (pendingImages.length > 0 || pendingDocs.length > 0) {
      setIsUploading(true);
      try {
        if (pendingImages.length > 0) {
          imageUrls = [];
          for (const img of pendingImages) {
            const formData = new FormData();
            formData.append('file', img);
            const res = await apiClient.post('/api/file/upload/chat/ai', formData, {
              headers: { 'Content-Type': undefined },
            });
            if (res.data?.code === 0 && res.data?.data?.fileUrl) {
              imageUrls.push(res.data.data.fileUrl);
            }
          }
        }
        if (pendingDocs.length > 0) {
          documentUrls = [];
          for (const doc of pendingDocs) {
            const formData = new FormData();
            formData.append('file', doc);
            const res = await apiClient.post('/api/file/upload/chat/ai', formData, {
              headers: { 'Content-Type': undefined },
            });
            if (res.data?.code === 0 && res.data?.data?.fileUrl) {
              documentUrls.push(res.data.data.fileUrl);
            }
          }
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

    onSend(content, {
      ...(imageUrls?.length ? { imageUrls } : {}),
      ...(documentUrls?.length ? { documentUrls } : {}),
    });
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (e.key === 'Enter' && !e.shiftKey && !e.nativeEvent.isComposing) {
      e.preventDefault();
      handleSend();
    }
  };

  const handleQuickPrompt = (text: string) => {
    setInput(text);
    // 自动发送
    setTimeout(() => {
      onSend(text);
    }, 0);
  };

  const removeImage = (index: number) => setPendingImages(prev => prev.filter((_, i) => i !== index));
  const removeDoc = (index: number) => setPendingDocs(prev => prev.filter((_, i) => i !== index));

  // 所有消息 + 流式消息
  const allMessages = [
    ...messages,
    ...(streamingContent ? [{
      role: 'assistant' as const,
      content: streamingContent,
      isStreaming: true,
    }] : []),
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
          <div className="w-8 h-8 rounded-lg bg-brand-500 flex items-center justify-center shadow-sm">
            <Bot size={16} className="text-white" />
          </div>
          <div className="min-w-0">
            <h3 className="text-sm font-bold text-gray-800 dark:text-gray-200 truncate">{sessionTitle}</h3>
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

      {/* 消息列表 */}
      <div ref={messagesContainerRef} className="flex-1 overflow-y-auto custom-scrollbar relative">
        {allMessages.length === 0 ? (
          /* 空状态 */
          <div className="flex items-center justify-center h-full">
            <div className="text-center px-8 max-w-lg">
              <div className="w-20 h-20 mx-auto mb-6 rounded-2xl bg-brand-500 flex items-center justify-center shadow-lg shadow-brand-500/20">
                <Bot size={40} className="text-white" />
              </div>
              <h2 className="text-xl font-bold text-gray-800 dark:text-gray-200 mb-2">
                你好，我是智云星课 AI 助手
              </h2>
              <p className="text-gray-400 text-sm mb-6">有什么我可以帮助你的吗？</p>
              <div className="flex flex-wrap justify-center gap-2">
                {QUICK_PROMPTS.map(text => (
                  <button
                    key={text}
                    onClick={() => handleQuickPrompt(text)}
                    className="px-3.5 py-2 text-sm text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/40 rounded-xl border border-brand-100 dark:border-brand-800 transition-colors"
                  >
                    {text}
                  </button>
                ))}
              </div>
            </div>
          </div>
        ) : (
          <div className="max-w-4xl mx-auto px-4 py-6 space-y-6">
            {allMessages.map((msg, index) => {
              // 判断是否是最后一条流式消息，用于在其下方显示图片生成状态
              const isLastStreaming = msg.isStreaming && index === allMessages.length - 1;
              return (
                <React.Fragment key={index}>
                  <div className={`flex gap-3 ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
                    {msg.role === 'assistant' && (
                      <div className="w-8 h-8 rounded-lg bg-brand-500 flex items-center justify-center flex-shrink-0 shadow-sm mt-0.5">
                        <Bot size={16} className="text-white" />
                      </div>
                    )}
                    <div className={`max-w-[75%] ${msg.role === 'user' ? '' : ''}`}>
                      {/* 附件预览（用户消息） */}
                      {msg.role === 'user' && msg.attachments && msg.attachments.length > 0 && (() => {
                        const { images, docs } = classifyAttachments(msg.attachments);
                        return (
                          <div className="flex flex-col items-end gap-2 mb-2">
                            {images.map((url, i) => (
                              <ImageAttachment key={`img-${i}`} url={url} />
                            ))}
                            {docs.map((url, i) => (
                              <DocAttachment key={`doc-${i}`} url={url} />
                            ))}
                          </div>
                        );
                      })()}
                      {/* 消息气泡 */}
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
                                // 渲染 <video> 标签为视频播放器
                                video: (props: React.ComponentProps<'video'>) => (
                                  <video
                                    {...props}
                                    controls
                                    className="rounded-xl border border-gray-200 dark:border-gray-700 shadow-md max-w-full not-prose"
                                    style={{ maxHeight: 320, maxWidth: '100%', borderRadius: 12 }}
                                  />
                                ),
                                // 兼容旧数据：[点击播放 AI 生成视频](url) 渲染为视频播放器
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
                      {/* AI 消息操作 */}
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
                  {/* 文生图 / 文生视频状态卡片：显示在流式消息下方 */}
                  {isLastStreaming && (imageGenerations.length > 0 || videoGenerations.length > 0) && (
                    <div className="flex gap-3 justify-start">
                      <div className="w-8 flex-shrink-0" />
                      <div className="space-y-3">
                        {imageGenerations.map(ig => (
                          <ImageGenerationCard key={`img-${ig.index}`} generation={ig} />
                        ))}
                        {videoGenerations.map(vg => (
                          <VideoGenerationCard key={`vid-${vg.index}`} generation={vg} />
                        ))}
                      </div>
                    </div>
                  )}
                </React.Fragment>
              );
            })}
            <div ref={messagesEndRef} />
          </div>
        )}

        {/* 滚动到底部按钮 */}
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
              <PendingImagePreview key={i} file={img} onRemove={() => removeImage(i)} />
            ))}
            {pendingDocs.map((doc, i) => (
              <PendingDocPreview key={i} file={doc} onRemove={() => removeDoc(i)} />
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

        {/* 提示 */}
        <p className="px-4 pb-2 text-[11px] text-gray-400 text-center">
          AI 助手可能会犯错，请核实重要信息
        </p>
      </div>
    </div>
  );
};

// ============ 主面板 ============

const AiChatPanel: React.FC = () => {
  const {
    sessions, messages, currentSessionId, sessionTitle,
    isLoading, isLoadingSessions, isInitializing, streamingContent,
    imageGenerations, videoGenerations,
    loadSessions, deleteSession, startNewSession, openSession,
    sendMessage, cancelStream, refreshTitle,
  } = useAiChat();

  const [showOverview, setShowOverview] = useState(true);
  const [assistants, setAssistants] = useState<AiAssistantVO[]>([]);
  const [currentPage, setCurrentPage] = useState(0);
  const [totalPages, setTotalPages] = useState(1);
  const [isLoadingMore, setIsLoadingMore] = useState(false);
  
  const PAGE_SIZE = 6;
  
  const hasInitRef = useRef(false);

  // 加载公开助手列表（分页）
  const loadAssistants = useCallback(async (page: number) => {
    setIsLoadingMore(true);
    
    try {
      const res = await aiApi.assistantListPublic({ page, size: PAGE_SIZE });
      if (res.data?.code === 0 && Array.isArray(res.data.data)) {
        setAssistants(res.data.data);
        setCurrentPage(page);
        
        const hasMore = res.data.data.length === PAGE_SIZE;
        setTotalPages(hasMore ? page + 2 : page + 1);
      }
    } catch (err) {
      console.error('获取助手列表失败:', err);
    } finally {
      setIsLoadingMore(false);
    }
  }, [PAGE_SIZE]);
  
  // 初始加载助手列表
  useEffect(() => {
    loadAssistants(0);
  }, [loadAssistants]);
  
  // 页码变化处理
  const handlePageChange = useCallback((page: number) => {
    if (page >= 0 && page < totalPages) {
      loadAssistants(page);
    }
  }, [loadAssistants, totalPages]);

  // 加载会话列表
  useEffect(() => {
    if (!hasInitRef.current) {
      hasInitRef.current = true;
      loadSessions();
    }
  }, [loadSessions]);

  // 消息数 ≤ 3 时自动刷新标题
  useEffect(() => {
    if (messages.length > 0 && messages.length <= 3 && !isLoading) {
      refreshTitle();
    }
  }, [messages.length, isLoading, refreshTitle]);

  const handleNewSession = useCallback(async () => {
    const success = await startNewSession();
    if (success) {
      setShowOverview(false);
    } else {
      toast.error('创建新会话失败');
    }
  }, [startNewSession]);

  const handleSelectSession = useCallback(async (session: AiChatSession) => {
    await openSession(session);
    setShowOverview(false);
  }, [openSession]);

  const handleDeleteSession = useCallback(async (session: AiChatSession) => {
    const success = await deleteSession(session.sessionId);
    if (success) {
      toast.success('已删除');
      loadSessions();
    } else {
      toast.error('删除失败');
    }
  }, [deleteSession, loadSessions]);

  const handleSend = useCallback(async (content: string, options?: { imageUrls?: string[]; documentUrls?: string[] }) => {
    // 如果没有当前会话，先创建
    if (currentSessionId == null) {
      const success = await startNewSession();
      if (!success) {
        toast.error('创建会话失败');
        return;
      }
      setShowOverview(false);
      // 等 state 更新后再发送 - 使用 setTimeout
      setTimeout(() => sendMessage(content, options), 100);
      return;
    }
    sendMessage(content, options);
  }, [currentSessionId, startNewSession, sendMessage]);

  const handleSelectAssistant = useCallback((assistant: AiAssistantVO) => {
    // 跳转到专用的 AI 助手聊天页面
    window.location.href = `/ai-chat/${String(assistant.id)}`;
  }, []);

  return (
    <div className="flex h-full">
      {/* 左侧会话列表 */}
      <SessionSidebar
        sessions={sessions}
        currentSessionId={currentSessionId}
        isLoading={isLoadingSessions}
        onSelect={handleSelectSession}
        onDelete={handleDeleteSession}
        onNew={handleNewSession}
        showOverview={showOverview}
        onShowOverview={() => setShowOverview(true)}
      />

      {/* 右侧内容区 */}
      {showOverview ? (
        <IntelligenceOverview
          onStartChat={handleNewSession}
          onViewHistory={() => setShowOverview(false)}
          assistants={assistants}
          currentPage={currentPage}
          totalPages={totalPages}
          onPageChange={handlePageChange}
          isLoadingMore={isLoadingMore}
          onSelectAssistant={handleSelectAssistant}
        />
      ) : (
        <ChatArea
          messages={messages}
          streamingContent={streamingContent}
          isLoading={isLoading}
          isInitializing={isInitializing}
          sessionTitle={sessionTitle}
          imageGenerations={imageGenerations}
          videoGenerations={videoGenerations}
          onSend={handleSend}
          onCancel={cancelStream}
          onNewSession={handleNewSession}
        />
      )}
    </div>
  );
};

export default AiChatPanel;
