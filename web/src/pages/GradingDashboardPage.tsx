import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, TrendingUp, Target, AlertTriangle, Award, BookOpen, BarChart3, Loader2, PenTool } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { GradingStatsResponse, SubjectProfileSummary, ScoreTrendItem, ErrorCategoryCount } from '../api/generated/models';
import toast from '../components/ui/Toast';
import { getSubjectName } from '../constants/exam';

const api = new DefaultApi(new Configuration(), '', apiClient);

const ERROR_CATEGORY_NAMES: Record<string, string> = {
  CONCEPT_ERROR: '概念错误', CALCULATION_ERROR: '计算错误',
  READING_ERROR: '审题错误', UNIT_ERROR: '单位错误',
  STEP_MISSING: '步骤缺失', LOGIC_INCOMPLETE: '逻辑不完整',
  EXPRESSION_UNCLEAR: '表达不清', GRAMMAR_ERROR: '语法错误',
  SPELLING_ERROR: '拼写错误', FORMAT_ERROR: '格式错误',
  KNOWLEDGE_GAP: '知识盲区', CARELESS_MISTAKE: '粗心大意',
};

const GradingDashboardPage: React.FC = () => {
  const navigate = useNavigate();
  const [stats, setStats] = useState<GradingStatsResponse | null>(null);
  const [profiles, setProfiles] = useState<SubjectProfileSummary[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    setLoading(true);
    try {
      const [statsRes, profileRes] = await Promise.all([
        api.getStats3(),
        api.getAllProfiles(),
      ]);
      if (statsRes.data?.code === 0 && statsRes.data?.data) {
        setStats(statsRes.data.data);
      }
      if (profileRes.data?.code === 0 && Array.isArray(profileRes.data?.data)) {
        setProfiles(profileRes.data.data);
      }
    } catch {
      toast.error('加载学习数据失败');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <Loader2 size={32} className="text-brand-500 animate-spin" />
      </div>
    );
  }

  const hasData = stats && (stats.totalSubmissions ?? 0) > 0;

  return (
    <div className="max-w-5xl mx-auto space-y-8">
      {/* 页头 */}
      <div className="flex items-center gap-4">
        <button onClick={() => navigate(-1)} className="p-2.5 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-800 transition-all active:scale-95 group">
          <ArrowLeft size={20} className="text-gray-500 group-hover:text-brand-500 transition-colors" />
        </button>
        <div className="flex-1">
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white tracking-tight">学习画像中心</h1>
          <p className="text-sm text-gray-500 dark:text-gray-400">AI 深度分析你的学情数据，助力精准提升</p>
        </div>
        <button onClick={() => navigate('/grading')}
          className="flex items-center gap-2 px-6 py-3 bg-brand-600 hover:bg-brand-700 text-white rounded-2xl text-sm font-bold transition-all shadow-xl shadow-brand-600/20 active:scale-[0.98] group">
          <PenTool size={16} className="group-hover:rotate-12 transition-transform" /> 
          <span>开始批改</span>
        </button>
      </div>

      {!hasData ? (
        <div className="text-center py-24 bg-white dark:bg-gray-900 rounded-3xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden relative">
          <div className="absolute top-0 inset-x-0 h-1 bg-gradient-to-r from-transparent via-brand-500/20 to-transparent" />
          <div className="relative z-10">
            <div className="w-20 h-20 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-6 shadow-inner">
              <BarChart3 size={40} className="text-gray-300 dark:text-gray-600" />
            </div>
            <h2 className="text-xl font-bold text-gray-900 dark:text-white mb-2">暂无学情数据</h2>
            <p className="text-sm text-gray-400 dark:text-gray-500 mb-8 max-w-xs mx-auto">
              通过智能批改提交作业后，AI 将自动为你生成多维度的学习报告
            </p>
            <button onClick={() => navigate('/grading')}
              className="px-8 py-3 bg-brand-600 hover:bg-brand-700 text-white rounded-2xl text-sm font-bold transition-all shadow-lg shadow-brand-600/20">
              立即开启第一次批改
            </button>
          </div>
        </div>
      ) : (
        <>
          {/* 概览卡片 */}
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
            <OverviewCard icon={<BookOpen size={20} />} label="累计批改" value={stats?.totalSubmissions ?? 0} unit="次" color="brand" />
            <OverviewCard icon={<Target size={20} />} label="平均得分率"
              value={`${((stats?.avgScoreRate ?? 0) * 100).toFixed(0)}`} unit="%" color="green" />
            <OverviewCard icon={<Award size={20} />} label="覆盖学科"
              value={Object.keys(stats?.subjectScoreRates ?? {}).length} unit="门" color="blue" />
            <OverviewCard icon={<AlertTriangle size={20} />} label="薄弱知识点"
              value={profiles.reduce((sum, p) => sum + (p.weakPointCount ?? 0), 0)} unit="个" color="red" />
          </div>

          <div className="grid grid-cols-1 xl:grid-cols-3 gap-6">
            {/* 得分趋势 */}
            <div className="xl:col-span-2">
              {stats?.scoreTrend && stats.scoreTrend.length > 0 && (
                <ScoreTrendChart data={stats.scoreTrend} />
              )}
            </div>
            
            {/* 学科得分率 */}
            <div className="xl:col-span-1">
              {stats?.subjectScoreRates && Object.keys(stats.subjectScoreRates).length > 0 && (
                <SubjectScoreCard rates={stats.subjectScoreRates} />
              )}
            </div>
          </div>

          {/* 错因分布 */}
          {stats?.errorDistribution && stats.errorDistribution.length > 0 && (
            <ErrorDistributionCard data={stats.errorDistribution} />
          )}

          {/* 各学科知识画像 */}
          {profiles.length > 0 && (
            <div className="space-y-6">
              <div className="flex items-center gap-2 px-1">
                <div className="w-1.5 h-5 bg-brand-500 rounded-full" />
                <h2 className="text-lg font-bold text-gray-900 dark:text-white tracking-tight">各学科知识掌握度</h2>
              </div>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {profiles.map(p => (
                  <SubjectProfileCard key={p.subject} profile={p} />
                ))}
              </div>
            </div>
          )}
        </>
      )}
    </div>
  );
};

