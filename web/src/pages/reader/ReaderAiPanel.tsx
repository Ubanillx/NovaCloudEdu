import React from 'react';
import MarkdownRenderer from '../../components/chat/MarkdownRenderer';
import {
  X, Sparkles, BookMarked, Brain, MessageSquare, GraduationCap,
  Lightbulb, RefreshCw, Send, Check, Loader2,
} from 'lucide-react';
import type { ChapterSummary, KnowledgePoint, ConversationMessage, ReadingQuiz, QuizQuestion } from '../../api/generated/models';
import type { ThemeVars, AiTab } from './readerConstants';
import { KP_COLORS, KP_LABELS, floatingPanelStyle, stickyHeaderStyle } from './readerConstants';

interface ReaderAiPanelProps {
  themeVars: ThemeVars;
  onClose: () => void;
  // tab
  aiTab: AiTab;
  setAiTab: (tab: AiTab) => void;
  // summary
  summary: ChapterSummary | null;
  summaryType: string;
  setSummaryType: (t: string) => void;
  setSummary: (s: ChapterSummary | null) => void;
  summaryLoading: boolean;
  onGetSummary: () => void;
  onGenerateSummary: () => void;
  // knowledge
  knowledgePoints: KnowledgePoint[];
  kpLoading: boolean;
  onGetKP: () => void;
  onExtractKP: () => void;
  setKnowledgePoints: (kps: KnowledgePoint[]) => void;
  // chat
  chatMessages: ConversationMessage[];
  chatInput: string;
  setChatInput: (v: string) => void;
  chatLoading: boolean;
  onSendChat: () => void;
  chatEndRef: React.RefObject<HTMLDivElement | null>;
  // quiz
  quiz: ReadingQuiz | null;
  quizLoading: boolean;
  quizScore: number | null;
  quizSubmitting: boolean;
  userAnswers: string[];
  setUserAnswers: (a: string[]) => void;
  onGenerateQuiz: () => void;
  onSubmitQuiz: () => void;
  setQuiz: (q: ReadingQuiz | null) => void;
  setQuizScore: (s: number | null) => void;
}

