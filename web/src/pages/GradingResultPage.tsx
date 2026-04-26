import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { ArrowLeft, CheckCircle, XCircle, AlertTriangle, BookOpen, Brain, Loader2, RefreshCw, Lightbulb, ChevronDown } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { GradingResultResponse, QuestionGradingItem } from '../api/generated/models';
import toast from '../components/ui/Toast';
import { getQuestionTypeName } from '../constants/exam';
import GradingMarkdown from '../components/grading/GradingMarkdown';

const api = new DefaultApi(new Configuration(), '', apiClient);

const ERROR_CATEGORY_NAMES: Record<string, string> = {
  CONCEPT_ERROR: '概念错误',
  CALCULATION_ERROR: '计算错误',
  READING_ERROR: '审题错误',
  UNIT_ERROR: '单位错误',
  STEP_MISSING: '步骤缺失',
  LOGIC_INCOMPLETE: '逻辑不完整',
  EXPRESSION_UNCLEAR: '表达不清',
  GRAMMAR_ERROR: '语法错误',
  SPELLING_ERROR: '拼写错误',
  FORMAT_ERROR: '格式错误',
  KNOWLEDGE_GAP: '知识盲区',
  CARELESS_MISTAKE: '粗心大意',
};

const GradingResultPage: React.FC = () => {
  const { submissionId } = useParams<{ submissionId: string }>();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [result, setResult] = useState<GradingResultResponse | null>(null);

  useEffect(() => {
    if (!submissionId) return;
    loadResult();
  }, [submissionId]);

  const loadResult = async () => {
    setLoading(true);
    try {
      const res = await api.getResult({ submissionId: submissionId as unknown as number });
      if (res.data?.code === 0 && res.data?.data) {
        setResult(res.data.data);
      } else {
        toast.error(res.data?.message || '获取批改结果失败');
      }
    } catch {
      toast.error('获取批改结果失败');
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

  if (!result) {
    return (
      <div className="max-w-4xl mx-auto space-y-6">
        <div className="flex items-center gap-3">
          <button onClick={() => navigate(-1)} className="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <ArrowLeft size={20} className="text-gray-500" />
          </button>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">批改结果</h1>
        </div>
        <div className="text-center py-20 text-gray-400">
          <BookOpen size={48} className="mx-auto mb-4 opacity-50" />
          <p>暂无批改结果</p>
          <button onClick={() => navigate('/grading')}
            className="mt-4 px-6 py-2 bg-brand-600 text-white rounded-xl text-sm font-semibold hover:bg-brand-700 transition-all">
            去批改作业
          </button>
        </div>
      </div>
    );
  }

  const totalScore = result.totalScore ?? 0;
  const maxScore = result.maxScore ?? 0;
  const scoreRate = maxScore > 0 ? totalScore / maxScore : 0;
  const questions = result.questions ?? [];
  const correctCount = questions.filter(q => (q.score ?? 0) >= (q.maxScore ?? 1)).length;
  const wrongCount = questions.length - correctCount;

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      {/* 页头 */}
      <div className="flex items-center gap-4">
        <button onClick={() => navigate(-1)} className="p-2.5 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-800 transition-all active:scale-95 group">
          <ArrowLeft size={20} className="text-gray-500 group-hover:text-brand-500 transition-colors" />
        </button>
        <div className="flex-1">
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white tracking-tight">批改详情报告</h1>
          <p className="text-sm text-gray-500 dark:text-gray-400">
            {result.gradingTime ? new Date(result.gradingTime).toLocaleString('zh-CN', {
              year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit'
            }) : ''}
          </p>
        </div>
        <button onClick={() => navigate('/grading')}
          className="flex items-center gap-2 px-5 py-2.5 bg-brand-600 hover:bg-brand-700 text-white rounded-xl text-sm font-bold transition-all shadow-lg shadow-brand-600/20 active:scale-[0.98]">
          <RefreshCw size={16} /> 再测一次
        </button>
      </div>

      {/* 得分概览卡片 */}
      <div className="bg-white dark:bg-gray-900 rounded-3xl border border-gray-100 dark:border-gray-800 p-8 shadow-sm relative overflow-hidden">
        {/* 装饰背景 */}
        <div className="absolute top-0 right-0 w-32 h-32 bg-brand-500/5 rounded-full -mr-16 -mt-16 blur-3xl" />
        
        <div className="flex flex-col md:flex-row items-center gap-8 relative z-10">
          {/* 分数环 */}
          <div className="relative w-36 h-36 flex-shrink-0">
            <svg viewBox="0 0 100 100" className="w-full h-full -rotate-90">
              <circle cx="50" cy="50" r="44" fill="none" stroke="currentColor"
                className="text-gray-100 dark:text-gray-800" strokeWidth="8" />
              <circle cx="50" cy="50" r="44" fill="none"
                className={scoreRate >= 0.8 ? 'text-green-500' : scoreRate >= 0.6 ? 'text-yellow-500' : 'text-red-500'}
                stroke="currentColor" strokeWidth="8" strokeLinecap="round"
                strokeDasharray={`${scoreRate * 276.5} 276.5`}
                style={{ transition: 'stroke-dasharray 1s ease-out' }} />
            </svg>
            <div className="absolute inset-0 flex flex-col items-center justify-center">
              <span className={`text-4xl font-black tabular-nums ${scoreRate >= 0.8 ? 'text-green-600 dark:text-green-400' : scoreRate >= 0.6 ? 'text-yellow-600 dark:text-yellow-400' : 'text-red-600 dark:text-red-400'}`}>
                {totalScore}
              </span>
              <div className="flex items-center gap-1 mt-0.5">
                <span className="text-[10px] font-bold text-gray-400 uppercase tracking-widest">Score /</span>
                <span className="text-xs font-bold text-gray-400">{maxScore}</span>
              </div>
            </div>
          </div>

          {/* 统计详情 */}
          <div className="flex-1 space-y-6">
            <div>
              <div className="flex items-end justify-between mb-2">
                <h3 className="text-lg font-bold text-gray-900 dark:text-white">整体表现评价</h3>
                <span className={`text-sm font-black ${scoreRate >= 0.8 ? 'text-green-500' : scoreRate >= 0.6 ? 'text-yellow-500' : 'text-red-500'}`}>
                  {(scoreRate * 100).toFixed(0)}% 正确率
                </span>
              </div>
              <div className="flex flex-wrap gap-3">
                <StatBadge icon={<CheckCircle size={14} />} label="正确" value={correctCount} color="green" />
                <StatBadge icon={<XCircle size={14} />} label="需改进" value={wrongCount} color="red" />
                <StatBadge icon={<BookOpen size={14} />} label="题目总数" value={questions.length} color="gray" />
              </div>
            </div>

            {result.overallComment && (
              <div className="p-4 rounded-2xl bg-brand-50/50 dark:bg-brand-900/10 border border-brand-100/50 dark:border-brand-800/30">
                <div className="flex items-start gap-3">
                  <div className="p-1.5 rounded-lg bg-brand-500/10 text-brand-500 flex-shrink-0">
                    <Lightbulb size={18} />
                  </div>
                  <GradingMarkdown
                    content={result.overallComment}
                    className="text-sm text-gray-700 dark:text-gray-300 leading-relaxed font-medium"
                  />
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* 逐题详情 */}
      <div className="space-y-4">
        <div className="flex items-center justify-between px-1">
          <div className="flex items-center gap-2">
            <div className="w-1.5 h-4 bg-brand-500 rounded-full" />
            <h2 className="text-base font-bold text-gray-900 dark:text-white">详细批改解析</h2>
          </div>
          <span className="text-xs text-gray-400 font-medium">点击展开查看详细解析</span>
        </div>
        <div className="grid grid-cols-1 gap-4">
          {questions.map((q, idx) => (
            <QuestionCard key={idx} question={q} />
          ))}
        </div>
      </div>
    </div>
  );
};

// ==================== 子组件 ====================

const StatBadge: React.FC<{ icon: React.ReactNode; label: string; value: number; color: string }> = ({ icon, label, value, color }) => {
  const colorClasses: Record<string, string> = {
    green: 'text-green-600 dark:text-green-400 bg-green-50 dark:bg-green-900/20 border-green-100 dark:border-green-800/30',
    red: 'text-red-600 dark:text-red-400 bg-red-50 dark:bg-red-900/20 border-red-100 dark:border-red-800/30',
    gray: 'text-gray-600 dark:text-gray-400 bg-gray-50 dark:bg-gray-800/50 border-gray-100 dark:border-gray-700/30',
  };
  return (
    <div className={`flex items-center gap-2 px-3.5 py-2 rounded-xl text-sm font-bold border transition-all hover:scale-105 ${colorClasses[color] || colorClasses.gray}`}>
      <span className="opacity-80">{icon}</span>
      <span className="opacity-70 font-medium">{label}</span>
      <span className="ml-1 tabular-nums">{value}</span>
    </div>
  );
};

const QuestionCard: React.FC<{ question: QuestionGradingItem }> = ({ question }) => {
  const [expanded, setExpanded] = useState(false);
  const score = question.score ?? 0;
  const maxScore = question.maxScore ?? 0;
  const isCorrect = score >= maxScore;
  const isPartial = score > 0 && score < maxScore;

  return (
    <div className={`bg-white dark:bg-gray-900 rounded-2xl border transition-all duration-300 overflow-hidden ${
      expanded ? 'shadow-lg ring-1 ring-brand-500/10' : 'hover:shadow-sm'
    } ${
      isCorrect ? 'border-green-100 dark:border-green-900/30' :
      isPartial ? 'border-yellow-100 dark:border-yellow-900/30' :
      'border-red-100 dark:border-red-900/30'
    }`}>
      {/* 题目头 */}
      <button onClick={() => setExpanded(!expanded)}
        className="w-full flex items-center gap-4 px-5 py-4 text-left group">
        {/* 状态图标 */}
        <div className={`flex-shrink-0 w-10 h-10 rounded-full flex items-center justify-center transition-transform group-hover:scale-110 ${
          isCorrect ? 'bg-green-50 dark:bg-green-900/20 text-green-500' : 
          isPartial ? 'bg-yellow-50 dark:bg-yellow-900/20 text-yellow-500' : 
          'bg-red-50 dark:bg-red-900/20 text-red-500'
        }`}>
          {isCorrect ? <CheckCircle size={22} /> : isPartial ? <AlertTriangle size={22} /> : <XCircle size={22} />}
        </div>

        {/* 题号+题型 */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2.5">
            <span className="text-base font-bold text-gray-900 dark:text-white">
              第 {question.questionIndex} 题
            </span>
            {question.questionType && (
              <span className="text-[10px] font-black px-2 py-0.5 bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400 rounded-md uppercase tracking-wider">
                {getQuestionTypeName(question.questionType)}
              </span>
            )}
          </div>
          {question.comment && !expanded && (
            <GradingMarkdown
              content={question.comment}
              className="text-sm text-gray-500 dark:text-gray-400 mt-1 max-w-md line-clamp-1 [&_p]:truncate"
            />
          )}
        </div>

        {/* 得分 */}
        <div className="flex items-center gap-4">
          <div className={`text-lg font-black tabular-nums ${
            isCorrect ? 'text-green-600 dark:text-green-400' :
            isPartial ? 'text-yellow-600 dark:text-yellow-400' :
            'text-red-600 dark:text-red-400'
          }`}>
            {score}<span className="text-xs font-normal text-gray-400 ml-1">/ {maxScore}</span>
          </div>
          <ChevronDown size={18} className={`text-gray-300 transition-transform duration-300 ${expanded ? 'rotate-180 text-brand-500' : ''}`} />
        </div>
      </button>

      {/* 展开详情 */}
      {expanded && (
        <div className="px-5 pb-6 space-y-5 animate-in slide-in-from-top-2 duration-300">
          <div className="h-px bg-gray-100 dark:bg-gray-800 w-full" />
          
          {/* 题干 */}
          {question.questionContent && (
            <div className="space-y-2">
              <div className="flex items-center gap-1.5 text-xs font-bold text-gray-400 dark:text-gray-500 uppercase tracking-widest">
                <BookOpen size={12} /> 题目内容
              </div>
              <GradingMarkdown
                content={question.questionContent}
                className="text-sm text-gray-700 dark:text-gray-300 bg-gray-50 dark:bg-gray-800/50 rounded-2xl px-4 py-3 leading-relaxed border border-gray-100 dark:border-gray-800/50"
              />
            </div>
          )}

          {/* 学生答案 vs 标准答案 */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {question.studentAnswer && (
              <div className="space-y-2">
                <div className="flex items-center gap-1.5 text-xs font-bold text-gray-400 dark:text-gray-500 uppercase tracking-widest">
                  你的作答
                </div>
                <GradingMarkdown content={question.studentAnswer} className={`text-sm rounded-2xl px-4 py-3 min-h-[60px] leading-relaxed border ${
                  isCorrect ? 'bg-green-50/30 dark:bg-green-900/5 border-green-100/50 dark:border-green-800/20 text-gray-700 dark:text-gray-300' :
                  isPartial ? 'bg-yellow-50/30 dark:bg-yellow-900/5 border-yellow-100/50 dark:border-yellow-800/20 text-gray-700 dark:text-gray-300' :
                  'bg-red-50/30 dark:bg-red-900/5 border-red-100/50 dark:border-red-800/20 text-gray-700 dark:text-gray-300'
                }`} />
              </div>
            )}
            {question.standardAnswer && (
              <div className="space-y-2">
                <div className="flex items-center gap-1.5 text-xs font-bold text-green-500 uppercase tracking-widest">
                  参考答案
                </div>
                <GradingMarkdown
                  content={question.standardAnswer}
                  className="text-sm text-green-700 dark:text-green-300 bg-green-50/50 dark:bg-green-900/10 border border-green-100 dark:border-green-800/30 rounded-2xl px-4 py-3 min-h-[60px] leading-relaxed font-medium"
                />
              </div>
            )}
          </div>

          {/* 知识点 & 错因 */}
          <div className="flex flex-wrap gap-4">
            {question.errorCategories && question.errorCategories.length > 0 && (
              <div className="flex-1 min-w-[200px] space-y-2">
                <div className="text-xs font-bold text-red-400 uppercase tracking-widest">错误分类</div>
                <div className="flex gap-2 flex-wrap">
                  {question.errorCategories.map(cat => (
                    <span key={cat} className="text-[11px] px-2.5 py-1 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-lg font-bold border border-red-100 dark:border-red-800/30">
                      {ERROR_CATEGORY_NAMES[cat] || cat}
                    </span>
                  ))}
                </div>
              </div>
            )}
            {question.knowledgePoints && question.knowledgePoints.length > 0 && (
              <div className="flex-1 min-w-[200px] space-y-2">
                <div className="text-xs font-bold text-brand-400 uppercase tracking-widest">考察知识点</div>
                <div className="flex gap-2 flex-wrap">
                  {question.knowledgePoints.map(kp => (
                    <div key={kp} className="text-[11px] px-2.5 py-1 bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 rounded-lg font-bold border border-brand-100 dark:border-brand-800/30">
                      <GradingMarkdown content={kp} />
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* 评语 */}
          {question.comment && (
            <div className="p-4 rounded-2xl bg-blue-50/50 dark:bg-blue-900/10 border border-blue-100/50 dark:border-blue-800/30 flex items-start gap-3">
              <div className="p-1.5 rounded-xl bg-blue-500 text-white shadow-sm flex-shrink-0 mt-0.5">
                <Brain size={16} />
              </div>
              <div className="space-y-1">
                <div className="text-xs font-bold text-blue-600 dark:text-blue-400 uppercase tracking-widest">AI 深度解析</div>
                <GradingMarkdown
                  content={question.comment}
                  className="text-sm text-gray-700 dark:text-gray-300 leading-relaxed font-medium"
                />
                {question.errorDetail && (
                  <GradingMarkdown
                    content={question.errorDetail}
                    className="text-xs text-gray-500 dark:text-gray-400 mt-2 pl-2 border-l-2 border-blue-200 dark:border-blue-800"
                  />
                )}
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default GradingResultPage;
