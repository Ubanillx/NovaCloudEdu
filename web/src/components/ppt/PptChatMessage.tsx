import React, { useState } from 'react';
import {
  Download, Check, Edit3, Loader2, FileText,
  AlertCircle, ChevronRight, ExternalLink,
} from 'lucide-react';
import MarkdownRenderer from '../chat/MarkdownRenderer';
import OutlineJsonEditor from './OutlineJsonEditor';
import type { PptChatMessage as PptChatMessageData } from '../../hooks/usePptChat';
import type { useTextToSpeech } from '../../hooks/useTextToSpeech';
import AiMessageActions from '../chat/AiMessageActions';

// ============ 大纲卡片 ============

interface OutlineCardProps {
  markdown: string;
  actionDone?: boolean;
  onConfirm?: () => void;
  onRevise?: (feedback: string) => void;
}

const OutlineCard: React.FC<OutlineCardProps> = ({ markdown, actionDone, onConfirm, onRevise }) => {
  const [showRevise, setShowRevise] = useState(false);
  const [feedback, setFeedback] = useState('');

  const handleRevise = () => {
    if (!feedback.trim() || !onRevise) return;
    onRevise(feedback.trim());
    setFeedback('');
    setShowRevise(false);
  };

  return (
    <div className="space-y-3">
      <div className="bg-white dark:bg-gray-800 rounded-2xl border border-gray-100 dark:border-gray-700 shadow-sm p-5 transition-all">
        <h4 className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-3">AI 生成的大纲</h4>
        <MarkdownRenderer
          content={markdown}
          className="prose prose-sm dark:prose-invert max-w-none prose-p:my-1 prose-headings:my-2 prose-ul:my-1 prose-ol:my-1 prose-li:my-0.5"
        />
      </div>

      {!actionDone && (
        <>
          {showRevise ? (
            <div className="space-y-2">
              <textarea
                value={feedback}
                onChange={e => setFeedback(e.target.value)}
                placeholder="请描述你希望修改的内容..."
                className="w-full h-20 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 resize-none focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                autoFocus
              />
              <div className="flex gap-2">
                <button
                  onClick={handleRevise}
                  disabled={!feedback.trim()}
                  className="px-4 py-1.5 bg-brand-600 text-white text-xs font-bold rounded-lg hover:bg-brand-700 disabled:opacity-50 transition-all"
                >
                  提交修改
                </button>
                <button
                  onClick={() => setShowRevise(false)}
                  className="px-3 py-1.5 text-xs text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 transition-colors"
                >
                  取消
                </button>
              </div>
            </div>
          ) : (
            <div className="flex gap-2">
              <button
                onClick={onConfirm}
                className="flex items-center gap-1.5 px-4 py-2 bg-brand-600 text-white rounded-xl text-xs font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
              >
                <Check size={14} />
                确认大纲
              </button>
              <button
                onClick={() => setShowRevise(true)}
                className="flex items-center gap-1.5 px-3 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl text-xs font-medium text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
              >
                <Edit3 size={14} />
                修改大纲
              </button>
            </div>
          )}
        </>
      )}

      {actionDone && (
        <div className="flex items-center gap-1.5 text-xs text-emerald-500">
          <Check size={12} />
          <span>大纲已确认</span>
        </div>
      )}
    </div>
  );
};

// ============ 进度卡片 ============

