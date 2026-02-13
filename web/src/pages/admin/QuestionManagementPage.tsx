import React, { useState, useEffect, useCallback, useRef } from 'react';
import {
  Search,
  Plus,
  Edit2,
  Trash2,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  Tag,
  BookOpen,
  Sparkles,
  Globe,
  Image,
  PenTool,
  Loader2,
  CheckCircle,
  AlertCircle
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration, getToken } from '../../api';
import type {
  QuestionResponse,
  CreateQuestionRequest,
  UpdateQuestionRequest,
} from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 题型配置
const QUESTION_TYPES = [
  { value: '', label: '全部题型' },
  { value: 'SINGLE_CHOICE', label: '单选题' },
  { value: 'MULTI_CHOICE', label: '多选题' },
  { value: 'FILL_BLANK', label: '填空题' },
  { value: 'TRUE_FALSE', label: '判断题' },
  { value: 'SHORT_ANSWER', label: '简答题' },
  { value: 'CALCULATION', label: '计算题' },
  { value: 'ESSAY', label: '论述题' },
];

const SUBJECTS = [
  { value: '', label: '全部学科' },
  { value: 'MATH', label: '数学' },
  { value: 'CHINESE', label: '语文' },
  { value: 'ENGLISH', label: '英语' },
  { value: 'PHYSICS', label: '物理' },
  { value: 'CHEMISTRY', label: '化学' },
  { value: 'BIOLOGY', label: '生物' },
  { value: 'HISTORY', label: '历史' },
  { value: 'GEOGRAPHY', label: '地理' },
  { value: 'POLITICS', label: '政治' },
];

const DIFFICULTY_OPTIONS = [
  { value: 0, label: '全部难度' },
  { value: 1, label: '⭐ 很简单' },
  { value: 2, label: '⭐⭐ 简单' },
  { value: 3, label: '⭐⭐⭐ 中等' },
  { value: 4, label: '⭐⭐⭐⭐ 困难' },
  { value: 5, label: '⭐⭐⭐⭐⭐ 很困难' },
];

const DIFFICULTY_COLORS: Record<number, string> = {
  1: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400',
  2: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400',
  3: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400',
  4: 'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-400',
  5: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400',
};

