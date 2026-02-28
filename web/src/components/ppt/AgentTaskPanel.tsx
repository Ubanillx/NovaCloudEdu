import React, { useEffect, useRef } from 'react';
import {
  CheckCircle2,
  Circle,
  Loader2,
  XCircle,
  SkipForward,
  Search,
  FileText,
  Palette,
  Eye,
  Wrench,
  Package,
  Brain,
  ChevronDown,
  ChevronUp,
  Sparkles,
  TrendingUp,
} from 'lucide-react';
import type {
  AgentTask,
  AgentTaskSummary,
  AgentTaskStatus,
  AgentRole,
  EvaluationResult,
  RepairProgress,
} from '../../hooks/usePptGeneration';

// ==================== Agent Role Config ====================

const ROLE_CONFIG: Record<AgentRole, { icon: React.ElementType; label: string; color: string }> = {
  RESEARCHER: { icon: Search, label: '研究员', color: 'text-blue-500' },
  PLANNER: { icon: Brain, label: '规划师', color: 'text-purple-500' },
  CONTENT: { icon: FileText, label: '内容编辑', color: 'text-emerald-500' },
  DESIGN: { icon: Palette, label: '视觉设计', color: 'text-pink-500' },
  EVALUATOR: { icon: Eye, label: '质量审查', color: 'text-amber-500' },
  REPAIRER: { icon: Wrench, label: '修复优化', color: 'text-orange-500' },
  ASSEMBLER: { icon: Package, label: '组装输出', color: 'text-indigo-500' },
};

const STATUS_CONFIG: Record<AgentTaskStatus, { icon: React.ElementType; label: string; className: string }> = {
  PENDING: { icon: Circle, label: '等待中', className: 'text-gray-300 dark:text-gray-600' },
  IN_PROGRESS: { icon: Loader2, label: '进行中', className: 'text-brand-500 animate-spin' },
  COMPLETED: { icon: CheckCircle2, label: '已完成', className: 'text-emerald-500' },
  FAILED: { icon: XCircle, label: '失败', className: 'text-red-500' },
  SKIPPED: { icon: SkipForward, label: '跳过', className: 'text-gray-400' },
};

// ==================== Sub Components ====================

const TaskItem: React.FC<{ task: AgentTask; isLatest: boolean }> = ({ task, isLatest }) => {
  const roleConfig = ROLE_CONFIG[task.agentRole] || ROLE_CONFIG.CONTENT;
  const statusConfig = STATUS_CONFIG[task.status] || STATUS_CONFIG.PENDING;
  const StatusIcon = statusConfig.icon;
  const RoleIcon = roleConfig.icon;

  return (
    <div
      className={`flex items-start gap-2.5 px-3 py-2 rounded-lg transition-all duration-300 ${
        isLatest && task.status === 'IN_PROGRESS'
          ? 'bg-brand-50/80 dark:bg-brand-900/20 ring-1 ring-brand-200 dark:ring-brand-800'
          : task.status === 'COMPLETED'
            ? 'bg-emerald-50/50 dark:bg-emerald-900/10'
            : task.status === 'FAILED'
              ? 'bg-red-50/50 dark:bg-red-900/10'
              : 'hover:bg-gray-50 dark:hover:bg-gray-800/30'
      }`}
    >
      {/* Status icon */}
      <div className="mt-0.5 flex-shrink-0">
        <StatusIcon size={16} className={statusConfig.className} />
      </div>

      {/* Content */}
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-1.5">
          <RoleIcon size={12} className={`flex-shrink-0 ${roleConfig.color}`} />
          <span className={`text-xs font-medium ${roleConfig.color}`}>{roleConfig.label}</span>
          {task.slideIndex !== undefined && task.slideIndex !== null && (
            <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-gray-100 dark:bg-gray-700 text-gray-500 dark:text-gray-400">
              P{task.slideIndex + 1}
            </span>
          )}
        </div>
        <p className="text-xs text-gray-600 dark:text-gray-400 mt-0.5 leading-relaxed truncate">
          {task.description}
        </p>
        {task.detail && task.status === 'IN_PROGRESS' && (
          <p className="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5 truncate italic">
            {task.detail}
          </p>
        )}
        {task.durationMs !== undefined && task.durationMs > 0 && task.status === 'COMPLETED' && (
          <p className="text-[10px] text-gray-400 mt-0.5">
            {task.durationMs < 1000
              ? `${task.durationMs}ms`
              : `${(task.durationMs / 1000).toFixed(1)}s`}
          </p>
        )}
      </div>
    </div>
  );
};

const ScoreBar: React.FC<{ label: string; score: number; color: string }> = ({ label, score, color }) => (
  <div className="flex items-center gap-2">
    <span className="text-[11px] text-gray-500 dark:text-gray-400 w-10 text-right">{label}</span>
    <div className="flex-1 h-1.5 bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
      <div
        className={`h-full rounded-full transition-all duration-700 ${color}`}
        style={{ width: `${Math.min(100, score)}%` }}
      />
    </div>
    <span className="text-[11px] font-medium text-gray-600 dark:text-gray-300 w-7">{score}</span>
  </div>
);