const ProgressCard: React.FC<{ current: number; total: number }> = ({ current, total }) => {
  const pct = total > 0 ? Math.round((current / total) * 100) : 0;
  const isDone = total > 0 && current >= total;
  return (
    <div className="bg-white dark:bg-gray-800 rounded-2xl border border-gray-100 dark:border-gray-700 shadow-sm p-4 max-w-sm">
      <div className="flex items-center gap-3 mb-2">
        <div className={`w-8 h-8 rounded-lg flex items-center justify-center ${isDone ? 'bg-emerald-50 dark:bg-emerald-900/30' : 'bg-brand-50 dark:bg-brand-900/30'}`}>
          {isDone
            ? <Check size={16} className="text-emerald-500" />
            : <Loader2 size={16} className="text-brand-500 animate-spin" />
          }
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-xs font-medium text-gray-700 dark:text-gray-300">
            {isDone ? '幻灯片生成完成' : '正在生成幻灯片'}
          </p>
          <p className="text-[11px] text-gray-400">
            {current > 0 ? `第 ${current} / ${total} 页` : '准备中...'}
          </p>
        </div>
        <span className={`text-xs font-bold ${isDone ? 'text-emerald-500' : 'text-brand-500'}`}>{pct}%</span>
      </div>
      <div className="w-full h-1.5 bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
        <div
          className={`h-full rounded-full transition-all duration-500 ease-out ${isDone ? 'bg-emerald-500' : 'bg-brand-500'}`}
          style={{ width: `${pct}%` }}
        />
      </div>
    </div>
  );
};

// ============ 下载卡片 ============

const DownloadCard: React.FC<{ url: string; fileName?: string }> = ({ url, fileName }) => {
  const handleEdit = () => {
    const params = new URLSearchParams({
      fileUrl: url,
      fileName: fileName || '演示文稿.pptx',
    });
    window.open(`/admin/ppt-editor?${params.toString()}`, '_blank');
  };

  return (
    <div className="flex items-center gap-2 max-w-md">
      <a
        href={url}
        target="_blank"
        rel="noopener noreferrer"
        className="flex items-center gap-3 px-4 py-3 bg-emerald-50 dark:bg-emerald-900/20 rounded-2xl border border-emerald-100 dark:border-emerald-800/40 hover:shadow-sm transition-all flex-1 min-w-0 group"
      >
        <div className="w-10 h-10 rounded-xl bg-emerald-100 dark:bg-emerald-800/40 flex items-center justify-center flex-shrink-0">
          <Download size={18} className="text-emerald-600 dark:text-emerald-400" />
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-sm font-medium text-emerald-700 dark:text-emerald-300 truncate group-hover:text-emerald-800 dark:group-hover:text-emerald-200 transition-colors">
            {fileName || 'PPT 文件'}
          </p>
          <p className="text-[11px] text-emerald-500/70 dark:text-emerald-400/60">点击下载</p>
        </div>
        <FileText size={16} className="text-emerald-400 flex-shrink-0" />
      </a>
      <button
        onClick={handleEdit}
        className="flex items-center gap-1.5 px-3 py-3 bg-brand-50 dark:bg-brand-900/20 rounded-2xl border border-brand-100 dark:border-brand-800/40 hover:shadow-sm hover:bg-brand-100 dark:hover:bg-brand-900/40 transition-all flex-shrink-0 group"
        title="在线编辑"
      >
        <ExternalLink size={16} className="text-brand-600 dark:text-brand-400" />
        <span className="text-xs font-medium text-brand-600 dark:text-brand-400">在线编辑</span>
      </button>
    </div>
  );
};

// ============ 主组件 ============

interface PptChatMessageProps {
  message: PptChatMessageData;
  messageIndex: number;
  tts: ReturnType<typeof useTextToSpeech>;
  onConfirmOutline?: () => void;
  onReviseOutline?: (feedback: string) => void;
  onUpdateOutline?: (json: string) => void;
  outlineJson?: string;
  isGenerating?: boolean;
}

