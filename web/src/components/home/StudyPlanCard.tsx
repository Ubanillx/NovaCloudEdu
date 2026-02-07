import React, { useState, useEffect, useCallback } from 'react';
import { Plus, Check, Trash2, ClipboardList, AlertTriangle, AlertCircle } from 'lucide-react';

interface StudyPlan {
  id: string;
  title: string;
  priority: number; // 0: 普通, 1: 重要, 2: 紧急
  isCompleted: boolean;
  createdAt: string;
}

const STORAGE_KEY = 'nova_study_plans';

function getTodayKey(): string {
  return new Date().toISOString().split('T')[0];
}

function loadPlans(): StudyPlan[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return [];
    const all: StudyPlan[] = JSON.parse(raw);
    const today = getTodayKey();
    return all.filter((p) => p.createdAt === today);
  } catch {
    return [];
  }
}

function savePlans(plans: StudyPlan[]) {
  try {
    // 保留其他日期的计划 + 今日计划
    const raw = localStorage.getItem(STORAGE_KEY);
    const all: StudyPlan[] = raw ? JSON.parse(raw) : [];
    const today = getTodayKey();
    const otherDays = all.filter((p) => p.createdAt !== today);
    localStorage.setItem(STORAGE_KEY, JSON.stringify([...otherDays, ...plans]));
  } catch { /* ignore */ }
}

const PRIORITY_CONFIG = [
  { label: '普通', color: 'bg-blue-500', textColor: 'text-blue-600 dark:text-blue-400', bgColor: 'bg-blue-50 dark:bg-blue-900/20' },
  { label: '重要', color: 'bg-amber-500', textColor: 'text-amber-600 dark:text-amber-400', bgColor: 'bg-amber-50 dark:bg-amber-900/20', icon: AlertCircle },
  { label: '紧急', color: 'bg-red-500', textColor: 'text-red-600 dark:text-red-400', bgColor: 'bg-red-50 dark:bg-red-900/20', icon: AlertTriangle },
];

