import React, { useState, useEffect, useCallback } from 'react';
import {
  Upload,
  Trash2,
  Eye,
  RefreshCw,
  Search,
  FileText,
  Loader2,
  X,
} from 'lucide-react';
import { PPTApi } from '../../api/generated/api/pptapi';
import { apiClient, Configuration } from '../../api';
import type { PptTemplateListResponse } from '../../api/generated/models';
import { toast } from '../../components/ui';

const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';
const api = new PPTApi(new Configuration(), API_BASE, apiClient);

const PptTemplateManagementPage: React.FC = () => {
  const [templates, setTemplates] = useState<PptTemplateListResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [showUpload, setShowUpload] = useState(false);
  const [uploadLoading, setUploadLoading] = useState(false);
  const [uploadForm, setUploadForm] = useState({ name: '', description: '' });
  const [uploadFile, setUploadFile] = useState<File | null>(null);
  const [previewId, setPreviewId] = useState<string | null>(null);
  const [previewData, setPreviewData] = useState<any>(null);
  const [previewLoading, setPreviewLoading] = useState(false);

  const fetchTemplates = useCallback(async () => {
    setLoading(true);
    try {
      const res = await api.listTemplates();
      const data = (res.data as any)?.data || [];
      setTemplates(data);
    } catch (err) {
      toast.error('加载模板列表失败');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchTemplates();
  }, [fetchTemplates]);

  const handleUpload = async () => {
    if (!uploadFile || !uploadForm.name.trim()) {
      toast.error('请填写模板名称并选择文件');
      return;
    }
    setUploadLoading(true);
    try {
      const formData = new FormData();
      formData.append('file', uploadFile);
      formData.append('name', uploadForm.name);
      if (uploadForm.description) {
        formData.append('description', uploadForm.description);
      }
      await apiClient.post('/api/ppt/templates', formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
      });
      toast.success('模板上传成功');
      setShowUpload(false);
      setUploadForm({ name: '', description: '' });
      setUploadFile(null);
      fetchTemplates();
    } catch (err) {
      toast.error('上传失败');
    } finally {
      setUploadLoading(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('确定删除此模板？')) return;
    try {
      await api.deleteTemplate1({ id: id as unknown as number });
      toast.success('删除成功');
      fetchTemplates();
    } catch {
      toast.error('删除失败');
    }
  };

  const handlePreview = async (id: string) => {
    setPreviewId(id);
    setPreviewLoading(true);
    try {
      const res = await api.getTemplateDetail({ id: id as unknown as number });
      setPreviewData((res.data as any)?.data || null);
    } catch {
      toast.error('加载详情失败');
    } finally {
      setPreviewLoading(false);
    }
  };

  const filtered = templates.filter(t =>
    !searchQuery || (t.name || '').toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">PPT 模板管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理 PPT 生成助手使用的模板</p>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={fetchTemplates}
            className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
          >
            <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
          </button>
          <button
            onClick={() => setShowUpload(true)}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Upload size={18} />
            <span>上传模板</span>
          </button>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <div className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input
              type="text"
              value={searchQuery}
              onChange={e => setSearchQuery(e.target.value)}
              placeholder="搜索模板名称..."
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
        </div>
      </div>

      {/* Grid */}
      {loading ? (
        <div className="flex items-center justify-center h-64">
          <Loader2 className="w-8 h-8 animate-spin text-brand-500" />
        </div>
      ) : filtered.length === 0 ? (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm text-center py-16 transition-all duration-300">
          <FileText className="w-16 h-16 mx-auto text-gray-300 dark:text-gray-600 mb-4" />
          <p className="text-lg text-gray-400 mb-2">暂无模板</p>
          <p className="text-sm text-gray-300 dark:text-gray-500">点击右上角"上传模板"添加第一个模板</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
          {filtered.map(t => {
            const tid = String(t.id);
            return (
              <div
                key={tid}
                className="group bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden hover:shadow-lg hover:border-brand-300 dark:hover:border-brand-600 transition-all duration-300"
              >
                {/* 封面 */}
                <div className="relative aspect-video bg-gray-50 dark:bg-gray-800 overflow-hidden">
                  {t.coverUrl ? (
                    <img
                      src={t.coverUrl}
                      alt={t.name || '模板'}
                      className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                    />
                  ) : (
                    <div className="w-full h-full flex items-center justify-center">
                      <FileText className="w-12 h-12 text-gray-300 dark:text-gray-600" />
                    </div>
                  )}
                  {/* 操作按钮浮层 */}
                  <div className="absolute inset-0 bg-black/0 group-hover:bg-black/30 flex items-center justify-center gap-2 opacity-0 group-hover:opacity-100 transition-all duration-200">
                    <button
                      onClick={() => handlePreview(tid)}
                      className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 bg-white/90 dark:bg-gray-900/90 rounded-lg transition-all"
                      title="查看详情"
                    >
                      <Eye size={18} />
                    </button>
                    <button
                      onClick={() => handleDelete(tid)}
                      className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 bg-white/90 dark:bg-gray-900/90 rounded-lg transition-all"
                      title="删除"
                    >
                      <Trash2 size={18} />
                    </button>
                  </div>
                </div>
                {/* 信息 */}
                <div className="px-4 py-3">
                  <h3 className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors truncate text-sm">
                    {t.name || '未命名模板'}
                  </h3>
                  <div className="flex items-center justify-between mt-1.5">
                    <span className="text-xs text-gray-400">{t.slideCount || 0} 页幻灯片</span>
                    <span className={`text-xs font-medium ${t.enabled ? 'text-green-500' : 'text-gray-400'}`}>
                      {t.enabled ? '已启用' : '已禁用'}
                    </span>
                  </div>
                  {t.description && (
                    <p className="text-xs text-gray-400 mt-1.5 truncate">{t.description}</p>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* Upload Modal */}
      {showUpload && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={() => { setShowUpload(false); setUploadFile(null); }} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
            {/* Modal header */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">上传 PPT 模板</h3>
              <button onClick={() => { setShowUpload(false); setUploadFile(null); }} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
                <X size={20} />
              </button>
            </div>
            {/* Modal content */}
            <div className="p-6 space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">模板名称 *</label>
                <input
                  type="text"
                  value={uploadForm.name}
                  onChange={e => setUploadForm(p => ({ ...p, name: e.target.value }))}
                  placeholder="例如：商务蓝色模板"
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
                <textarea
                  value={uploadForm.description}
                  onChange={e => setUploadForm(p => ({ ...p, description: e.target.value }))}
                  placeholder="模板简要描述..."
                  rows={2}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 resize-none focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">PPTX 文件 *</label>
                <label className="flex items-center justify-center gap-2 px-4 py-6 rounded-xl border-2 border-dashed border-gray-300 dark:border-gray-600 cursor-pointer hover:border-brand-400 hover:bg-brand-50/30 dark:hover:bg-brand-900/10 transition-all">
                  <Upload className="w-5 h-5 text-gray-400" />
                  <span className="text-sm text-gray-500">
                    {uploadFile ? uploadFile.name : '点击选择 .pptx 文件'}
                  </span>
                  <input
                    type="file"
                    accept=".pptx"
                    className="hidden"
                    onChange={e => setUploadFile(e.target.files?.[0] || null)}
                  />
                </label>
              </div>
            </div>
            {/* Modal footer */}
            <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
              <button
                onClick={() => { setShowUpload(false); setUploadFile(null); }}
                className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
              >
                取消
              </button>
              <button
                onClick={handleUpload}
                disabled={uploadLoading || !uploadFile || !uploadForm.name.trim()}
                className="flex items-center gap-2 px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95"
              >
                {uploadLoading && <Loader2 className="w-4 h-4 animate-spin" />}
                上传
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Preview Modal */}
      {previewId && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={() => { setPreviewId(null); setPreviewData(null); }} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 max-h-[80vh] flex flex-col overflow-hidden animate-in zoom-in-95 duration-200">
            {/* Modal header */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">模板详情</h3>
              <button
                onClick={() => { setPreviewId(null); setPreviewData(null); }}
                className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
              >
                <X size={20} />
              </button>
            </div>
            {/* Modal content */}
            <div className="flex-1 overflow-y-auto p-6 space-y-4">
              {previewLoading ? (
                <div className="flex justify-center py-12">
                  <Loader2 className="w-8 h-8 animate-spin text-brand-500" />
                </div>
              ) : previewData ? (
                <>
                  {previewData.coverUrl && (
                    <img src={previewData.coverUrl} alt="封面" className="w-full rounded-lg" />
                  )}
                  <div className="grid grid-cols-2 gap-3 text-sm">
                    <div><span className="text-gray-400">名称：</span><span className="text-gray-900 dark:text-white">{previewData.name}</span></div>
                    <div><span className="text-gray-400">页数：</span><span className="text-gray-900 dark:text-white">{previewData.slideCount}</span></div>
                    <div className="col-span-2"><span className="text-gray-400">描述：</span><span className="text-gray-900 dark:text-white">{previewData.description || '无'}</span></div>
                    <div className="col-span-2"><span className="text-gray-400">模板 URL：</span>
                      <span className="text-xs text-brand-500 break-all">{previewData.templateUrl}</span>
                    </div>
                  </div>
                  {previewData.structureJson && (
                    <details className="mt-3">
                      <summary className="text-sm font-medium text-gray-500 cursor-pointer">结构 JSON</summary>
                      <pre className="mt-2 p-3 bg-gray-50 dark:bg-gray-800 rounded-lg text-xs overflow-x-auto max-h-64">
                        {typeof previewData.structureJson === 'string'
                          ? JSON.stringify(JSON.parse(previewData.structureJson), null, 2)
                          : JSON.stringify(previewData.structureJson, null, 2)}
                      </pre>
                    </details>
                  )}
                </>
              ) : (
                <p className="text-center text-gray-400">无数据</p>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default PptTemplateManagementPage;
