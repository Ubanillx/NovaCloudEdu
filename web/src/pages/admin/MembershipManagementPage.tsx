import React, { useState, useEffect, useCallback } from 'react';
import {
  Crown, Edit2, ChevronLeft, ChevronRight, RefreshCw, X,
  Loader2, CheckCircle, XCircle, UserPlus, Settings, Users,
  Clock, Ban, Info,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { MembershipPlan, UserMembership } from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

const PLAN_LABELS: Record<string, string> = { FREE: '免费版', BASIC: '基础版', PRO: '专业版', TEACHER: '教师版' };
const STATUS_LABELS: Record<string, string> = { PENDING: '待支付', ACTIVE: '生效中', EXPIRED: '已过期', CANCELLED: '已取消' };
const STATUS_COLORS: Record<string, string> = {
  PENDING: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400 border-yellow-200 dark:border-yellow-800',
  ACTIVE: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800',
  EXPIRED: 'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700',
  CANCELLED: 'bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800',
};

const formatLimit = (v?: number) => (v === -1 || v === undefined) ? '∞' : String(v);
const formatDateTime = (s?: string) => {
  if (!s) return '—';
  const d = new Date(s);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')} ${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`;
};

// ==================== 配额编辑弹窗 ====================
interface QuotaModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  plan: MembershipPlan | null;
}

const QuotaModal: React.FC<QuotaModalProps> = ({ isOpen, onClose, onSuccess, plan }) => {
  const [loading, setLoading] = useState(false);
  const [form, setForm] = useState({
    aiChatDailyLimit: -1, aiChatMonthlyLimit: -1,
    aiPptDailyLimit: -1, aiPptMonthlyLimit: -1,
    aiExamDailyLimit: -1, aiExamMonthlyLimit: -1,
    aiBookDailyLimit: -1, aiBookMonthlyLimit: -1,
  });

  useEffect(() => {
    if (plan) {
      setForm({
        aiChatDailyLimit: plan.aiChatDailyLimit ?? -1,
        aiChatMonthlyLimit: plan.aiChatMonthlyLimit ?? -1,
        aiPptDailyLimit: plan.aiPptDailyLimit ?? -1,
        aiPptMonthlyLimit: plan.aiPptMonthlyLimit ?? -1,
        aiExamDailyLimit: plan.aiExamDailyLimit ?? -1,
        aiExamMonthlyLimit: plan.aiExamMonthlyLimit ?? -1,
        aiBookDailyLimit: plan.aiBookDailyLimit ?? -1,
        aiBookMonthlyLimit: plan.aiBookMonthlyLimit ?? -1,
      });
    }
  }, [plan, isOpen]);

  const handleSubmit = async () => {
    if (!plan?.id) return;
    setLoading(true);
    try {
      const res = await api.updatePlanQuota({ planId: plan.id as unknown as number, updatePlanQuotaRequest: form });
      if (res.data.code === 0) { toast.success('配额更新成功'); onSuccess(); onClose(); }
      else toast.error(res.data.message || '更新失败');
    } catch (e: any) { toast.error(e?.response?.data?.message || '操作失败'); }
    finally { setLoading(false); }
  };

  if (!isOpen) return null;

  const fields = [
    { label: 'AI 对话', dKey: 'aiChatDailyLimit' as const, mKey: 'aiChatMonthlyLimit' as const },
    { label: 'PPT 生成', dKey: 'aiPptDailyLimit' as const, mKey: 'aiPptMonthlyLimit' as const },
    { label: 'AI 出题', dKey: 'aiExamDailyLimit' as const, mKey: 'aiExamMonthlyLimit' as const },
    { label: '电子书AI', dKey: 'aiBookDailyLimit' as const, mKey: 'aiBookMonthlyLimit' as const },
  ];

  const inputCls = 'w-full px-3 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white text-sm focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all';

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            编辑配额 — {PLAN_LABELS[plan?.code || ''] || plan?.name}
          </h3>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>
        <div className="p-6 space-y-4">
          <p className="text-xs text-gray-500 dark:text-gray-400 mb-2">-1 表示无限制</p>
          {fields.map(({ label, dKey, mKey }) => (
            <div key={label}>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">{label}</label>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <span className="text-xs text-gray-400">每日</span>
                  <input type="number" value={form[dKey]} onChange={e => setForm(prev => ({ ...prev, [dKey]: parseInt(e.target.value) || -1 }))} className={inputCls} />
                </div>
                <div>
                  <span className="text-xs text-gray-400">每月</span>
                  <input type="number" value={form[mKey]} onChange={e => setForm(prev => ({ ...prev, [mKey]: parseInt(e.target.value) || -1 }))} className={inputCls} />
                </div>
              </div>
            </div>
          ))}
        </div>
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
          <button onClick={handleSubmit} disabled={loading} className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2">
            {loading && <Loader2 size={16} className="animate-spin" />}
            保存配额
          </button>
        </div>
      </div>
    </div>
  );
};

