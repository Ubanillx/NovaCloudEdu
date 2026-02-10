import React, { useState, useEffect, useCallback } from 'react';
import { X, Loader2, GitBranch, RotateCcw, Plus, Clock, User, FileText } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../../../api';
import { toast } from '../../../../components/ui';
import type { WorkflowVersionResponse } from '../../../../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

interface VersionHistoryPanelProps {
  workflowId: string;
  open: boolean;
  onClose: () => void;
  onRollback?: () => void;
}

export const VersionHistoryPanel: React.FC<VersionHistoryPanelProps> = ({
  workflowId, open, onClose, onRollback,
}) => {
  const [versions, setVersions] = useState<WorkflowVersionResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [creating, setCreating] = useState(false);
  const [publishNote, setPublishNote] = useState('');
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [rollingBack, setRollingBack] = useState<number | null>(null);

  const loadVersions = useCallback(async () => {
    setLoading(true);
    try {
      const resp = await api.listVersions({ id: workflowId as unknown as number });
      if (resp.data.code === 0 && resp.data.data) {
        setVersions(resp.data.data);
      }
    } catch {
      toast.error('获取版本列表失败');
    } finally {
      setLoading(false);
    }
  }, [workflowId]);

  useEffect(() => {
    if (open) loadVersions();
  }, [open, loadVersions]);

  const handleCreateSnapshot = useCallback(async () => {
    setCreating(true);
    try {
      const userId = String(JSON.parse(localStorage.getItem('user_info') || '{}')?.id ?? '');
      const resp = await api.createVersionSnapshot({
        id: workflowId as unknown as number,
        userId: userId as unknown as number,
        publishNote: publishNote || undefined,
      });
      if (resp.data.code === 0) {
        toast.success('版本快照创建成功');
        setPublishNote('');
        setShowCreateForm(false);
        loadVersions();
      } else {
        toast.error(resp.data.message || '创建失败');
      }
    } catch {
      toast.error('创建版本快照失败');
    } finally {
      setCreating(false);
    }
  }, [workflowId, publishNote, loadVersions]);

  const handleRollback = useCallback(async (versionNumber: number) => {
    if (!confirm(`确定要回滚到版本 v${versionNumber} 吗？当前未保存的更改将丢失。`)) return;
    setRollingBack(versionNumber);
    try {
      const resp = await api.rollbackToVersion({
        id: workflowId as unknown as number,
        versionNumber,
      });
      if (resp.data.code === 0) {
        toast.success(`已回滚到版本 v${versionNumber}`);
        onRollback?.();
        onClose();
      } else {
        toast.error(resp.data.message || '回滚失败');
      }
    } catch {
      toast.error('版本回滚失败');
    } finally {
      setRollingBack(null);
    }
  }, [workflowId, onRollback, onClose]);

  if (!open) return null;

  return (
    <div className="fixed inset-0 z-50 flex">
      <div className="absolute inset-0 bg-black/40 backdrop-blur-sm" onClick={onClose} />
      <div className="relative ml-auto w-full max-w-md bg-white dark:bg-gray-900 shadow-2xl flex flex-col animate-in slide-in-from-right duration-200">
        {/* 头部 */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-2">
            <GitBranch size={18} className="text-brand-500" />
            <h3 className="text-lg font-bold text-gray-900 dark:text-white">版本历史</h3>
            <span className="text-xs text-gray-400">{versions.length} 个版本</span>
          </div>
          <div className="flex items-center gap-1">
            <button
              onClick={() => setShowCreateForm(!showCreateForm)}
              className="p-2 text-gray-400 hover:text-brand-500 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
              title="创建版本快照"
            >
              <Plus size={16} />
            </button>
            <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
              <X size={20} />
            </button>
          </div>
        </div>

        {/* 创建快照表单 */}
        {showCreateForm && (
          <div className="px-6 py-4 border-b border-gray-100 dark:border-gray-800 bg-brand-50/50 dark:bg-brand-900/10">
            <p className="text-sm font-bold text-gray-700 dark:text-gray-300 mb-2">创建版本快照</p>
            <textarea
              value={publishNote}
              onChange={(e) => setPublishNote(e.target.value)}
              placeholder="发布说明（可选）"
              rows={2}
              className="w-full px-3 py-2 bg-white dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
            />
            <div className="flex items-center justify-end gap-2 mt-2">
              <button
                onClick={() => { setShowCreateForm(false); setPublishNote(''); }}
                className="px-3 py-1.5 text-xs font-medium text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 transition-colors"
              >
                取消
              </button>
              <button
                onClick={handleCreateSnapshot}
                disabled={creating}
                className="px-4 py-1.5 bg-brand-600 text-white text-xs font-bold rounded-lg hover:bg-brand-700 disabled:opacity-50 transition-all active:scale-95"
              >
                {creating ? '创建中...' : '创建快照'}
              </button>
            </div>
          </div>
        )}

        {/* 版本列表 */}
        <div className="flex-1 overflow-y-auto">
          {loading ? (
            <div className="flex flex-col items-center justify-center py-20 gap-3">
              <Loader2 className="animate-spin text-brand-500" size={24} />
              <p className="text-sm text-gray-400">加载中...</p>
            </div>
          ) : versions.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-20 gap-3">
              <GitBranch size={32} className="text-gray-300 dark:text-gray-600" />
              <p className="text-sm text-gray-400 dark:text-gray-500">暂无版本记录</p>
              <p className="text-xs text-gray-400 dark:text-gray-500">点击右上角 + 创建第一个版本快照</p>
            </div>
          ) : (
            <div className="divide-y divide-gray-100 dark:divide-gray-800">
              {versions.map((v, idx) => (
                <div key={String(v.id)} className="px-6 py-4 hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors group">
                  <div className="flex items-start justify-between">
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2">
                        <span className="px-2 py-0.5 bg-brand-100 dark:bg-brand-900/30 text-brand-700 dark:text-brand-400 text-xs font-bold rounded-md">
                          v{v.version}
                        </span>
                        {idx === 0 && (
                          <span className="px-1.5 py-0.5 bg-emerald-100 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-400 text-[10px] font-bold rounded">
                            最新
                          </span>
                        )}
                        <span className="text-sm font-medium text-gray-900 dark:text-white truncate">
                          {v.name || '未命名'}
                        </span>
                      </div>
                      {v.publishNote && (
                        <div className="flex items-center gap-1 mt-1.5">
                          <FileText size={12} className="text-gray-400 flex-shrink-0" />
                          <p className="text-xs text-gray-500 dark:text-gray-400 truncate">{v.publishNote}</p>
                        </div>
                      )}
                      <div className="flex items-center gap-3 mt-1.5">
                        <span className="flex items-center gap-1 text-[11px] text-gray-400">
                          <Clock size={11} />
                          {v.createTime ? new Date(v.createTime).toLocaleString('zh-CN') : '-'}
                        </span>
                        {v.publishedBy && (
                          <span className="flex items-center gap-1 text-[11px] text-gray-400">
                            <User size={11} />
                            {String(v.publishedBy).substring(0, 8)}...
                          </span>
                        )}
                      </div>
                    </div>
                    {idx > 0 && (
                      <button
                        onClick={() => handleRollback(v.version!)}
                        disabled={rollingBack !== null}
                        className="opacity-0 group-hover:opacity-100 flex items-center gap-1 px-2.5 py-1.5 text-xs font-bold text-amber-600 dark:text-amber-400 bg-amber-50 dark:bg-amber-900/20 hover:bg-amber-100 dark:hover:bg-amber-900/30 border border-amber-200 dark:border-amber-800 rounded-lg transition-all disabled:opacity-50"
                        title={`回滚到 v${v.version}`}
                      >
                        {rollingBack === v.version ? (
                          <Loader2 size={12} className="animate-spin" />
                        ) : (
                          <RotateCcw size={12} />
                        )}
                        回滚
                      </button>
                    )}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};