// ==================== 子组件 ====================

const OverviewCard: React.FC<{ icon: React.ReactNode; label: string; value: number | string; unit?: string; color: string }> = ({ icon, label, value, unit, color }) => {
  const colorMap: Record<string, string> = {
    brand: 'bg-brand-500/10 text-brand-600 dark:text-brand-400 ring-brand-500/20',
    green: 'bg-green-500/10 text-green-600 dark:text-green-400 ring-green-500/20',
    blue: 'bg-blue-500/10 text-blue-600 dark:text-blue-400 ring-blue-500/20',
    red: 'bg-red-500/10 text-red-600 dark:text-red-400 ring-red-500/20',
  };
  return (
    <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-5 shadow-sm hover:shadow-sm transition-shadow group relative overflow-hidden">
      <div className={`absolute top-0 right-0 p-4 opacity-5 group-hover:opacity-10 transition-opacity`}>
        {icon}
      </div>
      <div className={`inline-flex p-2.5 rounded-xl mb-4 ring-1 ${colorMap[color] || colorMap.brand}`}>
        {icon}
      </div>
      <div className="flex items-baseline gap-1">
        <div className="text-3xl font-black text-gray-900 dark:text-white tracking-tight tabular-nums">{value}</div>
        {unit && <span className="text-xs font-bold text-gray-400 uppercase tracking-widest">{unit}</span>}
      </div>
      <div className="text-xs font-bold text-gray-500 dark:text-gray-400 mt-1 uppercase tracking-wider">{label}</div>
    </div>
  );
};