// ==================== 开通会员弹窗 ====================
interface GrantModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  plans: MembershipPlan[];
}

const GrantModal: React.FC<GrantModalProps> = ({ isOpen, onClose, onSuccess, plans }) => {
  const [loading, setLoading] = useState(false);
  const [userId, setUserId] = useState('');
  const [planId, setPlanId] = useState('');

  const handleSubmit = async () => {
    if (!userId.trim() || !planId) { toast.warning('请填写用户ID和选择计划'); return; }
    setLoading(true);
    try {
      const res = await api.grantMembership({ grantMembershipRequest: { userId: userId as unknown as number, planId: planId as unknown as number } });
      if (res.data.code === 0) { toast.success('开通成功'); onSuccess(); onClose(); setUserId(''); setPlanId(''); }
      else toast.error(res.data.message || '操作失败');
    } catch (e: any) { toast.error(e?.response?.data?.message || '操作失败'); }
    finally { setLoading(false); }
  };

  if (!isOpen) return null;

  const inputCls = 'w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white text-sm focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all';

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">为用户开通会员</h3>
          <button onClick={onClose} aria-label="关闭" className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
        </div>
        <div className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">用户ID *</label>
            <input type="text" value={userId} onChange={e => setUserId(e.target.value)} className={inputCls} placeholder="请输入用户ID" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">会员计划 *</label>
            <select value={planId} onChange={e => setPlanId(e.target.value)} className={inputCls + ' cursor-pointer'}>
              <option value="">请选择</option>
              {plans.map(p => <option key={String(p.id)} value={String(p.id)}>{PLAN_LABELS[p.code || ''] || p.name}</option>)}
            </select>
          </div>
        </div>
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
          <button onClick={handleSubmit} disabled={loading} className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2">
            {loading && <Loader2 size={16} className="animate-spin" />}
            确认开通
          </button>
        </div>
      </div>
    </div>
  );
};

