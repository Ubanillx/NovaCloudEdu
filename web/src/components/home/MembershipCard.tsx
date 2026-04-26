import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Crown, Zap, Sparkles, BookOpen, FileText, Brain, ArrowRight, Loader2, FileCheck } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { UserMembershipDetailResponse } from '../../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

const PLAN_COLORS: Record<string, { bg: string; text: string; icon: string; border: string; gradient: string }> = {
  FREE: {
    bg: 'bg-gray-50 dark:bg-gray-800/50',
    text: 'text-gray-600 dark:text-gray-400',
    icon: 'text-gray-400',
    border: 'border-gray-200 dark:border-gray-700',
    gradient: 'from-gray-400 to-gray-500',
  },
  BASIC: {
    bg: 'bg-blue-50 dark:bg-blue-900/20',
    text: 'text-blue-600 dark:text-blue-400',
    icon: 'text-blue-500',
    border: 'border-blue-200 dark:border-blue-800',
    gradient: 'from-blue-500 to-indigo-500',
  },
  PRO: {
    bg: 'bg-amber-50 dark:bg-amber-900/20',
    text: 'text-amber-600 dark:text-amber-400',
    icon: 'text-amber-500',
    border: 'border-amber-200 dark:border-amber-800',
    gradient: 'from-amber-500 to-orange-500',
  },
  TEACHER: {
    bg: 'bg-purple-50 dark:bg-purple-900/20',
    text: 'text-purple-600 dark:text-purple-400',
    icon: 'text-purple-500',
    border: 'border-purple-200 dark:border-purple-800',
    gradient: 'from-purple-500 to-pink-500',
  },
};

const PLAN_LABELS: Record<string, string> = {
  FREE: '免费版',
  BASIC: '基础版',
  PRO: '专业版',
  TEACHER: '教师版',
};

interface QuotaItem {
  label: string;
  icon: React.ElementType;
  dailyRemaining: number;
  monthlyRemaining: number;
}

const QuotaBar: React.FC<{ label: string; icon: React.ElementType; daily: number; monthly: number }> = ({ label, icon: Icon, daily, monthly }) => {
  const isUnlimited = daily === -1 && monthly === -1;
  return (
    <div className="flex items-center gap-3 py-2">
      <Icon size={16} className="text-gray-400 dark:text-gray-500 flex-shrink-0" />
      <div className="flex-1 min-w-0">
        <div className="flex items-center justify-between mb-1">
          <span className="text-xs font-medium text-gray-600 dark:text-gray-400">{label}</span>
          <span className="text-xs text-gray-500 dark:text-gray-500">
            {isUnlimited ? '无限' : `今日${daily} / 本月${monthly}`}
          </span>
        </div>
        {!isUnlimited && (
          <div className="h-1.5 bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
            <div
              className="h-full bg-gradient-to-r from-brand-500 to-brand-400 rounded-full transition-all duration-500"
              style={{ width: daily <= 0 ? '100%' : `${Math.max(5, 100 - daily * 5)}%` }}
            />
          </div>
        )}
      </div>
    </div>
  );
};

export const MembershipCard: React.FC = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [membershipDetail, setMembershipDetail] = useState<UserMembershipDetailResponse | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const memRes = await api.getCurrentMembership();
        if (memRes.data.code === 0 && memRes.data.data) {
          setMembershipDetail(memRes.data.data);
        }
      } catch {
        // silent
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);

  if (loading) {
    return (
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 flex items-center justify-center min-h-[200px]">
        <Loader2 size={24} className="animate-spin text-gray-400" />
      </div>
    );
  }

  const planCode = membershipDetail?.planCode || 'FREE';
  const colors = PLAN_COLORS[planCode] || PLAN_COLORS.FREE;
  const planLabel = PLAN_LABELS[planCode] || '免费版';

  const quotaItems: QuotaItem[] = membershipDetail ? [
    { label: 'AI 对话', icon: Brain, dailyRemaining: membershipDetail.aiChatDailyRemaining ?? -1, monthlyRemaining: membershipDetail.aiChatMonthlyRemaining ?? -1 },
    { label: 'PPT 生成', icon: FileText, dailyRemaining: membershipDetail.aiPptDailyRemaining ?? -1, monthlyRemaining: membershipDetail.aiPptMonthlyRemaining ?? -1 },
    { label: 'AI 出题', icon: Sparkles, dailyRemaining: membershipDetail.aiExamDailyRemaining ?? -1, monthlyRemaining: membershipDetail.aiExamMonthlyRemaining ?? -1 },
    { label: '电子书AI', icon: BookOpen, dailyRemaining: membershipDetail.aiBookDailyRemaining ?? -1, monthlyRemaining: membershipDetail.aiBookMonthlyRemaining ?? -1 },
    { label: '智能批改', icon: FileCheck, dailyRemaining: membershipDetail.aiGradingDailyRemaining ?? -1, monthlyRemaining: membershipDetail.aiGradingMonthlyRemaining ?? -1 },
  ] : [];

  return (
    <div className={`bg-white dark:bg-gray-900 rounded-2xl border ${colors.border} overflow-hidden shadow-sm`}>
      {/* Header */}
      <div className={`${colors.bg} px-5 py-4 flex items-center justify-between`}>
        <div className="flex items-center gap-3">
          <div className={`w-10 h-10 rounded-xl bg-white/80 dark:bg-gray-900/70 border ${colors.border} flex items-center justify-center shadow-sm`}>
            <Crown size={20} className={colors.text} />
          </div>
          <div>
            <div className={`text-sm font-bold ${colors.text}`}>{planLabel}</div>
            {membershipDetail?.status === 'ACTIVE' && membershipDetail.expireTime ? (
              <div className="text-xs text-gray-500 dark:text-gray-500">
                到期：{new Date(membershipDetail.expireTime).toLocaleDateString('zh-CN')}
              </div>
            ) : membershipDetail?.status === 'ACTIVE' ? (
              <div className="text-xs text-gray-500 dark:text-gray-500">永久有效</div>
            ) : (
              <div className="text-xs text-gray-500 dark:text-gray-500">未开通会员</div>
            )}
          </div>
        </div>
        {planCode === 'FREE' && (
          <button
            onClick={() => navigate('/membership')}
            className="flex items-center gap-1 px-3 py-1.5 text-xs font-bold text-white bg-gradient-to-r from-brand-500 to-brand-600 rounded-lg hover:shadow-sm hover:shadow-brand-500/20 transition-all active:scale-95"
          >
            <Zap size={14} />
            升级
          </button>
        )}
      </div>

      {/* AI Quota */}
      {quotaItems.length > 0 && (
        <div className="px-5 py-3 space-y-0.5">
          <div className="text-xs font-semibold text-gray-500 dark:text-gray-500 uppercase tracking-wider mb-2">AI 额度</div>
          {quotaItems.map((item) => (
            <QuotaBar
              key={item.label}
              label={item.label}
              icon={item.icon}
              daily={item.dailyRemaining}
              monthly={item.monthlyRemaining}
            />
          ))}
        </div>
      )}

      {/* Footer */}
      <div className="px-5 py-3 border-t border-gray-100 dark:border-gray-800">
        <button
          onClick={() => navigate('/membership')}
          className="w-full flex items-center justify-center gap-2 text-xs font-medium text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors py-1"
        >
          查看会员详情
          <ArrowRight size={14} />
        </button>
      </div>
    </div>
  );
};

export default MembershipCard;
