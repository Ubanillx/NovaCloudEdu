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
  Megaphone,
  Calendar,
  Eye,
  Upload,
  Clock,
  CheckCircle,
  XCircle,
  Send
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { 
  AnnouncementResponse, 
  CreateAnnouncementRequest, 
  UpdateAnnouncementRequest,
  QueryAnnouncementRequest 
} from '../../api/generated/models';
import { toast, TruncateWithTooltip } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 状态配置
const STATUS_OPTIONS = [
  { value: '', label: '全部状态' },
  { value: 0, label: '草稿', color: 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700' },
  { value: 1, label: '已发布', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' },
  { value: 2, label: '已下线', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800' },
];

// 图片上传组件
interface ImageUploadProps {
  value?: string;
  onChange: (url: string) => void;
  label?: string;
}

const ImageUpload: React.FC<ImageUploadProps> = ({ value, onChange, label = '封面图片' }) => {
  const [uploading, setUploading] = useState(false);
  const [previewUrl, setPreviewUrl] = useState(value || '');
  const fileInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    setPreviewUrl(value || '');
  }, [value]);

  const handleFileSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    if (!file.type.startsWith('image/')) {
      toast.error('请选择图片文件');
      return;
    }

    if (file.size > 5 * 1024 * 1024) {
      toast.error('图片大小不能超过 5MB');
      return;
    }

    setUploading(true);
    try {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('businessType', 'announcement');

      const response = await apiClient.post('/api/file/upload', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      });

      if (response.data?.code === 0 && response.data?.data?.url) {
        const url = response.data.data.url;
        setPreviewUrl(url);
        onChange(url);
        toast.success('上传成功');
      } else {
        toast.error(response.data?.message || '上传失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '上传失败');
    } finally {
      setUploading(false);
      if (fileInputRef.current) {
        fileInputRef.current.value = '';
      }
    }
  };

  const handleUrlInput = (url: string) => {
    setPreviewUrl(url);
    onChange(url);
  };

  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">{label}</label>
      <div className="space-y-3">
        {/* 预览区域 */}
        {previewUrl && (
          <div className="relative w-full h-40 rounded-xl overflow-hidden border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/50">
            <img src={previewUrl} alt="预览" className="w-full h-full object-cover" />
            <button
              type="button"
              onClick={() => { setPreviewUrl(''); onChange(''); }}
              className="absolute top-2 right-2 p-1.5 bg-red-500 text-white rounded-lg hover:bg-red-600 transition-colors"
            >
              <X size={14} />
            </button>
          </div>
        )}
        
        {/* 上传按钮和URL输入 */}
        <div className="flex gap-3">
          <input
            ref={fileInputRef}
            type="file"
            accept="image/*"
            onChange={handleFileSelect}
            className="hidden"
          />
          <button
            type="button"
            onClick={() => fileInputRef.current?.click()}
            disabled={uploading}
            className="flex items-center gap-2 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors disabled:opacity-50"
          >
            {uploading ? <RefreshCw size={16} className="animate-spin" /> : <Upload size={16} />}
            <span>{uploading ? '上传中...' : '上传图片'}</span>
          </button>
          <input
            type="text"
            value={previewUrl}
            onChange={(e) => handleUrlInput(e.target.value)}
            placeholder="或输入图片URL"
            className="flex-1 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all text-sm"
          />
        </div>
      </div>
    </div>
  );
};

// 公告表单弹窗组件
interface AnnouncementFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  announcement?: AnnouncementResponse | null;
}