const ReaderAiPanel: React.FC<ReaderAiPanelProps> = (props) => {
  const { themeVars, onClose, aiTab, setAiTab } = props;

  return (
    <div
      className="absolute top-6 right-6 bottom-6 w-[400px] z-30 shadow-[0_20px_50px_rgba(0,0,0,0.15)] animate-in fade-in duration-200 rounded-[28px] border flex flex-col overflow-hidden ring-1 ring-black/5 dark:ring-white/10"
      style={floatingPanelStyle(themeVars.bg, themeVars.border)}
    >
      {/* AI Tab 头 */}
      <div className="flex flex-col sticky top-0 z-20 transition-all duration-200" style={stickyHeaderStyle(themeVars.bg)}>
        <div className="flex items-center justify-between px-6 py-4">
          <h3 className="text-sm font-bold flex items-center gap-2.5 opacity-90">
            <div className="p-1.5 rounded-lg bg-brand-500/10 text-brand-600 dark:text-brand-400">
              <Sparkles size={16} />
            </div>
            AI 智能助手
          </h3>
          <button onClick={onClose} className="p-1.5 rounded-lg hover:bg-black/5 dark:hover:bg-white/10 transition-colors text-gray-400 hover:text-gray-600 dark:hover:text-gray-200">
            <X size={18} />
          </button>
        </div>
        <div className="px-6 pb-4">
          <div className="flex items-center p-1 rounded-xl bg-black/[0.03] dark:bg-white/[0.03] border border-black/5 dark:border-white/5">
            {([
              { key: 'summary' as AiTab, icon: BookMarked, label: '总结' },
              { key: 'knowledge' as AiTab, icon: Lightbulb, label: '知识点' },
              { key: 'chat' as AiTab, icon: MessageSquare, label: '问答' },
              { key: 'quiz' as AiTab, icon: GraduationCap, label: '测试' },
            ]).map(({ key, icon: Icon, label }) => (
              <button
                key={key}
                onClick={() => setAiTab(key)}
                className="flex-1 flex items-center justify-center gap-1.5 py-2 rounded-lg text-[11px] font-bold transition-all"
                style={{
                  background: aiTab === key ? themeVars.bg : 'transparent',
                  color: aiTab === key ? themeVars.accent : themeVars.muted,
                  boxShadow: aiTab === key ? '0 2px 8px rgba(0,0,0,0.08)' : 'none',
                }}
              >
                <Icon size={13} />
                {label}
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* AI Tab 内容 */}
      <div className="flex-1 overflow-y-auto custom-scrollbar p-6">
        {aiTab === 'summary' && <SummaryTab {...props} />}
        {aiTab === 'knowledge' && <KnowledgeTab {...props} />}
        {aiTab === 'chat' && <ChatTab {...props} />}
        {aiTab === 'quiz' && <QuizTab {...props} />}
      </div>
    </div>
  );
};

// ━━━━━━━━━━ Tab: 总结 ━━━━━━━━━━

const SummaryTab: React.FC<ReaderAiPanelProps> = ({
  themeVars, summary, summaryType, setSummaryType, setSummary, summaryLoading, onGetSummary, onGenerateSummary,
}) => (
  <div className="space-y-8">
    <div className="flex items-center gap-2 p-1 rounded-xl bg-black/5 dark:bg-white/5">
      {(['BRIEF', 'DETAILED', 'KEYPOINTS'] as string[]).map(t => (
        <button
          key={t}
          onClick={() => { setSummaryType(t); setSummary(null); }}
          className="flex-1 py-2 rounded-lg text-[10px] font-bold transition-all"
          style={{
            background: summaryType === t ? themeVars.bg : 'transparent',
            boxShadow: summaryType === t ? '0 1px 3px rgba(0,0,0,0.1)' : 'none',
            color: summaryType === t ? themeVars.accent : themeVars.muted,
          }}
        >
          {t === 'BRIEF' ? '简要' : t === 'DETAILED' ? '详细' : '要点'}
        </button>
      ))}
    </div>
    {!summary && !summaryLoading && (
      <button
        onClick={onGetSummary}
        className="w-full flex items-center justify-center gap-3 px-6 py-4 rounded-2xl text-white text-sm font-black transition-all hover:scale-[1.02] shadow-lg shadow-brand-500/20"
        style={{ background: themeVars.accent }}
      >
        <Brain size={18} />
        生成本章总结
      </button>
    )}
    {summaryLoading && (
      <div className="flex flex-col items-center justify-center py-12 gap-4">
        <div className="w-12 h-12 rounded-2xl bg-brand-500/10 flex items-center justify-center">
          <Loader2 size={24} className="animate-spin text-brand-500" />
        </div>
        <span className="text-sm font-bold animate-pulse" style={{ color: themeVars.muted }}>AI 正在深度研读本章内容...</span>
      </div>
    )}
    {summary && (
      <div className="space-y-6 animate-in fade-in duration-300">
        <MarkdownRenderer
          content={summary.content || ''}
          className="prose prose-sm max-w-none reader-ai-content"
        />
        {summary.keyPoints && summary.keyPoints.length > 0 && (
          <div className="space-y-3">
            <h4 className="text-[10px] font-black uppercase tracking-widest opacity-50">核心知识要点</h4>
            <div className="grid grid-cols-1 gap-2">
              {summary.keyPoints.map((kp, i) => (
                <div key={i} className="flex items-start gap-3 p-3 rounded-xl border-2 border-transparent transition-all hover:border-brand-500/20" style={{ background: themeVars.card }}>
                  <span className="mt-0.5 w-6 h-6 rounded-lg flex items-center justify-center text-xs font-black flex-shrink-0" style={{ background: `${themeVars.accent}20`, color: themeVars.accent }}>{i + 1}</span>
                  <span className="text-sm leading-relaxed">{kp}</span>
                </div>
              ))}
            </div>
          </div>
        )}
        <button
          onClick={() => { setSummary(null); onGenerateSummary(); }}
          disabled={summaryLoading}
          className="w-full flex items-center justify-center gap-2 py-3 rounded-xl text-xs font-black border-2 transition-all hover:scale-[1.02] disabled:opacity-50"
          style={{ borderColor: themeVars.border, color: themeVars.muted }}
        >
          <RefreshCw size={14} />
          重新生成深度总结
        </button>
      </div>
    )}
  </div>
);

// ━━━━━━━━━━ Tab: 知识点 ━━━━━━━━━━

const KnowledgeTab: React.FC<ReaderAiPanelProps> = ({
  themeVars, knowledgePoints, kpLoading, onGetKP, onExtractKP, setKnowledgePoints,
}) => (
  <div className="space-y-6">
    {knowledgePoints.length === 0 && !kpLoading && (
      <div className="flex flex-col items-center gap-6 py-8">
        <div className="w-20 h-20 rounded-3xl bg-amber-500/10 flex items-center justify-center text-amber-500">
          <Lightbulb size={40} />
        </div>
        <div className="text-center">
          <p className="text-sm font-black mb-1">提取知识精华</p>
          <p className="text-xs opacity-50">AI 将自动识别本章的概念、术语和公式</p>
        </div>
        <button
          onClick={onGetKP}
          className="w-full flex items-center justify-center gap-3 px-6 py-4 rounded-2xl text-white text-sm font-black transition-all hover:scale-[1.02] shadow-lg shadow-amber-500/20 bg-amber-500"
        >
          <Sparkles size={18} />
          开始提取知识点
        </button>
      </div>
    )}
    {kpLoading && (
      <div className="flex flex-col items-center justify-center py-12 gap-4">
        <div className="w-12 h-12 rounded-2xl bg-amber-500/10 flex items-center justify-center text-amber-500">
          <Loader2 size={24} className="animate-spin" />
        </div>
        <span className="text-sm font-bold animate-pulse text-amber-500">AI 正在捕捉知识点...</span>
      </div>
    )}
    {knowledgePoints.length > 0 && (
      <div className="space-y-4 animate-in fade-in duration-300">
        <div className="grid grid-cols-1 gap-3">
          {knowledgePoints.map((kp, i) => {
            const typeStr = kp.pointType || 'CONCEPT';
            return (
              <div key={i} className="rounded-2xl border p-5 transition-all hover:scale-[1.02] group" style={{ borderColor: themeVars.border, background: themeVars.card }}>
                <div className="flex items-center gap-2 mb-3">
                  <span className={`inline-flex items-center px-2 py-1 rounded-lg text-[10px] font-black uppercase tracking-widest border ${KP_COLORS[typeStr] || KP_COLORS.CONCEPT}`}>
                    {KP_LABELS[typeStr] || typeStr}
                  </span>
                  <span className="text-sm font-black">{kp.name}</span>
                </div>
                {kp.description && (
                  <p className="text-xs leading-relaxed opacity-80 group-hover:opacity-100 transition-opacity" style={{ color: themeVars.text }}>{kp.description}</p>
                )}
              </div>
            );
          })}
        </div>
        <button
          onClick={() => { setKnowledgePoints([]); onExtractKP(); }}
          disabled={kpLoading}
          className="w-full flex items-center justify-center gap-2 py-3 rounded-xl text-xs font-black border transition-all hover:scale-[1.02] disabled:opacity-50"
          style={{ borderColor: themeVars.border, color: themeVars.muted }}
        >
          <RefreshCw size={14} />
          重新深度扫描
        </button>
      </div>
    )}
  </div>
);

// ━━━━━━━━━━ Tab: 问答 ━━━━━━━━━━

const ChatTab: React.FC<ReaderAiPanelProps> = ({
  themeVars, chatMessages, chatInput, setChatInput, chatLoading, onSendChat, chatEndRef,
}) => (
  <div className="flex flex-col h-full -mx-6 -my-6 relative">
    <div className="flex-1 overflow-y-auto custom-scrollbar p-6 pb-24 space-y-4">
      {chatMessages.length === 0 && (
        <div className="flex flex-col items-center justify-center h-full text-center gap-4 opacity-40">
          <div className="w-16 h-16 rounded-full bg-brand-500/10 flex items-center justify-center">
            <MessageSquare size={32} />
          </div>
          <div className="space-y-1">
            <p className="text-sm font-black">AI 知识问答</p>
            <p className="text-xs">您可以询问关于本章节的任何问题</p>
          </div>
        </div>
      )}
      {chatMessages.map((msg, i) => (
        <div key={i} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'} animate-in fade-in duration-200`}>
          <div
            className={`max-w-[90%] rounded-[20px] px-4 py-3 text-[13px] leading-relaxed shadow-sm ${msg.role === 'user' ? 'rounded-tr-none' : 'rounded-tl-none border'}`}
            style={{
              background: msg.role === 'user' ? themeVars.accent : themeVars.card,
              color: msg.role === 'user' ? '#fff' : themeVars.text,
              borderColor: msg.role === 'user' ? 'transparent' : themeVars.border,
            }}
          >
            {msg.role === 'assistant' ? (
              <MarkdownRenderer
                content={msg.content || ''}
                className="prose prose-sm max-w-none reader-ai-chat"
              />
            ) : (
              <span className="font-medium">{msg.content}</span>
            )}
          </div>
        </div>
      ))}
      {chatLoading && (
        <div className="flex justify-start">
          <div className="rounded-2xl px-4 py-3 bg-black/5 dark:bg-white/5 border border-transparent">
            <div className="flex gap-1">
              <div className="w-1.5 h-1.5 rounded-full bg-brand-500 animate-bounce" />
              <div className="w-1.5 h-1.5 rounded-full bg-brand-500 animate-bounce [animation-delay:0.2s]" />
              <div className="w-1.5 h-1.5 rounded-full bg-brand-500 animate-bounce [animation-delay:0.4s]" />
            </div>
          </div>
        </div>
      )}
      <div ref={chatEndRef} />
    </div>

    <div className="absolute bottom-3 left-6 right-6 z-10">
      <div
        className="p-1 rounded-[20px] flex items-center gap-1 shadow-2xl border backdrop-blur-xl ring-1 ring-black/5 dark:ring-white/10 transition-all focus-within:ring-2 focus-within:ring-brand-500/20"
        style={{ background: `${themeVars.bg}ee`, borderColor: themeVars.border }}
      >
        <input
          type="text"
          value={chatInput}
          onChange={e => setChatInput(e.target.value)}
          onKeyDown={e => { if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); onSendChat(); } }}
          placeholder="有什么可以帮您？"
          className="w-full pl-4 pr-2 py-2.5 bg-transparent text-[13px] border-none outline-none"
          style={{ color: themeVars.text }}
        />
        <button
          onClick={onSendChat}
          disabled={!chatInput.trim() || chatLoading}
          className="w-9 h-9 flex items-center justify-center rounded-xl text-white transition-all hover:scale-[1.02] disabled:opacity-40 shadow-sm flex-shrink-0"
          style={{ background: themeVars.accent }}
        >
          <Send size={15} />
        </button>
      </div>
    </div>
  </div>
);

