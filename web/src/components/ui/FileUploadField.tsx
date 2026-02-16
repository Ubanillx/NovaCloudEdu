import React, { useState, useRef, useCallback } from 'react';
import { Upload, X, RefreshCw, FileVideo, FileText, Link2, ChevronDown, ChevronUp, CheckCircle2 } from 'lucide-react';
import { apiClient } from '../../api';

interface FileUploadFieldProps {
  label: string;
  value: string;
  onChange: (url: string) => void;
  businessType: string;
  accept?: string;
  maxSize?: number;
  placeholder?: string;
  icon?: React.ReactNode;
  hint?: string;
}

interface UploadState {
  uploading: boolean;
  progress: number;
  fileName: string;
  fileSize: number;
  error: string;
  processing: boolean; // 进度100%但等待服务端响应/落盘
}

const formatSize = (bytes: number): string => {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  if (bytes < 1024 * 1024 * 1024) return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
  return `${(bytes / (1024 * 1024 * 1024)).toFixed(1)} GB`;
};

const extractFileName = (url: string): string => {
  if (!url) return '';
  try {
    const path = new URL(url).pathname;
    const parts = path.split('/');
    return decodeURIComponent(parts[parts.length - 1] || '');
  } catch {
    const parts = url.split('/');
    return parts[parts.length - 1]?.split('?')[0] || url;
  }
};