const PptChatMessageComponent: React.FC<PptChatMessageProps> = ({
  message,
  messageIndex,
  tts,
  onConfirmOutline,
  onReviseOutline,
  onUpdateOutline,
  outlineJson,
  isGenerating,
}) => {
  const { type, content, isStreaming } = message;

  // ---- User message ----
  if (type === 'user') {
    return (
      <div className="flex justify-end">
        <div className="max-w-[75%]">
          <div className="rounded-2xl px-4 py-3 bg-brand-500 text-white rounded-tr-sm">
            <p className="text-sm leading-relaxed whitespace-pre-wrap">{content}</p>
          </div>
        </div>
      </div>
    );
  }

  // ---- AI text message ----
  if (type === 'ai-text') {
    return (
      <div className="flex justify-start">
        <div className="max-w-[80%]">
          <div className="rounded-2xl px-4 py-3 bg-white dark:bg-gray-800 text-gray-800 dark:text-gray-200 rounded-tl-sm border border-gray-100 dark:border-gray-700 shadow-sm">
            {content ? (
              <MarkdownRenderer
                content={content}
                isStreaming={!!isStreaming}
                showCursor={!!isStreaming}
                className="prose prose-sm dark:prose-invert max-w-none prose-p:my-1 prose-headings:my-2 prose-code:text-brand-600 dark:prose-code:text-brand-400 prose-code:bg-brand-50 dark:prose-code:bg-brand-900/30 prose-code:px-1 prose-code:py-0.5 prose-code:rounded prose-code:before:content-none prose-code:after:content-none"
              />
            ) : isStreaming ? (
              <div className="flex items-center gap-2 text-gray-400">
                <Loader2 size={14} className="animate-spin" />
                <span className="text-xs">思考中...</span>
              </div>
            ) : null}
          </div>
          {!isStreaming && content && (
            <AiMessageActions
              text={content}
              messageIndex={messageIndex}
              tts={tts}
            />
          )}
        </div>
      </div>
    );
  }

  // ---- Outline card ----
  if (type === 'outline-card' && (message.outlineMarkdown || outlineJson)) {
    // Use JSON editor if outlineJson is available and not yet confirmed
    if (outlineJson && !message.actionDone) {
      return (
        <div className="flex justify-start">
          <div className="flex-1 max-w-[90%]">
            <OutlineJsonEditor
              outlineJson={outlineJson}
              onSave={onUpdateOutline || (() => {})}
              onConfirm={onConfirmOutline || (() => {})}
              isLoading={isGenerating}
            />
          </div>
        </div>
      );
    }
    // Fallback: markdown outline card
    return (
      <div className="flex justify-start">
        <div className="max-w-[85%]">
          <OutlineCard
            markdown={message.outlineMarkdown || ''}
            actionDone={message.actionDone}
            onConfirm={onConfirmOutline}
            onRevise={onReviseOutline}
          />
        </div>
      </div>
    );
  }

  // ---- Progress card ----
  if (type === 'progress-card' && message.progress) {
    return (
      <div className="flex justify-start">
        <ProgressCard current={message.progress.current} total={message.progress.total} />
      </div>
    );
  }

  // ---- Download card ----
  if (type === 'download-card' && message.downloadUrl) {
    return (
      <div className="flex justify-start">
        <DownloadCard url={message.downloadUrl} fileName={message.downloadFileName} />
      </div>
    );
  }

  // ---- Status message ----
  if (type === 'status') {
    return (
      <div className="flex justify-start">
        <div className="flex items-center gap-2 px-4 py-1.5 bg-gray-100 dark:bg-gray-800 rounded-full">
          <ChevronRight size={12} className="text-gray-400" />
          <span className="text-xs text-gray-500 dark:text-gray-400">{content}</span>
        </div>
      </div>
    );
  }

  // ---- Error message ----
  if (type === 'error') {
    return (
      <div className="flex justify-start">
        <div className="flex items-center gap-2 rounded-2xl px-4 py-3 bg-red-50 dark:bg-red-900/20 border border-red-100 dark:border-red-800/40 max-w-[75%]">
          <AlertCircle size={14} className="text-red-500 flex-shrink-0" />
          <p className="text-sm text-red-700 dark:text-red-300">{content}</p>
        </div>
      </div>
    );
  }

  return null;
};

export default PptChatMessageComponent;