// ━━━━━━━━━━ Tab: 测试 ━━━━━━━━━━

const QuizTab: React.FC<ReaderAiPanelProps> = ({
  themeVars, quiz, quizLoading, quizScore, quizSubmitting, userAnswers, setUserAnswers,
  onGenerateQuiz, onSubmitQuiz, setQuiz, setQuizScore,
}) => (
  <div className="space-y-6">
    {!quiz && !quizLoading && (
      <div className="flex flex-col items-center gap-6 py-8">
        <div className="w-20 h-20 rounded-3xl bg-emerald-500/10 flex items-center justify-center text-emerald-500">
          <GraduationCap size={40} />
        </div>
        <div className="text-center">
          <p className="text-sm font-black mb-1">检验学习成果</p>
          <p className="text-xs opacity-50">AI 将根据本章内容生成 5 道测试题</p>
        </div>
        <button
          onClick={onGenerateQuiz}
          className="w-full flex items-center justify-center gap-3 px-6 py-4 rounded-2xl text-white text-sm font-black transition-all hover:scale-[1.02] shadow-lg shadow-emerald-500/20 bg-emerald-500"
        >
          <Sparkles size={18} />
          开始智能出题
        </button>
      </div>
    )}
    {quizLoading && (
      <div className="flex flex-col items-center justify-center py-12 gap-4">
        <div className="w-12 h-12 rounded-2xl bg-emerald-500/10 flex items-center justify-center text-emerald-500">
          <Loader2 size={24} className="animate-spin" />
        </div>
        <span className="text-sm font-bold animate-pulse text-emerald-500">AI 正在精心设计题目...</span>
      </div>
    )}
    {quiz && quiz.questions && (
      <div className="space-y-6 animate-in fade-in duration-300">
        {quizScore !== null && (
          <div className="rounded-3xl border p-8 text-center relative overflow-hidden shadow-sm" style={{ borderColor: themeVars.accent, background: `${themeVars.accent}05` }}>
            <div className="relative z-10">
              <p className="text-5xl font-black mb-2 tracking-tight" style={{ color: themeVars.accent }}>{quizScore}</p>
              <p className="text-xs font-bold uppercase tracking-widest opacity-60">本次测试得分</p>
            </div>
            <div className="absolute -top-4 -right-4 opacity-10 rotate-12">
              <GraduationCap size={120} />
            </div>
          </div>
        )}
        <div className="space-y-4">
          {quiz.questions.map((q: QuizQuestion, qi: number) => (
            <QuizQuestionCard
              key={qi}
              q={q}
              qi={qi}
              themeVars={themeVars}
              userAnswers={userAnswers}
              setUserAnswers={setUserAnswers}
              quizScore={quizScore}
            />
          ))}
        </div>

        <div
          className="sticky bottom-0 -mx-6 -mb-6 p-6 transition-all duration-200 z-10"
          style={{
            background: `linear-gradient(to top, ${themeVars.bg}ee 0%, ${themeVars.bg}cc 80%, transparent 100%)`,
            backdropFilter: 'blur(10px)',
          }}
        >
          {quizScore === null ? (
            <button
              onClick={onSubmitQuiz}
              disabled={quizSubmitting || userAnswers.some(a => !a)}
              className="w-full flex items-center justify-center gap-3 px-6 py-4 rounded-2xl text-white text-sm font-black transition-all hover:scale-[1.02] disabled:opacity-40 shadow-xl shadow-brand-500/20"
              style={{ background: themeVars.accent }}
            >
              {quizSubmitting ? <Loader2 size={20} className="animate-spin" /> : <Check size={20} />}
              {quizSubmitting ? '正在阅卷...' : '提交测试答案'}
            </button>
          ) : (
            <button
              onClick={() => { setQuiz(null); setQuizScore(null); setUserAnswers([]); onGenerateQuiz(); }}
              className="w-full flex items-center justify-center gap-3 px-6 py-4 rounded-2xl text-white text-sm font-black transition-all hover:scale-[1.02] shadow-xl shadow-emerald-500/20 bg-emerald-500"
            >
              <RefreshCw size={20} />
              再战一组题目
            </button>
          )}
        </div>
      </div>
    )}
  </div>
);

