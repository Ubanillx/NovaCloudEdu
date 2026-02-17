import React, { useRef } from 'react';
import { Upload, X, Loader2 } from 'lucide-react';

interface ImageUploadAreaProps {
  /** 当前预览图 URL（可以是服务器 URL 或 data URL） */
  value: string;
  /** 用户选择文件后的回调，父组件负责上传逻辑 */
  onFileSelect: (file: File) => void;
  /** 图片 URL 变更回调（清除图片、URL 输入） */
  onChange: (url: string) => void;
  /** 标签文本 */
  label?: string;
  /** 是否必填 */
  required?: boolean;
  /** 宽高比 CSS class，默认 aspect-video (16:9) */
  aspectRatio?: string;
  /** 接受的文件类型 */
  accept?: string;
  /** 空状态提示文案 */
  placeholder?: string;
  /** 格式说明文案 */
  hint?: string;
  /** 是否显示 URL 文本输入框 */
  showUrlInput?: boolean;
  /** 是否正在上传 */
  uploading?: boolean;
  /** 是否支持拖拽上传 */
  enableDrop?: boolean;
}

const ImageUploadArea: React.FC<ImageUploadAreaProps> = ({
  value,
  onFileSelect,
  onChange,
  label,
  required = false,
  aspectRatio = 'aspect-video',
  accept = 'image/jpeg,image/png,image/webp',
  placeholder = '点击选择图片',
  hint = 'JPG / PNG / WebP，最大 5MB',
  showUrlInput = false,
  uploading = false,
  enableDrop = false,
}) => {
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) onFileSelect(file);
    if (fileInputRef.current) fileInputRef.current.value = '';
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    if (uploading) return;
    const file = e.dataTransfer.files?.[0];
    if (file) onFileSelect(file);
  };

  return (
    <div>
      {label && (
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          {label}{required && ' *'}
        </label>
      )}
      <div className={showUrlInput ? 'space-y-3' : ''}>
        <input
          ref={fileInputRef}
          type="file"
          accept={accept}
          onChange={handleFileChange}
          className="hidden"
        />
        <div
          onClick={() => { if (!value && !uploading) fileInputRef.current?.click(); }}
          onDragOver={enableDrop ? (e) => { e.preventDefault(); e.stopPropagation(); } : undefined}
          onDragEnter={enableDrop ? (e) => { e.preventDefault(); e.stopPropagation(); } : undefined}
          onDrop={enableDrop ? handleDrop : undefined}
          className={`relative w-full ${aspectRatio} rounded-xl overflow-hidden border-2 border-dashed transition-all ${
            value
              ? 'border-gray-200 dark:border-gray-700'
              : 'border-gray-200 dark:border-gray-700 hover:border-brand-400 dark:hover:border-brand-500 cursor-pointer'
          } bg-gray-50 dark:bg-gray-800/50`}
        >
          {value ? (
            <>
              <img src={value} alt="预览" className="w-full h-full object-cover" />
              <div className="absolute inset-0 bg-black/0 hover:bg-black/40 transition-all group flex items-center justify-center">
                <div className="opacity-0 group-hover:opacity-100 transition-opacity flex items-center gap-2">
                  <button type="button" onClick={(e) => { e.stopPropagation(); fileInputRef.current?.click(); }}
                    className="p-2 bg-white/90 text-gray-700 rounded-lg hover:bg-white transition-colors" title="更换图片">
                    <Upload size={18} />
                  </button>
                  <button type="button" onClick={(e) => { e.stopPropagation(); onChange(''); }}
                    className="p-2 bg-red-500/90 text-white rounded-lg hover:bg-red-600 transition-colors" title="删除图片">
                    <X size={18} />
                  </button>
                </div>
              </div>
            </>
          ) : uploading ? (
            <div className="absolute inset-0 flex flex-col items-center justify-center gap-2">
              <Loader2 size={32} className="text-brand-500 animate-spin" />
              <p className="text-sm font-medium text-brand-500">上传中...</p>
            </div>
          ) : (
            <div className="absolute inset-0 flex flex-col items-center justify-center gap-2">
              <Upload size={32} className="text-gray-300 dark:text-gray-600" />
              <p className="text-sm text-gray-400 dark:text-gray-500">{placeholder}</p>
              {hint && <p className="text-xs text-gray-300 dark:text-gray-600">{hint}</p>}
            </div>
          )}
        </div>

        {showUrlInput && (
          <div className="flex gap-3">
            <button
              type="button"
              onClick={() => fileInputRef.current?.click()}
              disabled={uploading}
              className="flex items-center gap-2 px-4 py-2.5 bg-brand-600 text-white rounded-xl text-sm font-medium hover:bg-brand-700 transition-colors disabled:opacity-50"
            >
              {uploading ? <Loader2 size={16} className="animate-spin" /> : <Upload size={16} />}
              <span>{uploading ? '上传中...' : '上传图片'}</span>
            </button>
            <input
              type="text"
              value={value}
              onChange={(e) => onChange(e.target.value)}
              placeholder="或输入图片URL"
              className="flex-1 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all text-sm"
            />
          </div>
        )}
      </div>
    </div>
  );
};

export default ImageUploadArea;
