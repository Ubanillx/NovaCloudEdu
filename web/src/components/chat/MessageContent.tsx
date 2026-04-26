import React, { useState } from 'react';
import {
  FileText, FileSpreadsheet, FileImage, FileArchive, FileAudio, FileVideo,
  File, Download, X, Loader2, Presentation, Eye, ExternalLink,
  Phone, PhoneMissed, PhoneOff, Video,
} from 'lucide-react';

// ============ 工具函数 ============

/** 根据文件扩展名返回图标和颜色 */
const getFileInfo = (fileName: string): { icon: React.ReactNode; color: string; bg: string } => {
  const ext = fileName.split('.').pop()?.toLowerCase() || '';
  switch (ext) {
    case 'pdf':
      return { icon: <FileText size={22} />, color: 'text-red-500', bg: 'bg-red-50 dark:bg-red-900/20' };
    case 'doc': case 'docx':
      return { icon: <FileText size={22} />, color: 'text-blue-500', bg: 'bg-blue-50 dark:bg-blue-900/20' };
    case 'xls': case 'xlsx':
      return { icon: <FileSpreadsheet size={22} />, color: 'text-green-500', bg: 'bg-green-50 dark:bg-green-900/20' };
    case 'ppt': case 'pptx':
      return { icon: <Presentation size={22} />, color: 'text-orange-500', bg: 'bg-orange-50 dark:bg-orange-900/20' };
    case 'txt': case 'md':
      return { icon: <FileText size={22} />, color: 'text-gray-500', bg: 'bg-gray-100 dark:bg-gray-800' };
    case 'zip': case 'rar': case '7z':
      return { icon: <FileArchive size={22} />, color: 'text-amber-700', bg: 'bg-amber-50 dark:bg-amber-900/20' };
    case 'mp3': case 'wav': case 'aac': case 'm4a':
      return { icon: <FileAudio size={22} />, color: 'text-blue-500', bg: 'bg-blue-50 dark:bg-blue-900/20' };
    case 'mp4': case 'avi': case 'mov': case 'mkv':
      return { icon: <FileVideo size={22} />, color: 'text-pink-500', bg: 'bg-pink-50 dark:bg-pink-900/20' };
    case 'jpg': case 'jpeg': case 'png': case 'gif': case 'webp':
      return { icon: <FileImage size={22} />, color: 'text-cyan-500', bg: 'bg-cyan-50 dark:bg-cyan-900/20' };
    default:
      return { icon: <File size={22} />, color: 'text-gray-400', bg: 'bg-gray-100 dark:bg-gray-800' };
  }
};

/** 格式化文件大小（兼容已格式化字符串 "105.2 KB" 和纯字节数 "107520"） */
const formatFileSize = (size: string): string => {
  if (!size) return '';
  // 已包含单位（来自 Flutter 或新版 Web），直接返回
  if (/[A-Za-z]/.test(size)) return size;
  // 纯数字，视为原始字节数
  const bytes = parseInt(size, 10);
  if (isNaN(bytes)) return size;
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  if (bytes < 1024 * 1024 * 1024) return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
  return `${(bytes / (1024 * 1024 * 1024)).toFixed(1)} GB`;
};

// ============ 图片预览弹窗 ============

interface ImagePreviewProps {
  src: string;
  onClose: () => void;
}

const ImagePreview: React.FC<ImagePreviewProps> = ({ src, onClose }) => {
  return (
    <div
      className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/80 backdrop-blur-sm animate-in fade-in duration-200"
      onClick={onClose}
    >
      <button
        onClick={onClose}
        className="absolute top-4 right-4 p-2 rounded-full bg-black/50 hover:bg-black/70 text-white transition-colors z-10"
      >
        <X size={20} />
      </button>
      <img
        src={src}
        alt="预览"
        className="max-w-[90vw] max-h-[90vh] object-contain rounded-lg shadow-2xl animate-in zoom-in-95 duration-200"
        onClick={(e) => e.stopPropagation()}
      />
    </div>
  );
};

// ============ 图片消息 ============

interface ImageMessageProps {
  content: string;
}

const ImageMessage: React.FC<ImageMessageProps> = ({ content }) => {
  const [showPreview, setShowPreview] = useState(false);
  const [loadError, setLoadError] = useState(false);
  const [loading, setLoading] = useState(true);

  if (loadError) {
    return (
      <div className="flex flex-col items-center justify-center w-[150px] h-[100px] bg-gray-100 dark:bg-gray-800 rounded-lg text-gray-400">
        <FileImage size={28} className="mb-1 opacity-50" />
        <span className="text-xs">图片加载失败</span>
      </div>
    );
  }

  return (
    <>
      <div
        className="cursor-pointer overflow-hidden rounded-lg relative"
        onClick={() => setShowPreview(true)}
      >
        {loading && (
          <div className="absolute inset-0 flex items-center justify-center bg-gray-100 dark:bg-gray-800 rounded-lg">
            <Loader2 size={20} className="animate-spin text-gray-400" />
          </div>
        )}
        <img
          src={content}
          alt="图片消息"
          className="max-w-[240px] max-h-[240px] object-cover rounded-lg hover:opacity-90 transition-opacity"
          onLoad={() => setLoading(false)}
          onError={() => { setLoadError(true); setLoading(false); }}
        />
      </div>
      {showPreview && <ImagePreview src={content} onClose={() => setShowPreview(false)} />}
    </>
  );
};

