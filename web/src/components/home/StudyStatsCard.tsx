import React, { useState, useEffect, useCallback } from 'react';
import { CalendarDays, Flame, Heart, Trophy, Zap, CheckCircle2, Loader2 } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { UserStatsResult, CheckinRankingItem } from '../../api/generated/models';
import toast from '../ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

const CACHE_KEY = 'nova_cache_user_stats';

function getCachedStats(): UserStatsResult | null {
  try {
    const raw = localStorage.getItem(CACHE_KEY);
    if (!raw) return null;
    const entry = JSON.parse(raw);
    if (Date.now() > entry.timestamp + entry.expiry) {
      localStorage.removeItem(CACHE_KEY);
      return null;
    }
    return entry.data;
  } catch {
    return null;
  }
}

function cacheStats(data: UserStatsResult) {
  try {
    localStorage.setItem(CACHE_KEY, JSON.stringify({ data, timestamp: Date.now(), expiry: 5 * 60 * 1000 }));
  } catch { /* ignore */ }
}

export const StudyStatsCard: React.FC = () => {
  const [stats, setStats] = useState<UserStatsResult | null>(null);
  const [ranking, setRanking] = useState<CheckinRankingItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [checkinLoading, setCheckinLoading] = useState(false);
  const [showRanking, setShowRanking] = useState(false);

  const fetchStats = useCallback(async () => {
    const cached = getCachedStats();
    if (cached) {
      setStats(cached);
      setLoading(false);
    }
    try {
      const res = await api.getUserStats();
      if (res.data.code === 0 && res.data.data) {
        setStats(res.data.data);
        cacheStats(res.data.data);
      }
    } catch { /* ignore */ }
    finally { setLoading(false); }
  }, []);

  useEffect(() => {
    fetchStats();
  }, [fetchStats]);

  const handleCheckin = async () => {
    if (checkinLoading || stats?.checkedInToday) return;
    setCheckinLoading(true);
    try {
      const res = await api.checkin();
      if (res.data.code === 0 && res.data.data) {
        // 更新本地状态
        setStats((prev) => prev ? {
          ...prev,
          checkedInToday: true,
          totalCheckinDays: res.data.data!.totalCheckinDays ?? prev.totalCheckinDays,
          currentStreak: res.data.data!.streakDays ?? prev.currentStreak,
        } : prev);
        // 清缓存让下次刷新
        localStorage.removeItem(CACHE_KEY);
        toast.success('打卡成功，继续保持！');
      }
    } catch { toast.error('打卡失败，请稍后重试'); }
    finally { setCheckinLoading(false); }
  };

  const loadRanking = async () => {
    if (ranking.length > 0) {
      setShowRanking(!showRanking);
      return;
    }
    try {
      const res = await api.getCheckinRanking({ limit: 5 });
      if (res.data.code === 0 && res.data.data) {
        setRanking(res.data.data);
      }
    } catch { /* ignore */ }
    setShowRanking(true);
  };

  if (loading && !stats) {
    return (
      <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm p-5 animate-pulse">
        <div className="h-5 bg-gray-200 dark:bg-gray-800 rounded w-20 mb-4" />
        <div className="grid grid-cols-3 gap-3 mb-4">
          {[1, 2, 3].map((i) => (
            <div key={i} className="h-16 bg-gray-100 dark:bg-gray-800 rounded-xl" />
          ))}
        </div>
        <div className="h-11 bg-gray-200 dark:bg-gray-800 rounded-xl" />
      </div>
    );
  }

  const registerDays = stats?.registerDays ?? 0;
  const checkinDays = stats?.totalCheckinDays ?? 0;
  const totalLikes = stats?.totalLikes ?? 0;
  const checkedIn = stats?.checkedInToday ?? false;
  const streak = stats?.currentStreak ?? 0;

  return (
    <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm overflow-hidden">
      {/* Header */}
      <div className="px-5 pt-5 pb-3">
        <h3 className="font-bold text-base flex items-center gap-2 text-gray-900 dark:text-white">
          <span className="w-1 h-5 bg-brand-600 rounded-full" />
          学习状态
        </h3>
      </div>

      {/* 统计数据 */}
      <div className="px-5 pb-4">
        <div className="grid grid-cols-3 gap-3">
          <div className="bg-blue-50 dark:bg-blue-900/20 rounded-xl p-2.5 text-center">
            <CalendarDays size={16} className="text-blue-500 mx-auto mb-0.5" />
            <div className="text-lg font-bold text-gray-900 dark:text-white">{registerDays}</div>
            <div className="text-[10px] text-gray-500 dark:text-gray-400 font-medium whitespace-nowrap">学习</div>
          </div>
          <div className="bg-red-50 dark:bg-red-900/20 rounded-xl p-2.5 text-center">
            <Flame size={16} className="text-red-500 mx-auto mb-0.5" />
            <div className="text-lg font-bold text-gray-900 dark:text-white">{checkinDays}</div>
            <div className="text-[10px] text-gray-500 dark:text-gray-400 font-medium whitespace-nowrap">打卡</div>
          </div>
          <div className="bg-pink-50 dark:bg-pink-900/20 rounded-xl p-2.5 text-center">
            <Heart size={16} className="text-pink-500 mx-auto mb-0.5" />
            <div className="text-lg font-bold text-gray-900 dark:text-white">{totalLikes}</div>
            <div className="text-[10px] text-gray-500 dark:text-gray-400 font-medium whitespace-nowrap">心心</div>
          </div>
        </div>
      </div>

      {/* 连续打卡提示 */}
      {streak > 0 && (
        <div className="mx-5 mb-3 flex items-center gap-2 px-3 py-2 bg-amber-50 dark:bg-amber-900/10 rounded-lg">
          <Zap size={14} className="text-amber-500" />
          <span className="text-xs text-amber-700 dark:text-amber-400 font-medium">已连续打卡 {streak} 天，继续保持！</span>
        </div>
      )}

      {/* 打卡按钮 + 排行榜入口 */}
      <div className="px-5 pb-4 flex gap-2">
        <button
          onClick={handleCheckin}
          disabled={checkedIn || checkinLoading}
          className={`flex-1 h-11 rounded-xl text-sm font-bold flex items-center justify-center gap-2 transition-all active:scale-[0.98] ${
            checkedIn
              ? 'bg-gray-100 dark:bg-gray-800 text-gray-400 dark:text-gray-500 cursor-default'
              : 'bg-gradient-to-r from-red-500 to-pink-500 text-white shadow-lg shadow-red-500/20 hover:shadow-red-500/30'
          }`}
        >
          {checkinLoading ? (
            <Loader2 size={16} className="animate-spin" />
          ) : checkedIn ? (
            <>
              <CheckCircle2 size={16} />
              今日已打卡
            </>
          ) : (
            <>
              <Zap size={16} />
              立即打卡
            </>
          )}
        </button>
        <button
          onClick={loadRanking}
          className="w-11 h-11 rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800 flex items-center justify-center text-amber-500 hover:bg-amber-50 dark:hover:bg-amber-900/20 transition-colors"
          title="打卡排行榜"
        >
          <Trophy size={18} />
        </button>
      </div>

      {/* 排行榜展开区 */}
      {showRanking && (
        <div className="border-t border-gray-100 dark:border-gray-800 px-5 py-4">
          <h4 className="text-xs font-bold text-gray-500 dark:text-gray-400 uppercase tracking-wider mb-3 flex items-center gap-1.5">
            <Trophy size={12} className="text-amber-500" />
            打卡排行榜
          </h4>
          {ranking.length === 0 ? (
            <p className="text-xs text-gray-400 dark:text-gray-500 text-center py-3">暂无排行数据</p>
          ) : (
            <div className="space-y-2.5">
              {ranking.map((item, index) => {
                const rankColors = ['text-amber-500', 'text-gray-400', 'text-amber-700'];
                return (
                  <div key={item.userId} className="flex items-center gap-2.5">
                    <span className={`w-5 text-center text-xs font-bold ${index < 3 ? rankColors[index] : 'text-gray-400 dark:text-gray-500'}`}>
                      {index < 3 ? '🏆' : (item.rank ?? index + 1)}
                    </span>
                    <div className="w-7 h-7 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center overflow-hidden flex-shrink-0">
                      {item.userAvatar ? (
                        <img src={item.userAvatar} alt="" className="w-full h-full object-cover" />
                      ) : (
                        <span className="text-xs text-gray-400">{(item.userName ?? '?')[0]}</span>
                      )}
                    </div>
                    <span className="flex-1 text-sm text-gray-700 dark:text-gray-300 truncate">{item.userName}</span>
                    <span className="flex items-center gap-1 text-xs text-red-500 font-bold">
                      <Flame size={12} />
                      {item.totalCheckinDays}
                    </span>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      )}
    </div>
  );
};
