import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  ArrowLeft, BookOpen, Volume2, Trash2, CheckCircle2,
  BookMarked, GraduationCap, Clock, Loader2, RefreshCw,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { UserWordBookResponse, WordBookStats } from '../api/generated/models';
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

type TabKey = 'all' | 'notLearned' | 'learning' | 'mastered';

interface TabItem {
  key: TabKey;
  label: string;
  status?: number;
  icon: React.ReactNode;
  color: string;
}

const TABS: TabItem[] = [
  { key: 'all', label: '全部', icon: <BookOpen size={14} />, color: 'brand' },
  { key: 'notLearned', label: '未学习', status: 0, icon: <Clock size={14} />, color: 'gray' },
  { key: 'learning', label: '学习中', status: 1, icon: <GraduationCap size={14} />, color: 'amber' },
  { key: 'mastered', label: '已掌握', status: 2, icon: <CheckCircle2 size={14} />, color: 'green' },
];

const STATUS_COLORS: Record<number, { bg: string; text: string; dot: string }> = {
  0: { bg: 'bg-gray-100 dark:bg-gray-800', text: 'text-gray-600 dark:text-gray-400', dot: 'bg-gray-400' },
  1: { bg: 'bg-amber-50 dark:bg-amber-900/20', text: 'text-amber-600 dark:text-amber-400', dot: 'bg-amber-500' },
  2: { bg: 'bg-green-50 dark:bg-green-900/20', text: 'text-green-600 dark:text-green-400', dot: 'bg-green-500' },
};

const STATUS_LABELS: Record<number, string> = { 0: '未学习', 1: '学习中', 2: '已掌握' };