const FileUploadField: React.FC<FileUploadFieldProps> = ({
  label,
  value,
  onChange,
  businessType,
  accept = '*/*',
  maxSize,
  placeholder,
  icon,
  hint,
}) => {
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [uploadState, setUploadState] = useState<UploadState>({
    uploading: false, progress: 0, fileName: '', fileSize: 0, error: '', processing: false,
  });
  const [showManualInput, setShowManualInput] = useState(false);
  const [manualUrl, setManualUrl] = useState('');
  const dragCounterRef = useRef(0);
  const [isDragging, setIsDragging] = useState(false);

  const doUpload = useCallback(async (file: File) => {
    if (maxSize && file.size > maxSize) {
      setUploadState(prev => ({ ...prev, error: `文件大小超过限制 (${formatSize(maxSize)})` }));
      return;
    }

    setUploadState({ uploading: true, progress: 0, fileName: file.name, fileSize: file.size, error: '', processing: false });

    const formData = new FormData();
    formData.append('file', file);

    try {
      const res = await apiClient.post(`/api/file/upload/${businessType}`, formData, {
        // 让浏览器自动设置 multipart 边界，避免因自定义头导致进度事件异常
        headers: { 'Content-Type': undefined as any },
        onUploadProgress: (e) => {
          const total = e.total ?? file.size; // 某些环境 total 为空，回退到文件大小
          if (total) {
            const nextProgress = Math.min(100, Math.round((e.loaded / total) * 100));
            setUploadState(prev => ({ ...prev, progress: nextProgress, processing: nextProgress >= 100 }));
          }
        },
      });

      if ((res.data?.code === 0 || res.data?.code === 200) && res.data?.data?.fileUrl) {
        onChange(res.data.data.fileUrl);
        setUploadState(prev => ({ ...prev, uploading: false, progress: 100, processing: false }));
      } else {
        setUploadState(prev => ({ ...prev, uploading: false, error: res.data?.message || '上传失败', processing: false }));
      }
    } catch (err: any) {
      setUploadState(prev => ({
        ...prev, uploading: false, processing: false,
        error: err?.response?.data?.message || '上传失败，请重试',
      }));
    }
  }, [businessType, maxSize, onChange]);

  const handleFileSelect = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) doUpload(file);
    e.target.value = '';
  }, [doUpload]);

  const handleDragEnter = useCallback((e: React.DragEvent) => {
    e.preventDefault(); e.stopPropagation();
    dragCounterRef.current++;
    if (e.dataTransfer.types.includes('Files')) setIsDragging(true);
  }, []);

  const handleDragLeave = useCallback((e: React.DragEvent) => {
    e.preventDefault(); e.stopPropagation();
    dragCounterRef.current--;
    if (dragCounterRef.current === 0) setIsDragging(false);
  }, []);

  const handleDragOver = useCallback((e: React.DragEvent) => {
    e.preventDefault(); e.stopPropagation();
  }, []);

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault(); e.stopPropagation();
    dragCounterRef.current = 0;
    setIsDragging(false);
    const file = e.dataTransfer.files?.[0];
    if (file) doUpload(file);
  }, [doUpload]);

  const handleManualSubmit = () => {
    if (manualUrl.trim()) {
      onChange(manualUrl.trim());
      setManualUrl('');
      setShowManualInput(false);
    }
  };

  const handleClear = () => {
    onChange('');
    setUploadState({ uploading: false, progress: 0, fileName: '', fileSize: 0, error: '', processing: false });
  };

  const isVideo = accept?.includes('video');
  const defaultIcon = icon || (isVideo ? <FileVideo size={28} /> : <FileText size={28} />);

  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">{label}</label>

      <input ref={fileInputRef} type="file" accept={accept} onChange={handleFileSelect} className="hidden" />

      {/* === 已上传状态 === */}
      {value && !uploadState.uploading ? (
        <div className="flex items-center gap-3 px-4 py-3 bg-green-50/80 dark:bg-green-900/10 border border-green-200 dark:border-green-800/40 rounded-xl">
          <div className="flex-shrink-0 text-green-600 dark:text-green-400">
            <CheckCircle2 size={20} />
          </div>
          <div className="flex-1 min-w-0">
            <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
              {uploadState.fileName || extractFileName(value)}
            </p>
            {uploadState.fileSize > 0 && (
              <p className="text-xs text-gray-500 dark:text-gray-400">{formatSize(uploadState.fileSize)}</p>
            )}
          </div>
          <div className="flex items-center gap-1 flex-shrink-0">
            <button type="button" onClick={() => fileInputRef.current?.click()}
              className="p-1.5 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
              title="替换文件">
              <Upload size={16} />
            </button>
            <button type="button" onClick={handleClear}
              className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
              title="删除文件">
              <X size={16} />
            </button>
          </div>
        </div>
      ) : uploadState.uploading ? (
        /* === 上传中状态 === */
        <div className="px-4 py-3 bg-brand-50/50 dark:bg-brand-900/10 border border-brand-200 dark:border-brand-800/40 rounded-xl">
          <div className="flex items-center gap-3 mb-2">
            <RefreshCw size={18} className="text-brand-500 animate-spin flex-shrink-0" />
            <p className="text-sm font-medium text-gray-900 dark:text-white truncate flex-1">
              {uploadState.fileName}
            </p>
            <span className="text-xs font-bold text-brand-600 dark:text-brand-400 flex-shrink-0">
              {uploadState.progress}%
            </span>
          </div>
          <div className="w-full h-1.5 bg-gray-200 dark:bg-gray-700 rounded-full overflow-hidden">
            <div className="h-full bg-brand-500 rounded-full transition-all duration-300"
              style={{ width: `${uploadState.progress}%` }} />
          </div>
          {uploadState.processing && (
            <p className="text-xs text-gray-500 dark:text-gray-400 mt-1.5">
              上传完成，正在后台处理，请稍候…
            </p>
          )}
          {uploadState.fileSize > 0 && (
            <p className="text-xs text-gray-400 mt-1.5">
              {formatSize(Math.round(uploadState.fileSize * uploadState.progress / 100))} / {formatSize(uploadState.fileSize)}
            </p>
          )}
        </div>
      ) : (
        /* === 空状态 — 拖拽区域 === */
        <div
          onClick={() => fileInputRef.current?.click()}
          onDragEnter={handleDragEnter}
          onDragLeave={handleDragLeave}
          onDragOver={handleDragOver}
          onDrop={handleDrop}
          className={`relative cursor-pointer rounded-xl border-2 border-dashed transition-all duration-200 ${
            isDragging
              ? 'border-brand-400 bg-brand-50/50 dark:bg-brand-900/20'
              : 'border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-700 bg-gray-50/50 dark:bg-gray-800/30 hover:bg-brand-50/30 dark:hover:bg-brand-900/10'
          }`}
        >
          <div className="flex flex-col items-center justify-center py-6 gap-2">
            <div className={`transition-colors ${isDragging ? 'text-brand-500' : 'text-gray-300 dark:text-gray-600'}`}>
              {defaultIcon}
            </div>
            <p className="text-sm text-gray-500 dark:text-gray-400">
              {isDragging ? '松开以上传文件' : (placeholder || '点击或拖拽文件到此处上传')}
            </p>
            {hint && (
              <p className="text-xs text-gray-300 dark:text-gray-600">{hint}</p>
            )}
          </div>
        </div>
      )}

      {/* 错误提示 */}
      {uploadState.error && (
        <p className="text-xs text-red-500 mt-1.5">{uploadState.error}</p>
      )}

      {/* 手动输入 URL 折叠区域 */}
      {!value && !uploadState.uploading && (
        <div className="mt-2">
          <button type="button" onClick={() => setShowManualInput(!showManualInput)}
            className="flex items-center gap-1 text-xs text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors">
            <Link2 size={12} />
            <span>手动输入URL</span>
            {showManualInput ? <ChevronUp size={12} /> : <ChevronDown size={12} />}
          </button>
          {showManualInput && (
            <div className="flex gap-2 mt-1.5">
              <input type="text" value={manualUrl}
                onChange={(e) => setManualUrl(e.target.value)}
                onKeyDown={(e) => { if (e.key === 'Enter') { e.preventDefault(); handleManualSubmit(); } }}
                className="flex-1 px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="https://..." />
              <button type="button" onClick={handleManualSubmit}
                className="px-3 py-2 bg-brand-600 text-white text-xs font-bold rounded-lg hover:bg-brand-700 transition-all flex-shrink-0">
                确认
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default FileUploadField;