export const StudyPlanCard: React.FC = () => {
  const [plans, setPlans] = useState<StudyPlan[]>([]);
  const [showAdd, setShowAdd] = useState(false);
  const [newTitle, setNewTitle] = useState('');
  const [newPriority, setNewPriority] = useState(0);

  useEffect(() => {
    setPlans(loadPlans());
  }, []);

  const persist = useCallback((updated: StudyPlan[]) => {
    setPlans(updated);
    savePlans(updated);
  }, []);

  const addPlan = () => {
    const title = newTitle.trim();
    if (!title) return;
    const plan: StudyPlan = {
      id: Date.now().toString(),
      title,
      priority: newPriority,
      isCompleted: false,
      createdAt: getTodayKey(),
    };
    persist([...plans, plan]);
    setNewTitle('');
    setNewPriority(0);
    setShowAdd(false);
  };

  const toggleComplete = (id: string) => {
    persist(plans.map((p) => p.id === id ? { ...p, isCompleted: !p.isCompleted } : p));
  };

  const deletePlan = (id: string) => {
    persist(plans.filter((p) => p.id !== id));
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter') {
      e.preventDefault();
      addPlan();
    }
    if (e.key === 'Escape') {
      setShowAdd(false);
      setNewTitle('');
    }
  };

  const completedCount = plans.filter((p) => p.isCompleted).length;
  const progress = plans.length === 0 ? 0 : completedCount / plans.length;

  return (
    <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm overflow-hidden">
      {/* Header */}
      <div className="px-5 pt-5 pb-3 flex items-center justify-between">
        <h3 className="font-bold text-base flex items-center gap-2 text-gray-900 dark:text-white">
          <span className="w-1 h-5 bg-brand-600 rounded-full" />
          今日计划
        </h3>
        <div className="flex items-center gap-2">
          {plans.length > 0 && (
            <span className="text-xs font-bold text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 px-2 py-0.5 rounded-full">
              {Math.round(progress * 100)}%
            </span>
          )}
        </div>
      </div>

      {/* 进度条 */}
      {plans.length > 0 && (
        <div className="mx-5 mb-3">
          <div className="h-1.5 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
            <div
              className="h-full bg-gradient-to-r from-brand-500 to-accent-500 rounded-full transition-all duration-500"
              style={{ width: `${progress * 100}%` }}
            />
          </div>
        </div>
      )}

      {/* 计划列表 */}
      <div className="px-5 pb-2">
        {plans.length === 0 && !showAdd ? (
          <div className="text-center py-6">
            <ClipboardList size={32} className="text-gray-300 dark:text-gray-700 mx-auto mb-2" />
            <p className="text-xs text-gray-400 dark:text-gray-500">今天还没有学习计划</p>
          </div>
        ) : (
          <div className="space-y-2">
            {plans.map((plan) => {
              const pConfig = PRIORITY_CONFIG[plan.priority];
              return (
                <div
                  key={plan.id}
                  className={`flex items-center gap-2.5 p-2.5 rounded-xl transition-colors group ${
                    plan.isCompleted
                      ? 'bg-gray-50 dark:bg-gray-800/50'
                      : 'bg-white dark:bg-gray-900 border border-gray-100 dark:border-gray-800'
                  }`}
                >
                  {/* 完成按钮 */}
                  <button
                    onClick={() => toggleComplete(plan.id)}
                    className={`w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0 transition-colors ${
                      plan.isCompleted
                        ? 'bg-green-500 border-green-500'
                        : 'border-gray-300 dark:border-gray-600 hover:border-green-400'
                    }`}
                  >
                    {plan.isCompleted && <Check size={12} className="text-white" />}
                  </button>

                  {/* 优先级指示条 */}
                  {plan.priority > 0 && (
                    <div className={`w-0.5 h-5 rounded-full flex-shrink-0 ${pConfig.color}`} />
                  )}

                  {/* 标题 */}
                  <span className={`flex-1 text-sm truncate ${
                    plan.isCompleted
                      ? 'text-gray-400 dark:text-gray-500 line-through'
                      : 'text-gray-700 dark:text-gray-300'
                  }`}>
                    {plan.title}
                  </span>

                  {/* 优先级标签 */}
                  {plan.priority > 0 && !plan.isCompleted && (
                    <span className={`text-[10px] font-bold px-1.5 py-0.5 rounded ${pConfig.bgColor} ${pConfig.textColor} whitespace-nowrap`}>
                      {pConfig.label}
                    </span>
                  )}

                  {/* 删除按钮 */}
                  <button
                    onClick={() => deletePlan(plan.id)}
                    className="p-1 text-gray-300 dark:text-gray-600 hover:text-red-500 dark:hover:text-red-400 opacity-0 group-hover:opacity-100 transition-all flex-shrink-0"
                  >
                    <Trash2 size={13} />
                  </button>
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* 添加计划区域 */}
      {showAdd ? (
        <div className="px-5 pb-4 pt-2 space-y-2.5">
          <input
            autoFocus
            value={newTitle}
            onChange={(e) => setNewTitle(e.target.value)}
            onKeyDown={handleKeyDown}
            placeholder="输入学习计划..."
            className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg outline-none focus:border-brand-500 dark:focus:border-brand-500 text-gray-900 dark:text-white placeholder-gray-400 transition-colors"
          />
          <div className="flex items-center justify-between">
            <div className="flex gap-1.5">
              {PRIORITY_CONFIG.map((p, i) => (
                <button
                  key={i}
                  onClick={() => setNewPriority(i)}
                  className={`text-[10px] font-bold px-2 py-1 rounded-lg transition-colors ${
                    newPriority === i
                      ? `${p.bgColor} ${p.textColor} ring-1 ring-current`
                      : 'text-gray-400 dark:text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-800'
                  }`}
                >
                  {p.label}
                </button>
              ))}
            </div>
            <div className="flex gap-2">
              <button
                onClick={() => { setShowAdd(false); setNewTitle(''); }}
                className="text-xs text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 px-2 py-1"
              >
                取消
              </button>
              <button
                onClick={addPlan}
                disabled={!newTitle.trim()}
                className="text-xs font-bold text-white bg-brand-600 hover:bg-brand-700 px-3 py-1 rounded-lg disabled:opacity-50 transition-colors"
              >
                添加
              </button>
            </div>
          </div>
        </div>
      ) : (
        <div className="px-5 pb-4 pt-1">
          <button
            onClick={() => setShowAdd(true)}
            className="w-full py-2.5 rounded-xl border border-dashed border-gray-200 dark:border-gray-700 text-gray-400 dark:text-gray-500 hover:border-brand-300 hover:text-brand-500 dark:hover:border-brand-700 dark:hover:text-brand-400 text-sm flex items-center justify-center gap-1.5 transition-colors"
          >
            <Plus size={14} />
            添加学习计划
          </button>
        </div>
      )}
    </div>
  );
};
