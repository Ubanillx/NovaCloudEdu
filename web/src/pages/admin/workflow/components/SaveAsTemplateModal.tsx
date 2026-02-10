import React, { useState, useCallback } from 'react';
import { X, BookTemplate } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../../../api';
import { toast } from '../../../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

interface SaveAsTemplateModalProps {
  workflowId: string;
  workflowName: string;
  open: boolean;
  onClose: () => void;
}

export const SaveAsTemplateModal: React.FC<SaveAsTemplateModalProps> = ({
  workflowId, workflowName, open, onClose,
}) => {
  const [name, setName] = useState(workflowName ? `${workflowName} 模板` : '');
  const [description, setDescription] = useState('');
  const [category, setCategory] = useState('');
  const [saving, setSaving] = useState(false);

  const handleSave = useCallback(async () => {
    if (!name.trim()) { toast.error('请输入模板名称'); return; }
    setSaving(true);
    try {
      const userId = String(JSON.parse(localStorage.getItem('user_info') || '{}')?.id ?? '');
      const resp = await api.createTemplate({
        workflowId: workflowId as unknown as number,
        name: name.trim(),
        userId: userId as unknown as number,
        description: description || undefined,
        category: category || undefined,
      });
      if (resp.data.code === 0) {
        toast.success('已保存为模板');
        onClose();
      } else {
        toast.error(resp.data.message || '保存失败');
      }
    } catch {
      toast.error('保存为模板失败');
    } finally {
      setSaving(false);
    }
  }, [workflowId, name, description, category, onClose]);

  if (!open) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        {/* 头部 */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-2">
            <BookTemplate size={18} className="text-brand-500" />
            <h3 className="text-lg font-bold text-gray-900 dark:text-white">保存为模板</h3>
          </div>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* 表单 */}
        <div className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">模板名称 *</label>
            <input
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="输入模板名称"
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">分类</label>
            <select
              value={category}
              onChange={(e) => setCategory(e.target.value)}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
            >
              <option value="">请选择分类</option>
              <option value="数据处理">数据处理</option>
              <option value="自动化">自动化</option>
              <option value="AI助手">AI助手</option>
              <option value="通知推送">通知推送</option>
              <option value="教学辅助">教学辅助</option>
              <option value="其他">其他</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
            <textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="描述模板的用途和特点..."
              rows={3}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
            />
          </div>
        </div>

        {/* 底部 */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">
            取消
          </button>
          <button
            onClick={handleSave}
            disabled={saving || !name.trim()}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95"
          >
            {saving ? '保存中...' : '保存为模板'}
          </button>
        </div>
      </div>
    </div>
  );
};
