import { useState, useEffect, useCallback } from 'react';
import {
  Users, BookOpen, ShoppingCart, DollarSign, Activity, MessageSquare,
  TrendingUp, TrendingDown, Minus, RefreshCw, AlertTriangle, Clock,
  CheckCircle2, Brain, FileText, Presentation, Workflow, Bot,
  GraduationCap, School, BarChart3, PieChart, Crown, BookA,
  ClipboardList, Newspaper, CalendarCheck, Globe, Loader2
} from 'lucide-react';
import { AdminDashboardControllerApi, apiClient } from '../../api';
import type {
  DashboardOverviewResponse,
  DashboardTrendsResponse,
  DashboardLearningResponse,
  DashboardContentResponse,
  DashboardAiSystemResponse,
  DashboardAlertsResponse,
} from '../../api';
import { Toast } from '../../components/ui';

const dashboardApi = new AdminDashboardControllerApi(undefined, '', apiClient);

// 环比计算
function calcChange(current?: number, previous?: number): { percent: number; direction: 'up' | 'down' | 'same' } {
  const c = current ?? 0;
  const p = previous ?? 0;
  if (p === 0) return { percent: c > 0 ? 100 : 0, direction: c > 0 ? 'up' : 'same' };
  const pct = Math.round(((c - p) / p) * 100);
  return { percent: Math.abs(pct), direction: pct > 0 ? 'up' : pct < 0 ? 'down' : 'same' };
}

// 格式化数字
function fmt(n?: number): string {
  if (n === undefined || n === null) return '0';
  if (n >= 10000) return (n / 10000).toFixed(1) + 'w';
  if (n >= 1000) return (n / 1000).toFixed(1) + 'k';
  return String(n);
}

// 格式化金额
function fmtMoney(n?: number): string {
  if (n === undefined || n === null) return '¥0.00';
  return '¥' + n.toFixed(2);
}

// 格式化时长
function fmtDuration(seconds?: number): string {
  if (!seconds) return '0h';
  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  if (h > 0) return `${h}h ${m}m`;
  return `${m}m`;
}

// 趋势指示器组件
function TrendBadge({ current, previous }: { current?: number; previous?: number }) {
  const { percent, direction } = calcChange(current, previous);
  if (direction === 'same') return <span className="flex items-center gap-1 text-xs text-gray-400"><Minus size={12} />持平</span>;
  if (direction === 'up') return <span className="flex items-center gap-1 text-xs text-green-500"><TrendingUp size={12} />+{percent}%</span>;
  return <span className="flex items-center gap-1 text-xs text-red-500"><TrendingDown size={12} />-{percent}%</span>;
}

// KPI 卡片
function KpiCard({ icon: Icon, label, value, subValue, current, previous, color = 'brand' }: {
  icon: React.ElementType; label: string; value: string; subValue?: string;
  current?: number; previous?: number; color?: string;
}) {
  const colorMap: Record<string, string> = {
    brand: 'bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400',
    blue: 'bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400',
    green: 'bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400',
    purple: 'bg-purple-50 dark:bg-purple-900/20 text-purple-600 dark:text-purple-400',
    orange: 'bg-orange-50 dark:bg-orange-900/20 text-orange-600 dark:text-orange-400',
    red: 'bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400',
    cyan: 'bg-cyan-50 dark:bg-cyan-900/20 text-cyan-600 dark:text-cyan-400',
    pink: 'bg-pink-50 dark:bg-pink-900/20 text-pink-600 dark:text-pink-400',
  };
  return (
    <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-5 shadow-sm hover:shadow-md transition-all duration-300">
      <div className="flex items-center justify-between mb-3">
        <div className={`w-10 h-10 rounded-xl flex items-center justify-center ${colorMap[color] || colorMap.brand}`}>
          <Icon size={20} />
        </div>
        {current !== undefined && previous !== undefined && (
          <TrendBadge current={current} previous={previous} />
        )}
      </div>
      <p className="text-2xl font-bold text-gray-900 dark:text-white">{value}</p>
      <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">{label}</p>
      {subValue && <p className="text-xs text-gray-400 dark:text-gray-500 mt-0.5">{subValue}</p>}
    </div>
  );
}