const ScoreTrendChart: React.FC<{ data: ScoreTrendItem[] }> = ({ data }) => {
  const maxVal = Math.max(...data.map(d => d.maxScore ?? 100));
  return (
    <div className="bg-white dark:bg-gray-900 rounded-3xl border border-gray-100 dark:border-gray-800 p-7 shadow-sm h-full flex flex-col">
      <div className="flex items-center justify-between mb-8">
        <div className="flex items-center gap-3">
          <div className="p-2 rounded-xl bg-brand-500/10 text-brand-500">
            <TrendingUp size={20} />
          </div>
          <div>
            <h3 className="text-sm font-bold text-gray-900 dark:text-white uppercase tracking-wider">最近批改得分趋势</h3>
            <p className="text-[10px] text-gray-400 font-medium">展示最近 10 次提交的表现情况</p>
          </div>
        </div>
      </div>
      <div className="flex-1 flex items-end gap-3 min-h-[160px]">
        {data.map((item, i) => {
          const score = item.score ?? 0;
          const max = item.maxScore ?? 100;
          const pct = maxVal > 0 ? (score / maxVal) * 100 : 0;
          const rate = max > 0 ? score / max : 0;
          return (
            <div key={i} className="flex-1 flex flex-col items-center gap-2 group relative">
              <div className="absolute -top-10 left-1/2 -translate-x-1/2 bg-gray-900 dark:bg-white text-white dark:text-gray-900 text-[10px] px-2.5 py-1.5 rounded-xl opacity-0 group-hover:opacity-100 transition-all scale-90 group-hover:scale-100 pointer-events-none z-10 whitespace-nowrap shadow-xl">
                <span className="font-black">{score}</span> / {max} ({(rate * 100).toFixed(0)}%)
                <div className="mt-0.5 opacity-60 font-medium">{getSubjectName(item.subject)}</div>
                <div className="absolute -bottom-1 left-1/2 -translate-x-1/2 border-l-4 border-r-4 border-t-4 border-transparent border-t-gray-900 dark:border-t-white" />
              </div>
              <div
                style={{ height: `${Math.max(pct, 8)}%` }}
                className={`w-full rounded-t-xl transition-all duration-500 group-hover:brightness-110 group-hover:shadow-sm relative overflow-hidden ${
                  rate >= 0.8 ? 'bg-gradient-to-t from-green-500 to-green-400' :
                  rate >= 0.6 ? 'bg-gradient-to-t from-yellow-500 to-yellow-400' :
                  'bg-gradient-to-t from-red-500 to-red-400'
                }`}>
                <div className="absolute top-0 inset-x-0 h-1/2 bg-white/20 opacity-0 group-hover:opacity-100 transition-opacity" />
              </div>
              <span className="text-[10px] font-bold text-gray-400 tabular-nums">
                {item.createTime ? new Date(item.createTime).toLocaleDateString('zh-CN', { month: 'numeric', day: 'numeric' }) : ''}
              </span>
            </div>
          );
        })}
      </div>
    </div>
  );
};

