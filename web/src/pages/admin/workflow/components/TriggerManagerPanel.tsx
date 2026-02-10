import React, { useState, useEffect, useCallback } from 'react';
import { X, Loader2, Zap, Plus, Trash2, ToggleLeft, ToggleRight, Clock, Globe, Radio, Copy, Check } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../../../api';
import { toast } from '../../../../components/ui';
import type { WorkflowTriggerResponse } from '../../../../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

interface TriggerManagerPanelProps {
  workflowId: string;
  open: boolean;
  onClose: () => void;
}

type TriggerType = 'SCHEDULE' | 'WEBHOOK';

export const TriggerManagerPanel: React.FC<TriggerManagerPanelProps> = ({
  workflowId, open, onClose,
}) => {
  const [triggers, setTriggers] = useState<WorkflowTriggerResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [showCreate, setShowCreate] = useState(false);
  const [createType, setCreateType] = useState<TriggerType>('SCHEDULE');
  const [creating, setCreating] = useState(false);
  const [formName, setFormName] = useState('');
  const [formCron, setFormCron] = useState('');
  const [formTimezone, setFormTimezone] = useState('Asia/Shanghai');
  const [formSecret, setFormSecret] = useState('');
  const [formValidateSig, setFormValidateSig] = useState(false);
  const [copiedId, setCopiedId] = useState<string | null>(null);

  const loadTriggers = useCallback(async () => {
    setLoading(true);
    try {
      const resp = await api.listTriggers({ id: workflowId as unknown as number });
      if (resp.data.code === 0 && resp.data.data) {
        setTriggers(resp.data.data);
      }
    } catch {
      toast.error('获取触发器列表失败');
    } finally {
      setLoading(false);
    }
  }, [workflowId]);

  useEffect(() => {
    if (open) loadTriggers();
  }, [open, loadTriggers]);

  const resetForm = () => {
    setFormName('');
    setFormCron('');
    setFormTimezone('Asia/Shanghai');
    setFormSecret('');
    setFormValidateSig(false);
    setShowCreate(false);
  };

  const handleCreate = useCallback(async () => {
    if (!formName.trim()) { toast.error('请输入触发器名称'); return; }
    setCreating(true);
    try {
      let resp;
      if (createType === 'SCHEDULE') {
        if (!formCron.trim()) { toast.error('请输入 Cron 表达式'); setCreating(false); return; }
        resp = await api.createScheduleTrigger({
          id: workflowId as unknown as number,
          name: formName,
          cronExpression: formCron,
          timezone: formTimezone || undefined,
        });
      } else {
        resp = await api.createWebhookTrigger({
          id: workflowId as unknown as number,
          name: formName,
          secret: formSecret || undefined,
          validateSignature: formValidateSig,
        });
      }
      if (resp.data.code === 0) {
        toast.success('触发器创建成功');
        resetForm();
        loadTriggers();
      } else {
        toast.error(resp.data.message || '创建失败');
      }
    } catch {
      toast.error('创建触发器失败');
    } finally {
      setCreating(false);
    }
  }, [workflowId, createType, formName, formCron, formTimezone, formSecret, formValidateSig, loadTriggers]);

  const handleToggle = useCallback(async (trigger: WorkflowTriggerResponse) => {
    try {
      const triggerId = trigger.id as unknown as number;
      const resp = trigger.enabled
        ? await api.disableTrigger({ triggerId })
        : await api.enableTrigger({ triggerId });
      if (resp.data.code === 0) {
        toast.success(trigger.enabled ? '已禁用' : '已启用');
        loadTriggers();
      } else {
        toast.error(resp.data.message || '操作失败');
      }
    } catch {
      toast.error('操作失败');
    }
  }, [loadTriggers]);

  const handleDelete = useCallback(async (trigger: WorkflowTriggerResponse) => {
    if (!confirm(`确定要删除触发器「${trigger.name}」吗？`)) return;
    try {
      const resp = await api.deleteTrigger({ triggerId: trigger.id as unknown as number });
      if (resp.data.code === 0) {
        toast.success('已删除');
        loadTriggers();
      } else {
        toast.error(resp.data.message || '删除失败');
      }
    } catch {
      toast.error('删除失败');
    }
  }, [loadTriggers]);

  const typeIcon = (type?: string) => {
    switch (type) {
      case 'SCHEDULE': return <Clock size={14} className="text-blue-400" />;
      case 'WEBHOOK': return <Globe size={14} className="text-purple-400" />;
      case 'EVENT': return <Radio size={14} className="text-amber-400" />;
      default: return <Zap size={14} className="text-gray-400" />;
    }
  };

  if (!open) return null;

  const apiBaseUrl = (import.meta.env.VITE_API_BASE_URL as string) || 'http://localhost:8080';

  const WebhookUrlDisplay: React.FC<{
    webhookPath: string;
    triggerId: string;
    copiedId: string | null;
    onCopy: (tid: string, url: string) => void;
  }> = ({ webhookPath, triggerId, copiedId: cid, onCopy }) => {
    const fullUrl = `${apiBaseUrl}${webhookPath}`;
    const isCopied = cid === triggerId;
    return (
      <div className="mt-2 flex items-center gap-1.5">
        <div className="flex-1 min-w-0 px-2.5 py-1.5 bg-gray-100 dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700">
          <code className="text-[11px] text-gray-600 dark:text-gray-400 font-mono break-all select-all">{fullUrl}</code>
        </div>
        <button
          onClick={() => onCopy(triggerId, fullUrl)}
          className={`flex-shrink-0 p-1.5 rounded-lg border transition-all ${
            isCopied
              ? 'bg-emerald-50 dark:bg-emerald-900/20 border-emerald-300 dark:border-emerald-700 text-emerald-600 dark:text-emerald-400'
              : 'bg-white dark:bg-gray-800 border-gray-200 dark:border-gray-700 text-gray-400 hover:text-brand-500 hover:border-brand-300 dark:hover:border-brand-700'
          }`}
          title="复制地址"
        >
          {isCopied ? <Check size={13} /> : <Copy size={13} />}
        </button>
      </div>
    );
  };

  return (
    <div className="fixed inset-0 z-50 flex">
      <div className="absolute inset-0 bg-black/40 backdrop-blur-sm" onClick={onClose} />
      <div className="relative ml-auto w-full max-w-md bg-white dark:bg-gray-900 shadow-2xl flex flex-col animate-in slide-in-from-right duration-200">
        {/* 头部 */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <div className="flex items-center gap-2">
            <Zap size={18} className="text-brand-500" />
            <h3 className="text-lg font-bold text-gray-900 dark:text-white">触发器管理</h3>
            <span className="text-xs text-gray-400">{triggers.length} 个</span>
          </div>
          <div className="flex items-center gap-1">
            <button
              onClick={() => setShowCreate(!showCreate)}
              className="p-2 text-gray-400 hover:text-brand-500 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
              title="创建触发器"
            >
              <Plus size={16} />
            </button>
            <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
              <X size={20} />
            </button>
          </div>
        </div>

        {/* 创建表单 */}
        {showCreate && (
          <div className="px-6 py-4 border-b border-gray-100 dark:border-gray-800 bg-brand-50/50 dark:bg-brand-900/10 space-y-3">
            <p className="text-sm font-bold text-gray-700 dark:text-gray-300">创建触发器</p>
            {/* 类型选择 */}
            <div className="flex items-center gap-2">
              <button
                onClick={() => setCreateType('SCHEDULE')}
                className={`flex items-center gap-1.5 px-3 py-1.5 text-xs font-bold rounded-lg border transition-all ${
                  createType === 'SCHEDULE'
                    ? 'bg-blue-50 dark:bg-blue-900/20 border-blue-300 dark:border-blue-700 text-blue-700 dark:text-blue-400'
                    : 'bg-white dark:bg-gray-800 border-gray-200 dark:border-gray-700 text-gray-500'
                }`}
              >
                <Clock size={12} /> 定时
              </button>
              <button
                onClick={() => setCreateType('WEBHOOK')}
                className={`flex items-center gap-1.5 px-3 py-1.5 text-xs font-bold rounded-lg border transition-all ${
                  createType === 'WEBHOOK'
                    ? 'bg-purple-50 dark:bg-purple-900/20 border-purple-300 dark:border-purple-700 text-purple-700 dark:text-purple-400'
                    : 'bg-white dark:bg-gray-800 border-gray-200 dark:border-gray-700 text-gray-500'
                }`}
              >
                <Globe size={12} /> Webhook
              </button>
            </div>
            {/* 名称 */}
            <input
              value={formName}
              onChange={(e) => setFormName(e.target.value)}
              placeholder="触发器名称"
              className="w-full px-3 py-2 bg-white dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
            />
            {/* 定时 */}
            {createType === 'SCHEDULE' && (
              <>
                <input
                  value={formCron}
                  onChange={(e) => setFormCron(e.target.value)}
                  placeholder="Cron 表达式，如 0 0 * * * (每小时)"
                  className="w-full px-3 py-2 bg-white dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all font-mono"
                />
                <input
                  value={formTimezone}
                  onChange={(e) => setFormTimezone(e.target.value)}
                  placeholder="时区，默认 Asia/Shanghai"
                  className="w-full px-3 py-2 bg-white dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                />
              </>
            )}
            {/* Webhook */}
            {createType === 'WEBHOOK' && (
              <>
                <input
                  value={formSecret}
                  onChange={(e) => setFormSecret(e.target.value)}
                  placeholder="Secret（可选）"
                  className="w-full px-3 py-2 bg-white dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                />
                <div onClick={() => setFormValidateSig(!formValidateSig)} role="checkbox" aria-checked={formValidateSig}
                  className="flex items-center gap-2.5 cursor-pointer group">
                  <div className={`flex-shrink-0 w-4 h-4 rounded-md border-2 flex items-center justify-center transition-all ${
                    formValidateSig
                      ? 'bg-brand-500 border-brand-500 dark:bg-brand-600 dark:border-brand-600'
                      : 'border-gray-300 dark:border-gray-600 group-hover:border-brand-300 dark:group-hover:border-brand-700'
                  }`}>
                    {formValidateSig && (
                      <svg className="w-2.5 h-2.5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3.5}>
                        <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                      </svg>
                    )}
                  </div>
                  <span className="text-sm text-gray-600 dark:text-gray-400 select-none">验证签名</span>
                </div>
              </>
            )}
            <div className="flex items-center justify-end gap-2">
              <button onClick={resetForm} className="px-3 py-1.5 text-xs font-medium text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 transition-colors">
                取消
              </button>
              <button
                onClick={handleCreate}
                disabled={creating}
                className="px-4 py-1.5 bg-brand-600 text-white text-xs font-bold rounded-lg hover:bg-brand-700 disabled:opacity-50 transition-all active:scale-95"
              >
                {creating ? '创建中...' : '创建'}
              </button>
            </div>
          </div>
        )}

        {/* 触发器列表 */}
        <div className="flex-1 overflow-y-auto">
          {loading ? (
            <div className="flex flex-col items-center justify-center py-20 gap-3">
              <Loader2 className="animate-spin text-brand-500" size={24} />
              <p className="text-sm text-gray-400">加载中...</p>
            </div>
          ) : triggers.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-20 gap-3">
              <Zap size={32} className="text-gray-300 dark:text-gray-600" />
              <p className="text-sm text-gray-400 dark:text-gray-500">暂无触发器</p>
              <p className="text-xs text-gray-400 dark:text-gray-500">点击右上角 + 创建触发器</p>
            </div>
          ) : (
            <div className="divide-y divide-gray-100 dark:divide-gray-800">
              {triggers.map((t) => (
                <div key={String(t.id)} className="px-6 py-4 hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors group">
                  <div className="flex items-start justify-between">
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2">
                        {typeIcon(t.type)}
                        <span className="text-sm font-medium text-gray-900 dark:text-white">{t.name}</span>
                        <span className={`px-1.5 py-0.5 text-[10px] font-bold rounded ${
                          t.enabled
                            ? 'bg-emerald-100 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-400'
                            : 'bg-gray-100 dark:bg-gray-800 text-gray-500'
                        }`}>
                          {t.enabled ? '已启用' : '已禁用'}
                        </span>
                      </div>
                      <div className="flex items-center gap-3 mt-1.5">
                        <span className="text-[11px] text-gray-400">{t.type}</span>
                        <span className="text-[11px] text-gray-400">触发 {t.triggerCount ?? 0} 次</span>
                        {t.lastTriggeredAt && (
                          <span className="text-[11px] text-gray-400">
                            最后触发: {new Date(t.lastTriggeredAt).toLocaleString('zh-CN')}
                          </span>
                        )}
                      </div>
                      {/* Webhook 地址 */}
                      {t.type === 'WEBHOOK' && !!t.config && !!(t.config as Record<string, unknown>).webhookPath && (
                        <WebhookUrlDisplay
                          webhookPath={String((t.config as Record<string, unknown>).webhookPath)}
                          triggerId={String(t.id)}
                          copiedId={copiedId}
                          onCopy={(tid, url) => {
                            navigator.clipboard.writeText(url).then(() => {
                              setCopiedId(tid);
                              toast.success('Webhook 地址已复制');
                              setTimeout(() => setCopiedId((prev) => prev === tid ? null : prev), 2000);
                            });
                          }}
                        />
                      )}
                    </div>
                    <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                      <button
                        onClick={() => handleToggle(t)}
                        className={`p-1.5 rounded-lg transition-all ${
                          t.enabled
                            ? 'text-emerald-500 hover:bg-emerald-50 dark:hover:bg-emerald-900/20'
                            : 'text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800'
                        }`}
                        title={t.enabled ? '禁用' : '启用'}
                      >
                        {t.enabled ? <ToggleRight size={18} /> : <ToggleLeft size={18} />}
                      </button>
                      <button
                        onClick={() => handleDelete(t)}
                        className="p-1.5 text-gray-400 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                        title="删除"
                      >
                        <Trash2 size={14} />
                      </button>
                    </div>
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