// 简易柱状图（纯 CSS）
function MiniBarChart({ data, labelKey, valueKey, maxBars = 7 }: {
  data: Array<Record<string, unknown>>; labelKey: string; valueKey: string; maxBars?: number;
}) {
  const sliced = data.slice(-maxBars);
  const maxVal = Math.max(...sliced.map(d => Number(d[valueKey]) || 0), 1);
  return (
    <div className="flex items-end gap-1 h-20">
      {sliced.map((d, i) => {
        const val = Number(d[valueKey]) || 0;
        const h = Math.max((val / maxVal) * 100, 4);
        const label = String(d[labelKey] || '').slice(-5);
        return (
          <div key={i} className="flex-1 flex flex-col items-center gap-1">
            <div className="w-full bg-brand-500/80 dark:bg-brand-400/60 rounded-t transition-all duration-500" style={{ height: `${h}%` }} title={`${label}: ${val}`} />
            <span className="text-[10px] text-gray-400 truncate w-full text-center">{label}</span>
          </div>
        );
      })}
    </div>
  );
}

// 简易饼图（SVG 环形）
function MiniDonut({ data, labelKey, valueKey }: {
  data: Array<Record<string, unknown>>; labelKey: string; valueKey: string;
}) {
  const total = data.reduce((s, d) => s + (Number(d[valueKey]) || 0), 0);
  if (total === 0) return <p className="text-sm text-gray-400 text-center py-4">暂无数据</p>;
  const colors = ['#6366f1', '#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899'];
  let cumAngle = 0;
  const arcs = data.map((d, i) => {
    const val = Number(d[valueKey]) || 0;
    const angle = (val / total) * 360;
    const startAngle = cumAngle;
    cumAngle += angle;
    const large = angle > 180 ? 1 : 0;
    const rad = (a: number) => (a - 90) * Math.PI / 180;
    const r = 40;
    const cx = 50, cy = 50;
    const x1 = cx + r * Math.cos(rad(startAngle));
    const y1 = cy + r * Math.sin(rad(startAngle));
    const x2 = cx + r * Math.cos(rad(startAngle + angle));
    const y2 = cy + r * Math.sin(rad(startAngle + angle));
    const path = angle >= 359.9
      ? `M ${cx} ${cy - r} A ${r} ${r} 0 1 1 ${cx - 0.01} ${cy - r} Z`
      : `M ${cx} ${cy} L ${x1} ${y1} A ${r} ${r} 0 ${large} 1 ${x2} ${y2} Z`;
    return { path, color: colors[i % colors.length], label: String(d[labelKey]), val, pct: ((val / total) * 100).toFixed(1) };
  });
  return (
    <div className="flex items-center gap-4">
      <svg viewBox="0 0 100 100" className="w-20 h-20 flex-shrink-0">
        {arcs.map((a, i) => <path key={i} d={a.path} fill={a.color} opacity={0.85} />)}
        <circle cx="50" cy="50" r="22" className="fill-white dark:fill-gray-900" />
      </svg>
      <div className="flex-1 space-y-1 text-xs">
        {arcs.slice(0, 5).map((a, i) => (
          <div key={i} className="flex items-center gap-2">
            <span className="w-2.5 h-2.5 rounded-full flex-shrink-0" style={{ background: a.color }} />
            <span className="text-gray-600 dark:text-gray-300 truncate">{a.label}</span>
            <span className="ml-auto text-gray-400">{a.pct}%</span>
          </div>
        ))}
      </div>
    </div>
  );
}

