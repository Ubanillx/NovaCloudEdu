import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  ArrowLeft, Crown, Check, X, Zap, Loader2, Brain, FileText, Sparkles, BookOpen,
  History, ChevronRight, AlertCircle,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { MembershipPlan, UserMembership, UserMembershipDetailResponse } from '../api/generated/models';
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

const PLAN_LABELS: Record<string, string> = { FREE: '免费版', BASIC: '基础版', PRO: '专业版', TEACHER: '教师版' };
const STATUS_LABELS: Record<string, string> = { PENDING: '待支付', ACTIVE: '生效中', EXPIRED: '已过期', CANCELLED: '已取消' };
const STATUS_COLORS: Record<string, string> = {
  PENDING: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400',
  ACTIVE: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400',
  EXPIRED: 'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400',
  CANCELLED: 'bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-400',
};

const PLAN_GRADIENTS: Record<string, string> = {
  FREE: 'from-gray-400 to-gray-500',
  BASIC: 'from-blue-500 to-indigo-600',
  PRO: 'from-amber-500 to-orange-600',
  TEACHER: 'from-purple-500 to-pink-600',
};

const formatLimit = (v?: number) => (v === -1 || v === undefined) ? '无限' : String(v);

const MembershipPage: React.FC = () => {
  const navigate = useNavigate();
  const [plans, setPlans] = useState<MembershipPlan[]>([]);
  const [currentMembership, setCurrentMembership] = useState<UserMembershipDetailResponse | null>(null);
  const [history, setHistory] = useState<UserMembership[]>([]);
  const [quota, setQuota] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [purchasing, setPurchasing] = useState<string | null>(null);
  const [showHistory, setShowHistory] = useState(false);

  const fetchData = async () => {
    try {
      const [plansRes, memRes, histRes, quotaRes] = await Promise.all([
        api.listPlans(),
        api.getCurrentMembership(),
        api.getMembershipHistory(),
        api.getAiQuota(),
      ]);
      if (plansRes.data.code === 0) setPlans((plansRes.data.data || []).filter((p: MembershipPlan) => p.code !== 'TEACHER'));
      if (memRes.data.code === 0) setCurrentMembership(memRes.data.data || null);
      if (histRes.data.code === 0) setHistory(histRes.data.data || []);
      if (quotaRes.data.code === 0) setQuota(quotaRes.data.data);
    } catch { /* silent */ } finally { setLoading(false); }
  };

  useEffect(() => { fetchData(); }, []);

  const handlePurchase = async (planId: number | undefined) => {
    if (!planId) return;
    setPurchasing(String(planId));
    try {
      const res = await api.purchaseMembership({ purchaseMembershipRequest: { planId: planId as unknown as number } });
      if (res.data.code === 0) {
        toast.success(`订单创建成功！订单号：${res.data.data}，请等待管理员确认支付。`);
        fetchData();
      } else {
        toast.error(res.data.message || '购买失败');
      }
    } catch (err: any) {
      toast.error(err?.response?.data?.message || '购买失败');
    } finally {
      setPurchasing(null);
    }
  };

  const currentPlanId = currentMembership?.status === 'ACTIVE' ? currentMembership.planId : null;

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <Loader2 size={32} className="animate-spin text-brand-500" />
      </div>
    );
  }

  return (
    <div className="max-w-5xl mx-auto space-y-8">
      {/* Header */}
      <div className="flex items-center gap-4">
        <button onClick={() => navigate(-1)} className="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
          <ArrowLeft size={20} className="text-gray-600 dark:text-gray-400" />
        </button>
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">会员中心</h1>
          <p className="text-sm text-gray-500 dark:text-gray-400">解锁更多AI功能，提升学习体验</p>
        </div>
      </div>

      {/* Current AI Quota Summary */}
      {quota && (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm">
          <h3 className="text-sm font-semibold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-4">今日 AI 额度</h3>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {[
              { key: 'AI_CHAT', label: 'AI 对话', icon: Brain },
              { key: 'AI_PPT', label: 'PPT 生成', icon: FileText },
              { key: 'AI_EXAM', label: 'AI 出题', icon: Sparkles },
              { key: 'AI_BOOK', label: '电子书AI', icon: BookOpen },
            ].map(({ key, label, icon: Icon }) => {
              const d = quota[key]?.dailyRemaining ?? -1;
              const m = quota[key]?.monthlyRemaining ?? -1;
              const isUnlimited = d === -1 && m === -1;
              return (
                <div key={key} className="flex items-center gap-3 p-3 rounded-xl bg-gray-50 dark:bg-gray-800/50">
                  <Icon size={20} className="text-brand-500 flex-shrink-0" />
                  <div>
                    <div className="text-xs text-gray-500 dark:text-gray-400">{label}</div>
                    <div className="text-sm font-bold text-gray-900 dark:text-white">
                      {isUnlimited ? '无限' : `${d}次/天 · ${m}次/月`}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}

      {/* Plan Cards */}
      <div className="grid md:grid-cols-3 gap-6">
        {plans.map((plan) => {
          const code = plan.code || 'FREE';
          const gradient = PLAN_GRADIENTS[code] || PLAN_GRADIENTS.FREE;
          const isCurrent = String(plan.id) === String(currentPlanId);
          const isFree = plan.price === 0 || plan.code === 'FREE';

          return (
            <div
              key={String(plan.id)}
              className={`relative bg-white dark:bg-gray-900 rounded-2xl border ${isCurrent ? 'border-brand-500 ring-2 ring-brand-500/20' : 'border-gray-200 dark:border-gray-800'} overflow-hidden shadow-sm hover:shadow-sm transition-all duration-300`}
            >
              {isCurrent && (
                <div className="absolute top-4 right-4 px-2.5 py-1 bg-brand-500 text-white text-xs font-bold rounded-full">当前</div>
              )}
              {/* Plan Header */}
              <div className={`bg-gradient-to-br ${gradient} p-6 text-white`}>
                <Crown size={28} className="mb-3 opacity-90" />
                <h3 className="text-xl font-bold">{PLAN_LABELS[code] || plan.name}</h3>
                <div className="mt-2">
                  <span className="text-3xl font-black">¥{plan.price ?? 0}</span>
                  {plan.durationDays && plan.durationDays > 0 && (
                    <span className="text-sm opacity-80 ml-1">/{plan.durationDays}天</span>
                  )}
                  {(!plan.durationDays || plan.durationDays === 0) && (
                    <span className="text-sm opacity-80 ml-1">/永久</span>
                  )}
                </div>
                <p className="text-sm opacity-80 mt-2">{plan.description}</p>
              </div>

              {/* Features */}
              <div className="p-5 space-y-3">
                <div className="space-y-2">
                  {[
                    { label: 'AI对话', daily: plan.aiChatDailyLimit, monthly: plan.aiChatMonthlyLimit },
                    { label: 'PPT生成', daily: plan.aiPptDailyLimit, monthly: plan.aiPptMonthlyLimit },
                    { label: 'AI出题', daily: plan.aiExamDailyLimit, monthly: plan.aiExamMonthlyLimit },
                    { label: '电子书AI', daily: plan.aiBookDailyLimit, monthly: plan.aiBookMonthlyLimit },
                  ].map((f) => (
                    <div key={f.label} className="flex items-center justify-between text-sm">
                      <span className="text-gray-600 dark:text-gray-400">{f.label}</span>
                      <span className="font-medium text-gray-900 dark:text-white">
                        {formatLimit(f.daily)}/天 · {formatLimit(f.monthly)}/月
                      </span>
                    </div>
                  ))}
                  <div className="flex items-center justify-between text-sm pt-2 border-t border-gray-100 dark:border-gray-800">
                    <span className="text-gray-600 dark:text-gray-400">会员课访问</span>
                    {plan.courseMemberAccess ? (
                      <Check size={18} className="text-green-500" />
                    ) : (
                      <X size={18} className="text-gray-300 dark:text-gray-600" />
                    )}
                  </div>
                </div>

                {/* Action */}
                {isCurrent ? (
                  <button disabled className="w-full py-2.5 text-sm font-bold text-gray-400 bg-gray-100 dark:bg-gray-800 rounded-xl cursor-not-allowed">
                    当前计划
                  </button>
                ) : isFree ? null : (
                  <button
                    onClick={() => handlePurchase(plan.id)}
                    disabled={!!purchasing}
                    className="w-full py-2.5 text-sm font-bold text-white bg-gradient-to-r from-brand-500 to-brand-600 rounded-xl hover:shadow-sm hover:shadow-brand-500/20 transition-all active:scale-[0.98] disabled:opacity-50 flex items-center justify-center gap-2"
                  >
                    {purchasing === String(plan.id) ? <Loader2 size={16} className="animate-spin" /> : <Zap size={16} />}
                    立即开通
                  </button>
                )}
              </div>
            </div>
          );
        })}
      </div>

      {/* Membership History */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 overflow-hidden shadow-sm">
        <button
          onClick={() => setShowHistory(!showHistory)}
          className="w-full flex items-center justify-between px-6 py-4 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors"
        >
          <div className="flex items-center gap-3">
            <History size={20} className="text-gray-400" />
            <span className="font-semibold text-gray-900 dark:text-white">会员记录</span>
            <span className="text-xs text-gray-400">({history.length})</span>
          </div>
          <ChevronRight size={20} className={`text-gray-400 transition-transform ${showHistory ? 'rotate-90' : ''}`} />
        </button>

        {showHistory && (
          <div className="border-t border-gray-100 dark:border-gray-800">
            {history.length === 0 ? (
              <div className="p-8 text-center text-gray-400 text-sm">暂无会员记录</div>
            ) : (
              <div className="divide-y divide-gray-100 dark:divide-gray-800">
                {history.map((m) => (
                  <div key={String(m.id)} className="px-6 py-3 flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <Crown size={16} className="text-gray-400" />
                      <div>
                        <div className="text-sm font-medium text-gray-900 dark:text-white">
                          订单号：{m.orderNo || '—'}
                        </div>
                        <div className="text-xs text-gray-500">
                          {m.startTime ? new Date(m.startTime).toLocaleDateString('zh-CN') : '—'}
                          {m.expireTime ? ` ~ ${new Date(m.expireTime).toLocaleDateString('zh-CN')}` : ' ~ 永久'}
                        </div>
                      </div>
                    </div>
                    <span className={`px-2.5 py-1 text-xs font-semibold rounded-full ${STATUS_COLORS[m.status || 'PENDING']}`}>
                      {STATUS_LABELS[m.status || 'PENDING']}
                    </span>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </div>

      {/* Info */}
      <div className="flex items-start gap-3 p-4 bg-blue-50 dark:bg-blue-900/20 rounded-xl border border-blue-100 dark:border-blue-900/30">
        <AlertCircle size={18} className="text-blue-500 mt-0.5 flex-shrink-0" />
        <div className="text-sm text-blue-700 dark:text-blue-300">
          <p className="font-medium mb-1">支付说明</p>
          <p className="text-blue-600 dark:text-blue-400">目前支持线下支付，购买后请联系管理员确认收款，确认后会员即刻生效。</p>
        </div>
      </div>
    </div>
  );
};

export default MembershipPage;
