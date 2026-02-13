import React, { useState, useEffect, useCallback } from 'react';
import {
  Upload,
  Trash2,
  Eye,
  RefreshCw,
  Plus,
  X,
  FileText,
  Loader2,
  Shield,
  CheckCircle
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { ExamTemplateResponse } from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

export const ExamTemplateManagementPage: React.FC = () => {
  const [templates, setTemplates] = useState<ExamTemplateResponse[]>([]);
  const [loading, setLoading] = useState(false);

  // 上传弹窗
  const [showUploadModal, setShowUploadModal] = useState(false);
  const [uploadName, setUploadName] = useState('');
  const [uploadDesc, setUploadDesc] = useState('');
  const [uploadFile, setUploadFile] = useState<File | null>(null);
  const [uploading, setUploading] = useState(false);

  // 预览
  const [previewingId, setPreviewingId] = useState<string | null>(null);

  const fetchTemplates = useCallback(async () => {
    setLoading(true);
    try {
      const res = await api.listAllTemplates();
      setTemplates(res.data?.data || []);
    } catch (e: any) {
      toast.error('加载模板失败: ' + (e.message || ''));
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { fetchTemplates(); }, [fetchTemplates]);

  const handleUpload = async () => {
    if (!uploadFile) { toast.error('请选择 .typ 模板文件'); return; }
    if (!uploadName.trim()) { toast.error('请输入模板名称'); return; }

    setUploading(true);
    try {
      const formData = new FormData();
      formData.append('file', uploadFile);
      formData.append('name', uploadName.trim());
      if (uploadDesc.trim()) {
        formData.append('description', uploadDesc.trim());
      }
      await apiClient.post('/api/exam-templates', formData, {
        headers: { 'Content-Type': undefined },
      });
      toast.success('模板上传成功');
      setShowUploadModal(false);
      setUploadName('');
      setUploadDesc('');
      setUploadFile(null);
      fetchTemplates();
    } catch (e: any) {
      toast.error('上传失败: ' + (e.message || ''));
    } finally {
      setUploading(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('确定删除此模板？')) return;
    try {
      await api.deleteTemplate2({ id: id as unknown as number });
      toast.success('删除成功');
      fetchTemplates();
    } catch (e: any) {
      toast.error('删除失败: ' + (e.message || ''));
    }
  };

  const handlePreview = async (tplId: string) => {
    setPreviewingId(tplId);
    try {
      const res = await apiClient.post(
        `/api/exam-templates/${tplId}/preview`,
        null,
        { responseType: 'blob' }
      );
      const blob = new Blob([res.data], { type: 'application/pdf' });
      const url = URL.createObjectURL(blob);
      window.open(url, '_blank');
    } catch (e: any) {
      toast.error('预览失败: ' + (e.message || ''));
    } finally {
      setPreviewingId(null);
    }
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* 页头 */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">试卷模板管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理 Typst 排版模板，支持自定义试卷样式</p>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={() => fetchTemplates()}
            className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 rounded-xl transition-all">
            <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
          </button>
          <button onClick={() => setShowUploadModal(true)}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">
            <Plus size={18} />
            <span>上传模板</span>
          </button>
        </div>
      </div>

      {/* 模板卡片列表 */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {loading && templates.length === 0 ? (
          Array.from({ length: 3 }).map((_, i) => (
            <div key={i} className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-6 animate-pulse">
              <div className="h-32 bg-gray-100 dark:bg-gray-800 rounded-xl mb-4" />
              <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-2/3 mb-2" />
              <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
            </div>
          ))
        ) : templates.length === 0 ? (
          <div className="col-span-full bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-12">
            <div className="flex flex-col items-center">
              <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                <FileText size={32} className="text-gray-300" />
              </div>
              <p className="text-gray-500 dark:text-gray-400 font-medium">暂无模板，点击上传按钮添加</p>
            </div>
          </div>
        ) : templates.map(tpl => (
          <div key={String(tpl.id)} className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden group hover:shadow-md transition-all duration-300">
            {/* 封面预览区 */}
            <div className="h-40 bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-800 dark:to-gray-900 flex items-center justify-center relative">
              {tpl.coverUrl ? (
                <iframe src={tpl.coverUrl} className="w-full h-full border-0 pointer-events-none" title="模板预览" />
              ) : (
                <FileText size={48} className="text-gray-300 dark:text-gray-600" />
              )}
              {tpl.isSystem && (
                <span className="absolute top-2 left-2 flex items-center gap-1 px-2 py-1 bg-blue-500/90 text-white text-xs font-bold rounded-lg">
                  <Shield size={10} /> 系统内置
                </span>
              )}
            </div>

            {/* 信息区 */}
            <div className="p-4">
              <div className="flex items-start justify-between gap-2">
                <div className="min-w-0">
                  <h3 className="font-bold text-gray-900 dark:text-white truncate">{tpl.name}</h3>
                  {tpl.description && (
                    <p className="text-xs text-gray-500 dark:text-gray-400 mt-1 line-clamp-2">{tpl.description}</p>
                  )}
                </div>
                <span className={`shrink-0 flex items-center gap-1 px-2 py-1 rounded-lg text-xs font-bold ${
                  tpl.isEnabled
                    ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400'
                    : 'bg-gray-100 text-gray-500 dark:bg-gray-800 dark:text-gray-400'
                }`}>
                  <CheckCircle size={10} /> {tpl.isEnabled ? '启用' : '停用'}
                </span>
              </div>

              {/* 操作栏 */}
              <div className="flex items-center gap-2 mt-3 pt-3 border-t border-gray-100 dark:border-gray-800">
                <button onClick={() => handlePreview(String(tpl.id))} disabled={previewingId === String(tpl.id)}
                  className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium text-gray-600 dark:text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all">
                  {previewingId === String(tpl.id) ? <Loader2 size={14} className="animate-spin" /> : <Eye size={14} />}
                  预览
                </button>
                {!tpl.isSystem && (
                  <button onClick={() => handleDelete(String(tpl.id))}
                    className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium text-gray-600 dark:text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all">
                    <Trash2 size={14} /> 删除
                  </button>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* 上传弹窗 */}
      {showUploadModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={() => setShowUploadModal(false)} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 animate-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">上传试卷模板</h3>
              <button onClick={() => setShowUploadModal(false)} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
            </div>
            <div className="p-6 space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">模板名称 *</label>
                <input type="text" value={uploadName} onChange={e => setUploadName(e.target.value)}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="如：简约双栏模板" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
                <input type="text" value={uploadDesc} onChange={e => setUploadDesc(e.target.value)}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="描述模板的排版风格" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">模板文件 (.typ) *</label>
                <label className={`flex flex-col items-center justify-center w-full h-32 border-2 border-dashed rounded-xl cursor-pointer transition-all ${
                  uploadFile
                    ? 'border-brand-400 bg-brand-50/50 dark:bg-brand-900/10'
                    : 'border-gray-200 dark:border-gray-700 hover:border-brand-400 hover:bg-gray-50 dark:hover:bg-gray-800/50'
                }`}>
                  <input type="file" accept=".typ" className="sr-only"
                    onChange={e => setUploadFile(e.target.files?.[0] || null)} />
                  {uploadFile ? (
                    <div className="flex flex-col items-center">
                      <FileText size={24} className="text-brand-500 mb-2" />
                      <p className="text-sm font-medium text-brand-600">{uploadFile.name}</p>
                      <p className="text-xs text-gray-400 mt-1">{(uploadFile.size / 1024).toFixed(1)} KB</p>
                    </div>
                  ) : (
                    <div className="flex flex-col items-center">
                      <Upload size={24} className="text-gray-400 mb-2" />
                      <p className="text-sm text-gray-500">点击选择 .typ 文件</p>
                      <p className="text-xs text-gray-400 mt-1">最大 1MB</p>
                    </div>
                  )}
                </label>
              </div>
            </div>
            <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
              <button onClick={() => setShowUploadModal(false)} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
              <button onClick={handleUpload} disabled={uploading}
                className="flex items-center gap-2 px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed">
                {uploading && <Loader2 size={16} className="animate-spin" />}
                上传
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ExamTemplateManagementPage;