// ============ 文件预览工具 ============

/** 微软 Office Online 支持预览的扩展名 */
const OFFICE_PREVIEW_EXTS = new Set([
  'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx',
]);

/** 浏览器原生可预览的扩展名 */
const BROWSER_PREVIEW_EXTS = new Set([
  'pdf', 'txt',
]);

/** 图片扩展名（直接在弹窗中 img 展示） */
const IMAGE_EXTS = new Set([
  'jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'svg',
]);

/** 判断文件是否支持预览 */
const canPreview = (fileName: string): boolean => {
  const ext = fileName.split('.').pop()?.toLowerCase() || '';
  return OFFICE_PREVIEW_EXTS.has(ext) || BROWSER_PREVIEW_EXTS.has(ext) || IMAGE_EXTS.has(ext);
};

/** 获取预览类型 */
const getPreviewType = (fileName: string): 'office' | 'browser' | 'image' | null => {
  const ext = fileName.split('.').pop()?.toLowerCase() || '';
  if (OFFICE_PREVIEW_EXTS.has(ext)) return 'office';
  if (BROWSER_PREVIEW_EXTS.has(ext)) return 'browser';
  if (IMAGE_EXTS.has(ext)) return 'image';
  return null;
};

/** 获取微软 Office Online 预览 URL */
const getOfficePreviewUrl = (fileUrl: string): string =>
  `https://view.officeapps.live.com/op/view.aspx?src=${encodeURIComponent(fileUrl)}`;

// ============ 文件预览弹窗 ============

interface FilePreviewModalProps {
  fileName: string;
  fileUrl: string;
  onClose: () => void;
}

const FilePreviewModal: React.FC<FilePreviewModalProps> = ({ fileName, fileUrl, onClose }) => {
  const previewType = getPreviewType(fileName);
  const [iframeLoading, setIframeLoading] = useState(true);

  const previewSrc = previewType === 'office'
    ? getOfficePreviewUrl(fileUrl)
    : fileUrl;

  return (
    <div
      className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/80 backdrop-blur-sm animate-in fade-in duration-200"
      onClick={onClose}
    >
      <div
        className="relative w-[90vw] h-[85vh] max-w-5xl bg-white dark:bg-gray-900 rounded-2xl shadow-2xl overflow-hidden flex flex-col animate-in zoom-in-95 duration-200"
        onClick={(e) => e.stopPropagation()}
      >
        {/* 头部 */}
        <div className="flex items-center justify-between px-4 py-3 border-b border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/80">
          <div className="flex items-center gap-2 min-w-0">
            <Eye size={16} className="text-brand-500 flex-shrink-0" />
            <span className="text-sm font-medium text-gray-700 dark:text-gray-200 truncate">{fileName}</span>
          </div>
          <div className="flex items-center gap-2 flex-shrink-0">
            <a
              href={previewSrc}
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-1 px-2.5 py-1.5 text-xs font-medium text-gray-600 dark:text-gray-300 bg-white dark:bg-gray-700 border border-gray-200 dark:border-gray-600 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors"
              title="在新窗口预览"
            >
              <ExternalLink size={13} />
              新窗口
            </a>
            <a
              href={fileUrl}
              download={fileName}
              className="flex items-center gap-1 px-2.5 py-1.5 text-xs font-medium text-white bg-brand-500 rounded-lg hover:bg-brand-600 transition-colors"
              title="下载文件"
            >
              <Download size={13} />
              下载
            </a>
            <button
              onClick={onClose}
              className="p-1.5 rounded-lg hover:bg-gray-200 dark:hover:bg-gray-600 transition-colors"
            >
              <X size={16} className="text-gray-500" />
            </button>
          </div>
        </div>
        {/* 预览内容 */}
        <div className="flex-1 relative">
          {previewType === 'image' ? (
            <div className="w-full h-full flex items-center justify-center bg-gray-100 dark:bg-gray-950 p-4">
              <img
                src={fileUrl}
                alt={fileName}
                className="max-w-full max-h-full object-contain rounded"
              />
            </div>
          ) : (
            <>
              {iframeLoading && (
                <div className="absolute inset-0 flex items-center justify-center bg-white dark:bg-gray-900 z-10">
                  <div className="flex flex-col items-center gap-3 text-gray-400">
                    <Loader2 size={28} className="animate-spin" />
                    <span className="text-sm">正在加载预览...</span>
                  </div>
                </div>
              )}
              <iframe
                src={previewSrc}
                title={`预览 ${fileName}`}
                className="w-full h-full border-none"
                onLoad={() => setIframeLoading(false)}
              />
            </>
          )}
        </div>
      </div>
    </div>
  );
};