// ==================== Main Component ====================

interface AgentTaskPanelProps {
  tasks: AgentTask[];
  summary: AgentTaskSummary | null;
  evaluationResult: EvaluationResult | null;
  repairProgress: RepairProgress | null;
}

const AgentTaskPanel: React.FC<AgentTaskPanelProps> = ({
  tasks,
  summary,
  evaluationResult,
  repairProgress,
}) => {
  const [collapsed, setCollapsed] = React.useState(false);
  const listRef = useRef<HTMLDivElement>(null);

  // Auto-scroll to latest in-progress task
  useEffect(() => {
    if (listRef.current && !collapsed) {
      const inProgressEl = listRef.current.querySelector('[data-in-progress="true"]');
      if (inProgressEl) {
        inProgressEl.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
      }
    }
  }, [tasks, collapsed]);

  if (tasks.length === 0) return null;

  const latestInProgressId = [...tasks].reverse().find(t => t.status === 'IN_PROGRESS')?.id;
  const progress = summary?.progress ?? 0;

  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="px-3 py-2.5 border-b border-gray-100 dark:border-gray-800">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-1.5">
            <Sparkles size={14} className="text-brand-500" />
            <span className="text-xs font-semibold text-gray-700 dark:text-gray-300">Agent 任务</span>
          </div>
          <button
            onClick={() => setCollapsed(!collapsed)}
            className="p-1 rounded hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
          >
            {collapsed ? <ChevronDown size={14} className="text-gray-400" /> : <ChevronUp size={14} className="text-gray-400" />}
          </button>
        </div>

        {/* Progress bar */}
        {summary && (
          <div className="mt-2">
            <div className="flex items-center justify-between mb-1">
              <span className="text-[10px] text-gray-400">
                {summary.completed}/{summary.total} 完成
              </span>
              <span className="text-[10px] font-medium text-brand-500">{progress}%</span>
            </div>
            <div className="h-1.5 bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
              <div
                className="h-full bg-gradient-to-r from-brand-400 to-brand-500 rounded-full transition-all duration-500"
                style={{ width: `${progress}%` }}
              />
            </div>
          </div>
        )}
      </div>

      {/* Repair progress badge */}
      {repairProgress && (
        <div className="px-3 py-1.5 border-b border-gray-100 dark:border-gray-800 bg-amber-50/50 dark:bg-amber-900/10">
          <div className="flex items-center gap-1.5">
            <TrendingUp size={12} className="text-amber-500" />
            <span className="text-[11px] text-amber-600 dark:text-amber-400">
              {repairProgress.phase === 'evaluating' ? '质量评估中' : `修复第 ${repairProgress.slideIndex !== undefined ? repairProgress.slideIndex + 1 : '?'} 页`}
              {repairProgress.round > 0 && ` (第${repairProgress.round}轮)`}
            </span>
          </div>
        </div>
      )}

      {/* Task list */}
      {!collapsed && (
        <div ref={listRef} className="flex-1 overflow-y-auto custom-scrollbar">
          <div className="p-1.5 space-y-0.5">
            {tasks.map(task => (
              <div key={task.id} data-in-progress={task.id === latestInProgressId ? 'true' : undefined}>
                <TaskItem task={task} isLatest={task.id === latestInProgressId} />
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Evaluation result */}
      {evaluationResult && !collapsed && (
        <div className="border-t border-gray-100 dark:border-gray-800 px-3 py-2.5">
          <div className="flex items-center gap-1.5 mb-2">
            <Eye size={12} className="text-amber-500" />
            <span className="text-[11px] font-semibold text-gray-600 dark:text-gray-300">质量评估</span>
            <span className={`text-xs font-bold ml-auto ${
              evaluationResult.overallScore >= 80 ? 'text-emerald-500' :
              evaluationResult.overallScore >= 60 ? 'text-amber-500' : 'text-red-500'
            }`}>
              {evaluationResult.overallScore}分
            </span>
          </div>
          <div className="space-y-1.5">
            <ScoreBar label="内容" score={evaluationResult.contentScore} color="bg-blue-400" />
            <ScoreBar label="设计" score={evaluationResult.designScore} color="bg-pink-400" />
            <ScoreBar label="连贯" score={evaluationResult.coherenceScore} color="bg-purple-400" />
          </div>
          {evaluationResult.repairRounds > 0 && (
            <p className="text-[10px] text-gray-400 mt-1.5">
              经过 {evaluationResult.repairRounds} 轮修复优化
            </p>
          )}
        </div>
      )}
    </div>
  );
};

export default AgentTaskPanel;
