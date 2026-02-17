import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import parse from 'html-react-parser';
import 'katex/dist/katex.min.css';
import renderMathInElement from 'katex/contrib/auto-render';
import { ArrowLeft, Menu, Settings, BookOpen, Loader2, Sparkles, Type } from 'lucide-react';
import { apiClient, DefaultApi, AIApi, Configuration } from '../api';
import type {
  BookDTO, ChapterDTO, ChapterContentDTO,
  ChapterSummary, KnowledgePoint, ConversationMessage,
  ReadingQuiz,
} from '../api/generated/models';
import { toast } from '../components/ui';
import { useReaderSettingsStore } from '../stores/useReaderSettingsStore';
import { THEMES, FONT_FAMILIES, parserOptions } from './reader/readerConstants';
import type { AiTab } from './reader/readerConstants';
import ReaderSidebar from './reader/ReaderSidebar';
import ReaderSettingsPanel from './reader/ReaderSettingsPanel';
import ReaderAiPanel from './reader/ReaderAiPanel';
import FloatingProgressBar from './reader/FloatingProgressBar';
import PdfReaderView from './reader/PdfReaderView';

const api = new DefaultApi(new Configuration(), '', apiClient);
const aiApi = new AIApi(new Configuration(), '', apiClient);

// ─── 主页面 ──────────────────────────────────────────────────────────────────────