const WordBookPage: React.FC = () => {
  const navigate = useNavigate();
  const audioRef = useRef<HTMLAudioElement | null>(null);

  const [activeTab, setActiveTab] = useState<TabKey>('all');
  const [words, setWords] = useState<UserWordBookResponse[]>([]);
  const [stats, setStats] = useState<WordBookStats | null>(null);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [removing, setRemoving] = useState<string | null>(null);
  const [updatingStatus, setUpdatingStatus] = useState<string | null>(null);

  const currentTab = TABS.find(t => t.key === activeTab)!;

  const fetchStats = useCallback(async () => {
    try {
      const res = await api.getStats();
      if (res.data?.code === 0 && res.data.data) {
        setStats(res.data.data as WordBookStats);
      }
    } catch { /* ignore */ }
  }, []);

  const fetchWords = useCallback(async (status?: number, p = 1) => {
    setLoading(true);
    try {
      const res = await api.getWordBookList({ status, page: p, size: 50 });
      if (res.data?.code === 0 && res.data.data) {
        setWords(res.data.data as UserWordBookResponse[]);
      }
    } catch {
      toast.error('加载失败');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchStats();
  }, [fetchStats]);

  useEffect(() => {
    fetchWords(currentTab.status, page);
  }, [fetchWords, currentTab.status, page]);

  const handleTabChange = (tab: TabKey) => {
    setActiveTab(tab);
    setPage(1);
  };

  const handleRemove = async (item: UserWordBookResponse) => {
    if (!item.id) return;
    const idStr = String(item.id);
    setRemoving(idStr);
    try {
      await api.removeFromWordBook({ wordBookId: item.id });
      toast.success('已从生词本移除');
      setWords(prev => prev.filter(w => String(w.id) !== idStr));
      fetchStats();
    } catch {
      toast.error('移除失败');
    } finally {
      setRemoving(null);
    }
  };

  const handleUpdateStatus = async (item: UserWordBookResponse, newStatus: number) => {
    if (!item.id) return;
    const idStr = String(item.id);
    setUpdatingStatus(idStr);
    try {
      await api.updateLearningStatus({ wordBookId: item.id, status: newStatus });
      toast.success('状态已更新');
      // 如果当前 tab 有过滤，移除不匹配的项
      if (currentTab.status !== undefined && newStatus !== currentTab.status) {
        setWords(prev => prev.filter(w => String(w.id) !== idStr));
      } else {
        setWords(prev => prev.map(w =>
          String(w.id) === idStr
            ? { ...w, learningStatus: newStatus, learningStatusDesc: STATUS_LABELS[newStatus] }
            : w
        ));
      }
      fetchStats();
    } catch {
      toast.error('更新失败');
    } finally {
      setUpdatingStatus(null);
    }
  };

  const playAudio = (url?: string, e?: React.MouseEvent) => {
    e?.stopPropagation();
    if (!url) return;
    if (audioRef.current) audioRef.current.pause();
    audioRef.current = new Audio(url);
    audioRef.current.play().catch(() => {});
  };

  const getTabCount = (tab: TabKey): number => {
    if (!stats) return 0;
    switch (tab) {
      case 'all': return Number(stats.total ?? 0);
      case 'notLearned': return Number(stats.notLearned ?? 0);
      case 'learning': return Number(stats.learned ?? 0);
      case 'mastered': return Number(stats.mastered ?? 0);
    }
  };

  return (
    <div className="max-w-4xl mx-auto animate-in fade-in duration-500 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <button
            onClick={() => navigate(-1)}
            className="flex items-center gap-2 text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors group"
          >
            <div className="p-1.5 rounded-lg bg-white dark:bg-gray-900 border border-gray-100 dark:border-gray-800 group-hover:border-brand-200 shadow-sm transition-all">
              <ArrowLeft size={16} className="group-hover:-translate-x-0.5 transition-transform" />
            </div>
          </button>
          <div>
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white flex items-center gap-2">
              <BookMarked size={24} className="text-brand-600" />
              生词本
            </h1>
            <p className="text-sm text-gray-500 dark:text-gray-400 mt-0.5">
              收藏的单词，随时复习
            </p>
          </div>
        </div>
        <button
          onClick={() => { fetchWords(currentTab.status, page); fetchStats(); }}
          className="flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium text-gray-500 dark:text-gray-400 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg hover:border-brand-300 dark:hover:border-brand-600 hover:text-brand-600 transition-all"
        >
          <RefreshCw size={13} />
          刷新
        </button>
      </div>

      {/* 统计卡片 */}
      {stats && (
        <div className="grid grid-cols-4 gap-3">
          <StatsCard label="总计" value={Number(stats.total ?? 0)} icon={<BookOpen size={18} />} color="brand" />
          <StatsCard label="未学习" value={Number(stats.notLearned ?? 0)} icon={<Clock size={18} />} color="gray" />
          <StatsCard label="学习中" value={Number(stats.learned ?? 0)} icon={<GraduationCap size={18} />} color="amber" />
          <StatsCard label="已掌握" value={Number(stats.mastered ?? 0)} icon={<CheckCircle2 size={18} />} color="green" />
        </div>
      )}

      {/* Tab 栏 */}
      <div className="flex gap-1 p-1 bg-gray-100 dark:bg-gray-800/50 rounded-xl">
        {TABS.map(tab => {
          const count = getTabCount(tab.key);
          const isActive = activeTab === tab.key;
          return (
            <button
              key={tab.key}
              onClick={() => handleTabChange(tab.key)}
              className={`flex-1 flex items-center justify-center gap-1.5 px-3 py-2 rounded-lg text-sm font-medium transition-all ${
                isActive
                  ? 'bg-white dark:bg-gray-900 text-gray-900 dark:text-white shadow-sm'
                  : 'text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300'
              }`}
            >
              {tab.icon}
              {tab.label}
              {count > 0 && (
                <span className={`text-[10px] font-bold px-1.5 py-0.5 rounded-full ${
                  isActive
                    ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400'
                    : 'bg-gray-200 dark:bg-gray-700 text-gray-500 dark:text-gray-400'
                }`}>
                  {count}
                </span>
              )}
            </button>
          );
        })}
      </div>

      {/* 单词列表 */}
      <div className="space-y-2">
        {loading ? (
          <div className="space-y-2">
            {[1, 2, 3, 4, 5].map(i => (
              <div key={i} className="bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 p-4 animate-pulse">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                  <div className="flex-1 space-y-2">
                    <div className="h-5 bg-gray-100 dark:bg-gray-800 rounded w-32" />
                    <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-48" />
                  </div>
                  <div className="h-6 bg-gray-100 dark:bg-gray-800 rounded-full w-14" />
                </div>
              </div>
            ))}
          </div>
        ) : words.length === 0 ? (
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-16 text-center">
            <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
              <BookMarked size={32} className="text-gray-300 dark:text-gray-600" />
            </div>
            <p className="text-gray-500 dark:text-gray-400 font-medium mb-2">
              {activeTab === 'all' ? '生词本还是空的' : `暂无${currentTab.label}的单词`}
            </p>
            <p className="text-xs text-gray-400 dark:text-gray-500 mb-4">
              在每日单词页面点击「生词本」按钮添加单词
            </p>
            <button
              onClick={() => navigate('/daily-words')}
              className="text-sm font-medium text-brand-600 hover:text-brand-700 dark:text-brand-400 dark:hover:text-brand-300"
            >
              去学习单词 →
            </button>
          </div>
        ) : (
          words.map(item => (
            <WordCard
              key={String(item.id)}
              item={item}
              removing={String(item.id) === removing}
              updatingStatus={String(item.id) === updatingStatus}
              onNavigate={() => {
                if (item.word?.id) navigate(`/daily-word/${item.word.id}`);
              }}
              onRemove={() => handleRemove(item)}
              onUpdateStatus={(status) => handleUpdateStatus(item, status)}
              onPlayAudio={(url, e) => playAudio(url, e)}
            />
          ))
        )}
      </div>

      {/* 分页 - 简单的加载更多 */}
      {!loading && words.length >= 50 && (
        <div className="text-center">
          <button
            onClick={() => setPage(p => p + 1)}
            className="text-sm font-medium text-brand-600 hover:text-brand-700 dark:text-brand-400"
          >
            加载更多...
          </button>
        </div>
      )}
    </div>
  );
};

/* ==================== 子组件 ==================== */

interface StatsCardProps {
  label: string;
  value: number;
  icon: React.ReactNode;
  color: 'brand' | 'gray' | 'amber' | 'green';
}

const StatsCard: React.FC<StatsCardProps> = ({ label, value, icon, color }) => {
  const colorMap = {
    brand: { bg: 'bg-brand-50 dark:bg-brand-900/20', iconColor: 'text-brand-500', valueColor: 'text-brand-700 dark:text-brand-300' },
    gray: { bg: 'bg-gray-50 dark:bg-gray-800/50', iconColor: 'text-gray-400', valueColor: 'text-gray-700 dark:text-gray-300' },
    amber: { bg: 'bg-amber-50 dark:bg-amber-900/20', iconColor: 'text-amber-500', valueColor: 'text-amber-700 dark:text-amber-300' },
    green: { bg: 'bg-green-50 dark:bg-green-900/20', iconColor: 'text-green-500', valueColor: 'text-green-700 dark:text-green-300' },
  };
  const c = colorMap[color];

  return (
    <div className={`${c.bg} rounded-xl p-4 text-center transition-colors`}>
      <div className={`flex justify-center mb-2 ${c.iconColor}`}>{icon}</div>
      <div className={`text-2xl font-bold ${c.valueColor} leading-none mb-1`}>{value}</div>
      <p className="text-[11px] text-gray-500 dark:text-gray-400 font-medium">{label}</p>
    </div>
  );
};

interface WordCardProps {
  item: UserWordBookResponse;
  removing: boolean;
  updatingStatus: boolean;
  onNavigate: () => void;
  onRemove: () => void;
  onUpdateStatus: (status: number) => void;
  onPlayAudio: (url?: string, e?: React.MouseEvent) => void;
}

const WordCard: React.FC<WordCardProps> = ({
  item, removing, updatingStatus, onNavigate, onRemove, onUpdateStatus, onPlayAudio,
}) => {
  const word = item.word;
  if (!word) return null;

  const status = item.learningStatus ?? 0;
  const statusStyle = STATUS_COLORS[status] || STATUS_COLORS[0];
  const statusLabel = item.learningStatusDesc || STATUS_LABELS[status] || '未学习';
  const initial = word.word?.[0]?.toUpperCase() || '?';

  // 下一个状态循环：0→1→2→0
  const nextStatus = (status + 1) % 3;
  const nextLabel = STATUS_LABELS[nextStatus];

  return (
    <div
      className="group bg-white dark:bg-gray-900 rounded-xl border border-gray-100 dark:border-gray-800 hover:border-brand-200 dark:hover:border-brand-800 hover:shadow-md shadow-sm p-4 transition-all cursor-pointer"
      onClick={onNavigate}
    >
      <div className="flex items-center gap-4">
        {/* 首字母头像 */}
        <div className={`w-12 h-12 rounded-xl ${statusStyle.bg} flex items-center justify-center flex-shrink-0`}>
          <span className={`text-lg font-bold ${statusStyle.text}`}>{initial}</span>
        </div>

        {/* 单词信息 */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1">
            <h3 className="text-base font-bold text-gray-900 dark:text-white tracking-wide group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors">
              {word.word}
            </h3>
            {word.audioUrlUs && (
              <button
                onClick={(e) => onPlayAudio(word.audioUrlUs, e)}
                className="p-1 text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 rounded-md hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-colors"
                title="播放发音"
              >
                <Volume2 size={14} />
              </button>
            )}
          </div>
          <div className="flex items-center gap-3 text-xs text-gray-500 dark:text-gray-400">
            {word.pronunciationUs && (
              <span className="font-mono">{word.pronunciationUs}</span>
            )}
            <span className="truncate">{word.translation}</span>
          </div>
        </div>

        {/* 状态 + 操作 */}
        <div className="flex items-center gap-2 flex-shrink-0 opacity-80 group-hover:opacity-100 transition-opacity">
          {/* 状态标签 */}
          <span className={`px-2.5 py-1 rounded-full text-[11px] font-bold ${statusStyle.bg} ${statusStyle.text}`}>
            {statusLabel}
          </span>

          {/* 切换状态 */}
          <button
            onClick={(e) => { e.stopPropagation(); onUpdateStatus(nextStatus); }}
            disabled={updatingStatus}
            className="hidden group-hover:flex items-center gap-1 px-2.5 py-1 rounded-lg text-[11px] font-medium text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/30 transition-colors disabled:opacity-50"
            title={`标记为${nextLabel}`}
          >
            {updatingStatus ? <Loader2 size={12} className="animate-spin" /> : <CheckCircle2 size={12} />}
            {nextLabel}
          </button>

          {/* 移除 */}
          <button
            onClick={(e) => { e.stopPropagation(); onRemove(); }}
            disabled={removing}
            className="hidden group-hover:flex items-center p-1.5 rounded-lg text-gray-400 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors disabled:opacity-50"
            title="从生词本移除"
          >
            {removing ? <Loader2 size={14} className="animate-spin" /> : <Trash2 size={14} />}
          </button>
        </div>
      </div>

      {/* 例句 - hover 展开 */}
      {word.example && (
        <div className="hidden group-hover:block mt-3 ml-16 pl-0 border-l-2 border-brand-200 dark:border-brand-800">
          <p className="text-xs text-gray-600 dark:text-gray-400 italic pl-3 leading-relaxed">{word.example}</p>
          {word.exampleTranslation && (
            <p className="text-xs text-gray-400 dark:text-gray-500 pl-3 mt-1">{word.exampleTranslation}</p>
          )}
        </div>
      )}
    </div>
  );
};

export default WordBookPage;
