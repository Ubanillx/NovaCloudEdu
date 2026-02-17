import React, { useState, useEffect, useCallback } from 'react';
import {
  Search, Plus, Edit2, Trash2, Play, Copy, Archive, Send,
  RefreshCw, ChevronLeft, ChevronRight, X, Clock,
  CheckCircle2, Loader2, FileText, Workflow, PenTool, BookTemplate
} from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { WorkflowResponse, CreateWorkflowRequest, UpdateWorkflowRequest } from '../../api/generated/models';
import { toast } from '../../components/ui';
import { TemplateGalleryModal } from './workflow/components/TemplateGalleryModal';

const api = new DefaultApi(new Configuration(), '', apiClient);

const STATUS_MAP: Record<string, { label: string; color: string; icon: React.ReactNode }> = {
  DRAFT: { label: '草稿', color: 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700', icon: <FileText size={14} /> },
  PUBLISHED: { label: '已发布', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800', icon: <CheckCircle2 size={14} /> },
  ARCHIVED: { label: '已归档', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800', icon: <Archive size={14} /> },
};

// ==================== 表单弹窗 ====================
interface WorkflowFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  workflow?: WorkflowResponse | null;
}

const WorkflowFormModal: React.FC<WorkflowFormModalProps> = ({ isOpen, onClose, onSuccess, workflow }) => {
  const isEdit = !!workflow;
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({ name: '', description: '' });

  useEffect(() => {
    if (workflow) {
      setFormData({ name: workflow.name || '', description: workflow.description || '' });
    } else {
      setFormData({ name: '', description: '' });
    }
  }, [workflow, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.name.trim()) { toast.warning('请输入工作流名称'); return; }
    setLoading(true);
    try {
      if (isEdit && workflow?.id) {
        const resp = await api.update({ id: workflow.id as unknown as number, updateWorkflowRequest: { name: formData.name, description: formData.description } as UpdateWorkflowRequest });
        if (resp.data.code === 0) { toast.success('更新成功'); onSuccess(); onClose(); } else { toast.error(resp.data.message || '更新失败'); }
      } else {
        const currentUserId = String(JSON.parse(localStorage.getItem('user_info') || '{}')?.id ?? '');
        const resp = await api.create({ createWorkflowRequest: { userId: currentUserId as unknown as number, name: formData.name, description: formData.description } as CreateWorkflowRequest });
        if (resp.data.code === 0) { toast.success('创建成功'); onSuccess(); onClose(); } else { toast.error(resp.data.message || '创建失败'); }
      }
    } catch (error: any) { toast.error(error?.response?.data?.message || '网络错误'); } finally { setLoading(false); }
  };

  if (!isOpen) return null;
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">{isEdit ? '编辑工作流' : '新建工作流'}</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
        </div>
        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">工作流名称 *</label>
            <input type="text" value={formData.name} onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))} placeholder="请输入工作流名称" className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all" autoFocus />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
            <textarea value={formData.description} onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))} placeholder="请输入工作流描述（可选）" rows={4} className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none" />
          </div>
        </form>
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button type="button" onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
          <button onClick={handleSubmit} disabled={loading} className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2">
            {loading && <Loader2 size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建工作流'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ==================== 执行弹窗 ====================
interface ExecuteModalProps {
  isOpen: boolean;
  onClose: () => void;
  workflow: WorkflowResponse | null;
}

const ExecuteModal: React.FC<ExecuteModalProps> = ({ isOpen, onClose, workflow }) => {
  const [loading, setLoading] = useState(false);
  const [inputJson, setInputJson] = useState('{}');
  const [result, setResult] = useState<any>(null);

  useEffect(() => { if (isOpen) { setInputJson('{}'); setResult(null); } }, [isOpen]);

  const handleExecute = async () => {
    if (!workflow?.id) return;
    setLoading(true);
    setResult(null);
    try {
      let parsedInput = {};
      try { parsedInput = JSON.parse(inputJson); } catch { toast.error('输入参数 JSON 格式错误'); setLoading(false); return; }
      const currentUserId = String(JSON.parse(localStorage.getItem('user_info') || '{}')?.id ?? '');
      const resp = await api.execute({ id: workflow.id as unknown as number, executeWorkflowRequest: { userId: currentUserId as unknown as number, input: parsedInput } });
      if (resp.data.code === 0) { setResult(resp.data.data); toast.success('执行完成'); } else { toast.error(resp.data.message || '执行失败'); }
    } catch (error: any) { toast.error(error?.response?.data?.message || '执行失败'); } finally { setLoading(false); }
  };

  if (!isOpen || !workflow) return null;
  const execStatus = result?.status || '';
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">执行工作流：{workflow.name}</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
        </div>
        <div className="p-6 space-y-4 overflow-y-auto flex-1">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">输入参数 (JSON)</label>
            <textarea value={inputJson} onChange={(e) => setInputJson(e.target.value)} rows={5} className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white font-mono text-sm focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none" />
          </div>
          <button onClick={handleExecute} disabled={loading} className="px-6 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95 disabled:opacity-50 flex items-center gap-2">
            {loading ? <Loader2 size={16} className="animate-spin" /> : <Play size={16} />}
            {loading ? '执行中...' : '执行'}
          </button>
          {result && (
            <div className="space-y-3">
              <div className="flex items-center gap-2 text-sm font-bold">
                <span className="text-gray-700 dark:text-gray-300">执行状态：</span>
                <span className={execStatus === 'COMPLETED' ? 'text-green-500' : execStatus === 'FAILED' ? 'text-red-500' : 'text-blue-500'}>{execStatus}</span>
                {result.durationMs != null && <span className="text-gray-400 ml-2">耗时 {result.durationMs}ms</span>}
              </div>
              {result.errorMessage && <div className="p-3 bg-red-50 dark:bg-red-900/20 rounded-xl text-sm text-red-600 dark:text-red-400 border border-red-200 dark:border-red-800">{result.errorMessage}</div>}
              {result.output && (
                <div>
                  <p className="text-sm font-bold text-gray-700 dark:text-gray-300 mb-1">输出结果</p>
                  <pre className="p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl text-xs text-gray-700 dark:text-gray-300 overflow-x-auto border border-gray-200 dark:border-gray-700">{JSON.stringify(result.output, null, 2)}</pre>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

// ==================== 主页面 ====================
export const WorkflowManagementPage: React.FC = () => {
  const navigate = useNavigate();
  const [workflows, setWorkflows] = useState<WorkflowResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [page, setPage] = useState(0);
  const [total, setTotal] = useState(0);
  const pageSize = 10;
  const [searchName, setSearchName] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [modalOpen, setModalOpen] = useState(false);
  const [editingWorkflow, setEditingWorkflow] = useState<WorkflowResponse | null>(null);
  const [executeModalOpen, setExecuteModalOpen] = useState(false);
  const [executingWorkflow, setExecutingWorkflow] = useState<WorkflowResponse | null>(null);
  const [templateGalleryOpen, setTemplateGalleryOpen] = useState(false);

  const fetchWorkflows = useCallback(async () => {
    setLoading(true);
    try {
      const currentUserId = String(JSON.parse(localStorage.getItem('user_info') || '{}')?.id ?? '');
      const resp = await api.listByUser({ userId: currentUserId as unknown as number, page, size: pageSize });
      if (resp.data.code === 0 && resp.data.data) {
        let list = resp.data.data as WorkflowResponse[];
        if (searchName.trim()) {
          list = list.filter(w => w.name?.toLowerCase().includes(searchName.toLowerCase()));
        }
        if (statusFilter) {
          list = list.filter(w => w.status === statusFilter);
        }
        setWorkflows(list);
        setTotal(list.length);
      } else {
        setWorkflows([]);
        setTotal(0);
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '获取工作流列表失败');
      setWorkflows([]);
    } finally {
      setLoading(false);
    }
  }, [page, searchName, statusFilter]);

  useEffect(() => { fetchWorkflows(); }, [fetchWorkflows]);

  const handlePublish = async (wf: WorkflowResponse) => {
    if (!wf.id) return;
    try {
      const resp = await api.publish1({ id: wf.id as unknown as number });
      if (resp.data.code === 0) { toast.success('发布成功'); fetchWorkflows(); } else { toast.error(resp.data.message || '发布失败'); }
    } catch (error: any) { toast.error(error?.response?.data?.message || '发布失败'); }
  };

  const handleArchive = async (wf: WorkflowResponse) => {
    if (!wf.id) return;
    try {
      const resp = await api.archive1({ id: wf.id as unknown as number });
      if (resp.data.code === 0) { toast.success('归档成功'); fetchWorkflows(); } else { toast.error(resp.data.message || '归档失败'); }
    } catch (error: any) { toast.error(error?.response?.data?.message || '归档失败'); }
  };

  const handleDelete = async (wf: WorkflowResponse) => {
    if (!wf.id) return;
    if (!window.confirm(`确定要删除工作流「${wf.name}」吗？此操作不可恢复。`)) return;
    try {
      const resp = await api._delete({ id: wf.id as unknown as number });
      if (resp.data.code === 0) { toast.success('删除成功'); fetchWorkflows(); } else { toast.error(resp.data.message || '删除失败'); }
    } catch (error: any) { toast.error(error?.response?.data?.message || '删除失败'); }
  };

  const handleCopy = async (wf: WorkflowResponse) => {
    if (!wf.id) return;
    const newName = window.prompt('请输入新工作流名称', `${wf.name} - 副本`);
    if (!newName) return;
    try {
      const currentUserId = String(JSON.parse(localStorage.getItem('user_info') || '{}')?.id ?? '');
      const resp = await api.copy({ id: wf.id as unknown as number, newName, userId: currentUserId as unknown as number });
      if (resp.data.code === 0) { toast.success('复制成功'); fetchWorkflows(); } else { toast.error(resp.data.message || '复制失败'); }
    } catch (error: any) { toast.error(error?.response?.data?.message || '复制失败'); }
  };

  const handleSearch = (e: React.FormEvent) => { e.preventDefault(); setPage(0); fetchWorkflows(); };

  const formatTime = (t?: string) => { if (!t) return '-'; try { return new Date(t).toLocaleString('zh-CN'); } catch { return t; } };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">AI 工作流管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">创建、管理和执行 AI 工作流</p>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={() => setTemplateGalleryOpen(true)} className="flex items-center gap-2 px-4 py-2 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors">
            <BookTemplate size={18} className="text-brand-500" />
            <span className="text-gray-700 dark:text-gray-300">从模板创建</span>
          </button>
          <button onClick={() => { setEditingWorkflow(null); setModalOpen(true); }} className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">
            <Plus size={18} />
            <span>新建工作流</span>
          </button>
        </div>
      </div>

      {/* Search & Filter */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <form onSubmit={handleSearch} className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input type="text" placeholder="搜索工作流名称..." value={searchName} onChange={(e) => setSearchName(e.target.value)} className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all" />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select value={statusFilter} onChange={(e) => { setStatusFilter(e.target.value); setPage(0); }} className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer">
              <option value="">所有状态</option>
              <option value="DRAFT">草稿</option>
              <option value="PUBLISHED">已发布</option>
              <option value="ARCHIVED">已归档</option>
            </select>
            <button type="button" onClick={() => fetchWorkflows()} className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all">
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </form>
      </div>

      {/* Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">工作流信息</th>
                <th className="px-5 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-30">状态</th>
                <th className="px-5 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-30">版本</th>
                <th className="px-5 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-40">更新时间</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={5} className="px-4 py-8 h-20">
                      <div className="flex gap-4">
                        <div className="w-12 h-12 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : workflows.length > 0 ? (
                workflows.map((wf) => {
                  const st = STATUS_MAP[wf.status || 'DRAFT'] || STATUS_MAP.DRAFT;
                  return (
                    <tr key={String(wf.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-4">
                          <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-brand-50 to-indigo-50 dark:from-gray-800 dark:to-gray-800 flex items-center justify-center border border-gray-100 dark:border-gray-700">
                            <Workflow size={22} className="text-brand-500" />
                          </div>
                          <div className="min-w-0">
                            <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors truncate max-w-xs">{wf.name || '未命名工作流'}</p>
                            <p className="text-xs text-gray-500 dark:text-gray-400 mt-0.5 truncate max-w-xs">{wf.description || '暂无描述'}</p>
                          </div>
                        </div>
                      </td>
                      <td className="px-5 py-4">
                        <span className={`inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg text-xs font-bold border ${st.color}`}>
                          {st.icon}{st.label}
                        </span>
                      </td>
                      <td className="px-5 py-4">
                        <span className="text-sm font-medium text-gray-600 dark:text-gray-300">version{wf.version || 0}</span>
                      </td>
                      <td className="px-5 py-4">
                        <div className="flex items-center gap-1.5 text-sm text-gray-500 dark:text-gray-400">
                          <Clock size={14} />
                          <span>{formatTime(wf.updateTime)}</span>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                          <button onClick={() => { setEditingWorkflow(wf); setModalOpen(true); }} className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" title="编辑信息">
                            <Edit2 size={16} />
                          </button>
                          <button onClick={() => navigate(`/admin/workflows/${String(wf.id)}/edit`)} className="p-2 text-gray-400 hover:text-violet-600 hover:bg-violet-50 dark:hover:bg-violet-900/20 rounded-lg transition-all" title="编辑画布">
                            <PenTool size={16} />
                          </button>
                          {wf.status === 'DRAFT' && (
                            <button onClick={() => handlePublish(wf)} className="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all" title="发布">
                              <Send size={16} />
                            </button>
                          )}
                          {wf.status === 'PUBLISHED' && (
                            <button onClick={() => handleArchive(wf)} className="p-2 text-gray-400 hover:text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded-lg transition-all" title="归档">
                              <Archive size={16} />
                            </button>
                          )}
                          <button onClick={() => { setExecutingWorkflow(wf); setExecuteModalOpen(true); }} className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" title="执行">
                            <Play size={16} />
                          </button>
                          <button onClick={() => handleCopy(wf)} className="p-2 text-gray-400 hover:text-indigo-600 hover:bg-indigo-50 dark:hover:bg-indigo-900/20 rounded-lg transition-all" title="复制">
                            <Copy size={16} />
                          </button>
                          <button onClick={() => handleDelete(wf)} className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" title="删除">
                            <Trash2 size={16} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })
              ) : (
                <tr>
                  <td colSpan={5} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <Workflow size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无工作流</p>
                      <p className="text-gray-400 dark:text-gray-500 text-sm mt-1">点击「新建工作流」创建你的第一个 AI 工作流</p>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        {total > 0 && (
          <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 条工作流
            </p>
            <div className="flex items-center gap-2">
              <button disabled={page === 0 || loading} onClick={() => setPage(p => p - 1)} className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
                <ChevronLeft size={18} />
              </button>
              <span className="px-3 py-1 text-sm font-bold text-gray-600 dark:text-gray-300">第 {page + 1} 页</span>
              <button disabled={workflows.length < pageSize || loading} onClick={() => setPage(p => p + 1)} className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
                <ChevronRight size={18} />
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Modals */}
      <WorkflowFormModal isOpen={modalOpen} onClose={() => { setModalOpen(false); setEditingWorkflow(null); }} onSuccess={fetchWorkflows} workflow={editingWorkflow} />
      <ExecuteModal isOpen={executeModalOpen} onClose={() => { setExecuteModalOpen(false); setExecutingWorkflow(null); }} workflow={executingWorkflow} />
      <TemplateGalleryModal open={templateGalleryOpen} onClose={() => setTemplateGalleryOpen(false)} onCreated={fetchWorkflows} />
    </div>
  );
};