// ============ 文件消息 ============

interface FileMessageProps {
  content: string;
  isSelf: boolean;
}

const FileMessage: React.FC<FileMessageProps> = ({ content, isSelf }) => {
  const [showPreview, setShowPreview] = useState(false);

  let fileName: string;
  let fileUrl: string;
  let fileSize = '';

  if (content.includes('|')) {
    const parts = content.split('|');
    fileName = parts[0] || '未知文件';
    fileUrl = parts[1] || content;
    fileSize = parts[2] || '';
  } else {
    fileUrl = content;
    try {
      const url = new URL(content);
      const segments = url.pathname.split('/');
      fileName = segments[segments.length - 1] || '未知文件';
    } catch {
      fileName = '未知文件';
    }
  }

  const fileInfo = getFileInfo(fileName);
  const previewable = canPreview(fileName);

  const handleClick = () => {
    if (previewable) {
      setShowPreview(true);
    } else {
      window.open(fileUrl, '_blank');
    }
  };

  return (
    <>
      <div
        onClick={handleClick}
        className={`flex items-center gap-3 p-3 rounded-xl cursor-pointer transition-colors min-w-[200px] max-w-[280px] shadow-sm ${
          isSelf
            ? 'bg-brand-500 hover:bg-brand-600 rounded-tr-sm'
            : 'bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-700/80 border border-gray-200 dark:border-gray-700 rounded-tl-sm'
        }`}
      >
        {/* 文件图标 */}
        <div className={`flex items-center justify-center w-11 h-11 rounded-xl ${isSelf ? 'bg-white/20' : fileInfo.bg}`}>
          <span className={isSelf ? 'text-white' : fileInfo.color}>{fileInfo.icon}</span>
        </div>
        {/* 文件信息 */}
        <div className="flex-1 min-w-0">
          <p
            className={`text-sm font-medium truncate ${
              isSelf ? 'text-white' : 'text-gray-900 dark:text-gray-100'
            }`}
            title={fileName}
          >
            {fileName}
          </p>
          <div className="flex items-center gap-1 mt-0.5">
            {fileSize && (
              <span className={`text-xs ${isSelf ? 'text-white/70' : 'text-gray-500 dark:text-gray-400'}`}>
                {formatFileSize(fileSize)}
              </span>
            )}
            {fileSize && (
              <span className={`text-xs ${isSelf ? 'text-white/50' : 'text-gray-300 dark:text-gray-600'}`}>·</span>
            )}
            {previewable ? (
              <span className={`text-xs flex items-center gap-0.5 ${isSelf ? 'text-white/70' : 'text-brand-500'}`}>
                <Eye size={11} />
                预览
              </span>
            ) : (
              <span className={`text-xs flex items-center gap-0.5 ${isSelf ? 'text-white/70' : 'text-brand-500'}`}>
                <Download size={11} />
                下载
              </span>
            )}
          </div>
        </div>
      </div>
      {showPreview && (
        <FilePreviewModal
          fileName={fileName}
          fileUrl={fileUrl}
          onClose={() => setShowPreview(false)}
        />
      )}
    </>
  );
};

// ============ 通话消息 ============

interface CallMessageProps {
  content: string;
  isSelf: boolean;
}

const formatCallDuration = (seconds: number): string => {
  if (seconds <= 0) return '';
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  if (m > 0) return `${m}分${s.toString().padStart(2, '0')}秒`;
  return `${s}秒`;
};

const callStatusConfig: Record<string, { label: string; icon: React.ReactNode; color: string }> = {
  completed: { label: '通话结束', icon: <Phone size={16} />, color: 'text-green-500' },
  rejected:  { label: '已拒接',   icon: <PhoneOff size={16} />, color: 'text-red-400' },
  missed:    { label: '未接听',   icon: <PhoneMissed size={16} />, color: 'text-orange-400' },
  busy:      { label: '对方忙',   icon: <PhoneOff size={16} />, color: 'text-gray-400' },
  cancelled: { label: '已取消',   icon: <PhoneOff size={16} />, color: 'text-gray-400' },
};

