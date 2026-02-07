import { useState, useCallback, useRef } from 'react';
import { apiClient } from '../../api';

/** 上传结果 */
interface UploadResult {
  fileUrl?: string;
  fileName?: string;
  originalName?: string;
  fileSize?: number;
  businessType?: string;
}

/** 图片文件扩展名 */
const IMAGE_EXTS = new Set(['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'svg']);

/** 判断文件是否是图片 */
const isImageFile = (file: File): boolean => {
  if (file.type.startsWith('image/')) return true;
  const ext = file.name.split('.').pop()?.toLowerCase() || '';
  return IMAGE_EXTS.has(ext);
};

/** 格式化文件大小为带单位的字符串（与 Flutter 端 _formatFileSize 一致） */
const formatFileSize = (bytes: number): string => {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  if (bytes < 1024 * 1024 * 1024) return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
  return `${(bytes / (1024 * 1024 * 1024)).toFixed(1)} GB`;
};

interface UseChatUploadOptions {
  onSend: (content: string, type: string) => void;
}

/**
 * 聊天文件上传 hook
 * 封装图片/文件的上传逻辑，支持按钮选择和拖拽上传
 */
export function useChatUpload({ onSend }: UseChatUploadOptions) {
  const [uploading, setUploading] = useState(false);
  const imageInputRef = useRef<HTMLInputElement>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  /** 上传单个文件到后端 */
  const uploadFile = async (file: File): Promise<UploadResult | null> => {
    const formData = new FormData();
    formData.append('file', file);

    try {
      const res = await apiClient.post('/api/file/upload/chat/file', formData, {
        headers: { 'Content-Type': undefined },
      });
      const data = res.data;
      if ((data?.code === 0 || data?.code === 200) && data?.data) {
        return data.data as UploadResult;
      }
      return null;
    } catch (e) {
      console.error('文件上传失败:', e);
      return null;
    }
  };

  /** 处理文件上传（自动判断图片/文件类型） */
  const handleFileUpload = useCallback(async (files: FileList | File[]) => {
    if (uploading) return;
    setUploading(true);

    try {
      for (const file of Array.from(files)) {
        const result = await uploadFile(file);
        if (!result?.fileUrl) {
          console.error('上传失败:', file.name);
          continue;
        }

        if (isImageFile(file)) {
          // 图片消息：content 就是图片 URL
          onSend(result.fileUrl, 'IMAGE');
        } else {
          // 文件消息：格式 fileName|fileUrl|fileSize
          const content = `${file.name}|${result.fileUrl}|${formatFileSize(file.size)}`;
          onSend(content, 'FILE');
        }
      }
    } finally {
      setUploading(false);
    }
  }, [uploading, onSend]);

  /** 点击选择图片 */
  const triggerImagePick = useCallback(() => {
    imageInputRef.current?.click();
  }, []);

  /** 点击选择文件 */
  const triggerFilePick = useCallback(() => {
    fileInputRef.current?.click();
  }, []);

  /** input onChange 处理 */
  const handleInputChange = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (files && files.length > 0) {
      handleFileUpload(files);
    }
    // 重置 input 以允许再次选择同一文件
    e.target.value = '';
  }, [handleFileUpload]);

  /** 拖拽相关事件处理 */
  const [isDragging, setIsDragging] = useState(false);
  const dragCounterRef = useRef(0);

  const handleDragEnter = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    dragCounterRef.current++;
    if (e.dataTransfer.types.includes('Files')) {
      setIsDragging(true);
    }
  }, []);

  const handleDragLeave = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    dragCounterRef.current--;
    if (dragCounterRef.current === 0) {
      setIsDragging(false);
    }
  }, []);

  const handleDragOver = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
  }, []);

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    dragCounterRef.current = 0;
    setIsDragging(false);

    const files = e.dataTransfer.files;
    if (files && files.length > 0) {
      handleFileUpload(files);
    }
  }, [handleFileUpload]);

  return {
    uploading,
    isDragging,
    imageInputRef,
    fileInputRef,
    triggerImagePick,
    triggerFilePick,
    handleInputChange,
    handleDragEnter,
    handleDragLeave,
    handleDragOver,
    handleDrop,
    handleFileUpload,
  };
}