// ==================== 主页面 ====================
export const MembershipManagementPage: React.FC = () => {
  const [tab, setTab] = useState<'plans' | 'members'>('members');
  const [plans, setPlans] = useState<MembershipPlan[]>([]);
  const [members, setMembers] = useState<UserMembership[]>([]);
  const [stats, setStats] = useState<Record<string, number>>({});
  const [loading, setLoading] = useState(true);
  const [statusFilter, setStatusFilter] = useState(0);
  const [page, setPage] = useState(1);
  const [quotaPlan, setQuotaPlan] = useState<MembershipPlan | null>(null);
  const [showGrant, setShowGrant] = useState(false);
  const [actionLoading, setActionLoading] = useState<string | null>(null);

  const fetchPlans = useCallback(async () => {
    try {
      const res = await api.listPlans1();
      if (res.data.code === 0) setPlans(res.data.data || []);
    } catch { /* silent */ }
  }, []);

  const fetchMembers = useCallback(async () => {
    try {
      const res = await api.listMemberships({ status: statusFilter, page, size: 10 });
      if (res.data.code === 0) setMembers(res.data.data || []);
    } catch { /* silent */ }
  }, [statusFilter, page]);

  const fetchStats = useCallback(async () => {
    try {
      const res = await api.getStatistics1();
      if (res.data.code === 0 && res.data.data) setStats(res.data.data as any);
    } catch { /* silent */ }
  }, []);

  const fetchAll = useCallback(async () => {
    setLoading(true);
    await Promise.all([fetchPlans(), fetchMembers(), fetchStats()]);
    setLoading(false);
  }, [fetchPlans, fetchMembers, fetchStats]);

  useEffect(() => { fetchAll(); }, [fetchAll]);
  useEffect(() => { fetchMembers(); }, [statusFilter, page, fetchMembers]);

  const handleConfirmPayment = async (orderNo: string) => {
    setActionLoading(orderNo);
    try {
      const res = await api.confirmPayment1({ orderNo });
      if (res.data.code === 0) { toast.success('确认成功'); fetchMembers(); fetchStats(); }
      else toast.error(res.data.message || '操作失败');
    } catch (e: any) { toast.error(e?.response?.data?.message || '操作失败'); }
    finally { setActionLoading(null); }
  };

  const handleCancel = async (userId: any) => {
    setActionLoading(String(userId));
    try {
      const res = await api.cancelMembership1({ userId: userId as unknown as number });
      if (res.data.code === 0) { toast.success('取消成功'); fetchMembers(); fetchStats(); }
      else toast.error(res.data.message || '操作失败');
    } catch (e: any) { toast.error(e?.response?.data?.message || '操作失败'); }
    finally { setActionLoading(null); }
  };

  const getPlanName = (planId: any) => {
    const p = plans.find(pl => String(pl.id) === String(planId));
    return p ? (PLAN_LABELS[p.code || ''] || p.name) : '—';
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white flex items-center gap-3">
            <Crown size={28} className="text-amber-500" /> 会员管理
          </h1>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">管理会员计划、配额与用户会员状态</p>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={() => setShowGrant(true)} className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">
            <UserPlus size={18} /> 
            <span>开通会员</span>
          </button>
          <button onClick={fetchAll} className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all" title="刷新">
            <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
          </button>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        {[
          { label: '待支付', key: 'pending', icon: Clock, color: 'text-yellow-500', bg: 'bg-yellow-50 dark:bg-yellow-900/10' },
          { label: '生效中', key: 'active', icon: CheckCircle, color: 'text-green-500', bg: 'bg-green-50 dark:bg-green-900/10' },
          { label: '已过期', key: 'expired', icon: XCircle, color: 'text-gray-400', bg: 'bg-gray-50 dark:bg-gray-800/50' },
          { label: '已取消', key: 'cancelled', icon: Ban, color: 'text-red-500', bg: 'bg-red-50 dark:bg-red-900/10' },
        ].map(({ label, key, icon: Icon, color, bg }) => (
          <div key={key} className={`${bg} rounded-2xl border border-gray-100 dark:border-gray-800 p-5 shadow-sm transition-all hover:shadow-sm`}>
            <div className="flex items-center justify-between">
              <div className={`p-2 rounded-xl bg-white dark:bg-gray-900 shadow-sm ${color}`}>
                <Icon size={22} />
              </div>
              <span className="text-2xl font-black text-gray-900 dark:text-white">{stats[key] ?? 0}</span>
            </div>
            <div className="text-xs text-gray-500 dark:text-gray-400 mt-3 font-bold uppercase tracking-wider">{label}</div>
          </div>
        ))}
      </div>

      {/* Tabs */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div className="flex gap-1 p-1 bg-gray-100/80 dark:bg-gray-800/80 backdrop-blur-sm rounded-xl w-fit border border-gray-200/50 dark:border-gray-700/50">
          {([['plans', '计划管理', Settings], ['members', '会员列表', Users]] as const).map(([key, label, Icon]) => (
            <button
              key={key}
              onClick={() => setTab(key)}
              className={`flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-bold transition-all ${tab === key ? 'bg-white dark:bg-gray-900 text-brand-600 shadow-lg shadow-gray-200/50 dark:shadow-none' : 'text-gray-500 hover:text-gray-700 dark:hover:text-gray-300'}`}
            >
              <Icon size={16} /> <span>{label}</span>
            </button>
          ))}
        </div>
      </div>

      {/* Plans Tab */}
      {tab === 'plans' && (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse admin-table">
              <thead>
                <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800">
                  {['计划详情', '价格/有效期', 'AI 对话', 'PPT 生成', 'AI 出题', '电子书 AI', '权益', '操作'].map(h => (
                    <th key={h} className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
                {plans.map(p => (
                  <tr key={String(p.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className="w-10 h-10 rounded-xl bg-brand-50 dark:bg-brand-900/20 flex items-center justify-center text-brand-600">
                          <Crown size={20} />
                        </div>
                        <div>
                          <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">
                            {PLAN_LABELS[p.code || ''] || p.name}
                          </p>
                          <span className="px-1.5 py-0.5 text-[10px] font-mono font-bold bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400 rounded uppercase">
                            {p.code}
                          </span>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="space-y-1">
                        <p className="text-sm font-bold text-gray-900 dark:text-white">¥{p.price ?? 0}</p>
                        <p className="text-xs text-gray-500 dark:text-gray-400">{p.durationDays ? `${p.durationDays}天` : '永久有效'}</p>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="text-sm text-gray-700 dark:text-gray-300">
                        <span className="font-medium">{formatLimit(p.aiChatDailyLimit)}</span>
                        <span className="text-gray-400 mx-1">/</span>
                        <span className="text-xs text-gray-500">{formatLimit(p.aiChatMonthlyLimit)}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="text-sm text-gray-700 dark:text-gray-300">
                        <span className="font-medium">{formatLimit(p.aiPptDailyLimit)}</span>
                        <span className="text-gray-400 mx-1">/</span>
                        <span className="text-xs text-gray-500">{formatLimit(p.aiPptMonthlyLimit)}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="text-sm text-gray-700 dark:text-gray-300">
                        <span className="font-medium">{formatLimit(p.aiExamDailyLimit)}</span>
                        <span className="text-gray-400 mx-1">/</span>
                        <span className="text-xs text-gray-500">{formatLimit(p.aiExamMonthlyLimit)}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="text-sm text-gray-700 dark:text-gray-300">
                        <span className="font-medium">{formatLimit(p.aiBookDailyLimit)}</span>
                        <span className="text-gray-400 mx-1">/</span>
                        <span className="text-xs text-gray-500">{formatLimit(p.aiBookMonthlyLimit)}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      {p.courseMemberAccess ? (
                        <div className="flex items-center gap-1.5 text-green-600 dark:text-green-400">
                          <CheckCircle size={14} />
                          <span className="text-xs font-bold">会员课免费</span>
                        </div>
                      ) : (
                        <div className="flex items-center gap-1.5 text-gray-400">
                          <XCircle size={14} />
                          <span className="text-xs">无额外权益</span>
                        </div>
                      )}
                    </td>
                    <td className="px-6 py-4">
                      <button 
                        onClick={() => setQuotaPlan(p)} 
                        className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" 
                        title="编辑配额"
                      >
                        <Edit2 size={18} />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Members Tab */}
      {tab === 'members' && (
        <div className="space-y-4">
          {/* Filters */}
          <div className="flex flex-wrap items-center justify-between gap-4">
            <div className="flex gap-2">
              {[
                { label: '待支付', value: 0 },
                { label: '生效中', value: 1 },
                { label: '已过期', value: 2 },
                { label: '已取消', value: 3 },
              ].map(({ label, value }) => (
                <button
                  key={value}
                  onClick={() => { setStatusFilter(value); setPage(1); }}
                  className={`px-4 py-2 text-sm font-bold rounded-xl transition-all ${statusFilter === value ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' : 'bg-white dark:bg-gray-800 text-gray-500 hover:bg-gray-50 dark:hover:bg-gray-700 border border-gray-100 dark:border-gray-700 shadow-sm'}`}
                >
                  {label}
                </button>
              ))}
            </div>
          </div>

          {/* Table */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
            <div className="overflow-x-auto">
              <table className="w-full text-left border-collapse admin-table">
                <thead>
                  <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800">
                    {['会员信息', '关联订单', '有效期', '状态', '操作'].map(h => (
                      <th key={h} className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">{h}</th>
                    ))}
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
                  {loading ? (
                    Array.from({ length: 5 }).map((_, i) => (
                      <tr key={i} className="animate-pulse">
                        <td colSpan={5} className="px-6 py-6 h-20">
                          <div className="flex gap-4">
                            <div className="w-10 h-10 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                            <div className="space-y-2 flex-1">
                              <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                              <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                            </div>
                          </div>
                        </td>
                      </tr>
                    ))
                  ) : members.length === 0 ? (
                    <tr>
                      <td colSpan={5} className="px-6 py-12 text-center">
                        <div className="flex flex-col items-center">
                          <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                            <Users size={32} className="text-gray-300" />
                          </div>
                          <p className="text-gray-500 dark:text-gray-400 font-medium">暂无会员记录</p>
                        </div>
                      </td>
                    </tr>
                  ) : members.map(m => (
                    <tr key={String(m.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 rounded-xl bg-white dark:bg-gray-900 flex items-center justify-center border border-gray-200 dark:border-gray-700 shadow-sm">
                            <Users size={20} className="text-brand-500" />
                          </div>
                          <div>
                            <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">
                              {getPlanName(m.planId)}
                            </p>
                            <p className="text-xs text-gray-500 dark:text-gray-400 font-mono">ID: {String((m.userId as any)?.value ?? m.userId ?? '—')}</p>
                          </div>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        {m.orderNo ? (
                          <div className="flex flex-col">
                            <span className="text-xs font-mono text-gray-600 dark:text-gray-400 bg-gray-100 dark:bg-gray-800 px-1.5 py-0.5 rounded w-fit">{m.orderNo}</span>
                          </div>
                        ) : (
                          <span className="text-xs text-gray-400 italic">手动开通</span>
                        )}
                      </td>
                      <td className="px-6 py-4">
                        <div className="space-y-1">
                          <div className="flex items-center gap-1.5 text-xs text-gray-600 dark:text-gray-400">
                            <Clock size={12} className="text-gray-400" />
                            <span>{formatDateTime(m.startTime)} 开通</span>
                          </div>
                          <div className="flex items-center gap-1.5 text-xs text-gray-600 dark:text-gray-400">
                            <Info size={12} className="text-gray-400" />
                            <span>{m.expireTime ? `${formatDateTime(m.expireTime)} 到期` : '永久有效'}</span>
                          </div>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${STATUS_COLORS[m.status || 'PENDING']}`}>
                          {STATUS_LABELS[m.status || 'PENDING']}
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2">
                          {m.status === 'PENDING' && m.orderNo && (
                            <button
                              onClick={() => handleConfirmPayment(m.orderNo!)}
                              disabled={actionLoading === m.orderNo}
                              className="p-2 text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"
                              title="确认支付"
                            >
                              {actionLoading === m.orderNo ? <Loader2 size={18} className="animate-spin" /> : <CheckCircle size={18} />}
                            </button>
                          )}
                          {m.status === 'ACTIVE' && (
                            <button
                              onClick={() => handleCancel((m.userId as any)?.value ?? m.userId)}
                              disabled={actionLoading === String((m.userId as any)?.value ?? m.userId)}
                              className="p-2 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                              title="取消会员"
                            >
                              <Ban size={18} />
                            </button>
                          )}
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            {/* Pagination */}
            <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
              <p className="text-sm text-gray-500 dark:text-gray-400 font-medium">
                第 <span className="text-gray-900 dark:text-white font-bold">{page}</span> 页
              </p>
              <div className="flex items-center gap-2">
                <button 
                  onClick={() => setPage(Math.max(1, page - 1))} 
                  disabled={page <= 1} 
                  className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all shadow-sm"
                >
                  <ChevronLeft size={18} />
                </button>
                <button 
                  onClick={() => setPage(page + 1)} 
                  disabled={members.length < 10} 
                  className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all shadow-sm"
                >
                  <ChevronRight size={18} />
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Modals */}
      <QuotaModal isOpen={!!quotaPlan} onClose={() => setQuotaPlan(null)} onSuccess={fetchPlans} plan={quotaPlan} />
      <GrantModal isOpen={showGrant} onClose={() => setShowGrant(false)} onSuccess={() => { fetchMembers(); fetchStats(); }} plans={plans} />
    </div>
  );
};

export default MembershipManagementPage;