const EbookReaderPage: React.FC = () => {
  const { bookId } = useParams<{ bookId: string }>();
  const navigate = useNavigate();

  // ── 基础状态 ──
  const [book, setBook] = useState<BookDTO | null>(null);
  const [chapters, setChapters] = useState<ChapterDTO[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [content, setContent] = useState<ChapterContentDTO | null>(null);
  const [loading, setLoading] = useState(true);
  const [contentLoading, setContentLoading] = useState(false);
  const [pdfUrl, setPdfUrl] = useState<string | null>(null);

  // ── 面板状态 ──
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [settingsOpen, setSettingsOpen] = useState(false);
  const [aiPanelOpen, setAiPanelOpen] = useState(false);
  const [aiTab, setAiTab] = useState<AiTab>('summary');

  // ── 设置 ──
  const settings = useReaderSettingsStore();
  const themeVars = THEMES[settings.theme];

  // ── AI 状态 ──
  const [summary, setSummary] = useState<ChapterSummary | null>(null);
  const [summaryType, setSummaryType] = useState<string>('DETAILED');
  const [summaryLoading, setSummaryLoading] = useState(false);
  const [knowledgePoints, setKnowledgePoints] = useState<KnowledgePoint[]>([]);
  const [kpLoading, setKpLoading] = useState(false);
  const [chatMessages, setChatMessages] = useState<ConversationMessage[]>([]);
  const [chatInput, setChatInput] = useState('');
  const [chatLoading, setChatLoading] = useState(false);
  const [conversationId, setConversationId] = useState<string | null>(null);
  const [quiz, setQuiz] = useState<ReadingQuiz | null>(null);
  const [quizLoading, setQuizLoading] = useState(false);
  const [userAnswers, setUserAnswers] = useState<string[]>([]);
  const [quizScore, setQuizScore] = useState<number | null>(null);
  const [quizSubmitting, setQuizSubmitting] = useState(false);
  const chatEndRef = useRef<HTMLDivElement>(null);
  const contentRef = useRef<HTMLDivElement>(null);

  // ── userId ──
  const userId = (() => {
    try {
      const info = localStorage.getItem('user_info');
      return info ? String(JSON.parse(info)?.id ?? '') : '';
    } catch { return ''; }
  })();

  // ── 加载书籍和章节 ──
  const fetchBookData = useCallback(async () => {
    if (!bookId) return;
    setLoading(true);
    try {
      const bookRes = await api.getBook({ bookId: bookId as unknown as number });
      const bookData = bookRes.data?.code === 0 ? (bookRes.data.data || null) : null;
      setBook(bookData);

      // PDF 类型：获取预签名 URL，不加载章节
      if (bookData?.fileType === 'PDF') {
        try {
          const pdfRes = await apiClient.get(`/api/books/${bookId}/pdf-url`);
          if (pdfRes.data?.code === 0) setPdfUrl(pdfRes.data.data);
        } catch { toast.error('获取PDF文件失败'); }
      } else {
        // 非 PDF：加载章节列表
        const chaptersRes = await api.getBookChapters({ bookId: bookId as unknown as number });
        if (chaptersRes.data?.code === 0) setChapters(chaptersRes.data.data || []);
      }
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '加载书籍失败');
    } finally {
      setLoading(false);
    }
  }, [bookId]);

  useEffect(() => { fetchBookData(); }, [fetchBookData]);

  // ── 加载章节内容 ──
  const fetchContent = useCallback(async (chapterIndex: number) => {
    if (!bookId) return;
    setContentLoading(true);
    setContent(null);
    try {
      const res = await api.getChapterContent({
        bookId: bookId as unknown as number,
        chapterIndex,
      });
      if (res.data?.code === 0) setContent(res.data.data || null);
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '加载章节失败');
    } finally {
      setContentLoading(false);
    }
  }, [bookId]);

  useEffect(() => {
    if (chapters.length > 0) {
      fetchContent(chapters[currentIndex]?.chapterIndex ?? currentIndex);
    }
  }, [currentIndex, chapters, fetchContent]);

  // ── 切章时滚动到顶 + 清空 AI 状态 ──
  useEffect(() => {
    contentRef.current?.scrollTo(0, 0);
    setSummary(null);
    setKnowledgePoints([]);
    setChatMessages([]);
    setConversationId(null);
    setQuiz(null);
    setQuizScore(null);
    setUserAnswers([]);
  }, [currentIndex]);

  // ── KaTeX 公式渲染：章节内容加载后自动渲染 LaTeX 公式 ──
  useEffect(() => {
    if (!contentLoading && content && contentRef.current) {
      try {
        renderMathInElement(contentRef.current, {
          delimiters: [
            { left: '$$', right: '$$', display: true },
            { left: '\\[', right: '\\]', display: true },
            { left: '$', right: '$', display: false },
            { left: '\\(', right: '\\)', display: false },
          ],
          throwOnError: false,
          strict: false,
        });
      } catch { /* KaTeX 渲染失败不影响正常阅读 */ }
    }
  }, [contentLoading, content]);

  const saveProgress = useCallback(async () => {
    if (!bookId || !userId) return;
    try {
      await api.updateProgress({
        updateReadingProgressCommand: {
          userId: userId as unknown as number,
          bookId: bookId as unknown as number,
          chapterIndex: chapters[currentIndex]?.chapterIndex ?? currentIndex,
          position: 0,
        },
      });
    } catch { /* silent */ }
  }, [bookId, userId, chapters, currentIndex]);

  const goChapter = useCallback((idx: number) => {
    if (idx < 0 || idx >= chapters.length) return;
    saveProgress();
    setCurrentIndex(idx);
  }, [chapters, saveProgress]);

  // ── 键盘快捷键 ──
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (e.target instanceof HTMLInputElement || e.target instanceof HTMLTextAreaElement) return;
      if (e.key === 'ArrowLeft') goChapter(currentIndex - 1);
      if (e.key === 'ArrowRight') goChapter(currentIndex + 1);
    };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [currentIndex, goChapter]);

  // ── 当前章节 ID ──
  const currentChapter = chapters[currentIndex];
  const currentChapterId = currentChapter?.id;

  // ━━━━━━━━━━ AI 功能 ━━━━━━━━━━

  const handleGenerateSummary = async () => {
    if (!bookId || !currentChapterId) return;
    setSummaryLoading(true);
    setSummary(null);
    try {
      const res = await aiApi.generateSummary({
        bookId: bookId as unknown as number,
        chapterId: currentChapterId as unknown as number,
        summaryType,
      });
      if (res.data?.code === 0) setSummary(res.data.data || null);
      else toast.error(res.data?.message || '生成总结失败');
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '生成总结失败');
    } finally {
      setSummaryLoading(false);
    }
  };

  const handleGetSummary = async () => {
    if (!bookId || !currentChapterId) return;
    setSummaryLoading(true);
    try {
      const res = await aiApi.getSummary({
        bookId: bookId as unknown as number,
        chapterId: currentChapterId as unknown as number,
        summaryType,
      });
      if (res.data?.code === 0 && res.data.data) setSummary(res.data.data);
      else handleGenerateSummary();
    } catch {
      handleGenerateSummary();
    } finally {
      setSummaryLoading(false);
    }
  };

  const handleExtractKP = async () => {
    if (!bookId || !currentChapterId) return;
    setKpLoading(true);
    setKnowledgePoints([]);
    try {
      const res = await aiApi.extractKnowledgePoints({
        bookId: bookId as unknown as number,
        chapterId: currentChapterId as unknown as number,
      });
      if (res.data?.code === 0) setKnowledgePoints(res.data.data || []);
      else toast.error(res.data?.message || '提取知识点失败');
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '提取知识点失败');
    } finally {
      setKpLoading(false);
    }
  };

  const handleGetKP = async () => {
    if (!bookId || !currentChapterId) return;
    setKpLoading(true);
    try {
      const res = await aiApi.getKnowledgePoints({
        bookId: bookId as unknown as number,
        chapterId: currentChapterId as unknown as number,
      });
      if (res.data?.code === 0 && res.data.data && res.data.data.length > 0) {
        setKnowledgePoints(res.data.data);
      } else {
        handleExtractKP();
        return;
      }
    } catch {
      handleExtractKP();
      return;
    } finally {
      setKpLoading(false);
    }
  };

  const handleSendChat = async () => {
    if (!bookId || !chatInput.trim() || chatLoading) return;
    const question = chatInput.trim();
    setChatInput('');
    setChatMessages(prev => [...prev, { role: 'user', content: question, timestamp: new Date().toISOString() }]);
    setChatLoading(true);
    try {
      let res;
      if (conversationId) {
        res = await aiApi.continueConversation({
          bookId: bookId as unknown as number,
          conversationId: conversationId as unknown as number,
          requestBody: { question },
        });
      } else {
        const body: Record<string, any> = { userId, question };
        if (currentChapterId) body.chapterId = currentChapterId;
        res = await aiApi.askQuestion({
          bookId: bookId as unknown as number,
          requestBody: body,
        });
      }
      if (res.data?.code === 0 && res.data.data) {
        const data = res.data.data as any;
        if (data.conversationId) setConversationId(String(data.conversationId));
        setChatMessages(prev => [...prev, {
          role: 'assistant',
          content: data.answer || data.content || '未收到回复',
          timestamp: new Date().toISOString(),
        }]);
      }
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '问答失败');
      setChatMessages(prev => [...prev, { role: 'assistant', content: '抱歉，发生了错误，请稍后重试。', timestamp: new Date().toISOString() }]);
    } finally {
      setChatLoading(false);
      setTimeout(() => chatEndRef.current?.scrollIntoView({ behavior: 'smooth' }), 100);
    }
  };

  const handleGenerateQuiz = async () => {
    if (!bookId || !currentChapterId) return;
    setQuizLoading(true);
    setQuiz(null);
    setQuizScore(null);
    setUserAnswers([]);
    try {
      const res = await aiApi.generateQuiz({
        bookId: bookId as unknown as number,
        chapterId: currentChapterId as unknown as number,
        questionCount: 5,
      });
      if (res.data?.code === 0 && res.data.data) {
        setQuiz(res.data.data);
        setUserAnswers(new Array(res.data.data.questions?.length || 0).fill(''));
      } else {
        toast.error(res.data?.message || '生成测试失败');
      }
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '生成测试失败');
    } finally {
      setQuizLoading(false);
    }
  };

  const handleSubmitQuiz = async () => {
    if (!bookId || !quiz?.id) return;
    setQuizSubmitting(true);
    try {
      const quizId = quiz.id?.value;
      if (!quizId) return;
      const res = await aiApi.submitAnswers({
        bookId: bookId as unknown as number,
        quizId: quizId as unknown as number,
        requestBody: { answers: userAnswers },
      });
      if (res.data?.code === 0 && res.data.data) {
        setQuizScore((res.data.data as any).score ?? null);
      }
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '提交失败');
    } finally {
      setQuizSubmitting(false);
    }
  };

  // ── 加载中 ──
  if (loading) {
    return (
      <div className="h-screen flex items-center justify-center" style={{ background: themeVars.bg, color: themeVars.text }}>
        <Loader2 size={32} className="animate-spin mr-3" style={{ color: themeVars.accent }} />
        <span className="text-lg">加载中...</span>
      </div>
    );
  }

  if (!book) {
    return (
      <div className="h-screen flex flex-col items-center justify-center gap-4" style={{ background: themeVars.bg, color: themeVars.text }}>
        <BookOpen size={64} style={{ opacity: 0.3 }} />
        <p>书籍不存在或加载失败</p>
        <button onClick={() => navigate(-1)} className="px-4 py-2 rounded-xl text-white text-sm font-bold" style={{ background: themeVars.accent }}>返回</button>
      </div>
    );
  }

  // ── PDF 模式：react-pdf 阅读器 ──
  if (book.fileType === 'PDF') {
    if (!pdfUrl) {
      return (
        <div className="h-screen flex items-center justify-center" style={{ background: themeVars.bg, color: themeVars.text }}>
          <Loader2 size={32} className="animate-spin mr-3" style={{ color: themeVars.accent }} />
          <span className="text-lg">加载PDF中...</span>
        </div>
      );
    }
    return <PdfReaderView pdfUrl={pdfUrl} themeVars={themeVars} title={book.title} onBack={() => navigate(-1)} />;
  }

  return (
    <div className="h-screen flex flex-col overflow-hidden select-none" style={{ background: themeVars.bg, color: themeVars.text, fontFamily: FONT_FAMILIES[settings.fontFamily] }}>

      {/* ━━━━━━━━━━ TopBar ━━━━━━━━━━ */}
      <div className="flex-shrink-0 flex items-center justify-between px-6 h-14 border-b transition-all duration-300 z-40" style={{ background: themeVars.sidebar, borderColor: themeVars.border }}>
        <div className="flex items-center gap-3">
          <button
            onClick={() => { saveProgress(); navigate(-1); }}
            className="p-2 rounded-xl hover:bg-black/5 dark:hover:bg-white/5 transition-all active:scale-95 text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-gray-100"
            title="返回"
          >
            <ArrowLeft size={18} />
          </button>
          <div className="w-px h-5 mx-1 opacity-20" style={{ background: themeVars.text }} />
          <button
            onClick={() => setSidebarOpen(!sidebarOpen)}
            className={`p-2 rounded-xl transition-all active:scale-95 ${sidebarOpen ? 'bg-brand-500/10 text-brand-600' : 'hover:bg-black/5 dark:hover:bg-white/5 text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-gray-100'}`}
            title="目录"
            style={{ color: sidebarOpen ? themeVars.accent : undefined }}
          >
            <Menu size={18} />
          </button>
        </div>

        <div className="flex flex-col items-center max-w-[50%] text-center">
          <h1 className="text-[13px] font-bold truncate w-full opacity-90">{book.title}</h1>
          <p className="text-[10px] opacity-40 truncate w-full mt-0.5">{currentChapter?.title || `第 ${(currentChapter?.chapterIndex ?? currentIndex) + 1} 章`}</p>
        </div>

        <div className="flex items-center gap-2">
          <button
            onClick={() => { setAiPanelOpen(!aiPanelOpen); if (!aiPanelOpen) setSettingsOpen(false); }}
            className={`p-2 rounded-xl transition-all active:scale-95 ${aiPanelOpen ? 'bg-brand-500/10 text-brand-600' : 'hover:bg-black/5 dark:hover:bg-white/5 text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-gray-100'}`}
            title="AI 助手"
            style={{ color: aiPanelOpen ? themeVars.accent : undefined }}
          >
            <Sparkles size={18} />
          </button>
          <button
            onClick={() => { setSettingsOpen(!settingsOpen); if (!settingsOpen) setAiPanelOpen(false); }}
            className={`p-2 rounded-xl transition-all active:scale-95 ${settingsOpen ? 'bg-brand-500/10 text-brand-600' : 'hover:bg-black/5 dark:hover:bg-white/5 text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-gray-100'}`}
            title="设置"
            style={{ color: settingsOpen ? themeVars.accent : undefined }}
          >
            <Settings size={18} />
          </button>
        </div>
      </div>

      {/* ━━━━━━━━━━ 主体区域 ━━━━━━━━━━ */}
      <div className="flex-1 flex min-h-0 relative">

        {/* ── 左侧：目录 ── */}
        {sidebarOpen && (
          <ReaderSidebar
            chapters={chapters}
            currentIndex={currentIndex}
            themeVars={themeVars}
            onGoChapter={goChapter}
          />
        )}

        {/* ── 中间：内容区 ── */}
        <div ref={contentRef} className="flex-1 overflow-y-auto custom-scrollbar selection:bg-brand-500/30 transition-all duration-300 pb-24" style={{ background: themeVars.bg }}>
          {contentLoading ? (
            <div className="flex flex-col items-center justify-center h-full gap-4">
              <div className="relative">
                <div className="w-12 h-12 rounded-full border-2 border-brand-500/20 animate-ping absolute inset-0" />
                <Loader2 size={48} className="animate-spin relative" style={{ color: themeVars.accent }} />
              </div>
              <span className="text-sm font-medium animate-pulse" style={{ color: themeVars.muted }}>正在开启知识之门...</span>
            </div>
          ) : content ? (
            <div className="mx-auto py-20 px-10 md:px-16" style={{ maxWidth: settings.contentWidth }}>
              <div className="mb-16 pb-12 border-b-2 border-dashed" style={{ borderColor: themeVars.border }}>
                <h2 className="text-5xl font-black mb-6 leading-tight tracking-tight">{content.title || `第 ${(content.chapterIndex ?? 0) + 1} 章`}</h2>
                <div className="flex items-center gap-6 text-[13px]" style={{ color: themeVars.muted }}>
                  <div className="flex items-center gap-2 px-3 py-1 rounded-full bg-black/[0.03] dark:bg-white/[0.03]">
                    <Type size={14} className="opacity-60" />
                    <span className="font-bold">{content.wordCount?.toLocaleString() || 0} 字</span>
                  </div>
                  <div className="flex items-center gap-2 px-3 py-1 rounded-full bg-black/[0.03] dark:bg-white/[0.03]">
                    <BookOpen size={14} className="opacity-60" />
                    <span className="font-bold">第 {(content.chapterIndex ?? 0) + 1} 章节</span>
                  </div>
                </div>
              </div>
              <div
                className="prose max-w-none reader-content"
                style={{
                  fontSize: settings.fontSize,
                  lineHeight: settings.lineHeight,
                  color: themeVars.text,
                  '--tw-prose-body': themeVars.text,
                  '--tw-prose-headings': themeVars.text,
                  '--tw-prose-links': themeVars.accent,
                  '--tw-prose-bold': themeVars.text,
                  '--tw-prose-counters': themeVars.muted,
                  '--tw-prose-bullets': themeVars.muted,
                  '--tw-prose-quotes': themeVars.text,
                  '--tw-prose-captions': themeVars.muted,
                  '--tw-prose-code': themeVars.text,
                  '--tw-prose-pre-code': themeVars.text,
                  '--tw-prose-pre-bg': themeVars.card,
                  '--tw-prose-th-borders': themeVars.border,
                  '--tw-prose-td-borders': themeVars.border,
                } as React.CSSProperties}
              >
                {parse(content.content || '<p>暂无内容</p>', parserOptions)}
              </div>

              <div className="mt-20 pt-12 border-t flex flex-col items-center gap-6" style={{ borderColor: themeVars.border }}>
                <div className="flex items-center gap-4">
                  <button
                    onClick={() => goChapter(currentIndex - 1)}
                    disabled={currentIndex === 0}
                    className="flex flex-col items-start gap-1 p-6 rounded-2xl border-2 transition-all hover:scale-[1.02] active:scale-[0.98] disabled:opacity-20 disabled:hover:scale-100 group w-64"
                    style={{ borderColor: themeVars.border, background: themeVars.card }}
                  >
                    <span className="text-[10px] font-black uppercase tracking-widest opacity-40 group-hover:opacity-100 transition-opacity">上一章</span>
                    <span className="text-sm font-bold truncate w-full text-left">
                      {currentIndex > 0 ? (chapters[currentIndex - 1]?.title || '未命名章节') : '已是第一章'}
                    </span>
                  </button>
                  <button
                    onClick={() => goChapter(currentIndex + 1)}
                    disabled={currentIndex >= chapters.length - 1}
                    className="flex flex-col items-end gap-1 p-6 rounded-2xl border-2 transition-all hover:scale-[1.02] active:scale-[0.98] disabled:opacity-20 disabled:hover:scale-100 group w-64 text-right"
                    style={{ borderColor: themeVars.accent, background: `${themeVars.accent}05` }}
                  >
                    <span className="text-[10px] font-black uppercase tracking-widest opacity-60 group-hover:opacity-100 transition-opacity" style={{ color: themeVars.accent }}>下一章</span>
                    <span className="text-sm font-bold truncate w-full" style={{ color: themeVars.accent }}>
                      {currentIndex < chapters.length - 1 ? (chapters[currentIndex + 1]?.title || '未命名章节') : '已是最后一章'}
                    </span>
                  </button>
                </div>
              </div>
            </div>
          ) : (
            <div className="flex flex-col items-center justify-center h-full" style={{ color: themeVars.muted }}>
              <div className="w-24 h-24 rounded-full bg-black/5 dark:bg-white/5 flex items-center justify-center mb-6">
                <BookOpen size={48} className="opacity-20" />
              </div>
              <p className="text-sm font-medium">暂无内容，请选择其他章节</p>
            </div>
          )}
        </div>

        {/* ── 设置面板 ── */}
        {settingsOpen && (
          <ReaderSettingsPanel themeVars={themeVars} onClose={() => setSettingsOpen(false)} />
        )}

        {/* ── AI 面板 ── */}
        {aiPanelOpen && (
          <ReaderAiPanel
            themeVars={themeVars}
            onClose={() => setAiPanelOpen(false)}
            aiTab={aiTab}
            setAiTab={setAiTab}
            summary={summary}
            summaryType={summaryType}
            setSummaryType={setSummaryType}
            setSummary={setSummary}
            summaryLoading={summaryLoading}
            onGetSummary={handleGetSummary}
            onGenerateSummary={handleGenerateSummary}
            knowledgePoints={knowledgePoints}
            kpLoading={kpLoading}
            onGetKP={handleGetKP}
            onExtractKP={handleExtractKP}
            setKnowledgePoints={setKnowledgePoints}
            chatMessages={chatMessages}
            chatInput={chatInput}
            setChatInput={setChatInput}
            chatLoading={chatLoading}
            onSendChat={handleSendChat}
            chatEndRef={chatEndRef}
            quiz={quiz}
            quizLoading={quizLoading}
            quizScore={quizScore}
            quizSubmitting={quizSubmitting}
            userAnswers={userAnswers}
            setUserAnswers={setUserAnswers}
            onGenerateQuiz={handleGenerateQuiz}
            onSubmitQuiz={handleSubmitQuiz}
            setQuiz={setQuiz}
            setQuizScore={setQuizScore}
          />
        )}

        {/* ── 底部进度栏 ── */}
        <FloatingProgressBar
          currentIndex={currentIndex}
          totalChapters={chapters.length}
          themeVars={themeVars}
          onGoChapter={goChapter}
        />
      </div>
    </div>
  );
};

export default EbookReaderPage;