export const QuestionManagementPage: React.FC = () => {
  const [questions, setQuestions] = useState<QuestionResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [total, setTotal] = useState(0);
  const [pageNum, setPageNum] = useState(1);
  const [pageSize] = useState(20);

  // 筛选条件
  const [keyword, setKeyword] = useState('');
  const [filterType, setFilterType] = useState('');
  const [filterSubject, setFilterSubject] = useState('');
  const [filterDifficulty, setFilterDifficulty] = useState(0);

  // 弹窗
  const [showModal, setShowModal] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);

  // AI 出题
  const [showAiPanel, setShowAiPanel] = useState(false);
  const [aiGenerating, setAiGenerating] = useState(false);
  const [aiProgress, setAiProgress] = useState<string>('');
  const [aiResults, setAiResults] = useState<Array<{
    id?: string; index: number; content: string; options?: string;
    answer: string; explanation?: string; imageUrl?: string;
    knowledgeTags?: string[]; status: 'generating' | 'saved' | 'error'; error?: string;
  }>>([]);
  const [aiForm, setAiForm] = useState({
    subject: 'MATH', type: 'SINGLE_CHOICE', difficulty: 3, grade: '',
    count: 5, topic: '', userInput: '', withDiagram: false, withImage: false, enableWebSearch: false,
  });
  const abortRef = useRef<AbortController | null>(null);

  // 表单
  const [form, setForm] = useState<{
    type: string; subject: string; grade: string; difficulty: number;
    content: string; options: { label: string; text: string }[];
    answer: string; explanation: string; knowledgeTags: string;
  }>({
    type: 'SINGLE_CHOICE', subject: 'MATH', grade: '', difficulty: 3,
    content: '', options: [{ label: 'A', text: '' }, { label: 'B', text: '' }, { label: 'C', text: '' }, { label: 'D', text: '' }],
    answer: '', explanation: '', knowledgeTags: '',
  });

  const isChoiceType = form.type === 'SINGLE_CHOICE' || form.type === 'MULTI_CHOICE';

  // 加载数据
  const fetchQuestions = useCallback(async () => {
    setLoading(true);
    try {
      const params: Record<string, any> = { pageNum, pageSize };
      if (keyword) params.keyword = keyword;
      if (filterType) params.type = filterType;
      if (filterSubject) params.subject = filterSubject;
      if (filterDifficulty > 0) params.difficulty = filterDifficulty;

      const res = await api.queryQuestions({ request: params as any });
      const data = (res.data as any)?.data;
      if (data) {
        setQuestions(data.records || []);
        setTotal(data.total || 0);
      }
    } catch (e: any) {
      toast.error('加载题目失败: ' + (e.message || '未知错误'));
    } finally {
      setLoading(false);
    }
  }, [pageNum, pageSize, keyword, filterType, filterSubject, filterDifficulty]);

  useEffect(() => { fetchQuestions(); }, [fetchQuestions]);

  const handleSearch = () => { setPageNum(1); fetchQuestions(); };

  // 打开新建弹窗
  const handleCreate = () => {
    setEditingId(null);
    setForm({
      type: 'SINGLE_CHOICE', subject: 'MATH', grade: '', difficulty: 3,
      content: '', options: [{ label: 'A', text: '' }, { label: 'B', text: '' }, { label: 'C', text: '' }, { label: 'D', text: '' }],
      answer: '', explanation: '', knowledgeTags: '',
    });
    setShowModal(true);
  };

  // 打开编辑弹窗
  const handleEdit = (q: QuestionResponse) => {
    setEditingId(q.id as unknown as number);
    let parsedOptions = [{ label: 'A', text: '' }, { label: 'B', text: '' }, { label: 'C', text: '' }, { label: 'D', text: '' }];
    try {
      if (q.options) parsedOptions = JSON.parse(q.options as string);
    } catch { /* ignore */ }

    setForm({
      type: q.type || 'SINGLE_CHOICE',
      subject: q.subject || 'MATH',
      grade: (q as any).grade || '',
      difficulty: q.difficulty || 3,
      content: q.content || '',
      options: parsedOptions,
      answer: q.answer || '',
      explanation: q.explanation || '',
      knowledgeTags: (q.knowledgeTags || []).join(', '),
    });
    setShowModal(true);
  };

  // 保存
  const handleSave = async () => {
    if (!form.content.trim()) { toast.error('题干内容不能为空'); return; }
    if (!form.answer.trim()) { toast.error('答案不能为空'); return; }

    const tags = form.knowledgeTags.split(/[,，]/).map(t => t.trim()).filter(Boolean);
    const optionsJson = isChoiceType ? JSON.stringify(form.options) : undefined;

    try {
      if (editingId) {
        const req: UpdateQuestionRequest = {
          id: editingId,
          type: form.type,
          subject: form.subject,
          grade: form.grade || undefined,
          difficulty: form.difficulty,
          content: form.content,
          options: optionsJson,
          answer: form.answer,
          explanation: form.explanation || undefined,
          knowledgeTags: tags.length > 0 ? tags : undefined,
        };
        await api.updateQuestion({ updateQuestionRequest: req });
        toast.success('更新成功');
      } else {
        const req: CreateQuestionRequest = {
          type: form.type,
          subject: form.subject,
          grade: form.grade || undefined,
          difficulty: form.difficulty,
          content: form.content,
          options: optionsJson,
          answer: form.answer,
          explanation: form.explanation || undefined,
          knowledgeTags: tags.length > 0 ? tags : undefined,
          source: 'MANUAL',
        };
        await api.createQuestion({ createQuestionRequest: req });
        toast.success('创建成功');
      }
      setShowModal(false);
      fetchQuestions();
    } catch (e: any) {
      toast.error('保存失败: ' + (e.message || '未知错误'));
    }
  };

  // 删除
  const handleDelete = async (id: number) => {
    if (!confirm('确定要删除这道题目吗？')) return;
    try {
      await api.deleteQuestion({ id });
      toast.success('删除成功');
      fetchQuestions();
    } catch (e: any) {
      toast.error('删除失败: ' + (e.message || '未知错误'));
    }
  };

  // AI 出题 SSE
  const handleAiGenerate = async () => {
    if (aiGenerating) return; // 防重复点击
    setAiGenerating(true);
    setAiResults([]);
    setAiProgress('准备中...');

    const controller = new AbortController();
    abortRef.current = controller;

    try {
      const baseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';
      const token = getToken();

      const response = await fetch(`${baseUrl}/api/questions/ai-generate`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'text/event-stream',
          ...(token ? { 'Authorization': `Bearer ${token}` } : {}),
        },
        body: JSON.stringify({
          subject: aiForm.subject,
          type: aiForm.type,
          difficulty: aiForm.difficulty,
          grade: aiForm.grade || undefined,
          count: aiForm.count,
          topic: aiForm.topic || undefined,
          withDiagram: aiForm.withDiagram,
          withImage: aiForm.withImage,
          enableWebSearch: aiForm.enableWebSearch,
          userInput: aiForm.userInput || undefined,
        }),
        signal: controller.signal,
      });

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }

      const reader = response.body?.getReader();
      if (!reader) throw new Error('No response body');

      const decoder = new TextDecoder();
      let buffer = '';

      let currentEventName = 'message';

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        const lines = buffer.split('\n');
        buffer = lines.pop() || '';

        for (const line of lines) {
          // 空行 = SSE 事件边界，重置事件名
          if (line.trim() === '') {
            currentEventName = 'message';
            continue;
          }
          if (line.startsWith('event:')) {
            currentEventName = line.slice(6).trim();
            continue;
          }
          if (line.startsWith('data:')) {
            const dataStr = line.slice(5).trim();
            if (!dataStr) continue;
            try {
              const data = JSON.parse(dataStr);
              handleSseEvent(currentEventName, data);
            } catch {
              setAiProgress(dataStr);
            }
          }
        }
      }
    } catch (e: any) {
      if (e.name !== 'AbortError') {
        toast.error('AI 出题失败: ' + (e.message || '未知错误'));
      }
    } finally {
      setAiGenerating(false);
      abortRef.current = null;
    }
  };

  /**
   * SSE 事件处理（按后端事件名精确路由）
   *
   * 后端事件契约：
   *   started          → { count, subject, type }
   *   generating       → { index, total, message }
   *   saving_question  → { index, total, message, content }
   *   question_saved   → { id, index, total, content, options, answer, explanation, imageUrl, knowledgeTags }
   *   question_error   → { index, total, error }
   *   done             → { total, message }
   *   error            → { message }
   */
  const handleSseEvent = (eventName: string, data: any) => {
    switch (eventName) {
      case 'started':
        setAiProgress(`开始生成 ${data.count} 道题目...`);
        break;

      case 'generating':
        setAiProgress(data.message);
        break;

      case 'saving_question':
        setAiProgress(data.message);
        setAiResults(prev => {
          const existing = prev.findIndex(r => r.index === data.index);
          const item = {
            index: data.index, content: data.content,
            answer: '', status: 'generating' as const,
          };
          if (existing >= 0) {
            const next = [...prev];
            next[existing] = item;
            return next;
          }
          return [...prev, item];
        });
        break;

      case 'question_saved':
        setAiResults(prev => {
          const existing = prev.findIndex(r => r.index === data.index);
          const item = {
            id: data.id, index: data.index, content: data.content,
            options: data.options, answer: data.answer,
            explanation: data.explanation, imageUrl: data.imageUrl,
            knowledgeTags: data.knowledgeTags,
            status: 'saved' as const,
          };
          if (existing >= 0) {
            const next = [...prev];
            next[existing] = item;
            return next;
          }
          return [...prev, item];
        });
        break;

      case 'question_error':
        setAiResults(prev => [...prev, {
          index: data.index || prev.length + 1, content: '', answer: '',
          status: 'error' as const, error: data.error,
        }]);
        break;

      case 'done':
        setAiProgress(`完成！共生成 ${data.total} 道题目`);
        fetchQuestions();
        break;

      case 'error':
        setAiProgress(`错误：${data.message}`);
        break;

      default:
        if (data.message) setAiProgress(data.message);
        break;
    }
  };

  const handleAiCancel = () => {
    abortRef.current?.abort();
    setAiGenerating(false);
  };

  const totalPages = Math.ceil(total / pageSize);
  const typeLabel = (code: string) => QUESTION_TYPES.find(t => t.value === code)?.label || code;
  const subjectLabel = (code: string) => SUBJECTS.find(s => s.value === code)?.label || code;

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* 页头 */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">题库管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">共 {total} 道题目，支持手动创建和 AI 智能出题</p>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={() => setShowAiPanel(true)} className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-brand-500 to-brand-700 hover:from-brand-600 hover:to-brand-800 text-white rounded-xl text-sm font-bold shadow-lg shadow-brand-600/20 transition-all active:scale-95">
            <Sparkles size={18} />
            <span>AI 出题</span>
          </button>
          <button onClick={handleCreate} className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">
            <Plus size={18} />
            <span>新建题目</span>
          </button>
        </div>
      </div>

      {/* 搜索筛选栏 */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <div className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input
              type="text" placeholder="搜索题干内容..." value={keyword}
              onChange={e => setKeyword(e.target.value)}
              onKeyDown={e => e.key === 'Enter' && handleSearch()}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select value={filterType} onChange={e => { setFilterType(e.target.value); setPageNum(1); }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer">
              {QUESTION_TYPES.map(t => <option key={t.value} value={t.value}>{t.label}</option>)}
            </select>
            <select value={filterSubject} onChange={e => { setFilterSubject(e.target.value); setPageNum(1); }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer">
              {SUBJECTS.map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
            </select>
            <select value={filterDifficulty} onChange={e => { setFilterDifficulty(Number(e.target.value)); setPageNum(1); }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer">
              {DIFFICULTY_OPTIONS.map(d => <option key={d.value} value={d.value}>{d.label}</option>)}
            </select>
            <button onClick={() => { setPageNum(1); fetchQuestions(); }}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all">
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </div>
      </div>

      {/* 题目表格 */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider" style={{ width: '45%' }}>题目信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">题型</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">学科</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">难度</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={5} className="px-6 py-6">
                      <div className="space-y-2">
                        <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-3/4" />
                        <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
                      </div>
                    </td>
                  </tr>
                ))
              ) : questions.length > 0 ? (
                questions.map((q) => (
                  <tr key={String(q.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-6 py-4">
                      <p className="font-medium text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors line-clamp-2 text-sm leading-relaxed">
                        {q.content}
                      </p>
                      {(q.knowledgeTags || []).length > 0 && (
                        <div className="flex flex-wrap gap-1 mt-1.5">
                          {(q.knowledgeTags || []).slice(0, 3).map((tag, i) => (
                            <span key={i} className="inline-flex items-center gap-1 px-1.5 py-0.5 rounded text-xs bg-gray-100 text-gray-500 dark:bg-gray-800 dark:text-gray-400">
                              <Tag size={10} /> {tag}
                            </span>
                          ))}
                        </div>
                      )}
                    </td>
                    <td className="px-6 py-4">
                      <span className="px-2.5 py-1 rounded-lg text-xs font-bold border bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-400 border-brand-200 dark:border-brand-800">
                        {q.typeDesc || typeLabel(q.type || '')}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <span className="px-2.5 py-1 rounded-lg text-xs font-bold border bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-400 border-purple-200 dark:border-purple-800">
                        {q.subjectDesc || subjectLabel(q.subject || '')}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <span className={`px-2.5 py-1 rounded-lg text-xs font-bold ${DIFFICULTY_COLORS[q.difficulty || 3] || ''}`}>
                        {q.difficultyDesc || `难度${q.difficulty}`}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button onClick={() => handleEdit(q)} className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" title="编辑">
                          <Edit2 size={18} />
                        </button>
                        <button onClick={() => handleDelete(q.id as unknown as number)} className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" title="删除">
                          <Trash2 size={18} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={5} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <BookOpen size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无题目</p>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* 分页 */}
        {totalPages > 0 && (
          <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 条记录
            </p>
            <div className="flex items-center gap-2">
              <button disabled={pageNum <= 1} onClick={() => setPageNum(p => p - 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all">
                <ChevronLeft size={18} />
              </button>
              <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">
                {pageNum} / {totalPages}
              </span>
              <button disabled={pageNum >= totalPages} onClick={() => setPageNum(p => p + 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all">
                <ChevronRight size={18} />
              </button>
            </div>
          </div>
        )}
      </div>

      {/* AI 出题面板 */}
      {showAiPanel && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={() => { handleAiCancel(); setShowAiPanel(false); }} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-3xl mx-4 max-h-[90vh] overflow-y-auto animate-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand-500 to-brand-700 flex items-center justify-center">
                  <Sparkles size={20} className="text-white" />
                </div>
                <div>
                  <h3 className="text-lg font-bold text-gray-900 dark:text-white">AI 智能出题</h3>
                  <p className="text-xs text-gray-500 dark:text-gray-400">支持联网搜索热点、几何图形、配图生成</p>
                </div>
              </div>
              <button onClick={() => { handleAiCancel(); setShowAiPanel(false); }} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
            </div>

            <div className="p-6 space-y-4">
              {/* 第一行：学科 + 题型 + 难度 */}
              <div className="grid grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">学科</label>
                  <select value={aiForm.subject} onChange={e => setAiForm(f => ({ ...f, subject: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                    {SUBJECTS.filter(s => s.value).map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">题型</label>
                  <select value={aiForm.type} onChange={e => setAiForm(f => ({ ...f, type: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                    {QUESTION_TYPES.filter(t => t.value).map(t => <option key={t.value} value={t.value}>{t.label}</option>)}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">难度</label>
                  <select value={aiForm.difficulty} onChange={e => setAiForm(f => ({ ...f, difficulty: Number(e.target.value) }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                    {DIFFICULTY_OPTIONS.filter(d => d.value > 0).map(d => <option key={d.value} value={d.value}>{d.label}</option>)}
                  </select>
                </div>
              </div>

              {/* 第二行：数量 + 年级 */}
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">生成数量</label>
                  <input type="number" min={1} max={20} value={aiForm.count}
                    onChange={e => setAiForm(f => ({ ...f, count: Math.min(20, Math.max(1, Number(e.target.value) || 1)) }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all" />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">年级（可选）</label>
                  <input type="text" value={aiForm.grade}
                    onChange={e => setAiForm(f => ({ ...f, grade: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    placeholder="如：高一、初三" />
                </div>
              </div>

              {/* 知识点 */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">知识点/主题</label>
                <input type="text" value={aiForm.topic}
                  onChange={e => setAiForm(f => ({ ...f, topic: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="如：三角函数、勾股定理、近代史" />
              </div>

              {/* 用户自定义要求 */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">补充要求（可选）</label>
                <textarea value={aiForm.userInput}
                  onChange={e => setAiForm(f => ({ ...f, userInput: e.target.value }))}
                  rows={3}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                  placeholder="输入你的想法，如：题目结合生活实际场景、注重计算能力考察、出题风格偏应用型..." />
              </div>

              {/* 能力开关 */}
              <div className="flex flex-wrap gap-3">
                <label className={`flex items-center gap-2 px-4 py-2.5 rounded-xl border cursor-pointer transition-all ${
                  aiForm.enableWebSearch
                    ? 'border-orange-300 bg-orange-50 dark:bg-orange-900/20 dark:border-orange-700 text-orange-700 dark:text-orange-400'
                    : 'border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800'
                }`}>
                  <input type="checkbox" checked={aiForm.enableWebSearch}
                    onChange={e => setAiForm(f => ({ ...f, enableWebSearch: e.target.checked }))}
                    className="sr-only" />
                  <Globe size={16} />
                  <span className="text-sm font-medium">联网搜索热点</span>
                </label>

                <label className={`flex items-center gap-2 px-4 py-2.5 rounded-xl border cursor-pointer transition-all ${
                  aiForm.withDiagram
                    ? 'border-blue-300 bg-blue-50 dark:bg-blue-900/20 dark:border-blue-700 text-blue-700 dark:text-blue-400'
                    : 'border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800'
                }`}>
                  <input type="checkbox" checked={aiForm.withDiagram}
                    onChange={e => setAiForm(f => ({ ...f, withDiagram: e.target.checked }))}
                    className="sr-only" />
                  <PenTool size={16} />
                  <span className="text-sm font-medium">几何图形</span>
                </label>

                <label className={`flex items-center gap-2 px-4 py-2.5 rounded-xl border cursor-pointer transition-all ${
                  aiForm.withImage
                    ? 'border-green-300 bg-green-50 dark:bg-green-900/20 dark:border-green-700 text-green-700 dark:text-green-400'
                    : 'border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800'
                }`}>
                  <input type="checkbox" checked={aiForm.withImage}
                    onChange={e => setAiForm(f => ({ ...f, withImage: e.target.checked }))}
                    className="sr-only" />
                  <Image size={16} />
                  <span className="text-sm font-medium">生成配图</span>
                </label>
              </div>

              {/* 生成按钮 */}
              <div className="flex items-center gap-3">
                {!aiGenerating ? (
                  <button onClick={handleAiGenerate}
                    className="flex items-center gap-2 px-6 py-2.5 bg-gradient-to-r from-brand-500 to-brand-700 hover:from-brand-600 hover:to-brand-800 text-white rounded-xl text-sm font-bold shadow-lg shadow-brand-600/20 transition-all active:scale-95">
                    <Sparkles size={18} /> 开始生成
                  </button>
                ) : (
                  <button onClick={handleAiCancel}
                    className="flex items-center gap-2 px-6 py-2.5 bg-red-500 hover:bg-red-600 text-white rounded-xl text-sm font-bold transition-all active:scale-95">
                    <X size={18} /> 停止
                  </button>
                )}
                {aiProgress && (
                  <div className="flex items-center gap-2 text-sm text-gray-500">
                    {aiGenerating && <Loader2 size={16} className="animate-spin" />}
                    {aiProgress}
                  </div>
                )}
              </div>

              {/* 生成结果 */}
              {(aiResults.length > 0 || aiGenerating) && (
                <div className="space-y-3 pt-2">
                  <div className="flex items-center justify-between">
                    <h3 className="text-sm font-semibold text-gray-700 dark:text-gray-300">生成结果</h3>
                    {aiGenerating && aiResults.length > 0 && (
                      <span className="text-xs text-brand-600 dark:text-brand-400 font-medium">
                        {aiResults.filter(r => r.status === 'saved').length}/{aiForm.count} 已完成
                      </span>
                    )}
                  </div>

                  {/* 进度条 */}
                  {aiGenerating && (
                    <div className="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-1.5 overflow-hidden">
                      <div
                        className="h-full bg-gradient-to-r from-brand-500 to-brand-600 rounded-full transition-all duration-500 ease-out"
                        style={{ width: `${Math.max(5, (aiResults.filter(r => r.status === 'saved').length / aiForm.count) * 100)}%` }}
                      />
                    </div>
                  )}

                  {aiResults.map((r, i) => (
                    <div key={i} className={`p-4 rounded-xl border transition-all duration-300 ${
                      r.status === 'saved'
                        ? 'border-green-200 bg-green-50/50 dark:border-green-800 dark:bg-green-900/10 animate-in fade-in slide-in-from-bottom-2 duration-300'
                        : r.status === 'error'
                          ? 'border-red-200 bg-red-50/50 dark:border-red-800 dark:bg-red-900/10'
                          : 'border-brand-200 bg-brand-50/30 dark:border-brand-800 dark:bg-brand-900/10 animate-pulse'
                    }`}>
                      <div className="flex items-start justify-between gap-3">
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2 mb-1">
                            <span className={`text-xs font-bold ${r.status === 'generating' ? 'text-brand-600' : 'text-gray-500'}`}>#{r.index}</span>
                            {r.status === 'saved' && <CheckCircle size={14} className="text-green-500" />}
                            {r.status === 'generating' && <Loader2 size={14} className="text-brand-500 animate-spin" />}
                            {r.status === 'error' && <AlertCircle size={14} className="text-red-500" />}
                            {r.status === 'generating' && (
                              <span className="text-xs text-brand-500 font-medium">保存中...</span>
                            )}
                          </div>
                          {r.status === 'error' ? (
                            <p className="text-sm text-red-600">{r.error}</p>
                          ) : (
                            <>
                              <p className={`text-sm line-clamp-2 ${r.status === 'generating' ? 'text-gray-600 dark:text-gray-400' : 'text-gray-900 dark:text-white'}`}>{r.content}</p>
                              {r.status === 'saved' && (
                                <>
                                  {r.imageUrl && (
                                    <img src={r.imageUrl} alt="题目配图" className="mt-2 max-h-32 rounded-lg border border-gray-200 dark:border-gray-700" />
                                  )}
                                  <div className="flex items-center gap-3 mt-2 text-xs text-gray-500">
                                    {r.answer && <span>答案: {r.answer}</span>}
                                    {r.knowledgeTags && r.knowledgeTags.length > 0 && (
                                      <span>标签: {r.knowledgeTags.join(', ')}</span>
                                    )}
                                  </div>
                                </>
                              )}
                            </>
                          )}
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* 新建/编辑弹窗 */}
      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={() => setShowModal(false)} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-y-auto animate-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">{editingId ? '编辑题目' : '新建题目'}</h3>
              <button onClick={() => setShowModal(false)} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
            </div>

            <div className="p-6 space-y-4">
              {/* 第一行：题型 + 学科 + 难度 */}
              <div className="grid grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">题型 *</label>
                  <select value={form.type} onChange={e => setForm(f => ({ ...f, type: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                    {QUESTION_TYPES.filter(t => t.value).map(t => <option key={t.value} value={t.value}>{t.label}</option>)}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">学科 *</label>
                  <select value={form.subject} onChange={e => setForm(f => ({ ...f, subject: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                    {SUBJECTS.filter(s => s.value).map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">难度 *</label>
                  <select value={form.difficulty} onChange={e => setForm(f => ({ ...f, difficulty: Number(e.target.value) }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                    {DIFFICULTY_OPTIONS.filter(d => d.value > 0).map(d => <option key={d.value} value={d.value}>{d.label}</option>)}
                  </select>
                </div>
              </div>

              {/* 题干 */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">题干内容 * <span className="text-xs text-gray-400">（支持 KaTeX 公式）</span></label>
                <textarea rows={4} value={form.content} onChange={e => setForm(f => ({ ...f, content: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                  placeholder="输入题干内容..." />
              </div>

              {/* 选项（仅选择题） */}
              {isChoiceType && (
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">选项</label>
                  <div className="space-y-2">
                    {form.options.map((opt, i) => (
                      <div key={i} className="flex items-center gap-2">
                        <span className="w-8 h-8 flex items-center justify-center rounded-lg bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 text-sm font-bold shrink-0">
                          {String.fromCharCode(65 + i)}
                        </span>
                        <input type="text" value={opt.text}
                          onChange={e => {
                            const newOpts = [...form.options];
                            newOpts[i] = { ...newOpts[i], text: e.target.value };
                            setForm(f => ({ ...f, options: newOpts }));
                          }}
                          className="flex-1 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                          placeholder={`选项 ${String.fromCharCode(65 + i)}`} />
                        {form.options.length > 2 && (
                          <button onClick={() => setForm(f => ({ ...f, options: f.options.filter((_, j) => j !== i) }))}
                            className="p-1.5 rounded-lg hover:bg-red-50 dark:hover:bg-red-900/20 text-gray-400 hover:text-red-500 transition">
                            <X size={14} />
                          </button>
                        )}
                      </div>
                    ))}
                    {form.options.length < 6 && (
                      <button onClick={() => setForm(f => ({ ...f, options: [...f.options, { label: String.fromCharCode(65 + f.options.length), text: '' }] }))}
                        className="text-sm text-brand-600 hover:text-brand-700 dark:text-brand-400 font-medium">
                        + 添加选项
                      </button>
                    )}
                  </div>
                </div>
              )}

              {/* 答案 */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">标准答案 *</label>
                <textarea rows={2} value={form.answer} onChange={e => setForm(f => ({ ...f, answer: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                  placeholder={isChoiceType ? '如：A 或 ABD' : '输入标准答案...'} />
              </div>

              {/* 解析 */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">解析</label>
                <textarea rows={3} value={form.explanation} onChange={e => setForm(f => ({ ...f, explanation: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                  placeholder="输入解析（可选）..." />
              </div>

              {/* 知识点标签 */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">知识点标签</label>
                <input type="text" value={form.knowledgeTags} onChange={e => setForm(f => ({ ...f, knowledgeTags: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                  placeholder="多个标签用逗号分隔，如：三角函数, 正弦定理" />
              </div>
            </div>

            <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
              <button onClick={() => setShowModal(false)} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
              <button onClick={handleSave} className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">保存</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default QuestionManagementPage;
