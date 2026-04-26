import React, { useState, useEffect, useCallback } from 'react';
import { X, Loader2, Search, BookTemplate, Tag, Clock, Users, ChevronRight } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { apiClient, DefaultApi, Configuration } from '../../../../api';
import { toast } from '../../../../components/ui';
import type { WorkflowTemplateResponse } from '../../../../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

interface TemplateGalleryModalProps {
  open: boolean;
  onClose: () => void;
  onCreated?: () => void;
}

export const TemplateGalleryModal: React.FC<TemplateGalleryModalProps> = ({
  open, onClose, onCreated,
}) => {
  const navigate = useNavigate();
  const [templates, setTemplates] = useState<WorkflowTemplateResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [keyword, setKeyword] = useState('');
  const [category, setCategory] = useState('');
  const [creating, setCreating] = useState<string | null>(null);
  const [selectedTemplate, setSelectedTemplate] = useState<WorkflowTemplateResponse | null>(null);
  const [newName, setNewName] = useState('');
  const [newDescription, setNewDescription] = useState('');

  const loadTemplates = useCallback(async () => {
    setLoading(true);
    try {
      const resp = await api.searchTemplates({
        keyword: keyword || undefined,
        category: category || undefined,
        page: 0,
        size: 50,
      });
      if (resp.data.code === 0 && resp.data.data) {
        setTemplates(resp.data.data);
      }
    } catch {
      toast.error('获取模板列表失败');
    } finally {
      setLoading(false);
    }
  }, [keyword, category]);

  useEffect(() => {
    if (open) loadTemplates();
  }, [open, loadTemplates]);

  const handleUseTemplate = useCallback((tpl: WorkflowTemplateResponse) => {
    setSelectedTemplate(tpl);
    setNewName(tpl.name ? `${tpl.name} - 副本` : '');
    setNewDescription(tpl.description || '');
  }, []);

  const handleCreateFromTemplate = useCallback(async () => {
    if (!selectedTemplate?.id) return;
    if (!newName.trim()) { toast.error('请输入工作流名称'); return; }
    setCreating(String(selectedTemplate.id));
    try {
      const userId = String(JSON.parse(localStorage.getItem('user_info') || '{}')?.id ?? '');
      const resp = await api.createFromTemplate({
        templateId: selectedTemplate.id as unknown as number,
        userId: userId as unknown as number,
        name: newName.trim(),
        description: newDescription || undefined,
      });
      if (resp.data.code === 0) {
        toast.success('从模板创建成功');
        onCreated?.();
        onClose();
        // 导航到新工作流编辑页
        const newWf = resp.data.data as unknown as { id?: number | string };
        if (newWf?.id) {
          navigate(`/admin/workflows/${String(newWf.id)}/edit`);
        }
      } else {
        toast.error(resp.data.message || '创建失败');
      }
    } catch {
      toast.error('从模板创建失败');
    } finally {
      setCreating(null);
      setSelectedTemplate(null);
    }
  }, [selectedTemplate, newName, newDescription, onCreated, onClose, navigate]);

  if (!open) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-3xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[85vh] flex flex-col">
        {/* 头部 */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-2">
            <BookTemplate size={20} className="text-brand-500" />
            <h3 className="text-lg font-bold text-gray-900 dark:text-white">模板库</h3>
            <span className="text-xs text-gray-400">{templates.length} 个模板</span>
          </div>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* 搜索栏 */}
        <div className="px-6 py-3 border-b border-gray-100 dark:border-gray-800 flex items-center gap-3">
          <div className="flex-1 relative group">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={16} />
            <input
              type="text"
              value={keyword}
              onChange={(e) => setKeyword(e.target.value)}
              placeholder="搜索模板..."
              className="w-full pl-9 pr-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <select
            value={category}
            onChange={(e) => setCategory(e.target.value)}
            className="px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
          >
            <option value="">所有分类</option>
            <option value="数据处理">数据处理</option>
            <option value="自动化">自动化</option>
            <option value="AI助手">AI助手</option>
            <option value="通知推送">通知推送</option>
            <option value="教学辅助">教学辅助</option>
            <option value="其他">其他</option>
          </select>
        </div>

        {/* 模板列表 */}
        <div className="flex-1 overflow-y-auto">
          {loading ? (
            <div className="flex flex-col items-center justify-center py-20 gap-3">
              <Loader2 className="animate-spin text-brand-500" size={24} />
              <p className="text-sm text-gray-400">加载中...</p>
            </div>
          ) : templates.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-20 gap-3">
              <BookTemplate size={40} className="text-gray-300 dark:text-gray-600" />
              <p className="text-sm text-gray-400 dark:text-gray-500">暂无模板</p>
              <p className="text-xs text-gray-400 dark:text-gray-500">可以在工作流编辑器中将工作流保存为模板</p>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 p-6">
              {templates.map((tpl) => (
                <div
                  key={String(tpl.id)}
                  className="group relative bg-white dark:bg-gray-800/50 rounded-xl border border-gray-200 dark:border-gray-700 p-4 hover:border-brand-300 dark:hover:border-brand-700 hover:shadow-sm transition-all cursor-pointer"
                  onClick={() => handleUseTemplate(tpl)}
                >
                  <div className="flex items-start justify-between mb-2">
                    <div className="flex items-center gap-2">
                      <div className="w-8 h-8 rounded-lg bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 flex items-center justify-center shadow-sm">
                        <BookTemplate size={16} className="text-brand-500" />
                      </div>
                      <div>
                        <h4 className="text-sm font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">
                          {tpl.name || '未命名模板'}
                        </h4>
                        {tpl.category && (
                          <span className="flex items-center gap-0.5 text-[10px] text-gray-400">
                            <Tag size={9} /> {tpl.category}
                          </span>
                        )}
                      </div>
                    </div>
                    <ChevronRight size={16} className="text-gray-300 dark:text-gray-600 group-hover:text-brand-500 transition-colors" />
                  </div>
                  {tpl.description && (
                    <p className="text-xs text-gray-500 dark:text-gray-400 mb-2 line-clamp-2">{tpl.description}</p>
                  )}
                  <div className="flex items-center gap-3">
                    {tpl.tags && tpl.tags.length > 0 && (
                      <div className="flex items-center gap-1 flex-wrap">
                        {tpl.tags.slice(0, 3).map((tag, idx) => (
                          <span key={idx} className="px-1.5 py-0.5 bg-gray-100 dark:bg-gray-700 text-[10px] text-gray-500 dark:text-gray-400 rounded">
                            {tag}
                          </span>
                        ))}
                      </div>
                    )}
                    <div className="flex items-center gap-2 ml-auto">
                      {tpl.usageCount !== undefined && (
                        <span className="flex items-center gap-0.5 text-[10px] text-gray-400">
                          <Users size={10} /> {tpl.usageCount}
                        </span>
                      )}
                      {tpl.createTime && (
                        <span className="flex items-center gap-0.5 text-[10px] text-gray-400">
                          <Clock size={10} /> {new Date(tpl.createTime).toLocaleDateString('zh-CN')}
                        </span>
                      )}
                    </div>
                  </div>
                  {tpl.system && (
                    <span className="absolute top-2 right-2 px-1.5 py-0.5 bg-brand-100 dark:bg-brand-900/30 text-brand-700 dark:text-brand-400 text-[9px] font-bold rounded">
                      系统
                    </span>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* 从模板创建 - 确认弹窗 */}
      {selectedTemplate && (
        <div className="fixed inset-0 z-[60] flex items-center justify-center">
          <div className="absolute inset-0 bg-black/30" onClick={() => setSelectedTemplate(null)} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">从模板创建工作流</h3>
              <button onClick={() => setSelectedTemplate(null)} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
                <X size={20} />
              </button>
            </div>
            <div className="p-6 space-y-4">
              <div className="flex items-center gap-3 p-3 bg-brand-50 dark:bg-brand-900/10 rounded-xl border border-brand-100 dark:border-brand-900/30">
                <BookTemplate size={20} className="text-brand-500 flex-shrink-0" />
                <div>
                  <p className="text-sm font-bold text-gray-900 dark:text-white">{selectedTemplate.name}</p>
                  {selectedTemplate.category && <p className="text-xs text-gray-500">{selectedTemplate.category}</p>}
                </div>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">工作流名称 *</label>
                <input
                  value={newName}
                  onChange={(e) => setNewName(e.target.value)}
                  placeholder="输入新工作流名称"
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  autoFocus
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
                <textarea
                  value={newDescription}
                  onChange={(e) => setNewDescription(e.target.value)}
                  placeholder="描述（可选）"
                  rows={2}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                />
              </div>
            </div>
            <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
              <button onClick={() => setSelectedTemplate(null)} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">
                取消
              </button>
              <button
                onClick={handleCreateFromTemplate}
                disabled={creating !== null || !newName.trim()}
                className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95"
              >
                {creating ? '创建中...' : '创建工作流'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