const AnnouncementFormModal: React.FC<AnnouncementFormModalProps> = ({ isOpen, onClose, onSuccess, announcement }) => {
  const isEdit = !!announcement;
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState<CreateAnnouncementRequest>({
    title: '',
    content: '',
    sort: 0,
    startTime: '',
    endTime: '',
    coverImage: '',
  });

  useEffect(() => {
    if (announcement) {
      setFormData({
        title: announcement.title || '',
        content: announcement.content || '',
        sort: announcement.sort || 0,
        startTime: announcement.startTime ? announcement.startTime.slice(0, 16) : '',
        endTime: announcement.endTime ? announcement.endTime.slice(0, 16) : '',
        coverImage: announcement.coverImage || '',
      });
    } else {
      setFormData({
        title: '',
        content: '',
        sort: 0,
        startTime: '',
        endTime: '',
        coverImage: '',
      });
    }
  }, [announcement, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.title.trim()) {
      toast.warning('请输入公告标题');
      return;
    }
    if (!formData.content.trim()) {
      toast.warning('请输入公告内容');
      return;
    }

    setLoading(true);
    try {
      if (isEdit && announcement?.id) {
        const updateData: UpdateAnnouncementRequest = {
          id: announcement.id,
          title: formData.title,
          content: formData.content,
          sort: formData.sort,
          status: announcement.status,
          startTime: formData.startTime || undefined,
          endTime: formData.endTime || undefined,
          coverImage: formData.coverImage || undefined,
        };
        const response = await api.updateAnnouncement({ updateAnnouncementRequest: updateData });
        if (response.data.code === 0) {
          toast.success('更新成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '更新失败');
        }
      } else {
        const response = await api.createAnnouncement({ createAnnouncementRequest: formData });
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
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑公告' : '新增公告'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4 overflow-y-auto max-h-[calc(90vh-140px)]">
          {/* 标题 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">公告标题 *</label>
            <input
              type="text"
              value={formData.title}
              onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="请输入公告标题"
            />
          </div>

          {/* 内容 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">公告内容 *</label>
            <textarea
              value={formData.content}
              onChange={(e) => setFormData(prev => ({ ...prev, content: e.target.value }))}
              rows={6}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="请输入公告内容"
            />
          </div>

          {/* 封面图片 */}
          <ImageUpload
            value={formData.coverImage}
            onChange={(url) => setFormData(prev => ({ ...prev, coverImage: url }))}
          />

          {/* 排序和时间 */}
          <div className="grid grid-cols-3 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">排序权重</label>
              <input
                type="number"
                value={formData.sort}
                onChange={(e) => setFormData(prev => ({ ...prev, sort: parseInt(e.target.value) || 0 }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="0"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">开始时间</label>
              <input
                type="datetime-local"
                value={formData.startTime}
                onChange={(e) => setFormData(prev => ({ ...prev, startTime: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">结束时间</label>
              <input
                type="datetime-local"
                value={formData.endTime}
                onChange={(e) => setFormData(prev => ({ ...prev, endTime: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              />
            </div>
          </div>
        </form>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            取消
          </button>
          <button
            onClick={handleSubmit}
            disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {loading && <RefreshCw size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建公告'}
          </button>
        </div>
      </div>
    </div>
  );
};

export const AnnouncementManagementPage: React.FC = () => {
  const [announcements, setAnnouncements] = useState<AnnouncementResponse[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingAnnouncement, setEditingAnnouncement] = useState<AnnouncementResponse | null>(null);
  const [queryParams, setQueryParams] = useState<QueryAnnouncementRequest>({
    pageNum: 1,
    pageSize: 10,
    title: '',
    status: undefined,
  });

  const fetchAnnouncements = useCallback(async () => {
    setLoading(true);
    try {
      const response = await api.queryAnnouncements({ queryAnnouncementRequest: queryParams });
      if (response.data.code === 0) {
        setAnnouncements(response.data.data?.records || []);
        setTotal(response.data.data?.total || 0);
      } else {
        toast.error(response.data.message || '获取公告列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [queryParams]);

  useEffect(() => {
    fetchAnnouncements();
  }, [fetchAnnouncements]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setQueryParams(prev => ({ ...prev, pageNum: 1 }));
  };

  const handlePageChange = (newPage: number) => {
    setQueryParams(prev => ({ ...prev, pageNum: newPage }));
  };

  const getStatusBadge = (status?: number) => {
    const statusOption = STATUS_OPTIONS.find(s => s.value === status);
    return statusOption ? (
      <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${statusOption.color}`}>
        {statusOption.label}
      </span>
    ) : null;
  };

  // 发布公告
  const handlePublish = async (announcement: AnnouncementResponse) => {
    if (!announcement.id) return;
    try {
      const response = await api.publishAnnouncement1({ id: announcement.id });
      if (response.data.code === 0) {
        toast.success('发布成功');
        fetchAnnouncements();
      } else {
        toast.error(response.data.message || '发布失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  // 下线公告
  const handleOffline = async (announcement: AnnouncementResponse) => {
    if (!announcement.id) return;
    try {
      const response = await api.offlineAnnouncement({ id: announcement.id });
      if (response.data.code === 0) {
        toast.success('已下线');
        fetchAnnouncements();
      } else {
        toast.error(response.data.message || '操作失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  // 删除公告
  const handleDelete = async (announcement: AnnouncementResponse) => {
    if (!announcement.id) return;
    if (!window.confirm(`确定要删除公告 "${announcement.title}" 吗？此操作不可恢复。`)) {
      return;
    }
    try {
      const response = await api.deleteAnnouncement({ id: announcement.id });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchAnnouncements();
      } else {
        toast.error(response.data.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

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

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">公告管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理系统公告，支持定时发布和下线</p>
        </div>
        <div className="flex items-center gap-3">
          <button 
            onClick={() => { setEditingAnnouncement(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>新增公告</span>
          </button>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <form onSubmit={handleSearch} className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input 
              type="text" 
              placeholder="搜索公告标题..." 
              value={queryParams.title}
              onChange={(e) => setQueryParams(prev => ({ ...prev, title: e.target.value }))}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select 
              value={queryParams.status ?? ''}
              onChange={(e) => setQueryParams(prev => ({ 
                ...prev, 
                status: e.target.value === '' ? undefined : parseInt(e.target.value),
                pageNum: 1 
              }))}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              {STATUS_OPTIONS.map(opt => (
                <option key={String(opt.value)} value={opt.value}>{opt.label}</option>
              ))}
            </select>
            <button 
              type="button"
              onClick={() => fetchAnnouncements()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </form>
      </div>

      {/* Announcement Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">公告信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">展示时间</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">统计</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={5} className="px-6 py-8 h-20">
                      <div className="flex gap-4">
                        <div className="w-16 h-16 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : announcements.length > 0 ? (
                announcements.map((item) => (
                  <tr key={item.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-4">
                        <div className="w-16 h-16 rounded-xl bg-gradient-to-br from-brand-50 to-accent-50 dark:from-gray-800 dark:to-gray-800 p-0.5 border border-gray-100 dark:border-gray-700 flex-shrink-0">
                          {item.coverImage ? (
                            <img src={item.coverImage} alt="" className="w-full h-full rounded-[10px] object-cover" />
                          ) : (
                            <div className="w-full h-full rounded-[10px] flex items-center justify-center bg-white dark:bg-gray-900">
                              <Megaphone size={24} className="text-gray-400" />
                            </div>
                          )}
                        </div>
                        <div className="min-w-0">
                          <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">
                            <TruncateWithTooltip text={item.title || ''} maxWidth={200} />
                          </p>
                          <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">
                            <TruncateWithTooltip text={item.content || ''} maxWidth={280} />
                          </p>
                          <p className="text-xs text-gray-400 dark:text-gray-500 mt-1">
                            创建于 {formatDateTime(item.createTime)}
                          </p>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      {getStatusBadge(item.status)}
                    </td>
                    <td className="px-6 py-4">
                      <div className="space-y-1 text-sm">
                        <div className="flex items-center gap-2 text-gray-600 dark:text-gray-300">
                          <Clock size={14} className="text-gray-400" />
                          <span>{item.startTime ? formatDateTime(item.startTime) : '立即'}</span>
                        </div>
                        <div className="flex items-center gap-2 text-gray-600 dark:text-gray-300">
                          <Calendar size={14} className="text-gray-400" />
                          <span>{item.endTime ? formatDateTime(item.endTime) : '永久'}</span>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="space-y-1 text-sm">
                        <div className="flex items-center gap-2 text-gray-600 dark:text-gray-300">
                          <Eye size={14} className="text-gray-400" />
                          <span>浏览 {item.viewCount || 0}</span>
                        </div>
                        <div className="flex items-center gap-2 text-gray-600 dark:text-gray-300">
                          <CheckCircle size={14} className="text-gray-400" />
                          <span>已读 {item.readCount || 0}</span>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button 
                          onClick={() => { setEditingAnnouncement(item); setModalOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" 
                          title="编辑"
                        >
                          <Edit2 size={18} />
                        </button>
                        {item.status === 0 && (
                          <button 
                            onClick={() => handlePublish(item)}
                            className="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all" 
                            title="发布"
                          >
                            <Send size={18} />
                          </button>
                        )}
                        {item.status === 1 && (
                          <button 
                            onClick={() => handleOffline(item)}
                            className="p-2 text-gray-400 hover:text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded-lg transition-all" 
                            title="下线"
                          >
                            <XCircle size={18} />
                          </button>
                        )}
                        <button 
                          onClick={() => handleDelete(item)}
                          className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" 
                          title="删除"
                        >
                          <Trash2 size={18} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={5} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <Megaphone size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无公告数据</p>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
          <p className="text-sm text-gray-500 dark:text-gray-400">
            共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 条记录
          </p>
          <div className="flex items-center gap-2">
            <button 
              disabled={queryParams.pageNum === 1 || loading}
              onClick={() => handlePageChange((queryParams.pageNum || 1) - 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronLeft size={18} />
            </button>
            <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">
              {queryParams.pageNum} / {Math.ceil(total / (queryParams.pageSize || 10)) || 1}
            </span>
            <button 
              disabled={queryParams.pageNum === Math.ceil(total / (queryParams.pageSize || 10)) || loading || total === 0}
              onClick={() => handlePageChange((queryParams.pageNum || 1) + 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>

      {/* 公告表单弹窗 */}
      <AnnouncementFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingAnnouncement(null); }}
        onSuccess={fetchAnnouncements}
        announcement={editingAnnouncement}
      />
    </div>
  );
};