// 排行榜
function RankList({ data, labelKey, valueKey, title, valueSuffix = '' }: {
  data: Array<Record<string, unknown>>; labelKey: string; valueKey: string; title: string; valueSuffix?: string;
}) {
  if (!data?.length) return null;
  const maxVal = Math.max(...data.map(d => Number(d[valueKey]) || 0), 1);
  return (
    <div>
      <h4 className="text-sm font-bold text-gray-700 dark:text-gray-200 mb-3">{title}</h4>
      <div className="space-y-2">
        {data.slice(0, 5).map((d, i) => {
          const val = Number(d[valueKey]) || 0;
          const w = Math.max((val / maxVal) * 100, 8);
          return (
            <div key={i} className="flex items-center gap-3">
              <span className={`w-5 h-5 rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0 ${i < 3 ? 'bg-brand-100 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400' : 'bg-gray-100 dark:bg-gray-800 text-gray-400'}`}>{i + 1}</span>
              <div className="flex-1 min-w-0">
                <div className="flex items-center justify-between mb-0.5">
                  <span className="text-sm text-gray-700 dark:text-gray-300 truncate">{String(d[labelKey] || `#${d['user_id'] || d['class_id'] || d['id'] || i}`)}</span>
                  <span className="text-xs font-medium text-gray-500 ml-2">{fmt(val)}{valueSuffix}</span>
                </div>
                <div className="h-1.5 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
                  <div className="h-full bg-brand-500/60 dark:bg-brand-400/40 rounded-full transition-all duration-500" style={{ width: `${w}%` }} />
                </div>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}

// 面板容器
function Panel({ title, children, className = '' }: { title: string; children: React.ReactNode; className?: string }) {
  return (
    <div className={`bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-5 transition-all duration-300 ${className}`}>
      <h3 className="text-sm font-bold text-gray-700 dark:text-gray-200 mb-4 flex items-center gap-2">
        <BarChart3 size={16} className="text-brand-500" />
        {title}
      </h3>
      {children}
    </div>
  );
}

// 预警项
function AlertItem({ icon: Icon, label, count, color = 'orange' }: {
  icon: React.ElementType; label: string; count: number; color?: string;
}) {
  const colorCls = color === 'red'
    ? 'bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400'
    : 'bg-orange-50 dark:bg-orange-900/20 text-orange-600 dark:text-orange-400';
  return (
    <div className="flex items-center gap-3 p-3 rounded-xl bg-gray-50 dark:bg-gray-800/50">
      <div className={`w-9 h-9 rounded-lg flex items-center justify-center ${colorCls}`}>
        <Icon size={18} />
      </div>
      <div className="flex-1 min-w-0">
        <p className="text-sm text-gray-700 dark:text-gray-300">{label}</p>
      </div>
      <span className={`text-lg font-bold ${count > 0 ? 'text-orange-600 dark:text-orange-400' : 'text-gray-400'}`}>{count}</span>
    </div>
  );
}

export function DashboardPage() {
  const [loading, setLoading] = useState(true);
  const [overview, setOverview] = useState<DashboardOverviewResponse>();
  const [trends, setTrends] = useState<DashboardTrendsResponse>();
  const [learning, setLearning] = useState<DashboardLearningResponse>();
  const [content, setContent] = useState<DashboardContentResponse>();
  const [aiSystem, setAiSystem] = useState<DashboardAiSystemResponse>();
  const [alerts, setAlerts] = useState<DashboardAlertsResponse>();

  const userInfoStr = localStorage.getItem('user_info');
  const userInfo = userInfoStr ? JSON.parse(userInfoStr) : null;
  const userRole = (userInfo?.userRole || userInfo?.role || '').toLowerCase();
  const isAdmin = userRole === 'admin';

  const loadData = useCallback(async () => {
    setLoading(true);
    try {
      const res = await dashboardApi.getFull({});
      const d = res.data?.data;
      if (d) {
        setOverview(d.overview);
        setTrends(d.trends);
        setLearning(d.learning);
        setContent(d.content);
        setAiSystem(d.aiSystem);
        setAlerts(d.alerts);
      }
    } catch (err) {
      console.error('加载仪表盘数据失败:', err);
      Toast.error('加载仪表盘数据失败');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { loadData(); }, [loadData]);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-96">
        <Loader2 size={32} className="animate-spin text-brand-500" />
      </div>
    );
  }

  // 活动类型映射
  const activityTypeLabels: Record<string, string> = {
    COURSE_WATCH: '课程观看',
    ARTICLE_READ: '文章阅读',
    WORD_STUDY: '单词学习',
    HOMEWORK_SUBMIT: '作业提交',
    CHECKIN: '打卡',
  };

  const activityDist = (learning?.activityDistribution || []).map(d => ({
    ...d,
    label: activityTypeLabels[String(d['activity_type'])] || String(d['activity_type']),
    count: Number(d['cnt']) || 0,
  }));

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* 页头 */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
            {isAdmin ? '管理员仪表盘' : '教师工作台'}
          </h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">
            {isAdmin ? '平台运营数据概览与监控' : '班级教学数据概览'}
          </p>
        </div>
        <button
          onClick={loadData}
          className="flex items-center gap-2 px-4 py-2 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors"
        >
          <RefreshCw size={18} className={loading ? 'animate-spin' : ''} />
          <span>刷新数据</span>
        </button>
      </div>

      {/* KPI 卡片 */}
      <div className={`grid gap-4 ${isAdmin ? 'grid-cols-2 lg:grid-cols-4' : 'grid-cols-2 lg:grid-cols-4'}`}>
        {isAdmin ? (
          <>
            <KpiCard icon={Users} label="总用户数" value={fmt(overview?.totalUsers)} color="brand"
              subValue={`今日 +${overview?.todayNewUsers ?? 0}`}
              current={overview?.todayNewUsers} previous={overview?.yesterdayNewUsers} />
            <KpiCard icon={BookOpen} label="课程总数" value={fmt(overview?.totalCourses)} color="blue"
              subValue={`已发布 ${overview?.coursesByStatus?.['1'] ?? 0}`} />
            <KpiCard icon={Crown} label="活跃会员" value={fmt(overview?.activeMembers)} color="purple" />
            <KpiCard icon={Activity} label="今日活跃" value={fmt(overview?.todayDau)} color="green"
              current={overview?.todayDau} previous={overview?.yesterdayDau} />
            <KpiCard icon={ShoppingCart} label="今日订单" value={fmt(overview?.todayOrders)} color="orange"
              current={overview?.todayOrders} previous={overview?.yesterdayOrders} />
            <KpiCard icon={DollarSign} label="今日收入" value={fmtMoney(overview?.todayRevenue)} color="cyan"
              current={overview?.todayRevenue} previous={overview?.yesterdayRevenue} />
            <KpiCard icon={MessageSquare} label="待处理反馈" value={fmt(overview?.pendingFeedbacks)} color="red" />
            <KpiCard icon={Clock} label="平台学习时长" value={fmtDuration(learning?.totalDurationSec)} color="pink"
              subValue="近30天累计" />
          </>
        ) : (
          <>
            <KpiCard icon={School} label="我的班级" value={fmt(overview?.myClassCount)} color="brand" />
            <KpiCard icon={GraduationCap} label="我的学生" value={fmt(overview?.myStudentCount)} color="blue" />
            <KpiCard icon={Activity} label="今日活跃学生" value={fmt(overview?.todayDau)} color="green"
              current={overview?.todayDau} previous={overview?.yesterdayDau} />
            <KpiCard icon={CheckCircle2} label="作业平均得分率" value={`${learning?.avgHomeworkScoreRate ?? 0}%`} color="purple" />
          </>
        )}
      </div>

      {/* 趋势图 + 学情概览 */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        {/* 活跃趋势 */}
        <Panel title="活跃用户趋势（近30天）">
          {trends?.activeTrend?.length ? (
            <MiniBarChart data={trends.activeTrend as Array<Record<string, unknown>>} labelKey="activity_date" valueKey="dau" />
          ) : (
            <p className="text-sm text-gray-400 text-center py-8">暂无趋势数据</p>
          )}
        </Panel>

        {/* 活动类型分布 */}
        <Panel title="学习活动分布">
          {activityDist.length ? (
            <MiniDonut data={activityDist} labelKey="label" valueKey="count" />
          ) : (
            <p className="text-sm text-gray-400 text-center py-8">暂无活动数据</p>
          )}
        </Panel>

        {isAdmin && (
          <>
            {/* 用户增长 */}
            <Panel title="用户增长趋势（近30天）">
              {trends?.userGrowth?.length ? (
                <MiniBarChart data={trends.userGrowth as Array<Record<string, unknown>>} labelKey="day" valueKey="cnt" />
              ) : (
                <p className="text-sm text-gray-400 text-center py-8">暂无数据</p>
              )}
            </Panel>

            {/* 收入趋势 */}
            <Panel title="收入趋势（近30天）">
              {trends?.revenueTrend?.length ? (
                <MiniBarChart data={trends.revenueTrend as Array<Record<string, unknown>>} labelKey="day" valueKey="revenue" />
              ) : (
                <p className="text-sm text-gray-400 text-center py-8">暂无数据</p>
              )}
            </Panel>
          </>
        )}
      </div>

      {/* 排行榜 */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        <Panel title="活跃用户 Top 10">
          <RankList
            data={(learning?.topActiveUsers || []) as Array<Record<string, unknown>>}
            labelKey="user_id" valueKey="activity_count" title="" valueSuffix="次"
          />
          {!learning?.topActiveUsers?.length && <p className="text-sm text-gray-400 text-center py-4">暂无数据</p>}
        </Panel>

        {isAdmin && (
          <Panel title="活跃班级 Top 10">
            <RankList
              data={(learning?.topActiveClasses || []) as Array<Record<string, unknown>>}
              labelKey="class_id" valueKey="activity_count" title="" valueSuffix="次"
            />
            {!learning?.topActiveClasses?.length && <p className="text-sm text-gray-400 text-center py-4">暂无数据</p>}
          </Panel>
        )}
      </div>

      {/* 内容运营 — 仅管理员 */}
      {isAdmin && content && (
        <div>
          <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-4 flex items-center gap-2">
            <FileText size={20} className="text-brand-500" />
            内容运营
          </h2>
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-4">
            <KpiCard icon={BookOpen} label="课程" value={fmt(content.totalCourses)} color="brand" subValue={`${fmt(content.totalCourseStudents)} 学员`} />
            <KpiCard icon={FileText} label="每日文章" value={fmt(content.totalArticles)} color="blue" subValue={`${fmt(content.totalArticleViews)} 浏览`} />
            <KpiCard icon={BookA} label="每日单词" value={fmt(content.totalWords)} color="green" />
            <KpiCard icon={ClipboardList} label="试卷 / 题目" value={`${fmt(content.totalExamPapers)} / ${fmt(content.totalQuestions)}`} color="purple" />
            <KpiCard icon={BookOpen} label="电子书" value={fmt(content.totalBooks)} color="cyan" />
            <KpiCard icon={Newspaper} label="社区帖子" value={fmt(content.totalPosts)} color="orange" subValue={`今日 +${content.todayNewPosts ?? 0}`} />
          </div>

          {/* 热门排行 */}
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-4 mt-4">
            <Panel title="热门课程 Top 5">
              <RankList
                data={(content.topCourses || []) as Array<Record<string, unknown>>}
                labelKey="title" valueKey="student_count" title="" valueSuffix="人"
              />
              {!content.topCourses?.length && <p className="text-sm text-gray-400 text-center py-4">暂无数据</p>}
            </Panel>
            <Panel title="热门文章 Top 5">
              <RankList
                data={(content.topArticles || []) as Array<Record<string, unknown>>}
                labelKey="title" valueKey="view_count" title="" valueSuffix="浏览"
              />
              {!content.topArticles?.length && <p className="text-sm text-gray-400 text-center py-4">暂无数据</p>}
            </Panel>
            <Panel title="热门帖子 Top 5">
              <RankList
                data={(content.topPosts || []) as Array<Record<string, unknown>>}
                labelKey="title" valueKey="thumb_num" title="" valueSuffix="赞"
              />
              {!content.topPosts?.length && <p className="text-sm text-gray-400 text-center py-4">暂无数据</p>}
            </Panel>
          </div>
        </div>
      )}

      {/* AI & 系统 — 仅管理员 */}
      {isAdmin && aiSystem && (
        <div>
          <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-4 flex items-center gap-2">
            <Brain size={20} className="text-brand-500" />
            AI & 系统监控
          </h2>
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-4">
            <KpiCard icon={Bot} label="AI 对话" value={fmt(aiSystem.totalAiSessions)} color="brand" subValue={`今日 ${aiSystem.todayAiSessions ?? 0} 会话`} />
            <KpiCard icon={MessageSquare} label="AI 消息" value={fmt(aiSystem.totalAiMessages)} color="blue" subValue={`今日 ${aiSystem.todayAiMessages ?? 0}`} />
            <KpiCard icon={ClipboardList} label="智能批改" value={fmt(aiSystem.totalSubmissions)} color="green" subValue={`今日 ${aiSystem.todaySubmissions ?? 0}`} />
            <KpiCard icon={Presentation} label="PPT 生成" value={fmt(aiSystem.totalPptSessions)} color="purple"
              subValue={`成功 ${aiSystem.completedPptSessions ?? 0}`} />
            <KpiCard icon={Workflow} label="工作流执行" value={fmt(aiSystem.totalWorkflowExecutions)} color="cyan"
              subValue={`完成 ${aiSystem.completedWorkflowExecutions ?? 0}`} />
            <KpiCard icon={Brain} label="工作流总数" value={fmt(aiSystem.totalWorkflows)} color="orange" />
          </div>
        </div>
      )}

      {/* 待办 & 预警 — 仅管理员 */}
      {isAdmin && alerts && (
        <div>
          <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-4 flex items-center gap-2">
            <AlertTriangle size={20} className="text-orange-500" />
            待办 & 预警
          </h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            <AlertItem icon={MessageSquare} label="待处理反馈" count={alerts.pendingFeedbackCount ?? 0} color="red" />
            <AlertItem icon={Crown} label="即将过期会员（7天内）" count={alerts.expiringMemberCount ?? 0} />
            <AlertItem icon={Globe} label="爬虫失败任务（近7天）" count={alerts.failedScraperTaskCount ?? 0} />
            <AlertItem icon={CalendarCheck} label={`今日打卡（${alerts.todayCheckinCount ?? 0}/${alerts.totalUserCount ?? 0}）`}
              count={alerts.todayCheckinCount ?? 0} color="orange" />
          </div>

          {/* 最近待处理反馈列表 */}
          {(alerts.recentPendingFeedbacks?.length ?? 0) > 0 && (
            <div className="mt-4 bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
              <div className="px-5 py-3 border-b border-gray-100 dark:border-gray-800">
                <h4 className="text-sm font-bold text-gray-700 dark:text-gray-200">最近待处理反馈</h4>
              </div>
              <div className="divide-y divide-gray-50 dark:divide-gray-800">
                {(alerts.recentPendingFeedbacks as Array<Record<string, unknown>>).map((fb, i) => (
                  <div key={i} className="px-5 py-3 flex items-center justify-between hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors">
                    <div className="min-w-0">
                      <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{String(fb['title'] || '无标题')}</p>
                      <p className="text-xs text-gray-400">{String(fb['feedback_type'] || '')} · {String(fb['create_time'] || '').slice(0, 16)}</p>
                    </div>
                    <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${Number(fb['status']) === 0 ? 'bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400' : 'bg-yellow-50 dark:bg-yellow-900/20 text-yellow-600 dark:text-yellow-400'}`}>
                      {Number(fb['status']) === 0 ? '待处理' : '处理中'}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
