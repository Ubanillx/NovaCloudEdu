import React, { useState, useEffect, useCallback, useRef } from 'react';
import {
  Search,
  Plus,
  Edit2,
  Trash2,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  Database,
  FileText,
  Upload,
  Zap,
  ArrowLeft,
  File,
  AlertCircle,
  CheckCircle2,
  Clock,
  Loader2,
  Layers,
  Settings2,
  FileType,
  FileCode,
  BookOpen,
  Eye,
  Save,
  Hash,
  type LucideIcon,
  SearchCheck,
  ChevronDown,
  ChevronUp,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type {
  KnowledgeBaseVO,
  KnowledgeDocumentVO,
  CreateKnowledgeBaseCommand,
  UpdateKnowledgeBaseCommand
} from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 获取当前用户ID（字符串形式，避免雪花ID精度丢失）
const getCurrentUserId = (): number => {
  const userInfoStr = localStorage.getItem('user_info');
  const userInfo = userInfoStr ? JSON.parse(userInfoStr) : null;
  // 运行时已是字符串，用 as unknown as number 满足TS类型
  return (userInfo?.id ?? '') as unknown as number;
};

// 状态配置
const KB_STATUS_MAP: Record<string, { label: string; color: string }> = {
  ACTIVE: { label: '活跃', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' },
  ARCHIVED: { label: '已归档', color: 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700' },
};

const DOC_STATUS_MAP: Record<string, { label: string; color: string; icon: React.ElementType }> = {
  PENDING: { label: '待处理', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800', icon: Clock },
  PROCESSING: { label: '处理中', color: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400 border-blue-200 dark:border-blue-800', icon: Loader2 },
  COMPLETED: { label: '已完成', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800', icon: CheckCircle2 },
  FAILED: { label: '失败', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800', icon: AlertCircle },
};

const FILE_TYPE_ICONS: Record<string, { icon: LucideIcon; color: string }> = {
  PDF: { icon: FileType, color: 'text-red-500' },
  TXT: { icon: FileText, color: 'text-gray-500' },
  DOCX: { icon: File, color: 'text-blue-500' },
  DOC: { icon: File, color: 'text-blue-500' },
  MD: { icon: FileCode, color: 'text-purple-500' },
  HTML: { icon: FileCode, color: 'text-orange-500' },
  EPUB: { icon: BookOpen, color: 'text-teal-500' },
};

const FileTypeIcon: React.FC<{ fileType?: string; size?: number }> = ({ fileType, size = 18 }) => {
  const config = FILE_TYPE_ICONS[fileType || ''] || { icon: File, color: 'text-gray-400' };
  const Icon = config.icon;
  return <Icon size={size} className={config.color} />;
};

// 格式化时间
const formatDateTime = (dateStr?: string) => {
  if (!dateStr) return '-';
  return new Date(dateStr).toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
  });
};

// 格式化文件大小
const formatFileSize = (bytes?: number) => {
  if (!bytes || bytes === 0) return '-';
  const size = Number(bytes);
  if (size < 1024) return `${size} B`;
  if (size < 1024 * 1024) return `${(size / 1024).toFixed(1)} KB`;
  return `${(size / (1024 * 1024)).toFixed(1)} MB`;
};

// ==================== 知识库表单弹窗 ====================
interface KBFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  knowledgeBase?: KnowledgeBaseVO | null;
}

const KBFormModal: React.FC<KBFormModalProps> = ({ isOpen, onClose, onSuccess, knowledgeBase }) => {
  const isEdit = !!knowledgeBase;
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState<CreateKnowledgeBaseCommand>({
    name: '',
    description: '',
    chunkSize: 500,
    chunkOverlap: 50,
  });

  useEffect(() => {
    if (knowledgeBase) {
      setFormData({
        name: knowledgeBase.name || '',
        description: knowledgeBase.description || '',
        chunkSize: knowledgeBase.chunkSize || 500,
        chunkOverlap: knowledgeBase.chunkOverlap || 50,
      });
    } else {
      setFormData({ name: '', description: '', chunkSize: 500, chunkOverlap: 50 });
    }
  }, [knowledgeBase, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.name.trim()) {
      toast.warning('请输入知识库名称');
      return;
    }

    setLoading(true);
    try {
      if (isEdit && knowledgeBase?.id) {
        const updateData: UpdateKnowledgeBaseCommand = {
          name: formData.name,
          description: formData.description,
          chunkSize: formData.chunkSize,
          chunkOverlap: formData.chunkOverlap,
        };
        const response = await api.kbUpdate({
          id: knowledgeBase.id,
          updateKnowledgeBaseCommand: updateData,
        });
        if (response.data.code === 0) {
          toast.success('更新成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '更新失败');
        }
      } else {
        const userId = getCurrentUserId();
        const response = await api.kbCreate({
          userId,
          createKnowledgeBaseCommand: formData,
        });
        if (response.data.code === 0) {
          toast.success('创建成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '创建失败');
        }
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    } finally {
      setLoading(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 max-h-[90vh] overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑知识库' : '新建知识库'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4 overflow-y-auto max-h-[calc(90vh-140px)]">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">名称 *</label>
            <input
              type="text"
              value={formData.name}
              onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="请输入知识库名称"
              maxLength={128}
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
            <textarea
              value={formData.description}
              onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
              rows={3}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="请输入知识库描述"
              maxLength={2000}
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                分块大小
                <span className="text-xs text-gray-400 ml-1">(字符)</span>
              </label>
              <input
                type="number"
                value={formData.chunkSize}
                onChange={(e) => setFormData(prev => ({ ...prev, chunkSize: Number(e.target.value) || 500 }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                min={100}
                max={5000}
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                分块重叠
                <span className="text-xs text-gray-400 ml-1">(字符)</span>
              </label>
              <input
                type="number"
                value={formData.chunkOverlap}
                onChange={(e) => setFormData(prev => ({ ...prev, chunkOverlap: Number(e.target.value) || 50 }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                min={0}
                max={1000}
              />
            </div>
          </div>
        </form>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button type="button" onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">
            取消
          </button>
          <button
            onClick={handleSubmit}
            disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {loading && <RefreshCw size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建知识库'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ==================== 添加文档弹窗（支持批量） ====================
interface FileItem {
  uid: string;
  name: string;
  fileType: string;
  fileUrl: string;
  fileSize: number;
  content: string;
  status: 'pending' | 'uploading' | 'ready' | 'submitting' | 'done' | 'error';
  errorMsg?: string;
}

interface AddDocumentModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  knowledgeBaseId: number;
}

let fileUidCounter = 0;

const AddDocumentModal: React.FC<AddDocumentModalProps> = ({ isOpen, onClose, onSuccess, knowledgeBaseId }) => {
  const [submitting, setSubmitting] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [fileItems, setFileItems] = useState<FileItem[]>([]);
  const [inputMode, setInputMode] = useState<'text' | 'file'>('file');
  const [textForm, setTextForm] = useState({ name: '', content: '' });

  useEffect(() => {
    if (isOpen) {
      setFileItems([]);
      setTextForm({ name: '', content: '' });
      setInputMode('file');
    }
  }, [isOpen]);

  const ALLOWED_TYPES = ['PDF', 'TXT', 'DOCX', 'DOC', 'MD', 'HTML', 'EPUB'];
  const MAX_SIZE = 20 * 1024 * 1024;

  // 处理多文件选择
  const handleFilesSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;

    const newItems: FileItem[] = [];

    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const ext = file.name.split('.').pop()?.toUpperCase() || 'TXT';

      if (!ALLOWED_TYPES.includes(ext)) {
        toast.error(`跳过不支持的文件: ${file.name} (.${ext})`);
        continue;
      }
      if (file.size > MAX_SIZE) {
        toast.error(`跳过过大的文件: ${file.name} (超过 20MB)`);
        continue;
      }

      const uid = `file_${++fileUidCounter}`;
      newItems.push({
        uid,
        name: file.name,
        fileType: ext,
        fileUrl: '',
        fileSize: file.size,
        content: '',
        status: 'uploading',
      });
    }

    setFileItems(prev => [...prev, ...newItems]);

    // 异步处理每个文件的内容读取/上传
    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const ext = file.name.split('.').pop()?.toUpperCase() || 'TXT';
      if (!ALLOWED_TYPES.includes(ext) || file.size > MAX_SIZE) continue;

      const matchItem = newItems.find(it => it.name === file.name && it.fileType === ext);
      if (!matchItem) continue;

      try {
        if (['TXT', 'MD', 'HTML'].includes(ext)) {
          const text = await file.text();
          setFileItems(prev => prev.map(it =>
            it.uid === matchItem.uid ? { ...it, content: text, status: 'ready' } : it
          ));
        } else {
          const uploadFormData = new FormData();
          uploadFormData.append('file', file);

          const response = await apiClient.post('/api/file/upload/system/document', uploadFormData, {
            headers: { 'Content-Type': 'multipart/form-data' },
          });

          if (response.data?.code === 0 && response.data?.data?.fileUrl) {
            setFileItems(prev => prev.map(it =>
              it.uid === matchItem.uid ? { ...it, fileUrl: response.data.data.fileUrl, status: 'ready' } : it
            ));
          } else {
            setFileItems(prev => prev.map(it =>
              it.uid === matchItem.uid ? { ...it, status: 'error', errorMsg: response.data?.message || '上传失败' } : it
            ));
          }
        }
      } catch (error: any) {
        setFileItems(prev => prev.map(it =>
          it.uid === matchItem.uid ? { ...it, status: 'error', errorMsg: error?.response?.data?.message || '文件处理失败' } : it
        ));
      }
    }

    if (fileInputRef.current) fileInputRef.current.value = '';
  };

  // 移除某个文件
  const removeFile = (uid: string) => {
    setFileItems(prev => prev.filter(it => it.uid !== uid));
  };

  // 提交所有文档
  const handleSubmit = async () => {
    if (inputMode === 'text') {
      // 单文本模式
      if (!textForm.name.trim()) { toast.warning('请输入文档名称'); return; }
      if (!textForm.content.trim()) { toast.warning('请输入文档内容'); return; }

      setSubmitting(true);
      try {
        const userId = getCurrentUserId();
        const response = await api.kbAddDocument({
          id: knowledgeBaseId,
          userId,
          requestBody: {
            name: textForm.name as unknown as object,
            fileType: 'TXT' as unknown as object,
            fileUrl: '' as unknown as object,
            fileSize: textForm.content.length as unknown as object,
            content: textForm.content as unknown as object,
          },
        });
        if (response.data.code === 0) {
          toast.success('文档添加成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '添加失败');
        }
      } catch (error: any) {
        toast.error(error?.response?.data?.message || '操作失败');
      } finally {
        setSubmitting(false);
      }
      return;
    }

    // 批量文件模式
    const readyItems = fileItems.filter(it => it.status === 'ready');
    if (readyItems.length === 0) {
      toast.warning('没有可提交的文件，请先选择文件');
      return;
    }

    setSubmitting(true);
    const userId = getCurrentUserId();
    let successCount = 0;
    let failCount = 0;

    for (const item of readyItems) {
      setFileItems(prev => prev.map(it =>
        it.uid === item.uid ? { ...it, status: 'submitting' } : it
      ));
      try {
        const response = await api.kbAddDocument({
          id: knowledgeBaseId,
          userId,
          requestBody: {
            name: item.name as unknown as object,
            fileType: item.fileType as unknown as object,
            fileUrl: (item.fileUrl || '') as unknown as object,
            fileSize: item.fileSize as unknown as object,
            content: (item.content || '') as unknown as object,
          },
        });
        if (response.data.code === 0) {
          successCount++;
          setFileItems(prev => prev.map(it =>
            it.uid === item.uid ? { ...it, status: 'done' } : it
          ));
        } else {
          failCount++;
          setFileItems(prev => prev.map(it =>
            it.uid === item.uid ? { ...it, status: 'error', errorMsg: response.data.message || '添加失败' } : it
          ));
        }
      } catch (error: any) {
        failCount++;
        setFileItems(prev => prev.map(it =>
          it.uid === item.uid ? { ...it, status: 'error', errorMsg: error?.response?.data?.message || '操作失败' } : it
        ));
      }
    }

    setSubmitting(false);

    if (failCount === 0) {
      toast.success(`全部 ${successCount} 个文档添加成功`);
      onSuccess();
      onClose();
    } else {
      toast.warning(`完成 ${successCount} 个，失败 ${failCount} 个`);
      onSuccess();
    }
  };

  const getFileStatusIcon = (item: FileItem) => {
    switch (item.status) {
      case 'uploading': return <Loader2 size={16} className="text-blue-500 animate-spin" />;
      case 'ready': return <CheckCircle2 size={16} className="text-green-500" />;
      case 'submitting': return <Loader2 size={16} className="text-brand-500 animate-spin" />;
      case 'done': return <CheckCircle2 size={16} className="text-green-600" />;
      case 'error': return <AlertCircle size={16} className="text-red-500" />;
      default: return <Clock size={16} className="text-gray-400" />;
    }
  };

  const getFileStatusText = (item: FileItem) => {
    switch (item.status) {
      case 'uploading': return '读取中...';
      case 'ready': return '就绪';
      case 'submitting': return '提交中...';
      case 'done': return '已完成';
      case 'error': return item.errorMsg || '失败';
      default: return '等待';
    }
  };

  const readyCount = fileItems.filter(it => it.status === 'ready').length;
  const totalCount = fileItems.length;

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">添加文档</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Body */}
        <div className="p-6 space-y-4 overflow-y-auto max-h-[calc(90vh-140px)]">
          {/* 输入方式切换 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">添加方式</label>
            <div className="flex gap-2">
              <button
                type="button"
                onClick={() => setInputMode('file')}
                className={`flex-1 px-4 py-2.5 rounded-xl text-sm font-medium border transition-all ${
                  inputMode === 'file'
                    ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-500 text-brand-700 dark:text-brand-400'
                    : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800'
                }`}
              >
                <Upload size={16} className="inline mr-2" />
                批量上传文件
              </button>
              <button
                type="button"
                onClick={() => setInputMode('text')}
                className={`flex-1 px-4 py-2.5 rounded-xl text-sm font-medium border transition-all ${
                  inputMode === 'text'
                    ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-500 text-brand-700 dark:text-brand-400'
                    : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800'
                }`}
              >
                <FileText size={16} className="inline mr-2" />
                直接输入文本
              </button>
            </div>
          </div>

          {inputMode === 'file' ? (
            <>
              {/* 文件选择区域 */}
              <div>
                <input
                  ref={fileInputRef}
                  type="file"
                  accept=".txt,.md,.html,.pdf,.docx,.doc,.epub"
                  onChange={handleFilesSelect}
                  className="hidden"
                  multiple
                />
                <div
                  onClick={() => !submitting && fileInputRef.current?.click()}
                  className={`border-2 border-dashed rounded-xl p-6 text-center transition-colors ${
                    submitting
                      ? 'border-gray-200 dark:border-gray-800 cursor-not-allowed opacity-50'
                      : 'border-gray-300 dark:border-gray-700 cursor-pointer hover:border-brand-500 dark:hover:border-brand-400'
                  }`}
                >
                  <div className="flex flex-col items-center gap-2">
                    <Upload size={28} className="text-gray-400" />
                    <p className="text-sm text-gray-500">点击选择文件（支持多选）</p>
                    <p className="text-xs text-gray-400">TXT, MD, HTML, PDF, DOCX, EPUB · 单文件最大 20MB</p>
                  </div>
                </div>
              </div>

              {/* 文件列表 */}
              {fileItems.length > 0 && (
                <div>
                  <div className="flex items-center justify-between mb-2">
                    <label className="text-sm font-medium text-gray-700 dark:text-gray-300">
                      文件列表
                      <span className="text-xs text-gray-400 ml-2">({readyCount} 就绪 / {totalCount} 总计)</span>
                    </label>
                    {fileItems.some(it => it.status === 'done') && (
                      <button
                        type="button"
                        onClick={() => setFileItems(prev => prev.filter(it => it.status !== 'done'))}
                        className="text-xs text-gray-400 hover:text-red-500 transition-colors"
                      >
                        清除已完成
                      </button>
                    )}
                  </div>
                  <div className="space-y-2 max-h-[280px] overflow-y-auto pr-1">
                    {fileItems.map((item) => (
                      <div
                        key={item.uid}
                        className={`flex items-center gap-3 px-4 py-3 rounded-xl border transition-all ${
                          item.status === 'done'
                            ? 'bg-green-50/50 dark:bg-green-900/10 border-green-200 dark:border-green-800/50'
                            : item.status === 'error'
                            ? 'bg-red-50/50 dark:bg-red-900/10 border-red-200 dark:border-red-800/50'
                            : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700'
                        }`}
                      >
                        <div className="w-8 h-8 rounded-lg bg-white dark:bg-gray-800 flex items-center justify-center flex-shrink-0 border border-gray-100 dark:border-gray-700">
                          <FileTypeIcon fileType={item.fileType} size={16} />
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{item.name}</p>
                          <div className="flex items-center gap-2 mt-0.5">
                            <span className="text-xs text-gray-400">{item.fileType} · {formatFileSize(item.fileSize)}</span>
                            <span className="text-xs flex items-center gap-1">
                              {getFileStatusIcon(item)}
                              <span className={
                                item.status === 'done' ? 'text-green-600' :
                                item.status === 'error' ? 'text-red-500' :
                                item.status === 'submitting' ? 'text-brand-500' :
                                'text-gray-500'
                              }>
                                {getFileStatusText(item)}
                              </span>
                            </span>
                          </div>
                        </div>
                        {(item.status === 'ready' || item.status === 'error' || item.status === 'pending') && !submitting && (
                          <button
                            type="button"
                            onClick={() => removeFile(item.uid)}
                            className="p-1.5 text-gray-400 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all flex-shrink-0"
                          >
                            <X size={14} />
                          </button>
                        )}
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </>
          ) : (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文档名称 *</label>
                <input
                  type="text"
                  value={textForm.name}
                  onChange={(e) => setTextForm(prev => ({ ...prev, name: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="请输入文档名称"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文档内容 *</label>
                <textarea
                  value={textForm.content}
                  onChange={(e) => setTextForm(prev => ({ ...prev, content: e.target.value }))}
                  rows={10}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none font-mono text-sm"
                  placeholder="请粘贴或输入文档内容..."
                />
                {textForm.content && (
                  <p className="text-xs text-gray-400 mt-1">{textForm.content.length} 字符</p>
                )}
              </div>
            </>
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-between px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <div className="text-xs text-gray-400">
            {inputMode === 'file' && totalCount > 0 && (
              <span>{readyCount} 个文件就绪</span>
            )}
          </div>
          <div className="flex items-center gap-3">
            <button type="button" onClick={onClose} disabled={submitting} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors disabled:opacity-50">
              取消
            </button>
            <button
              onClick={handleSubmit}
              disabled={submitting || (inputMode === 'file' && readyCount === 0) || (inputMode === 'text' && (!textForm.name.trim() || !textForm.content.trim()))}
              className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
            >
              {submitting && <RefreshCw size={16} className="animate-spin" />}
              {inputMode === 'file'
                ? (submitting ? '提交中...' : `添加 ${readyCount} 个文档`)
                : (submitting ? '提交中...' : '添加文档')
              }
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

// ==================== 分块查看弹窗 ====================
interface ChunkViewerModalProps {
  isOpen: boolean;
  onClose: () => void;
  knowledgeBaseId: number;
  document: KnowledgeDocumentVO;
}

interface ChunkItem {
  id: number;
  knowledgeBaseId: number;
  documentId: number;
  content: string;
  chunkIndex: number;
  metadata: string;
  createTime: string;
}

const ChunkViewerModal: React.FC<ChunkViewerModalProps> = ({ isOpen, onClose, knowledgeBaseId, document: doc }) => {
  const [chunks, setChunks] = useState<ChunkItem[]>([]);
  const [loading, setLoading] = useState(false);
  const [page, setPage] = useState(0);
  const [total, setTotal] = useState(0);
  const pageSize = 10;

  const fetchChunks = useCallback(async () => {
    if (!doc.id) return;
    setLoading(true);
    try {
      const response = await api.kbListChunks({
        id: knowledgeBaseId as unknown as number,
        docId: doc.id as unknown as number,
        page,
        size: pageSize,
      });
      if (response.data.code === 0) {
        setChunks((response.data as any).data?.chunks || []);
        setTotal((response.data as any).data?.total || 0);
      }
    } catch {
      toast.error('获取分块列表失败');
    } finally {
      setLoading(false);
    }
  }, [doc.id, knowledgeBaseId, page]);

  useEffect(() => {
    if (isOpen) {
      setPage(0);
    }
  }, [isOpen]);

  useEffect(() => {
    if (isOpen) fetchChunks();
  }, [isOpen, fetchChunks]);

  if (!isOpen) return null;

  const totalPages = Math.ceil(total / pageSize);

  return (
    <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4" onClick={onClose}>
      <div className="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-4xl max-h-[85vh] flex flex-col border border-gray-200 dark:border-gray-700" onClick={(e) => e.stopPropagation()}>
        {/* Header */}
        <div className="flex items-center justify-between p-6 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-accent-50 dark:bg-accent-900/20 rounded-lg">
              <Layers size={20} className="text-accent-600 dark:text-accent-400" />
            </div>
            <div>
              <h2 className="text-lg font-bold text-gray-900 dark:text-white">{doc.name}</h2>
              <p className="text-sm text-gray-500">共 {total} 个分块 · {doc.fileType} · {formatFileSize(doc.fileSize)}</p>
            </div>
          </div>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all">
            <X size={20} />
          </button>
        </div>

        {/* Content */}
        <div className="flex-1 overflow-y-auto p-6 space-y-3">
          {loading ? (
            Array.from({ length: 3 }).map((_, i) => (
              <div key={i} className="animate-pulse bg-gray-50 dark:bg-gray-800 rounded-xl p-4 space-y-2">
                <div className="h-4 bg-gray-200 dark:bg-gray-700 rounded w-1/4" />
                <div className="h-3 bg-gray-200 dark:bg-gray-700 rounded w-full" />
                <div className="h-3 bg-gray-200 dark:bg-gray-700 rounded w-3/4" />
              </div>
            ))
          ) : chunks.length > 0 ? (
            chunks.map((chunk) => (
              <div key={String(chunk.id)} className="bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-gray-100 dark:border-gray-700 overflow-hidden">
                <div className="flex items-center justify-between px-4 py-2 bg-gray-100/50 dark:bg-gray-800 border-b border-gray-100 dark:border-gray-700">
                  <div className="flex items-center gap-2">
                    <Hash size={14} className="text-accent-500" />
                    <span className="text-xs font-bold text-gray-600 dark:text-gray-300">分块 {chunk.chunkIndex + 1}</span>
                  </div>
                  <span className="text-xs text-gray-400">{chunk.content.length} 字符</span>
                </div>
                <div className="p-4">
                  <pre className="text-sm text-gray-700 dark:text-gray-300 whitespace-pre-wrap break-words font-sans leading-relaxed max-h-48 overflow-y-auto">
                    {chunk.content}
                  </pre>
                </div>
              </div>
            ))
          ) : (
            <div className="text-center py-12">
              <Layers size={40} className="mx-auto text-gray-300 mb-3" />
              <p className="text-gray-500">暂无分块数据</p>
              <p className="text-gray-400 text-sm mt-1">请先对文档进行向量化处理</p>
            </div>
          )}
        </div>

        {/* Pagination Footer */}
        {total > 0 && (
          <div className="px-6 py-4 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between">
            <p className="text-sm text-gray-500">
              第 <span className="font-bold">{page + 1}</span> / {totalPages} 页，共 <span className="font-bold">{total}</span> 个分块
            </p>
            <div className="flex items-center gap-2">
              <button
                disabled={page === 0 || loading}
                onClick={() => setPage(p => p - 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronLeft size={16} />
              </button>
              <button
                disabled={page >= totalPages - 1 || loading}
                onClick={() => setPage(p => p + 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronRight size={16} />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

// ==================== 文档编辑弹窗 ====================
interface EditDocumentModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  knowledgeBaseId: number;
  document: KnowledgeDocumentVO;
}

const EditDocumentModal: React.FC<EditDocumentModalProps> = ({ isOpen, onClose, onSuccess, knowledgeBaseId, document: doc }) => {
  const [name, setName] = useState('');
  const [fileType, setFileType] = useState('');
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (isOpen && doc) {
      setName(doc.name || '');
      setFileType(doc.fileType || 'TXT');
    }
  }, [isOpen, doc]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!name.trim()) {
      toast.error('文档名称不能为空');
      return;
    }
    setSaving(true);
    try {
      const response = await api.kbUpdateDocument({
        id: knowledgeBaseId as unknown as number,
        docId: doc.id as unknown as number,
        requestBody: { name: name.trim(), fileType },
      });
      if (response.data.code === 0) {
        toast.success('更新成功');
        onSuccess();
        onClose();
      } else {
        toast.error(response.data.message || '更新失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    } finally {
      setSaving(false);
    }
  };

  if (!isOpen) return null;

  const fileTypes = ['TXT', 'PDF', 'DOCX', 'DOC', 'MD', 'HTML', 'EPUB'];

  return (
    <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4" onClick={onClose}>
      <div className="bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md border border-gray-200 dark:border-gray-700" onClick={(e) => e.stopPropagation()}>
        <div className="flex items-center justify-between p-6 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-brand-50 dark:bg-brand-900/20 rounded-lg">
              <Edit2 size={20} className="text-brand-600 dark:text-brand-400" />
            </div>
            <h2 className="text-lg font-bold text-gray-900 dark:text-white">编辑文档信息</h2>
          </div>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all">
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-5">
          <div>
            <label className="block text-sm font-bold text-gray-700 dark:text-gray-300 mb-2">文档名称</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none focus:border-brand-500 transition-all"
              placeholder="请输入文档名称"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-bold text-gray-700 dark:text-gray-300 mb-2">文件类型</label>
            <select
              value={fileType}
              onChange={(e) => setFileType(e.target.value)}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white outline-none focus:border-brand-500 transition-all"
            >
              {fileTypes.map(t => (
                <option key={t} value={t}>{t}</option>
              ))}
            </select>
          </div>

          <div className="flex gap-3 pt-2">
            <button
              type="button"
              onClick={onClose}
              className="flex-1 px-4 py-2.5 border border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-300 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-800 transition-all font-medium"
            >
              取消
            </button>
            <button
              type="submit"
              disabled={saving}
              className="flex-1 flex items-center justify-center gap-2 px-4 py-2.5 bg-brand-600 text-white rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95 disabled:opacity-50 font-bold"
            >
              {saving ? <Loader2 size={18} className="animate-spin" /> : <Save size={18} />}
              保存
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

// ==================== 文档详情面板 ====================
interface DocumentPanelProps {
  knowledgeBase: KnowledgeBaseVO;
  onBack: () => void;
}

const DocumentPanel: React.FC<DocumentPanelProps> = ({ knowledgeBase, onBack }) => {
  const [documents, setDocuments] = useState<KnowledgeDocumentVO[]>([]);
  const [loading, setLoading] = useState(false);
  const [page, setPage] = useState(0);
  const [addModalOpen, setAddModalOpen] = useState(false);
  const [processingIds, setProcessingIds] = useState<Set<string>>(new Set());
  const [batchProcessing, setBatchProcessing] = useState(false);
  const [chunkViewDoc, setChunkViewDoc] = useState<KnowledgeDocumentVO | null>(null);
  const [editDoc, setEditDoc] = useState<KnowledgeDocumentVO | null>(null);

  const fetchDocuments = useCallback(async () => {
    if (!knowledgeBase.id) return;
    setLoading(true);
    try {
      const response = await api.kbListDocuments({ id: knowledgeBase.id, page, size: 20 });
      if (response.data.code === 0) {
        setDocuments(response.data.data || []);
      } else {
        toast.error(response.data.message || '获取文档列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [knowledgeBase.id, page]);

  useEffect(() => {
    fetchDocuments();
  }, [fetchDocuments]);

  const handleDeleteDocument = async (doc: KnowledgeDocumentVO) => {
    if (!doc.id || !knowledgeBase.id) return;
    if (!window.confirm(`确定要删除文档 "${doc.name}" 吗？此操作不可恢复。`)) return;

    try {
      const response = await api.kbDeleteDocument({ id: knowledgeBase.id, docId: doc.id });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchDocuments();
      } else {
        toast.error(response.data.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const handleProcessDocument = async (doc: KnowledgeDocumentVO) => {
    if (!doc.id || !knowledgeBase.id) return;
    const docIdStr = String(doc.id);
    setProcessingIds(prev => new Set(prev).add(docIdStr));
    try {
      const response = await api.kbProcessDocument({ id: knowledgeBase.id, docId: doc.id });
      if (response.data.code === 0) {
        toast.success('向量化成功');
        fetchDocuments();
      } else {
        toast.error(response.data.message || '向量化失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '向量化失败');
    } finally {
      setProcessingIds(prev => {
        const next = new Set(prev);
        next.delete(docIdStr);
        return next;
      });
    }
  };

  const handleBatchProcess = async () => {
    if (!knowledgeBase.id) return;
    setBatchProcessing(true);
    try {
      const response = await api.kbBatchProcessByKnowledgeBase({ id: knowledgeBase.id });
      if (response.data.code === 0) {
        const result = response.data.data;
        toast.success(`批量向量化完成: 成功 ${result?.successCount || 0} / 共 ${result?.total || 0}`);
        fetchDocuments();
      } else {
        toast.error(response.data.message || '批量向量化失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '批量向量化失败');
    } finally {
      setBatchProcessing(false);
    }
  };

  const getDocStatusBadge = (status?: string) => {
    const config = DOC_STATUS_MAP[status || ''] || DOC_STATUS_MAP.PENDING;
    const Icon = config.icon;
    return (
      <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-lg text-xs font-bold border ${config.color}`}>
        <Icon size={12} className={status === 'PROCESSING' ? 'animate-spin' : ''} />
        {config.label}
      </span>
    );
  };

  const pendingCount = documents.filter(d => d.status === 'PENDING').length;

  return (
    <div className="space-y-6 animate-in fade-in duration-300">
      {/* Header with back button */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div className="flex items-center gap-4">
          <button
            onClick={onBack}
            className="p-2 text-gray-500 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-xl transition-all"
          >
            <ArrowLeft size={22} />
          </button>
          <div>
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white">{knowledgeBase.name}</h1>
            <p className="text-gray-500 dark:text-gray-400 mt-1 text-sm">
              {knowledgeBase.description || '暂无描述'} · 
              <span className="ml-1">{knowledgeBase.embeddingModel}</span> · 
              <span className="ml-1">分块 {knowledgeBase.chunkSize}/{knowledgeBase.chunkOverlap}</span>
            </p>
          </div>
        </div>
        <div className="flex items-center gap-3">
          {pendingCount > 0 && (
            <button
              onClick={handleBatchProcess}
              disabled={batchProcessing}
              className="flex items-center gap-2 px-4 py-2 bg-amber-500 text-white rounded-xl text-sm font-bold hover:bg-amber-600 shadow-lg shadow-amber-500/20 transition-all active:scale-95 disabled:opacity-50"
            >
              {batchProcessing ? <Loader2 size={18} className="animate-spin" /> : <Zap size={18} />}
              <span>全部向量化 ({pendingCount})</span>
            </button>
          )}
          <button
            onClick={() => setAddModalOpen(true)}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>添加文档</span>
          </button>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-brand-50 dark:bg-brand-900/20 rounded-lg">
              <FileText size={20} className="text-brand-600 dark:text-brand-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">{knowledgeBase.documentCount || 0}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">文档数</p>
            </div>
          </div>
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-accent-50 dark:bg-accent-900/20 rounded-lg">
              <Layers size={20} className="text-accent-600 dark:text-accent-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">{knowledgeBase.chunkCount || 0}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">分块数</p>
            </div>
          </div>
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-green-50 dark:bg-green-900/20 rounded-lg">
              <CheckCircle2 size={20} className="text-green-600 dark:text-green-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">
                {documents.filter(d => d.status === 'COMPLETED').length}
              </p>
              <p className="text-xs text-gray-500 dark:text-gray-400">已向量化</p>
            </div>
          </div>
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-amber-50 dark:bg-amber-900/20 rounded-lg">
              <Clock size={20} className="text-amber-600 dark:text-amber-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">{pendingCount}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">待处理</p>
            </div>
          </div>
        </div>
      </div>

      {/* Document Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">文档信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">类型</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">大小</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">分块数</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 3 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={6} className="px-6 py-6">
                      <div className="flex gap-4">
                        <div className="w-10 h-10 bg-gray-100 dark:bg-gray-800 rounded-lg" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/5" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : documents.length > 0 ? (
                documents.map((doc) => {
                  const isProcessing = processingIds.has(String(doc.id));
                  return (
                    <tr key={String(doc.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 rounded-lg bg-gray-50 dark:bg-gray-800 flex items-center justify-center flex-shrink-0">
                            <FileTypeIcon fileType={doc.fileType || 'TXT'} />
                          </div>
                          <div className="min-w-0">
                            <p className="font-bold text-sm text-gray-900 dark:text-white truncate max-w-[200px]">{doc.name}</p>
                            <p className="text-xs text-gray-400 mt-0.5">{formatDateTime(doc.createTime)}</p>
                          </div>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-600 dark:text-gray-300 font-medium">{doc.fileType}</span>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-500">{formatFileSize(doc.fileSize)}</span>
                      </td>
                      <td className="px-6 py-4">
                        {getDocStatusBadge(doc.status)}
                        {doc.status === 'FAILED' && doc.errorMessage && (
                          <p className="text-xs text-red-500 mt-1 max-w-[160px] truncate" title={doc.errorMessage}>
                            {doc.errorMessage}
                          </p>
                        )}
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-600 dark:text-gray-300">{doc.chunkCount || 0}</span>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                          {doc.status === 'COMPLETED' && (doc.chunkCount ?? 0) > 0 && (
                            <button
                              onClick={() => setChunkViewDoc(doc)}
                              className="p-2 text-gray-400 hover:text-accent-600 hover:bg-accent-50 dark:hover:bg-accent-900/20 rounded-lg transition-all"
                              title="查看分块"
                            >
                              <Eye size={18} />
                            </button>
                          )}
                          <button
                            onClick={() => setEditDoc(doc)}
                            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                            title="编辑"
                          >
                            <Edit2 size={18} />
                          </button>
                          {(doc.status === 'PENDING' || doc.status === 'FAILED') && (
                            <button
                              onClick={() => handleProcessDocument(doc)}
                              disabled={isProcessing}
                              className="p-2 text-gray-400 hover:text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded-lg transition-all disabled:opacity-50"
                              title="向量化"
                            >
                              {isProcessing ? <Loader2 size={18} className="animate-spin" /> : <Zap size={18} />}
                            </button>
                          )}
                          <button
                            onClick={() => handleDeleteDocument(doc)}
                            className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                            title="删除"
                          >
                            <Trash2 size={18} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })
              ) : (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <File size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无文档</p>
                      <p className="text-gray-400 text-sm mt-1">点击"添加文档"开始上传</p>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between">
          <p className="text-sm text-gray-500 dark:text-gray-400">
            共 <span className="font-bold text-gray-900 dark:text-white">{documents.length}</span> 个文档
          </p>
          <div className="flex items-center gap-2">
            <button
              disabled={page === 0 || loading}
              onClick={() => setPage(p => p - 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronLeft size={18} />
            </button>
            <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">{page + 1}</span>
            <button
              disabled={documents.length < 20 || loading}
              onClick={() => setPage(p => p + 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>

      {/* Add Document Modal */}
      <AddDocumentModal
        isOpen={addModalOpen}
        onClose={() => setAddModalOpen(false)}
        onSuccess={fetchDocuments}
        knowledgeBaseId={knowledgeBase.id!}
      />

      {/* Chunk Viewer Modal */}
      {chunkViewDoc && (
        <ChunkViewerModal
          isOpen={!!chunkViewDoc}
          onClose={() => setChunkViewDoc(null)}
          knowledgeBaseId={knowledgeBase.id!}
          document={chunkViewDoc}
        />
      )}

      {/* Edit Document Modal */}
      {editDoc && (
        <EditDocumentModal
          isOpen={!!editDoc}
          onClose={() => setEditDoc(null)}
          onSuccess={fetchDocuments}
          knowledgeBaseId={knowledgeBase.id!}
          document={editDoc}
        />
      )}
    </div>
  );
};

// ==================== 召回测试弹窗 ====================
interface RecallChunk {
  index: number;
  score: number;
  documentId: number;
  documentName: string | null;
  content: string;
  chunkIndex: number | null;
  metadata: Record<string, unknown> | null;
}

interface RecallTestResult {
  query: string;
  topK: number;
  similarityThreshold: number;
  totalResults: number;
  searchTimeMs: number;
  chunks: RecallChunk[];
}

interface RecallTestModalProps {
  isOpen: boolean;
  onClose: () => void;
  knowledgeBase: KnowledgeBaseVO | null;
}

const RecallTestModal: React.FC<RecallTestModalProps> = ({ isOpen, onClose, knowledgeBase }) => {
  const [query, setQuery] = useState('');
  const [topK, setTopK] = useState(5);
  const [threshold, setThreshold] = useState(0.3);
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<RecallTestResult | null>(null);
  const [expandedChunks, setExpandedChunks] = useState<Set<number>>(new Set());
  const [showAdvanced, setShowAdvanced] = useState(false);

  useEffect(() => {
    if (!isOpen) {
      setResult(null);
      setExpandedChunks(new Set());
    }
  }, [isOpen]);

  const handleTest = async () => {
    if (!knowledgeBase?.id || !query.trim()) return;
    setLoading(true);
    setResult(null);
    try {
      const response = await api.kbRecallTest({
        id: knowledgeBase.id as unknown as number,
        requestBody: { query: query.trim(), topK, similarityThreshold: threshold } as any,
      });
      if (response.data.code === 0) {
        setResult((response.data as any).data);
      } else {
        toast.error(response.data.message || '召回测试失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '召回测试请求失败');
    } finally {
      setLoading(false);
    }
  };

  const toggleChunk = (index: number) => {
    setExpandedChunks(prev => {
      const next = new Set(prev);
      if (next.has(index)) next.delete(index);
      else next.add(index);
      return next;
    });
  };

  const getScoreColor = (score: number) => {
    if (score >= 0.8) return 'text-green-600 bg-green-50 border-green-200 dark:text-green-400 dark:bg-green-900/20 dark:border-green-800';
    if (score >= 0.6) return 'text-blue-600 bg-blue-50 border-blue-200 dark:text-blue-400 dark:bg-blue-900/20 dark:border-blue-800';
    if (score >= 0.4) return 'text-amber-600 bg-amber-50 border-amber-200 dark:text-amber-400 dark:bg-amber-900/20 dark:border-amber-800';
    return 'text-red-600 bg-red-50 border-red-200 dark:text-red-400 dark:bg-red-900/20 dark:border-red-800';
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4" onClick={onClose}>
      <div
        className="bg-white dark:bg-gray-900 rounded-2xl shadow-xl border border-gray-200 dark:border-gray-700 w-full max-w-3xl max-h-[85vh] flex flex-col"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="flex items-center justify-between p-6 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand-50 to-accent-50 dark:from-brand-900/20 dark:to-accent-900/20 flex items-center justify-center border border-brand-100 dark:border-brand-800">
              <SearchCheck size={20} className="text-brand-600 dark:text-brand-400" />
            </div>
            <div>
              <h2 className="text-lg font-bold text-gray-900 dark:text-white">召回测试</h2>
              <p className="text-sm text-gray-500 dark:text-gray-400">{knowledgeBase?.name}</p>
            </div>
          </div>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg transition-all">
            <X size={20} />
          </button>
        </div>

        {/* Query Input */}
        <div className="p-6 space-y-4 border-b border-gray-100 dark:border-gray-800">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">查询文本</label>
            <textarea
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="输入要测试的查询文本..."
              rows={3}
              className="w-full px-4 py-3 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none focus:border-brand-500/50 focus:ring-2 focus:ring-brand-500/20 transition-all resize-none"
              onKeyDown={(e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                  e.preventDefault();
                  handleTest();
                }
              }}
            />
          </div>

          {/* Advanced Settings */}
          <div>
            <button
              onClick={() => setShowAdvanced(!showAdvanced)}
              className="flex items-center gap-1.5 text-sm text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 transition-colors"
            >
              <Settings2 size={14} />
              <span>高级设置</span>
              {showAdvanced ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
            </button>
            {showAdvanced && (
              <div className="mt-3 grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">返回条数 (TopK)</label>
                  <input
                    type="number"
                    value={topK}
                    onChange={(e) => setTopK(Math.max(1, Math.min(20, Number(e.target.value))))}
                    min={1}
                    max={20}
                    className="w-full px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                  />
                </div>
                <div>
                  <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">相似度阈值</label>
                  <input
                    type="number"
                    value={threshold}
                    onChange={(e) => setThreshold(Math.max(0, Math.min(1, Number(e.target.value))))}
                    min={0}
                    max={1}
                    step={0.05}
                    className="w-full px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white outline-none focus:border-brand-500/50 transition-all"
                  />
                </div>
              </div>
            )}
          </div>

          <button
            onClick={handleTest}
            disabled={loading || !query.trim()}
            className="w-full flex items-center justify-center gap-2 px-4 py-2.5 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg shadow-brand-600/20 transition-all active:scale-[0.98]"
          >
            {loading ? <Loader2 size={16} className="animate-spin" /> : <SearchCheck size={16} />}
            <span>{loading ? '检索中...' : '开始召回测试'}</span>
          </button>
        </div>

        {/* Results */}
        <div className="flex-1 overflow-y-auto p-6">
          {result ? (
            <div className="space-y-4">
              {/* Stats Bar */}
              <div className="flex items-center justify-between px-4 py-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-gray-100 dark:border-gray-800">
                <div className="flex items-center gap-4 text-sm">
                  <span className="text-gray-500">召回 <b className="text-gray-900 dark:text-white">{result.totalResults}</b> 条</span>
                  <span className="text-gray-500">耗时 <b className="text-gray-900 dark:text-white">{result.searchTimeMs}</b>ms</span>
                </div>
                <span className="text-xs text-gray-400">TopK={result.topK} · 阈值={result.similarityThreshold}</span>
              </div>

              {/* Chunks */}
              {result.chunks.length > 0 ? (
                <div className="space-y-3">
                  {result.chunks.map((chunk) => {
                    const expanded = expandedChunks.has(chunk.index);
                    return (
                      <div
                        key={chunk.index}
                        className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-700 overflow-hidden hover:border-brand-300 dark:hover:border-brand-700 transition-colors"
                      >
                        {/* Chunk Header */}
                        <div
                          className="flex items-center justify-between px-4 py-3 cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors"
                          onClick={() => toggleChunk(chunk.index)}
                        >
                          <div className="flex items-center gap-3">
                            <span className="w-7 h-7 flex items-center justify-center rounded-lg bg-gray-100 dark:bg-gray-800 text-xs font-bold text-gray-500">
                              {chunk.index}
                            </span>
                            <span className={`px-2 py-0.5 rounded-md text-xs font-bold border ${getScoreColor(chunk.score)}`}>
                              {(chunk.score * 100).toFixed(1)}%
                            </span>
                            <span className="text-sm text-gray-500 dark:text-gray-400 truncate max-w-[300px]">
                              {chunk.documentName || `文档 #${String(chunk.documentId)}`}
                            </span>
                          </div>
                          {expanded ? <ChevronUp size={16} className="text-gray-400" /> : <ChevronDown size={16} className="text-gray-400" />}
                        </div>

                        {/* Chunk Content (expandable) */}
                        {expanded && (
                          <div className="px-4 pb-4 border-t border-gray-100 dark:border-gray-800">
                            <pre className="mt-3 text-sm text-gray-700 dark:text-gray-300 whitespace-pre-wrap font-sans leading-relaxed bg-gray-50 dark:bg-gray-800/30 rounded-lg p-4 max-h-64 overflow-y-auto">
                              {chunk.content}
                            </pre>
                            {chunk.metadata && Object.keys(chunk.metadata).length > 0 && (
                              <div className="mt-2 text-xs text-gray-400">
                                <span className="font-medium">元数据：</span>
                                {JSON.stringify(chunk.metadata)}
                              </div>
                            )}
                          </div>
                        )}
                      </div>
                    );
                  })}
                </div>
              ) : (
                <div className="text-center py-12">
                  <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
                    <Search size={28} className="text-gray-300" />
                  </div>
                  <p className="text-gray-500 font-medium">未找到相关内容</p>
                  <p className="text-gray-400 text-sm mt-1">尝试调整查询文本或降低相似度阈值</p>
                </div>
              )}
            </div>
          ) : !loading ? (
            <div className="text-center py-12">
              <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
                <SearchCheck size={28} className="text-gray-300" />
              </div>
              <p className="text-gray-500 font-medium">输入查询文本开始测试</p>
              <p className="text-gray-400 text-sm mt-1">测试知识库的向量检索 + Rerank 召回效果</p>
            </div>
          ) : null}
        </div>
      </div>
    </div>
  );
};

// ==================== 主页面 ====================
export const KnowledgeBaseManagementPage: React.FC = () => {
  const [knowledgeBases, setKnowledgeBases] = useState<KnowledgeBaseVO[]>([]);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingKB, setEditingKB] = useState<KnowledgeBaseVO | null>(null);
  const [selectedKB, setSelectedKB] = useState<KnowledgeBaseVO | null>(null);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [page, setPage] = useState(0);
  const [recallTestKB, setRecallTestKB] = useState<KnowledgeBaseVO | null>(null);

  const fetchKnowledgeBases = useCallback(async () => {
    setLoading(true);
    try {
      const userId = getCurrentUserId();
      let response;
      if (searchKeyword.trim()) {
        response = await api.kbSearch({ keyword: searchKeyword, userId, page, size: 20 });
      } else {
        response = await api.kbListByCreator({ userId, page, size: 20 });
      }
      if (response.data.code === 0) {
        setKnowledgeBases(response.data.data || []);
      } else {
        toast.error(response.data.message || '获取知识库列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [searchKeyword, page]);

  useEffect(() => {
    fetchKnowledgeBases();
  }, [fetchKnowledgeBases]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setPage(0);
    fetchKnowledgeBases();
  };

  const handleDelete = async (kb: KnowledgeBaseVO) => {
    if (!kb.id) return;
    if (!window.confirm(`确定要删除知识库 "${kb.name}" 吗？\n将同时删除所有文档和向量数据，此操作不可恢复。`)) return;

    try {
      const response = await api.kbDelete({ id: kb.id });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchKnowledgeBases();
      } else {
        toast.error(response.data.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const getStatusBadge = (status?: string) => {
    const config = KB_STATUS_MAP[status || ''] || KB_STATUS_MAP.ACTIVE;
    return (
      <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${config.color}`}>
        {config.label}
      </span>
    );
  };

  // 如果选中了某个知识库，显示文档面板
  if (selectedKB) {
    return (
      <DocumentPanel
        knowledgeBase={selectedKB}
        onBack={() => { setSelectedKB(null); fetchKnowledgeBases(); }}
      />
    );
  }

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">知识库管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理AI知识库，上传文档并进行向量化处理</p>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => { setEditingKB(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>新建知识库</span>
          </button>
        </div>
      </div>

      {/* Search Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm">
        <form onSubmit={handleSearch} className="flex gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input
              type="text"
              placeholder="搜索知识库名称..."
              value={searchKeyword}
              onChange={(e) => setSearchKeyword(e.target.value)}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <button
            type="button"
            onClick={() => fetchKnowledgeBases()}
            className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
          >
            <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
          </button>
        </form>
      </div>

      {/* Knowledge Base Grid */}
      {loading ? (
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-5">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 animate-pulse">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-12 h-12 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                <div className="flex-1 space-y-2">
                  <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-2/3" />
                  <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                </div>
              </div>
              <div className="space-y-2">
                <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-full" />
                <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-4/5" />
              </div>
            </div>
          ))}
        </div>
      ) : knowledgeBases.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-5">
          {knowledgeBases.map((kb) => (
            <div
              key={String(kb.id)}
              className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm hover:shadow-lg transition-all duration-300 group cursor-pointer overflow-hidden"
              onClick={() => setSelectedKB(kb)}
            >
              {/* Card Header */}
              <div className="p-6 pb-4">
                <div className="flex items-start justify-between mb-3">
                  <div className="flex items-center gap-3">
                    <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-50 to-accent-50 dark:from-brand-900/20 dark:to-accent-900/20 flex items-center justify-center border border-brand-100 dark:border-brand-800 group-hover:scale-105 transition-transform">
                      <Database size={22} className="text-brand-600 dark:text-brand-400" />
                    </div>
                    <div>
                      <h3 className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors line-clamp-1">
                        {kb.name}
                      </h3>
                      {getStatusBadge(kb.status)}
                    </div>
                  </div>
                  <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity" onClick={(e) => e.stopPropagation()}>
                    <button
                      onClick={() => setRecallTestKB(kb)}
                      className="p-1.5 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                      title="召回测试"
                    >
                      <SearchCheck size={16} />
                    </button>
                    <button
                      onClick={() => { setEditingKB(kb); setModalOpen(true); }}
                      className="p-1.5 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                      title="编辑"
                    >
                      <Edit2 size={16} />
                    </button>
                    <button
                      onClick={() => handleDelete(kb)}
                      className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                      title="删除"
                    >
                      <Trash2 size={16} />
                    </button>
                  </div>
                </div>
                <p className="text-sm text-gray-500 dark:text-gray-400 line-clamp-2 min-h-[40px]">
                  {kb.description || '暂无描述'}
                </p>
              </div>

              {/* Card Footer - Stats */}
              <div className="px-6 py-3 bg-gray-50/50 dark:bg-gray-800/30 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between text-xs text-gray-400">
                <div className="flex items-center gap-4">
                  <span className="flex items-center gap-1">
                    <FileText size={14} />
                    {kb.documentCount || 0} 文档
                  </span>
                  <span className="flex items-center gap-1">
                    <Layers size={14} />
                    {kb.chunkCount || 0} 分块
                  </span>
                </div>
                <div className="flex items-center gap-1">
                  <Settings2 size={14} />
                  {kb.chunkSize}/{kb.chunkOverlap}
                </div>
              </div>

              {/* Card Footer - Time */}
              <div className="px-6 py-2.5 border-t border-gray-50 dark:border-gray-800/50 text-xs text-gray-400">
                创建于 {formatDateTime(kb.createTime)}
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-12 text-center">
          <div className="flex flex-col items-center">
            <div className="w-20 h-20 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
              <Database size={40} className="text-gray-300" />
            </div>
            <p className="text-gray-500 dark:text-gray-400 font-medium text-lg">暂无知识库</p>
            <p className="text-gray-400 text-sm mt-2">点击"新建知识库"开始创建</p>
          </div>
        </div>
      )}

      {/* Pagination */}
      {knowledgeBases.length > 0 && (
        <div className="flex items-center justify-center gap-2">
          <button
            disabled={page === 0 || loading}
            onClick={() => setPage(p => p - 1)}
            className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
          >
            <ChevronLeft size={18} />
          </button>
          <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">{page + 1}</span>
          <button
            disabled={knowledgeBases.length < 20 || loading}
            onClick={() => setPage(p => p + 1)}
            className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
          >
            <ChevronRight size={18} />
          </button>
        </div>
      )}

      {/* Knowledge Base Form Modal */}
      <KBFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingKB(null); }}
        onSuccess={fetchKnowledgeBases}
        knowledgeBase={editingKB}
      />

      {/* Recall Test Modal */}
      <RecallTestModal
        isOpen={!!recallTestKB}
        onClose={() => setRecallTestKB(null)}
        knowledgeBase={recallTestKB}
      />
    </div>
  );
};
