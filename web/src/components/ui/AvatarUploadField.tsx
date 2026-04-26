import React, { useRef, useState } from 'react';
import { Camera, Loader2, Trash2, Upload } from 'lucide-react';
import { apiClient } from '../../api';
import toast from './Toast';
import { Avatar } from './Avatar';

interface AvatarUploadFieldProps {
  label: string;
  value: string;
  onChange: (url: string) => void;
  name?: string;
  icon?: 'user' | 'group';
  businessType?: string;
  disabled?: boolean;
  hint?: string;
  maxSize?: number;
}

const DEFAULT_MAX_SIZE = 5 * 1024 * 1024;

const AvatarUploadField: React.FC<AvatarUploadFieldProps> = ({
  label,
  value,
  onChange,
  name,
  icon = 'user',
  businessType = 'group/avatar',
  disabled = false,
  hint = '支持 JPG / PNG / WebP，最大 5MB',
  maxSize = DEFAULT_MAX_SIZE,
}) => {
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [uploading, setUploading] = useState(false);

  const handleFile = async (file: File) => {
    if (!file.type.startsWith('image/')) {
      toast.warning('请选择图片文件');
      return;
    }
    if (file.size > maxSize) {
      toast.warning(`图片大小不能超过 ${Math.round(maxSize / 1024 / 1024)}MB`);
      return;
    }

    setUploading(true);
    try {
      const formData = new FormData();
      formData.append('file', file);
      const res = await apiClient.post(`/api/file/upload/${businessType}`, formData, {
        headers: { 'Content-Type': undefined as any },
      });
      if ((res.data?.code === 0 || res.data?.code === 200) && res.data?.data?.fileUrl) {
        onChange(res.data.data.fileUrl);
        toast.success('头像上传成功');
      } else {
        toast.error(res.data?.message || '头像上传失败');
      }
    } catch {
      toast.error('头像上传失败');
    } finally {
      setUploading(false);
      if (fileInputRef.current) fileInputRef.current.value = '';
    }
  };

  const handleSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) handleFile(file);
  };

  const openPicker = () => {
    if (!disabled && !uploading) fileInputRef.current?.click();
  };

  return (
    <div>
      <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
        {label}
      </label>
      <input
        ref={fileInputRef}
        type="file"
        accept="image/jpeg,image/png,image/webp"
        onChange={handleSelect}
        className="hidden"
      />
      <div className="flex items-center gap-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/50 px-3 py-3">
        <div className="relative">
          <Avatar src={value} name={name} icon={icon} size="xl" />
          {uploading && (
            <div className="absolute inset-0 rounded-xl bg-gray-950/45 flex items-center justify-center">
              <Loader2 size={20} className="text-white animate-spin" />
            </div>
          )}
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-sm font-medium text-gray-900 dark:text-white truncate">
            {value ? '已设置头像' : '未设置头像'}
          </p>
          <p className="text-xs text-gray-400 mt-0.5">{hint}</p>
          {!disabled && (
            <div className="flex items-center gap-2 mt-3">
              <button
                type="button"
                onClick={openPicker}
                disabled={uploading}
                className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium text-white bg-brand-500 hover:bg-brand-600 disabled:opacity-50 transition-colors active:scale-[0.98]"
              >
                {uploading ? <Loader2 size={14} className="animate-spin" /> : value ? <Camera size={14} /> : <Upload size={14} />}
                {value ? '更换头像' : '上传头像'}
              </button>
              {value && (
                <button
                  type="button"
                  onClick={() => onChange('')}
                  disabled={uploading}
                  className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-medium text-rose-600 dark:text-rose-300 bg-rose-50 dark:bg-rose-900/20 hover:bg-rose-100 dark:hover:bg-rose-900/30 disabled:opacity-50 transition-colors active:scale-[0.98]"
                >
                  <Trash2 size={14} />
                  移除
                </button>
              )}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default AvatarUploadField;