const CallMessage: React.FC<CallMessageProps> = ({ content, isSelf }) => {
  let mediaType = 'audio';
  let status = 'completed';
  let duration = 0;

  try {
    const data = JSON.parse(content);
    mediaType = data.mediaType || 'audio';
    status = data.status || 'completed';
    duration = data.duration || 0;
  } catch { /* 解析失败使用默认值 */ }

  const cfg = callStatusConfig[status] || callStatusConfig.completed;
  const isVideo = mediaType === 'video';
  const durationStr = status === 'completed' && duration > 0 ? formatCallDuration(duration) : '';

  return (
    <div
      className={`flex items-center gap-3 px-4 py-3 rounded-2xl shadow-sm min-w-[180px] ${
        isSelf
          ? 'bg-brand-500 text-white rounded-tr-sm'
          : 'bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-tl-sm border border-gray-100 dark:border-gray-800'
      }`}
    >
      <div className={`flex items-center justify-center w-9 h-9 rounded-full ${
        isSelf ? 'bg-white/20' : 'bg-gray-100 dark:bg-gray-700'
      }`}>
        <span className={isSelf ? 'text-white' : cfg.color}>
          {isVideo ? <Video size={18} /> : cfg.icon}
        </span>
      </div>
      <div className="flex flex-col">
        <span className={`text-sm font-medium ${isSelf ? 'text-white' : ''}`}>
          {isVideo ? '视频通话' : '语音通话'}
        </span>
        <span className={`text-xs ${isSelf ? 'text-white/70' : 'text-gray-500 dark:text-gray-400'}`}>
          {cfg.label}{durationStr ? ` · ${durationStr}` : ''}
        </span>
      </div>
    </div>
  );
};

// ============ MessageBubble：带气泡包裹的消息渲染 ============

interface MessageBubbleProps {
  content: string;
  type: string;
  isSelf: boolean;
  replyPreview?: React.ReactNode;
}

/**
 * MessageBubble 组件 —— 根据消息类型渲染不同内容，并自动决定是否包裹气泡。
 * - IMAGE：直接显示图片，无气泡
 * - FILE：显示文件卡片，无气泡
 * - TEXT/AUDIO/VIDEO：包裹在聊天气泡中
 */
export const MessageBubble: React.FC<MessageBubbleProps> = ({ content, type, isSelf, replyPreview }) => {
  const upperType = (type || 'TEXT').toUpperCase();

  // 图片消息：不需要气泡
  if (upperType === 'IMAGE') {
    if (!replyPreview) return <ImageMessage content={content} />;
    return (
      <div
        className={`max-w-[260px] overflow-hidden rounded-2xl p-2 shadow-sm ${
          isSelf
            ? 'bg-brand-500 text-white rounded-tr-sm'
            : 'bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-tl-sm border border-gray-100 dark:border-gray-800'
        }`}
      >
        {replyPreview}
        <ImageMessage content={content} />
      </div>
    );
  }

  // 文件消息：自带卡片样式，不需要气泡
  if (upperType === 'FILE') {
    if (!replyPreview) return <FileMessage content={content} isSelf={isSelf} />;
    return (
      <div
        className={`max-w-[280px] rounded-2xl p-2 shadow-sm ${
          isSelf
            ? 'bg-brand-500 text-white rounded-tr-sm'
            : 'bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-tl-sm border border-gray-100 dark:border-gray-800'
        }`}
      >
        {replyPreview}
        <FileMessage content={content} isSelf={isSelf} />
      </div>
    );
  }

  // 通话消息：自带卡片样式，不需要气泡
  if (upperType === 'CALL') {
    if (!replyPreview) return <CallMessage content={content} isSelf={isSelf} />;
    return (
      <div
        className={`rounded-2xl p-2 shadow-sm ${
          isSelf
            ? 'bg-brand-500 text-white rounded-tr-sm'
            : 'bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-tl-sm border border-gray-100 dark:border-gray-800'
        }`}
      >
        {replyPreview}
        <CallMessage content={content} isSelf={isSelf} />
      </div>
    );
  }

  // 其他消息（TEXT/AUDIO/VIDEO）：包裹气泡
  let inner: React.ReactNode;
  if (upperType === 'AUDIO') {
    inner = <span className="text-sm">🎵 语音消息</span>;
  } else if (upperType === 'VIDEO') {
    inner = <span className="text-sm">🎬 视频消息</span>;
  } else {
    inner = <span className="text-sm leading-relaxed break-words whitespace-pre-wrap">{content}</span>;
  }

  return (
    <div
      className={`min-w-0 max-w-full px-4 py-2.5 shadow-sm ${
        isSelf
          ? 'bg-brand-500 text-white rounded-2xl rounded-tr-sm'
          : 'bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-2xl rounded-tl-sm border border-gray-100 dark:border-gray-800'
      }`}
    >
      {replyPreview}
      {inner}
    </div>
  );
};
