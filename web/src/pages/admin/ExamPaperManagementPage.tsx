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
  BookOpen,
  Clock,
  FileText,
  Send,
  Undo2,
  Eye,
  Download,
  ListPlus,
  GripVertical,
  Loader2,
  ZoomIn,
  ZoomOut,
  ArrowLeft,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type {
  ExamPaperResponse,
  CreateExamPaperRequest,
  UpdateExamPaperRequest,
  PaperSectionResponse,
  PaperQuestionResponse,
  QuestionResponse,
} from '../../api/generated/models';
import { toast } from '../../components/ui';
import { QUESTION_TYPE_OPTIONS, SUBJECT_OPTIONS, getSubjectName } from '../../constants/exam';

const api = new DefaultApi(new Configuration(), '', apiClient);

const SUBJECTS = [{ value: '', label: '全部学科' }, ...SUBJECT_OPTIONS];

const STATUS_CONFIG: Record<string, { label: string; color: string }> = {
  DRAFT: { label: '草稿', color: 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400' },
  PUBLISHED: { label: '已发布', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' },
};

export const ExamPaperManagementPage: React.FC = () => {
  const [papers, setPapers] = useState<ExamPaperResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [total, setTotal] = useState(0);
  const [pageNum, setPageNum] = useState(1);
  const [pageSize] = useState(20);

  // 筛选
  const [keyword, setKeyword] = useState('');
  const [filterSubject, setFilterSubject] = useState('');
  const [filterStatus, setFilterStatus] = useState('');

  // 创建/编辑弹窗
  const [showModal, setShowModal] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [form, setForm] = useState({
    title: '', subtitle: '', subject: 'MATH', grade: '', durationMin: 0, layout: '{}', templateId: '' as string,
  });

  // 模板列表
  const [templateList, setTemplateList] = useState<{id: string; name: string}[]>([]);
  const fetchTemplates = useCallback(async () => {
    try {
      const res = await api.listTemplates1();
      const list = (res.data?.data || []).map((t: any) => ({ id: String(t.id), name: t.name || '' }));
      setTemplateList(list);
    } catch { /* ignore */ }
  }, []);
  useEffect(() => { fetchTemplates(); }, [fetchTemplates]);

  // 编辑器面板
  const [editorPaperId, setEditorPaperId] = useState<number | null>(null);
  const [editorPaper, setEditorPaper] = useState<ExamPaperResponse | null>(null);
  const [sections, setSections] = useState<PaperSectionResponse[]>([]);
  const [sectionQuestions, setSectionQuestions] = useState<Record<string, PaperQuestionResponse[]>>({});
  const [questionCache, setQuestionCache] = useState<Record<string, QuestionResponse>>({});

  // 添加大题弹窗
  const [showSectionModal, setShowSectionModal] = useState(false);
  const [sectionForm, setSectionForm] = useState({ title: '', description: '', questionType: '', sortOrder: 0 });

  // 添加题目弹窗（题库选择器）
  const [showAddQuestionModal, setShowAddQuestionModal] = useState(false);
  const [addQuestionSectionId, setAddQuestionSectionId] = useState<number | null>(null);
  const [addQuestionScore, setAddQuestionScore] = useState(5);
  const [pickerKeyword, setPickerKeyword] = useState('');
  const [pickerType, setPickerType] = useState('');
  const [pickerDifficulty, setPickerDifficulty] = useState<number | undefined>(undefined);
  const [pickerQuestions, setPickerQuestions] = useState<QuestionResponse[]>([]);
  const [pickerLoading, setPickerLoading] = useState(false);
  const [pickerPage, setPickerPage] = useState(1);
  const [pickerTotal, setPickerTotal] = useState(0);
  const [selectedQuestionIds, setSelectedQuestionIds] = useState<Set<string>>(new Set());
  const [addingQuestions, setAddingQuestions] = useState(false);
  const pickerPageSize = 8;
  const pickerSearchTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  // 实时 PDF 预览
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);
  const [previewLoading, setPreviewLoading] = useState(false);
  const [previewZoom, setPreviewZoom] = useState(100);
  const previewTimerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const prevPreviewUrlRef = useRef<string | null>(null);

  // debounce 触发 PDF 预览
  const triggerPreview = useCallback((paperId: number) => {
    if (previewTimerRef.current) clearTimeout(previewTimerRef.current);
    previewTimerRef.current = setTimeout(async () => {
      setPreviewLoading(true);
      try {
        const res = await apiClient.post(
          `/api/exam-papers/${paperId}/preview`,
          null,
          { responseType: 'blob', timeout: 60000 } // 60秒超时，题目多时编译较慢
        );
        const rawBlob: Blob = res.data instanceof Blob ? res.data : new Blob([res.data], { type: 'application/pdf' });
        const head = await rawBlob.slice(0, 5).text();
        if (!head.startsWith('%PDF')) {
          // 后端可能返回了 JSON 错误信息
          const errText = await rawBlob.text();
          console.warn('预览返回非PDF内容:', errText.substring(0, 200));
          return;
        }
        const blob = new Blob([rawBlob], { type: 'application/pdf' });
        const url = URL.createObjectURL(blob);
        // 清理旧 URL
        if (prevPreviewUrlRef.current) URL.revokeObjectURL(prevPreviewUrlRef.current);
        prevPreviewUrlRef.current = url;
        setPreviewUrl(url);
      } catch (err: any) {
        console.warn('PDF预览失败:', err?.message || err);
      } finally {
        setPreviewLoading(false);
      }
    }, 800);
  }, []);

  // 编辑器面板关闭时清理预览
  useEffect(() => {
    if (!editorPaperId) {
      if (prevPreviewUrlRef.current) { URL.revokeObjectURL(prevPreviewUrlRef.current); prevPreviewUrlRef.current = null; }
      setPreviewUrl(null);
      setPreviewZoom(100);
    }
    return () => {
      if (previewTimerRef.current) clearTimeout(previewTimerRef.current);
    };
  }, [editorPaperId]);

  // 加载试卷列表
  const fetchPapers = useCallback(async () => {
    setLoading(true);
    try {
      const params: Record<string, any> = { pageNum, pageSize };
      if (keyword) params.keyword = keyword;
      if (filterSubject) params.subject = filterSubject;
      if (filterStatus) params.status = filterStatus;
      const res = await api.queryExamPapers({ request: params as any });
      const data = (res.data as any)?.data;
      if (data) {
        setPapers(data.records || []);
        setTotal(data.total || 0);
      }
    } catch (e: any) {
      toast.error('加载试卷失败');
    } finally {
      setLoading(false);
    }
  }, [pageNum, pageSize, keyword, filterSubject, filterStatus]);

  useEffect(() => { fetchPapers(); }, [fetchPapers]);

  // 创建试卷
  const handleCreate = () => {
    setEditingId(null);
    setForm({ title: '', subtitle: '', subject: 'MATH', grade: '', durationMin: 0, layout: '{}', templateId: '' });
    setShowModal(true);
  };

  const handleEdit = (p: ExamPaperResponse) => {
    setEditingId(p.id as unknown as number);
    setForm({
      title: p.title || '', subtitle: p.subtitle || '', subject: p.subject || 'MATH',
      grade: p.grade || '', durationMin: p.durationMin || 0, layout: p.layout || '{}',
      templateId: p.templateId ? String(p.templateId) : '',
    });
    setShowModal(true);
  };

  const handleSave = async () => {
    if (!form.title.trim()) { toast.error('试卷标题不能为空'); return; }
    try {
      const tplId = form.templateId ? (form.templateId as unknown as number) : undefined;
      if (editingId) {
        const req: UpdateExamPaperRequest = {
          id: editingId, title: form.title, subtitle: form.subtitle || undefined,
          subject: form.subject, grade: form.grade || undefined,
          durationMin: form.durationMin > 0 ? form.durationMin : undefined,
          layout: form.layout || undefined,
          templateId: tplId,
        };
        await api.updateExamPaper({ updateExamPaperRequest: req });
        toast.success('更新成功');
      } else {
        const req: CreateExamPaperRequest = {
          title: form.title, subtitle: form.subtitle || undefined,
          subject: form.subject, grade: form.grade || undefined,
          durationMin: form.durationMin > 0 ? form.durationMin : undefined,
          layout: form.layout || undefined,
          templateId: tplId,
        };
        await api.createExamPaper({ createExamPaperRequest: req });
        toast.success('创建成功');
      }
      setShowModal(false);
      fetchPapers();
    } catch (e: any) {
      toast.error('保存失败');
    }
  };

  const handleDelete = async (id: number) => {
    if (!confirm('确定删除此试卷？将同时删除所有大题和关联题目。')) return;
    try {
      await api.deleteExamPaper({ id });
      toast.success('删除成功');
      if (editorPaperId === id) { setEditorPaperId(null); setEditorPaper(null); }
      fetchPapers();
    } catch { toast.error('删除失败'); }
  };

  const handlePublish = async (id: number) => {
    try {
      await api.publishExamPaper({ id });
      toast.success('发布成功');
      fetchPapers();
      if (editorPaperId === id) loadEditorPaper(id);
    } catch (e: any) {
      toast.error('发布失败: ' + ((e.response?.data as any)?.message || ''));
    }
  };

  const handleUnpublish = async (id: number) => {
    try {
      await api.unpublishExamPaper({ id });
      toast.success('已撤回为草稿');
      fetchPapers();
      if (editorPaperId === id) loadEditorPaper(id);
    } catch { toast.error('撤回失败'); }
  };

  // ============ 编辑器面板 ============
  const loadEditorPaper = async (id: number) => {
    try {
      const res = await api.getExamPaper({ id });
      const paper = (res.data as any)?.data;
      setEditorPaper(paper);
      setEditorPaperId(id);
      // 加载大题
      const secRes = await api.getSections({ paperId: id });
      const secs: PaperSectionResponse[] = (secRes.data as any)?.data || [];
      setSections(secs);
      // 加载各大题下的题目
      const sqMap: Record<string, PaperQuestionResponse[]> = {};
      for (const sec of secs) {
        const pqRes = await api.getPaperQuestions({ paperId: id, sectionId: sec.id as unknown as number });
        sqMap[String(sec.id)] = (pqRes.data as any)?.data || [];
      }
      setSectionQuestions(sqMap);
      // 触发实时预览
      triggerPreview(id);
    } catch { toast.error('加载试卷详情失败'); }
  };

  // 获取题目信息缓存
  const loadQuestionInfo = async (questionId: number) => {
    const key = String(questionId);
    if (questionCache[key]) return questionCache[key];
    try {
      const res = await api.getQuestion({ id: questionId });
      const q = (res.data as any)?.data as QuestionResponse;
      if (q) setQuestionCache(prev => ({ ...prev, [key]: q }));
      return q;
    } catch { return null; }
  };

  // 添加大题
  const handleAddSection = async () => {
    if (!editorPaperId || !sectionForm.title.trim()) { toast.error('大题标题不能为空'); return; }
    try {
      await api.addSection({
        paperId: editorPaperId,
        addPaperSectionRequest: {
          title: sectionForm.title, description: sectionForm.description || undefined,
          questionType: sectionForm.questionType || undefined, sortOrder: sectionForm.sortOrder,
        }
      });
      toast.success('添加大题成功');
      setShowSectionModal(false);
      setSectionForm({ title: '', description: '', questionType: '', sortOrder: 0 });
      loadEditorPaper(editorPaperId);
    } catch { toast.error('添加大题失败'); }
  };

  const handleDeleteSection = async (sectionId: number) => {
    if (!editorPaperId || !confirm('删除大题将同时删除该题下所有关联题目')) return;
    try {
      await api.deleteSection({ paperId: editorPaperId, sectionId });
      toast.success('删除成功');
      loadEditorPaper(editorPaperId);
    } catch { toast.error('删除失败'); }
  };

  // 题库搜索（直接调用，不防抖）
  const doSearchPickerQuestions = useCallback(async (page = 1, kw?: string, type?: string, diff?: number) => {
    setPickerLoading(true);
    try {
      const res = await api.queryQuestions({
        request: {
          keyword: (kw ?? pickerKeyword) || undefined,
          type: (type ?? pickerType) || undefined,
          subject: editorPaper?.subject || undefined,
          difficulty: diff ?? pickerDifficulty,
          pageNum: page,
          pageSize: pickerPageSize,
        }
      });
      const data = (res.data as any)?.data;
      setPickerQuestions(data?.records || data?.list || []);
      setPickerTotal(data?.total || 0);
      setPickerPage(page);
    } catch {
      toast.error('搜索题目失败');
    } finally {
      setPickerLoading(false);
    }
  }, [pickerKeyword, pickerType, pickerDifficulty, editorPaper?.subject, pickerPageSize]);

  // 防抖搜索（输入框 keyup 触发）
  const debouncedSearch = useCallback(() => {
    if (pickerSearchTimerRef.current) clearTimeout(pickerSearchTimerRef.current);
    pickerSearchTimerRef.current = setTimeout(() => doSearchPickerQuestions(1), 400);
  }, [doSearchPickerQuestions]);

  // 打开题目选择器时自动搜索
  useEffect(() => {
    if (showAddQuestionModal) doSearchPickerQuestions(1);
  }, [showAddQuestionModal]);

  // 筛选条件变化自动触发搜索
  useEffect(() => {
    if (showAddQuestionModal) debouncedSearch();
  }, [pickerType, pickerDifficulty]);

  // 计算当前试卷中所有大题已包含的题目 ID 集合（用于去重）
  const existingQuestionIds = React.useMemo(() => {
    const ids = new Set<string>();
    Object.values(sectionQuestions).forEach(pqs => {
      pqs.forEach(pq => { if (pq.questionId) ids.add(String(pq.questionId)); });
    });
    return ids;
  }, [sectionQuestions]);

  // 批量添加选中题目到大题
  const handleAddQuestionToSection = async () => {
    if (!editorPaperId || !addQuestionSectionId || selectedQuestionIds.size === 0) { toast.error('请至少选择一道题目'); return; }
    if (addingQuestions) return;
    setAddingQuestions(true);
    try {
      let baseOrder = sectionQuestions[String(addQuestionSectionId)]?.length || 0;
      let successCount = 0;
      for (const qId of selectedQuestionIds) {
        try {
          await api.addQuestionToSection({
            paperId: editorPaperId,
            sectionId: addQuestionSectionId,
            addPaperQuestionRequest: {
              questionId: qId as unknown as number,
              score: addQuestionScore,
              sortOrder: baseOrder++,
            }
          });
          successCount++;
        } catch {
          // 单题失败不中断批量操作
        }
      }
      toast.success(`成功添加 ${successCount} 道题目`);
      setShowAddQuestionModal(false);
      setSelectedQuestionIds(new Set());
      setAddQuestionScore(5);
      loadEditorPaper(editorPaperId);
    } catch { toast.error('添加题目失败'); } finally {
      setAddingQuestions(false);
    }
  };

  const handleRemovePaperQuestion = async (pqId: number, sectionId: number) => {
    if (!editorPaperId || !confirm('确定移除此题目？')) return;
    try {
      await api.removePaperQuestion({ paperId: editorPaperId, sectionId, pqId });
      toast.success('移除成功');
      loadEditorPaper(editorPaperId);
    } catch { toast.error('移除失败'); }
  };

  // 预览 PDF（直接用 apiClient 请求 blob，绕过生成 API 的 Accept:application/json 头）
  const handlePreviewPdf = async (id: number) => {
    try {
      const res = await apiClient.post(`/api/exam-papers/${id}/preview`, null, { responseType: 'blob' });
      const rawBlob: Blob = res.data instanceof Blob ? res.data : new Blob([res.data], { type: 'application/pdf' });
      // 检测返回内容是否为 PDF（%PDF 魔数）
      const head = await rawBlob.slice(0, 5).text();
      if (!head.startsWith('%PDF')) {
        const text = await rawBlob.text();
        try { const err = JSON.parse(text); toast.error(err.message || 'PDF 编译失败'); } catch { toast.error('PDF 编译返回异常内容'); }
        return;
      }
      const blob = new Blob([rawBlob], { type: 'application/pdf' });
      const url = URL.createObjectURL(blob);
      window.open(url, '_blank');
    } catch {
      toast.error('PDF预览失败，请确保 typst-service 已启动');
    }
  };

  const handleExportAnswerKey = async (id: number) => {
    try {
      const res = await apiClient.post(`/api/exam-papers/${id}/export-answer-key`, null, { responseType: 'blob' });
      const rawBlob: Blob = res.data instanceof Blob ? res.data : new Blob([res.data], { type: 'application/pdf' });
      const head = await rawBlob.slice(0, 5).text();
      if (!head.startsWith('%PDF')) {
        const text = await rawBlob.text();
        try { const err = JSON.parse(text); toast.error(err.message || '导出失败'); } catch { toast.error('导出返回异常内容'); }
        return;
      }
      const blob = new Blob([rawBlob], { type: 'application/pdf' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url; a.download = 'answer_key.pdf'; a.click();
      URL.revokeObjectURL(url);
    } catch { toast.error('导出失败，请确保 typst-service 已启动'); }
  };

  const totalPages = Math.ceil(total / pageSize);
  const subjectLabel = (code: string) => getSubjectName(code);

  // 当打开编辑器面板时，加载题目详情
  useEffect(() => {
    if (!editorPaperId) return;
    // 对 sectionQuestions 中的所有 questionId 批量加载
    const ids = new Set<number>();
    Object.values(sectionQuestions).flat().forEach(pq => ids.add(pq.questionId as unknown as number));
    ids.forEach(id => loadQuestionInfo(id));
  }, [sectionQuestions]);

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {editorPaperId && editorPaper ? (
        <>
          {/* ========== 编辑视图 ========== */}
          {/* 顶栏：返回 + 标题 + 操作 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm px-6 py-4">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-4 min-w-0">
                <button
                  onClick={() => { setEditorPaperId(null); setEditorPaper(null); }}
                  className="flex items-center gap-2 px-3 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-800 rounded-xl transition-all"
                >
                  <ArrowLeft size={18} />
                  <span>返回列表</span>
                </button>
                <div className="h-6 w-px bg-gray-200 dark:bg-gray-700" />
                <h1 className="text-xl font-bold text-gray-900 dark:text-white truncate">{editorPaper.title}</h1>
                <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border shrink-0 ${editorPaper.status === 'PUBLISHED' ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' : 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700'}`}>
                  {STATUS_CONFIG[editorPaper.status || 'DRAFT']?.label}
                </span>
              </div>
              <div className="flex items-center gap-2 shrink-0">
                <span className="text-sm text-gray-500 dark:text-gray-400">
                  {editorPaper.subjectDesc} · {editorPaper.totalScore}分{editorPaper.durationMin ? ` · ${editorPaper.durationMin}分钟` : ''}
                </span>
                <div className="h-5 w-px bg-gray-200 dark:bg-gray-700 mx-1" />
                <button onClick={() => handleEdit(editorPaper)} title="编辑信息"
                  className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"><Edit2 size={16} /></button>
                {editorPaper.status === 'DRAFT' ? (
                  <button onClick={() => handlePublish(editorPaperId)} title="发布"
                    className="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"><Send size={16} /></button>
                ) : (
                  <button onClick={() => handleUnpublish(editorPaperId)} title="撤回"
                    className="p-2 text-gray-400 hover:text-orange-600 hover:bg-orange-50 dark:hover:bg-orange-900/20 rounded-lg transition-all"><Undo2 size={16} /></button>
                )}
                <button onClick={() => handlePreviewPdf(editorPaperId)} title="预览PDF"
                  className="p-2 text-gray-400 hover:text-blue-600 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded-lg transition-all"><Eye size={16} /></button>
                <button onClick={() => handleExportAnswerKey(editorPaperId)} title="导出答案"
                  className="p-2 text-gray-400 hover:text-purple-600 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-all"><Download size={16} /></button>
              </div>
            </div>
          </div>

          {/* 主体：左组卷 + 右预览 */}
          <div className="flex gap-6" style={{ height: 'calc(100vh - 14rem)' }}>
            {/* 组卷操作区 */}
            <div className="w-1/2 bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-4 overflow-y-auto space-y-3">
              {/* 大题列表 */}
              {sections.map((sec) => (
                <div key={String(sec.id)} className="border border-gray-100 dark:border-gray-700 rounded-xl overflow-hidden">
                  <div className="flex items-center justify-between px-3 py-2.5 bg-gray-50/50 dark:bg-gray-800/50">
                    <div className="flex items-center gap-2 min-w-0">
                      <GripVertical size={14} className="text-gray-400 shrink-0" />
                      <span className="font-semibold text-sm text-gray-900 dark:text-white truncate">{sec.title}</span>
                      {sec.questionTypeDesc && (
                        <span className="text-xs text-gray-500 dark:text-gray-400 shrink-0">({sec.questionTypeDesc})</span>
                      )}
                    </div>
                    <div className="flex items-center gap-1 shrink-0">
                      <button onClick={() => {
                        setAddQuestionSectionId(sec.id as unknown as number);
                        setSelectedQuestionIds(new Set());
                        setAddQuestionScore(5);
                        setPickerKeyword('');
                        setPickerType('');
                        setPickerDifficulty(undefined);
                        setShowAddQuestionModal(true);
                      }} title="添加题目" className="p-1 rounded hover:bg-gray-200 dark:hover:bg-gray-700 text-gray-500 hover:text-brand-600 transition">
                        <ListPlus size={14} />
                      </button>
                      <button onClick={() => handleDeleteSection(sec.id as unknown as number)} title="删除大题"
                        className="p-1 rounded hover:bg-red-50 dark:hover:bg-red-900/20 text-gray-500 hover:text-red-600 transition">
                        <Trash2 size={14} />
                      </button>
                    </div>
                  </div>
                  {sec.description && <p className="px-3 py-1 text-xs text-gray-500 dark:text-gray-400 italic">{sec.description}</p>}

                  {/* 题目列表 */}
                  <div className="p-2 space-y-1">
                    {(sectionQuestions[String(sec.id)] || []).length === 0 ? (
                      <p className="text-center text-xs text-gray-400 py-2">暂无题目，点击 + 添加</p>
                    ) : (sectionQuestions[String(sec.id)] || []).map((pq, qIdx) => {
                      const cachedQ = questionCache[String(pq.questionId)];
                      return (
                        <div key={String(pq.id)} className="flex items-center gap-2 px-2 py-1.5 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-800/50 group">
                          <span className="text-xs text-gray-400 w-5 shrink-0">{qIdx + 1}.</span>
                          <div className="flex-1 min-w-0">
                            <p className="text-xs text-gray-700 dark:text-gray-300 truncate">
                              {cachedQ?.content || `题目 #${pq.questionId}`}
                            </p>
                          </div>
                          <span className="text-xs font-medium text-brand-600 dark:text-brand-400 shrink-0">{pq.score}分</span>
                          <button onClick={() => handleRemovePaperQuestion(pq.id as unknown as number, sec.id as unknown as number)}
                            className="p-1 rounded hover:bg-red-50 dark:hover:bg-red-900/20 text-gray-400 hover:text-red-500 opacity-0 group-hover:opacity-100 transition">
                            <X size={12} />
                          </button>
                        </div>
                      );
                    })}
                  </div>
                </div>
              ))}

              {/* 添加大题按钮 */}
              <button onClick={() => {
                setSectionForm({ title: '', description: '', questionType: '', sortOrder: sections.length });
                setShowSectionModal(true);
              }} className="w-full py-2.5 border-2 border-dashed border-gray-200 dark:border-gray-700 rounded-xl text-sm font-medium text-gray-500 hover:text-brand-600 hover:border-brand-400 dark:hover:border-brand-600 transition-all flex items-center justify-center gap-2">
                <Plus size={14} /> 添加大题
              </button>
            </div>

            {/* 实时 PDF 预览区 */}
            <div className="w-1/2 bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm flex flex-col overflow-hidden">
              {/* 预览工具栏 */}
              <div className="flex items-center justify-between px-3 py-2 border-b border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
                <span className="text-xs font-semibold text-gray-500 dark:text-gray-400 flex items-center gap-1.5">
                  <Eye size={12} /> 实时预览
                  {previewLoading && <Loader2 size={12} className="animate-spin text-brand-500" />}
                </span>
                <div className="flex items-center gap-1">
                  <button onClick={() => setPreviewZoom(z => Math.max(50, z - 25))} title="缩小"
                    className="p-1 rounded text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 transition">
                    <ZoomOut size={14} />
                  </button>
                  <span className="text-xs text-gray-500 w-8 text-center">{previewZoom}%</span>
                  <button onClick={() => setPreviewZoom(z => Math.min(200, z + 25))} title="放大"
                    className="p-1 rounded text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 transition">
                    <ZoomIn size={14} />
                  </button>
                  <button onClick={() => editorPaperId && triggerPreview(editorPaperId)} title="刷新预览"
                    className="p-1 rounded text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition ml-1">
                    <RefreshCw size={14} className={previewLoading ? 'animate-spin' : ''} />
                  </button>
                </div>
              </div>
              {/* PDF 内容区 */}
              <div className="flex-1 bg-gray-100 dark:bg-gray-950 overflow-auto">
                {previewUrl ? (
                  <iframe
                    src={previewUrl}
                    className="w-full h-full border-0"
                    style={{ transform: `scale(${previewZoom / 100})`, transformOrigin: 'top left', width: `${10000 / previewZoom}%`, height: `${10000 / previewZoom}%` }}
                    title="试卷预览"
                  />
                ) : (
                  <div className="flex flex-col items-center justify-center h-full text-gray-400">
                    {previewLoading ? (
                      <>
                        <Loader2 size={32} className="animate-spin mb-3 text-brand-400" />
                        <p className="text-sm">正在编译试卷...</p>
                      </>
                    ) : sections.length === 0 ? (
                      <>
                        <FileText size={32} className="mb-3 opacity-50" />
                        <p className="text-sm">添加大题和题目后将显示预览</p>
                      </>
                    ) : (
                      <>
                        <FileText size={32} className="mb-3 opacity-50" />
                        <p className="text-sm">点击刷新查看预览</p>
                      </>
                    )}
                  </div>
                )}
              </div>
            </div>
          </div>
        </>
      ) : (
        <>
          {/* ========== 列表视图 ========== */}
          {/* 页头 */}
          <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div>
              <h1 className="text-2xl font-bold text-gray-900 dark:text-white">试卷管理</h1>
              <p className="text-gray-500 dark:text-gray-400 mt-1">共 {total} 份试卷，支持组卷、预览和导出 PDF</p>
            </div>
            <button onClick={handleCreate} className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">
              <Plus size={18} />
              <span>新建试卷</span>
            </button>
          </div>

          {/* 搜索筛选栏 */}
          <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
            <div className="flex flex-col lg:flex-row gap-4">
              <div className="flex-1 relative group">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
                <input type="text" placeholder="搜索试卷标题..." value={keyword}
                  onChange={e => setKeyword(e.target.value)} onKeyDown={e => e.key === 'Enter' && fetchPapers()}
                  className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all" />
              </div>
              <div className="flex flex-wrap items-center gap-3">
                <select value={filterSubject} onChange={e => { setFilterSubject(e.target.value); setPageNum(1); }}
                  className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer">
                  {SUBJECTS.map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
                </select>
                <select value={filterStatus} onChange={e => { setFilterStatus(e.target.value); setPageNum(1); }}
                  className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer">
                  <option value="">全部状态</option>
                  <option value="DRAFT">草稿</option>
                  <option value="PUBLISHED">已发布</option>
                </select>
                <button onClick={() => { setPageNum(1); fetchPapers(); }}
                  className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all">
                  <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
                </button>
              </div>
            </div>
          </div>

          {/* 试卷列表 */}
          <div className="space-y-3">
            {loading && papers.length === 0 ? (
              <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-12">
                <div className="flex flex-col items-center">
                  <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4 animate-pulse">
                    <FileText size={32} className="text-gray-300" />
                  </div>
                  <p className="text-gray-400 font-medium">加载中...</p>
                </div>
              </div>
            ) : papers.length === 0 ? (
              <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-12">
                <div className="flex flex-col items-center">
                  <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                    <FileText size={32} className="text-gray-300" />
                  </div>
                  <p className="text-gray-500 dark:text-gray-400 font-medium">暂无试卷</p>
                </div>
              </div>
            ) : papers.map(p => (
              <div key={String(p.id)}
                onClick={() => loadEditorPaper(p.id as unknown as number)}
                className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-5 cursor-pointer shadow-sm hover:shadow-md transition-all duration-300 group hover:border-brand-300 dark:hover:border-brand-700">
                <div className="flex items-start justify-between gap-3">
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 mb-1.5">
                      <h3 className="font-bold text-gray-900 dark:text-white truncate group-hover:text-brand-600 transition-colors">{p.title}</h3>
                      <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${p.status === 'PUBLISHED' ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' : 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700'}`}>
                        {STATUS_CONFIG[p.status || 'DRAFT']?.label}
                      </span>
                    </div>
                    <div className="flex flex-wrap items-center gap-3 text-xs text-gray-500 dark:text-gray-400">
                      <span className="flex items-center gap-1"><BookOpen size={12} /> {p.subjectDesc || subjectLabel(p.subject || '')}</span>
                      <span className="flex items-center gap-1"><FileText size={12} /> {p.totalScore || 0}分</span>
                      {p.durationMin && <span className="flex items-center gap-1"><Clock size={12} /> {p.durationMin}分钟</span>}
                    </div>
                  </div>
                  <div className="flex items-center gap-1 shrink-0 opacity-0 group-hover:opacity-100 transition-opacity" onClick={e => e.stopPropagation()}>
                    {p.status === 'DRAFT' ? (
                      <button onClick={() => handlePublish(p.id as unknown as number)} title="发布" className="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"><Send size={16} /></button>
                    ) : (
                      <button onClick={() => handleUnpublish(p.id as unknown as number)} title="撤回" className="p-2 text-gray-400 hover:text-orange-600 hover:bg-orange-50 dark:hover:bg-orange-900/20 rounded-lg transition-all"><Undo2 size={16} /></button>
                    )}
                    <button onClick={() => handlePreviewPdf(p.id as unknown as number)} title="预览PDF" className="p-2 text-gray-400 hover:text-blue-600 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded-lg transition-all"><Eye size={16} /></button>
                    <button onClick={() => handleExportAnswerKey(p.id as unknown as number)} title="导出答案" className="p-2 text-gray-400 hover:text-purple-600 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-all"><Download size={16} /></button>
                    <button onClick={() => handleEdit(p)} title="编辑" className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"><Edit2 size={16} /></button>
                    <button onClick={() => handleDelete(p.id as unknown as number)} title="删除" className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"><Trash2 size={16} /></button>
                  </div>
                </div>
              </div>
            ))}

            {/* 分页 */}
            {totalPages > 0 && (
              <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm px-6 py-4 flex items-center justify-between transition-colors duration-300">
                <p className="text-sm text-gray-500 dark:text-gray-400">
                  共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 份试卷
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
        </>
      )}

      {/* ===== 创建/编辑试卷弹窗 ===== */}
      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={() => setShowModal(false)} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 animate-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">{editingId ? '编辑试卷' : '新建试卷'}</h3>
              <button onClick={() => setShowModal(false)} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
            </div>
            <div className="p-6 space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">标题 *</label>
                <input type="text" value={form.title} onChange={e => setForm(f => ({ ...f, title: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all" placeholder="如：2024年高三数学期末考试" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">副标题</label>
                <input type="text" value={form.subtitle} onChange={e => setForm(f => ({ ...f, subtitle: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all" placeholder="如：(考试时间120分钟 满分150分)" />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">学科 *</label>
                  <select value={form.subject} onChange={e => setForm(f => ({ ...f, subject: e.target.value }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                    {SUBJECTS.filter(s => s.value).map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">时长(分钟)</label>
                  <input type="number" value={form.durationMin || ''} onChange={e => setForm(f => ({ ...f, durationMin: Number(e.target.value) }))}
                    className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all" placeholder="120" />
                </div>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">排版模板</label>
                <select value={form.templateId} onChange={e => setForm(f => ({ ...f, templateId: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                  <option value="">系统默认模板</option>
                  {templateList.map(t => <option key={String(t.id)} value={String(t.id)}>{t.name}</option>)}
                </select>
              </div>
            </div>
            <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
              <button onClick={() => setShowModal(false)} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
              <button onClick={handleSave} className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">保存</button>
            </div>
          </div>
        </div>
      )}

      {/* ===== 添加大题弹窗 ===== */}
      {showSectionModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={() => setShowSectionModal(false)} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 animate-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">添加大题</h3>
              <button onClick={() => setShowSectionModal(false)} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
            </div>
            <div className="p-6 space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">标题 *</label>
                <input type="text" value={sectionForm.title} onChange={e => setSectionForm(f => ({ ...f, title: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all" placeholder='如：一、选择题' />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">描述</label>
                <input type="text" value={sectionForm.description} onChange={e => setSectionForm(f => ({ ...f, description: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all" placeholder='如：每小题5分，共60分' />
              </div>
            </div>
            <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
              <button onClick={() => setShowSectionModal(false)} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
              <button onClick={handleAddSection} className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">添加</button>
            </div>
          </div>
        </div>
      )}

      {/* ===== 添加题目弹窗（题库选择器） ===== */}
      {showAddQuestionModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={() => setShowAddQuestionModal(false)} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 animate-in zoom-in-95 duration-200 flex flex-col max-h-[85vh]">
            {/* 头部 */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800 shrink-0">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">从题库选择题目</h3>
              <button onClick={() => setShowAddQuestionModal(false)} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"><X size={20} /></button>
            </div>

            {/* 搜索与筛选 */}
            <div className="px-6 py-3 border-b border-gray-100 dark:border-gray-800 shrink-0 space-y-2">
              <div className="flex gap-2">
                <div className="flex-1 relative">
                  <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
                  <input type="text" value={pickerKeyword} onChange={e => { setPickerKeyword(e.target.value); debouncedSearch(); }}
                    onKeyDown={e => e.key === 'Enter' && doSearchPickerQuestions(1)}
                    className="w-full pl-9 pr-4 py-2 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    placeholder="搜索题目内容..." />
                </div>
                <button onClick={() => doSearchPickerQuestions(1)}
                  className="px-3 py-2 bg-brand-600 text-white text-sm font-medium rounded-lg hover:bg-brand-700 transition-all active:scale-95 shrink-0">
                  搜索
                </button>
              </div>
              <div className="flex gap-2">
                <select value={pickerType} onChange={e => { setPickerType(e.target.value); }}
                  className="px-3 py-1.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-xs text-gray-700 dark:text-gray-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 cursor-pointer">
                  <option value="">全部题型</option>
                  {QUESTION_TYPE_OPTIONS.map(t => <option key={t.value} value={t.value}>{t.label}</option>)}
                </select>
                <select value={pickerDifficulty ?? ''} onChange={e => setPickerDifficulty(e.target.value ? Number(e.target.value) : undefined)}
                  className="px-3 py-1.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-lg text-xs text-gray-700 dark:text-gray-300 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 cursor-pointer">
                  <option value="">全部难度</option>
                  <option value="1">★ 简单</option>
                  <option value="2">★★ 较易</option>
                  <option value="3">★★★ 中等</option>
                  <option value="4">★★★★ 较难</option>
                  <option value="5">★★★★★ 困难</option>
                </select>
              </div>
            </div>

            {/* 题目列表 */}
            <div className="flex-1 overflow-y-auto px-6 py-3 min-h-0">
              {pickerLoading ? (
                <div className="flex items-center justify-center py-12">
                  <Loader2 size={24} className="animate-spin text-brand-500" />
                  <span className="ml-2 text-sm text-gray-500">加载中...</span>
                </div>
              ) : pickerQuestions.length === 0 ? (
                <div className="flex flex-col items-center justify-center py-12 text-gray-400">
                  <BookOpen size={32} className="mb-3 opacity-50" />
                  <p className="text-sm">暂无题目，请调整搜索条件</p>
                </div>
              ) : (
                <div className="space-y-2">
                  {pickerQuestions.map((q) => {
                    const qId = String(q.id);
                    const isExisting = existingQuestionIds.has(qId);
                    const isSelected = selectedQuestionIds.has(qId);
                    const toggleSelect = () => {
                      if (isExisting) return;
                      setSelectedQuestionIds(prev => {
                        const next = new Set(prev);
                        if (next.has(qId)) next.delete(qId); else next.add(qId);
                        return next;
                      });
                    };
                    return (
                      <div key={qId} onClick={toggleSelect}
                        className={`p-3 rounded-xl border-2 transition-all ${
                          isExisting
                            ? 'border-gray-100 dark:border-gray-800 bg-gray-50 dark:bg-gray-800/30 opacity-60 cursor-not-allowed'
                            : isSelected
                              ? 'border-brand-500 bg-brand-50/50 dark:bg-brand-900/20 ring-1 ring-brand-500/30 cursor-pointer'
                              : 'border-gray-100 dark:border-gray-800 hover:border-gray-300 dark:hover:border-gray-600 hover:bg-gray-50 dark:hover:bg-gray-800/50 cursor-pointer'
                        }`}>
                        <div className="flex items-start gap-3">
                          <div className={`w-5 h-5 rounded border-2 flex items-center justify-center shrink-0 mt-0.5 transition-all ${
                            isExisting ? 'border-gray-300 dark:border-gray-600 bg-gray-200 dark:bg-gray-700'
                            : isSelected ? 'border-brand-500 bg-brand-500' : 'border-gray-300 dark:border-gray-600'
                          }`}>
                            {isExisting && <span className="text-[10px] text-gray-500">✓</span>}
                            {!isExisting && isSelected && <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}><path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" /></svg>}
                          </div>
                          <div className="flex-1 min-w-0">
                            <div className="flex items-center gap-2 mb-1 flex-wrap">
                              {isExisting && (
                                <span className="px-1.5 py-0.5 text-[10px] font-bold rounded bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400">已添加</span>
                              )}
                              {q.typeDesc && (
                                <span className="px-1.5 py-0.5 text-[10px] font-bold rounded bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400">{q.typeDesc}</span>
                              )}
                              {q.difficultyDesc && (
                                <span className="px-1.5 py-0.5 text-[10px] font-bold rounded bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400">{q.difficultyDesc}</span>
                              )}
                              {q.subjectDesc && (
                                <span className="px-1.5 py-0.5 text-[10px] font-bold rounded bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400">{q.subjectDesc}</span>
                              )}
                            </div>
                            <p className="text-sm text-gray-700 dark:text-gray-300 line-clamp-2">{q.content || '(无题干内容)'}</p>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>

            {/* 分页 */}
            {pickerTotal > pickerPageSize && (
              <div className="flex items-center justify-center gap-2 px-6 py-2 border-t border-gray-100 dark:border-gray-800 shrink-0">
                <button onClick={() => doSearchPickerQuestions(pickerPage - 1)} disabled={pickerPage <= 1}
                  className="p-1.5 rounded-lg text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 disabled:opacity-30 transition">
                  <ChevronLeft size={16} />
                </button>
                <span className="text-xs text-gray-500 dark:text-gray-400">{pickerPage} / {Math.ceil(pickerTotal / pickerPageSize)}</span>
                <button onClick={() => doSearchPickerQuestions(pickerPage + 1)} disabled={pickerPage >= Math.ceil(pickerTotal / pickerPageSize)}
                  className="p-1.5 rounded-lg text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 disabled:opacity-30 transition">
                  <ChevronRight size={16} />
                </button>
              </div>
            )}

            {/* 底部：分值 + 确认 */}
            <div className="flex items-center justify-between gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50 shrink-0">
              <div className="flex items-center gap-2">
                <label className="text-sm font-medium text-gray-700 dark:text-gray-300">分值</label>
                <input type="number" min={1} value={addQuestionScore} onChange={e => setAddQuestionScore(Number(e.target.value) || 1)}
                  className="w-20 px-3 py-1.5 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-lg text-sm text-gray-900 dark:text-white text-center focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all" />
                <span className="text-xs text-gray-400">分</span>
              </div>
              <div className="flex items-center gap-3">
                <button onClick={() => setShowAddQuestionModal(false)} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
                <button onClick={handleAddQuestionToSection} disabled={selectedQuestionIds.size === 0 || addingQuestions}
                  className="flex items-center gap-2 px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed">
                  {addingQuestions && <Loader2 size={14} className="animate-spin" />}
                  {addingQuestions ? '添加中...' : selectedQuestionIds.size > 0 ? `添加选中 (${selectedQuestionIds.size})` : '添加选中题目'}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ExamPaperManagementPage;