// ━━━━━━━━━━ 单题卡片 ━━━━━━━━━━

interface QuizQuestionCardProps {
  q: QuizQuestion;
  qi: number;
  themeVars: ThemeVars;
  userAnswers: string[];
  setUserAnswers: (a: string[]) => void;
  quizScore: number | null;
}

const QuizQuestionCard: React.FC<QuizQuestionCardProps> = ({ q, qi, themeVars, userAnswers, setUserAnswers, quizScore }) => {
  const showResult = quizScore !== null;

  const getOptionStyle = (selected: boolean, isCorrect: boolean) => {
    const base = { borderColor: themeVars.border, background: 'transparent', color: themeVars.text };
    if (showResult) {
      if (isCorrect) return { borderColor: '#10b981', background: '#10b98115', color: '#10b981' };
      if (selected) return { borderColor: '#ef4444', background: '#ef444415', color: '#ef4444' };
    } else if (selected) {
      return { borderColor: themeVars.accent, background: `${themeVars.accent}10`, color: themeVars.accent };
    }
    return base;
  };

  const selectAnswer = (val: string) => {
    if (quizScore !== null) return;
    const newAnswers = [...userAnswers];
    newAnswers[qi] = val;
    setUserAnswers(newAnswers);
  };

  return (
    <div className="rounded-2xl border p-6 space-y-5 transition-all hover:shadow-sm" style={{ borderColor: themeVars.border, background: themeVars.card }}>
      <div className="flex items-start gap-4">
        <span className="flex-shrink-0 w-8 h-8 rounded-lg bg-black/5 dark:bg-white/5 flex items-center justify-center text-xs font-black" style={{ color: themeVars.accent }}>
          {String(qi + 1).padStart(2, '0')}
        </span>
        <p className="text-sm font-bold leading-relaxed pt-1">{q.question}</p>
      </div>

      {q.type === 'CHOICE' && q.options && (
        <div className="grid grid-cols-1 gap-2.5">
          {q.options.map((opt, oi) => {
            const letter = String.fromCharCode(65 + oi);
            const selected = userAnswers[qi] === letter;
            const isCorrect = q.correctAnswer === letter;
            const styles = getOptionStyle(selected, isCorrect);
            return (
              <button
                key={oi}
                onClick={() => selectAnswer(letter)}
                className="w-full text-left flex items-center gap-3 px-4 py-3.5 rounded-xl text-sm border transition-all group hover:bg-black/5 dark:hover:bg-white/5"
                style={styles}
              >
                <span
                  className="flex-shrink-0 w-6 h-6 rounded-md border flex items-center justify-center text-[10px] font-black transition-all"
                  style={{
                    borderColor: selected || (showResult && isCorrect) ? 'transparent' : themeVars.border,
                    background: selected ? themeVars.accent : (showResult && isCorrect) ? '#10b981' : 'transparent',
                    color: selected || (showResult && isCorrect) ? '#fff' : themeVars.muted,
                  }}
                >
                  {letter}
                </span>
                <span className="flex-1 font-medium">{opt}</span>
                {showResult && isCorrect && <Check size={18} />}
                {showResult && selected && !isCorrect && <X size={18} />}
              </button>
            );
          })}
        </div>
      )}

      {q.type === 'TRUE_FALSE' && (
        <div className="flex gap-3">
          {['TRUE', 'FALSE'].map(v => {
            const selected = userAnswers[qi] === v;
            const isCorrect = q.correctAnswer === v;
            const styles = getOptionStyle(selected, isCorrect);
            return (
              <button
                key={v}
                onClick={() => selectAnswer(v)}
                className="flex-1 px-4 py-3.5 rounded-xl text-sm font-bold border transition-all hover:brightness-95"
                style={styles}
              >
                {v === 'TRUE' ? '正确' : '错误'}
              </button>
            );
          })}
        </div>
      )}

      {(q.type === 'FILL' || q.type === 'SHORT_ANSWER') && (
        <div className="space-y-3">
          <input
            type="text"
            value={userAnswers[qi] || ''}
            onChange={e => selectAnswer(e.target.value)}
            disabled={quizScore !== null}
            placeholder={q.type === 'FILL' ? '在此填写答案...' : '在此输入简答...'}
            className="w-full px-4 py-3.5 rounded-xl text-sm border outline-none transition-all focus:border-brand-500/50 bg-black/5 dark:bg-white/5"
            style={{ borderColor: themeVars.border, color: themeVars.text }}
          />
          {quizScore !== null && (
            <div className="p-4 rounded-xl text-xs flex gap-2 items-start" style={{ background: '#10b98115', color: '#10b981' }}>
              <Check size={14} className="mt-0.5" />
              <div>
                <span className="font-black mr-2">参考答案:</span>
                {q.correctAnswer}
              </div>
            </div>
          )}
        </div>
      )}

      {quizScore !== null && q.explanation && (
        <div className="mt-4 p-4 rounded-xl text-xs leading-relaxed flex gap-3" style={{ background: `${themeVars.accent}10`, color: themeVars.accent }}>
          <Lightbulb size={16} className="flex-shrink-0 mt-0.5" />
          <div>
            <p className="font-black mb-1">解析</p>
            <p className="opacity-90">{q.explanation}</p>
          </div>
        </div>
      )}
    </div>
  );
};

export default ReaderAiPanel;
