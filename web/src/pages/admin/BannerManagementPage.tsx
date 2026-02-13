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
  Image as ImageIcon,
  Calendar,
  Clock,
  Link2,
  ExternalLink,
  Send,
  XCircle,
  Upload,
  ArrowUpDown
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { 
  BannerResponse, 
  CreateBannerRequest, 
  UpdateBannerRequest,
  QueryBannerRequest 
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

// 跳转类型配置
const LINK_TYPE_OPTIONS = [
  { value: 0, label: '无跳转', icon: null },
  { value: 1, label: '内部路由', icon: Link2 },
  { value: 2, label: '外部链接', icon: ExternalLink },
];

// 图片上传组件
interface ImageUploadProps {
  value?: string;
  onChange: (url: string) => void;
  label?: string;
  aspectRatio?: string;
}

const ImageUpload: React.FC<ImageUploadProps> = ({ value, onChange, label = '轮播图片', aspectRatio = 'aspect-[16/9]' }) => {
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

    if (file.size > 10 * 1024 * 1024) {
      toast.error('图片大小不能超过 10MB');
      return;
    }

    setUploading(true);
    try {
      const formData = new FormData();
      formData.append('file', file);

      const response = await apiClient.post('/api/file/upload/banner', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      });

      if (response.data?.code === 0 && response.data?.data?.fileUrl) {
        const url = response.data.data.fileUrl;
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
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">{label} *</label>
      <div className="space-y-3">
        {/* 预览区域 */}
        <div className={`relative w-full ${aspectRatio} rounded-xl overflow-hidden border-2 border-dashed border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/50 ${!previewUrl ? 'flex items-center justify-center' : ''}`}>
          {previewUrl ? (
            <>
              <img src={previewUrl} alt="预览" className="w-full h-full object-cover" />
              <button
                type="button"
                onClick={() => { setPreviewUrl(''); onChange(''); }}
                className="absolute top-2 right-2 p-1.5 bg-red-500 text-white rounded-lg hover:bg-red-600 transition-colors"
              >
                <X size={14} />
              </button>
            </>
          ) : (
            <div className="text-center p-8">
              <ImageIcon size={48} className="mx-auto text-gray-300 dark:text-gray-600 mb-3" />
              <p className="text-sm text-gray-400 dark:text-gray-500">推荐尺寸: 1920 x 600 像素</p>
            </div>
          )}
        </div>
        
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
            className="flex items-center gap-2 px-4 py-2.5 bg-brand-600 text-white rounded-xl text-sm font-medium hover:bg-brand-700 transition-colors disabled:opacity-50"
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

// 轮播图表单弹窗组件
interface BannerFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  banner?: BannerResponse | null;
}

const BannerFormModal: React.FC<BannerFormModalProps> = ({ isOpen, onClose, onSuccess, banner }) => {
  const isEdit = !!banner;
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState<CreateBannerRequest>({
    title: '',
    imageUrl: '',
    linkType: 0,
    linkUrl: '',
    sort: 0,
    startTime: '',
    endTime: '',
  });

  useEffect(() => {
    if (banner) {
      setFormData({
        title: banner.title || '',
        imageUrl: banner.imageUrl || '',
        linkType: banner.linkType ?? 0,
        linkUrl: banner.linkUrl || '',
        sort: banner.sort || 0,
        startTime: banner.startTime ? banner.startTime.slice(0, 16) : '',
        endTime: banner.endTime ? banner.endTime.slice(0, 16) : '',
      });
    } else {
      setFormData({
        title: '',
        imageUrl: '',
        linkType: 0,
        linkUrl: '',
        sort: 0,
        startTime: '',
        endTime: '',
      });
    }
  }, [banner, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.title.trim()) {
      toast.warning('请输入轮播图标题');
      return;
    }
    if (!formData.imageUrl.trim()) {
      toast.warning('请上传轮播图片');
      return;
    }

    setLoading(true);
    try {
      if (isEdit && banner?.id) {
        const updateData: UpdateBannerRequest = {
          id: banner.id,
          title: formData.title,
          imageUrl: formData.imageUrl,
          linkType: formData.linkType,
          linkUrl: formData.linkUrl || undefined,
          sort: formData.sort,
          startTime: formData.startTime || undefined,
          endTime: formData.endTime || undefined,
          status: banner.status,
        };
        const response = await api.updateBanner({ updateBannerRequest: updateData });
        if (response.data.code === 0) {
          toast.success('更新成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '更新失败');
        }
      } else {
        const response = await api.createBanner({ createBannerRequest: formData });
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
            {isEdit ? '编辑轮播图' : '新增轮播图'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4 overflow-y-auto max-h-[calc(90vh-140px)]">
          {/* 标题 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">轮播图标题 *</label>
            <input
              type="text"
              value={formData.title}
              onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="请输入轮播图标题"
            />
          </div>

          {/* 图片上传 */}
          <ImageUpload
            value={formData.imageUrl}
            onChange={(url) => setFormData(prev => ({ ...prev, imageUrl: url }))}
          />

          {/* 跳转设置 */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">跳转类型</label>
              <select
                value={formData.linkType}
                onChange={(e) => setFormData(prev => ({ ...prev, linkType: parseInt(e.target.value) }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
              >
                {LINK_TYPE_OPTIONS.map(opt => (
                  <option key={opt.value} value={opt.value}>{opt.label}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">跳转地址</label>
              <input
                type="text"
                value={formData.linkUrl}
                onChange={(e) => setFormData(prev => ({ ...prev, linkUrl: e.target.value }))}
                disabled={formData.linkType === 0}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all disabled:opacity-50"
                placeholder={formData.linkType === 1 ? '/path/to/page' : 'https://example.com'}
              />
            </div>
          </div>

          {/* 排序和时间 */}
          <div className="grid grid-cols-3 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">排序权重</label>
              <input
                type="number"
                value={formData.sort}
                onChange={(e) => setFormData(prev => ({ ...prev, sort: parseInt(e.target.value) || 0 }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="值越大越靠前"
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
            {isEdit ? '保存修改' : '创建轮播图'}
          </button>
        </div>
      </div>
    </div>
  );
};

export const BannerManagementPage: React.FC = () => {
  const [banners, setBanners] = useState<BannerResponse[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingBanner, setEditingBanner] = useState<BannerResponse | null>(null);
  const [queryParams, setQueryParams] = useState<QueryBannerRequest>({
    pageNum: 1,
    pageSize: 10,
    title: '',
    status: undefined,
  });

  const fetchBanners = useCallback(async () => {
    setLoading(true);
    try {
      const response = await api.queryBanners({ request: queryParams });
      if (response.data.code === 0) {
        setBanners(response.data.data?.records || []);
        setTotal(response.data.data?.total || 0);
      } else {
        toast.error(response.data.message || '获取轮播图列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [queryParams]);

  useEffect(() => {
    fetchBanners();
  }, [fetchBanners]);

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

  const getLinkTypeBadge = (linkType?: number) => {
    const linkTypeOption = LINK_TYPE_OPTIONS.find(l => l.value === linkType);
    if (!linkTypeOption) return null;
    const Icon = linkTypeOption.icon;
    return (
      <span className="flex items-center gap-1 text-sm text-gray-600 dark:text-gray-300">
        {Icon && <Icon size={14} className="text-gray-400" />}
        {linkTypeOption.label}
      </span>
    );
  };

  // 发布轮播图
  const handlePublish = async (banner: BannerResponse) => {
    if (!banner.id) return;
    try {
      const response = await api.publishBanner({ id: banner.id });
      if (response.data.code === 0) {
        toast.success('发布成功');
        fetchBanners();
      } else {
        toast.error(response.data.message || '发布失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  // 下线轮播图
  const handleOffline = async (banner: BannerResponse) => {
    if (!banner.id) return;
    try {
      const response = await api.offlineBanner({ id: banner.id });
      if (response.data.code === 0) {
        toast.success('已下线');
        fetchBanners();
      } else {
        toast.error(response.data.message || '操作失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  // 删除轮播图
  const handleDelete = async (banner: BannerResponse) => {
    if (!banner.id) return;
    if (!window.confirm(`确定要删除轮播图 "${banner.title}" 吗？此操作不可恢复。`)) {
      return;
    }
    try {
      const response = await api.deleteBanner({ id: banner.id });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchBanners();
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
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">轮播图管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理首页轮播图，支持定时展示和跳转设置</p>
        </div>
        <div className="flex items-center gap-3">
          <button 
            onClick={() => { setEditingBanner(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>新增轮播图</span>
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
              placeholder="搜索轮播图标题..." 
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
              onClick={() => fetchBanners()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </form>
      </div>

      {/* Banner Grid */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        {loading ? (
          <div className="p-8 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {Array.from({ length: 6 }).map((_, i) => (
              <div key={i} className="animate-pulse">
                <div className="aspect-[16/9] bg-gray-100 dark:bg-gray-800 rounded-xl mb-3" />
                <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-3/4 mb-2" />
                <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
              </div>
            ))}
          </div>
        ) : banners.length > 0 ? (
          <div className="p-6 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {banners.map((item) => (
              <div key={item.id} className="group bg-gray-50 dark:bg-gray-800/50 rounded-xl overflow-hidden border border-gray-100 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-700 transition-all">
                {/* 图片预览 */}
                <div className="relative aspect-[16/9] overflow-hidden">
                  <img 
                    src={item.imageUrl} 
                    alt={item.title} 
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                  />
                  {/* 状态标签 */}
                  <div className="absolute top-2 left-2">
                    {getStatusBadge(item.status)}
                  </div>
                  {/* 排序标签 */}
                  <div className="absolute top-2 right-2 px-2 py-1 bg-black/50 backdrop-blur-sm rounded-lg text-xs text-white flex items-center gap-1">
                    <ArrowUpDown size={12} />
                    {item.sort || 0}
                  </div>
                  {/* 操作按钮 */}
                  <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-2">
                    <button 
                      onClick={() => { setEditingBanner(item); setModalOpen(true); }}
                      className="p-2.5 bg-white text-gray-700 rounded-lg hover:bg-brand-600 hover:text-white transition-colors" 
                      title="编辑"
                    >
                      <Edit2 size={18} />
                    </button>
                    {item.status === 0 && (
                      <button 
                        onClick={() => handlePublish(item)}
                        className="p-2.5 bg-white text-gray-700 rounded-lg hover:bg-green-600 hover:text-white transition-colors" 
                        title="发布"
                      >
                        <Send size={18} />
                      </button>
                    )}
                    {item.status === 1 && (
                      <button 
                        onClick={() => handleOffline(item)}
                        className="p-2.5 bg-white text-gray-700 rounded-lg hover:bg-amber-600 hover:text-white transition-colors" 
                        title="下线"
                      >
                        <XCircle size={18} />
                      </button>
                    )}
                    <button 
                      onClick={() => handleDelete(item)}
                      className="p-2.5 bg-white text-gray-700 rounded-lg hover:bg-red-600 hover:text-white transition-colors" 
                      title="删除"
                    >
                      <Trash2 size={18} />
                    </button>
                  </div>
                </div>
                {/* 信息区域 */}
                <div className="p-4">
                  <h3 className="font-bold text-gray-900 dark:text-white mb-2 group-hover:text-brand-600 transition-colors">
                    <TruncateWithTooltip text={item.title || ''} maxWidth={200} />
                  </h3>
                  <div className="space-y-2 text-sm">
                    <div className="flex items-center justify-between">
                      {getLinkTypeBadge(item.linkType)}
                      {item.linkUrl && (
                        <span className="text-xs text-gray-400 truncate max-w-[120px]" title={item.linkUrl}>
                          {item.linkUrl}
                        </span>
                      )}
                    </div>
                    <div className="flex items-center gap-4 text-xs text-gray-400">
                      <div className="flex items-center gap-1">
                        <Clock size={12} />
                        <span>{item.startTime ? formatDateTime(item.startTime).split(' ')[0] : '立即'}</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <Calendar size={12} />
                        <span>{item.endTime ? formatDateTime(item.endTime).split(' ')[0] : '永久'}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="p-12 text-center">
            <div className="w-20 h-20 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
              <ImageIcon size={40} className="text-gray-300" />
            </div>
            <p className="text-gray-500 dark:text-gray-400 font-medium">暂无轮播图数据</p>
            <button 
              onClick={() => { setEditingBanner(null); setModalOpen(true); }}
              className="mt-4 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-medium hover:bg-brand-700 transition-colors"
            >
              添加第一张轮播图
            </button>
          </div>
        )}

        {/* Pagination */}
        {banners.length > 0 && (
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
        )}
      </div>

      {/* 轮播图表单弹窗 */}
      <BannerFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingBanner(null); }}
        onSuccess={fetchBanners}
        banner={editingBanner}
      />
    </div>
  );
};