const SubjectScoreCard: React.FC<{ rates: Record<string, number> }> = ({ rates }) => {
  const sorted = Object.entries(rates).sort((a, b) => b[1] - a[1]);
  return (
    <div className="bg-white dark:bg-gray-900 rounded-3xl border border-gray-100 dark:border-gray-800 p-7 shadow-sm h-full flex flex-col">
      <div className="flex items-center gap-3 mb-8">
        <div className="p-2 rounded-xl bg-green-500/10 text-green-500">
          <BarChart3 size={20} />
        </div>
        <h3 className="text-sm font-bold text-gray-900 dark:text-white uppercase tracking-wider">学科得分分布</h3>
      </div>
      <div className="space-y-5 flex-1 overflow-y-auto custom-scrollbar pr-1">
        {sorted.map(([subject, rate]) => (
          <div key={subject} className="group">
            <div className="flex justify-between text-xs mb-2">
              <span className="text-gray-700 dark:text-gray-300 font-bold">{getSubjectName(subject)}</span>
              <span className={`font-black tabular-nums ${rate >= 0.8 ? 'text-green-500' : rate >= 0.6 ? 'text-yellow-500' : 'text-red-500'}`}>
                {(rate * 100).toFixed(0)}%
              </span>
            </div>
            <div className="w-full h-2.5 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden p-0.5">
              <div className={`h-full rounded-full transition-all duration-1000 ease-out relative group-hover:brightness-110 ${
                rate >= 0.8 ? 'bg-green-500' : rate >= 0.6 ? 'bg-yellow-500' : 'bg-red-500'
              }`} style={{ width: `${rate * 100}%` }}>
                <div className="absolute inset-0 bg-white/20 animate-pulse" />
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

const ErrorDistributionCard: React.FC<{ data: ErrorCategoryCount[] }> = ({ data }) => {
  const maxCount = Math.max(...data.map(d => d.count ?? 0), 1);
  return (
    <div className="bg-white dark:bg-gray-900 rounded-3xl border border-gray-100 dark:border-gray-800 p-7 shadow-sm">
      <div className="flex items-center gap-3 mb-8">
        <div className="p-2 rounded-xl bg-red-500/10 text-red-500">
          <AlertTriangle size={20} />
        </div>
        <div>
          <h3 className="text-sm font-bold text-gray-900 dark:text-white uppercase tracking-wider">错因深度剖析</h3>
          <p className="text-[10px] text-gray-400 font-medium">识别频繁出现的错误类型，精准弥补薄弱点</p>
        </div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-x-12 gap-y-6">
        {data.slice(0, 10).map((item) => {
          const pct = maxCount > 0 ? ((item.count ?? 0) / maxCount) * 100 : 0;
          return (
            <div key={item.category} className="flex flex-col gap-2 group">
              <div className="flex items-center justify-between">
                <span className="text-xs font-bold text-gray-600 dark:text-gray-400 truncate">
                  {ERROR_CATEGORY_NAMES[item.category ?? ''] || item.categoryName || item.category}
                </span>
                <span className="text-[10px] font-black text-gray-400 bg-gray-50 dark:bg-gray-800 px-2 py-0.5 rounded-md tabular-nums group-hover:text-red-500 transition-colors">
                  {item.count} 次
                </span>
              </div>
              <div className="flex-1 h-1.5 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
                <div className="h-full bg-red-500 rounded-full transition-all duration-1000 ease-out shadow-sm group-hover:scale-y-125 origin-left"
                  style={{ width: `${pct}%` }} />
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
};

const SubjectProfileCard: React.FC<{ profile: SubjectProfileSummary }> = ({ profile }) => {
  const mastery = profile.avgMasteryLevel ?? 0;
  const weakPoints = profile.weakPoints ?? [];
  const strongPoints = profile.strongPoints ?? [];

  return (
    <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm hover:shadow-sm hover:-translate-y-0.5 transition-all group overflow-hidden relative">
      {/* 水印背景 */}
      <div className="absolute -right-4 -bottom-4 opacity-5 group-hover:opacity-10 transition-opacity">
        <Target size={120} />
      </div>

      <div className="flex items-center justify-between mb-5 relative z-10">
        <h4 className="text-base font-bold text-gray-900 dark:text-white">
          {profile.subjectName || getSubjectName(profile.subject)}
        </h4>
        <div className={`flex items-center gap-1.5 px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-wider ${
          mastery >= 0.8 ? 'bg-green-500/10 text-green-600 dark:text-green-400 border border-green-500/20' :
          mastery >= 0.6 ? 'bg-yellow-500/10 text-yellow-600 dark:text-yellow-400 border border-yellow-500/20' :
          'bg-red-500/10 text-red-600 dark:text-red-400 border border-red-500/20'
        }`}>
          <Target size={10} />
          掌握度 {(mastery * 100).toFixed(0)}%
        </div>
      </div>

      <div className="grid grid-cols-3 gap-2 mb-5 relative z-10">
        <div className="text-center p-2 rounded-xl bg-gray-50 dark:bg-gray-800/50">
          <div className="text-xs font-black text-gray-900 dark:text-white tabular-nums">{profile.totalPoints ?? 0}</div>
          <div className="text-[9px] text-gray-400 font-bold uppercase">知识点</div>
        </div>
        <div className="text-center p-2 rounded-xl bg-red-50 dark:bg-red-900/10">
          <div className="text-xs font-black text-red-500 tabular-nums">{profile.weakPointCount ?? 0}</div>
          <div className="text-[9px] text-red-400 font-bold uppercase">薄弱</div>
        </div>
        <div className="text-center p-2 rounded-xl bg-green-50 dark:bg-green-900/10">
          <div className="text-xs font-black text-green-500 tabular-nums">{profile.strongPointCount ?? 0}</div>
          <div className="text-[9px] text-green-400 font-bold uppercase">优势</div>
        </div>
      </div>

      {/* 掌握度条 */}
      <div className="w-full h-1.5 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden mb-6 relative z-10 p-0.5">
        <div className={`h-full rounded-full shadow-sm ${
          mastery >= 0.8 ? 'bg-green-500' : mastery >= 0.6 ? 'bg-yellow-500' : 'bg-red-500'
        }`} style={{ width: `${mastery * 100}%` }} />
      </div>

      {/* 核心知识点列表 */}
      <div className="space-y-4 relative z-10">
        {weakPoints.length > 0 && (
          <div>
            <span className="text-[10px] font-black text-red-400 mb-2 block uppercase tracking-widest flex items-center gap-1.5">
              <AlertTriangle size={10} /> 待攻克知识点
            </span>
            <div className="flex gap-1.5 flex-wrap">
              {weakPoints.slice(0, 4).map(wp => (
                <span key={wp.knowledgePoint} className="text-[10px] px-2 py-1 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-lg font-bold border border-red-100/50 dark:border-red-800/30">
                  {wp.knowledgePoint}
                </span>
              ))}
              {weakPoints.length > 4 && <span className="text-[10px] px-2 py-1 text-gray-400 font-bold">+ {weakPoints.length - 4}</span>}
            </div>
          </div>
        )}

        {strongPoints.length > 0 && (
          <div>
            <span className="text-[10px] font-black text-green-400 mb-2 block uppercase tracking-widest flex items-center gap-1.5">
              <Award size={10} /> 优势知识点
            </span>
            <div className="flex gap-1.5 flex-wrap">
              {strongPoints.slice(0, 4).map(sp => (
                <span key={sp.knowledgePoint} className="text-[10px] px-2 py-1 bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 rounded-lg font-bold border border-green-100/50 dark:border-green-800/30">
                  {sp.knowledgePoint}
                </span>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default GradingDashboardPage;
