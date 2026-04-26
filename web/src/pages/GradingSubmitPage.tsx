import React, { useState, useRef, useCallback, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, X, Image, Loader2, CheckCircle, AlertCircle, BookOpen, FileText, Sparkles, ChevronDown, Search, Clock, XCircle, ChevronRight, BarChart3 } from 'lucide-react';
import { apiClient, authFetch, DefaultApi, Configuration } from '../api';
import toast from '../components/ui/Toast';
import { SUBJECT_OPTIONS, getSubjectName } from '../constants/exam';
import GradingMarkdown from '../components/grading/GradingMarkdown';

const api = new DefaultApi(new Configuration(), '', apiClient);

const isHeic = (file: File) =>
  file.type === 'image/heic' || file.type === 'image/heif' ||
  /\.heic$/i.test(file.name) || /\.heif$/i.test(file.name);

const convertHeicToJpeg = (file: File): Promise<File> => {
  if (!isHeic(file)) return Promise.resolve(file);
  return new Promise((resolve) => {
    const img = new window.Image();
    img.onload = () => {
      const canvas = document.createElement('canvas');
      canvas.width = img.naturalWidth;
      canvas.height = img.naturalHeight;
      const ctx = canvas.getContext('2d');
      if (!ctx) { resolve(file); return; }
      ctx.drawImage(img, 0, 0);
      canvas.toBlob(
        (blob) => {
          URL.revokeObjectURL(img.src);
          if (!blob) { resolve(file); return; }
          const name = file.name.replace(/\.heic$/i, '.jpg').replace(/\.heif$/i, '.jpg');
          resolve(new File([blob], name, { type: 'image/jpeg' }));
        },
        'image/jpeg',
        0.92,
      );
    };
    img.onerror = () => { URL.revokeObjectURL(img.src); resolve(file); };
    img.src = URL.createObjectURL(file);
  });
};

const GRADES = [
  '一年级', '二年级', '三年级', '四年级', '五年级', '六年级',
  '初一', '初二', '初三', '高一', '高二', '高三',
];

interface UploadedImage {
  file: File;
  preview: string;
  url: string;
  uploading: boolean;
  error: string;
}

interface GradingProgress {
  step: string;
  message: string;
  questionCount?: number;
  currentIndex?: number;
  totalQuestions?: number;
  questionResults: QuestionResult[];
  done: boolean;
  error: string;
  submissionId: string;
  totalScore?: number;
  maxScore?: number;
  overallComment?: string;
}

interface QuestionResult {
  index: number;
  questionContent?: string;
  studentAnswer?: string;
  standardAnswer?: string;
  score: number;
  maxScore: number;
  comment: string;
  errorCategories: string[];
  knowledgePoints: string[];
}

type GradingMode = 'GENERAL' | 'EXAM_PAPER';

const STATUS_NAMES: Record<string, { label: string; color: string }> = {
  PENDING: { label: '等待中', color: 'text-gray-500 bg-gray-100 dark:bg-gray-800' },
  OCR_PROCESSING: { label: '识别中', color: 'text-blue-500 bg-blue-50 dark:bg-blue-900/20' },
  GRADING: { label: '批改中', color: 'text-yellow-500 bg-yellow-50 dark:bg-yellow-900/20' },
  COMPLETED: { label: '已完成', color: 'text-green-500 bg-green-50 dark:bg-green-900/20' },
  FAILED: { label: '失败', color: 'text-red-500 bg-red-50 dark:bg-red-900/20' },
};

interface HistoryItem {
  submissionId?: string;
  gradingMode?: string;
  title?: string;
  subject?: string;
  status?: string;
  totalScore?: number;
  maxScore?: number;
  createTime?: string;
}

interface PaperItem {
  id: string;
  title: string;
  subtitle?: string;
  subject?: string;
  subjectName?: string;
  grade?: string;
  totalScore?: number;
  durationMin?: number;
}

const GradingSubmitPage: React.FC = () => {
  const navigate = useNavigate();
  const fileInputRef = useRef<HTMLInputElement>(null);

  // 表单状态
  const [mode, setMode] = useState<GradingMode>('GENERAL');
  const [title, setTitle] = useState('');
  const [subject, setSubject] = useState('');
  const [grade, setGrade] = useState('');
  const [images, setImages] = useState<UploadedImage[]>([]);

  // 试卷选择状态
  const [selectedPaperId, setSelectedPaperId] = useState<string>('');
  const [selectedPaperTitle, setSelectedPaperTitle] = useState('');
  const [papers, setPapers] = useState<PaperItem[]>([]);
  const [papersLoading, setPapersLoading] = useState(false);
  const [paperKeyword, setPaperKeyword] = useState('');
  const [paperSubjectFilter, setPaperSubjectFilter] = useState('');

  // 历史记录状态
  const [historyList, setHistoryList] = useState<HistoryItem[]>([]);
  const [historyLoading, setHistoryLoading] = useState(false);

  // 批改进度
  const [submitting, setSubmitting] = useState(false);
  const [progress, setProgress] = useState<GradingProgress | null>(null);

  // 加载历史记录
  useEffect(() => {
    loadHistory();
  }, []);

  // 试卷模式时加载试卷列表
  useEffect(() => {
    if (mode === 'EXAM_PAPER') {
      loadPapers();
    }
  }, [mode, paperKeyword, paperSubjectFilter]);

  const loadHistory = async () => {
    setHistoryLoading(true);
    try {
      const res = await api.getHistory({ page: 1, size: 5 });
      if (res.data?.code === 0 && Array.isArray(res.data?.data)) {
        setHistoryList(res.data.data as HistoryItem[]);
      }
    } catch { /* ignore */ } finally {
      setHistoryLoading(false);
    }
  };

  const loadPapers = async () => {
    setPapersLoading(true);
    try {
      const res = await api.getPublishedPapers({
        keyword: paperKeyword || undefined,
        subject: paperSubjectFilter || undefined,
        page: 1, size: 50,
      });
      const data = (res.data as any)?.data;
      if (data?.records) {
        setPapers(data.records as PaperItem[]);
      }
    } catch { /* ignore */ } finally {
      setPapersLoading(false);
    }
  };

  const selectPaper = (paper: PaperItem) => {
    setSelectedPaperId(paper.id);
    setSelectedPaperTitle(paper.title);
    if (paper.subject) setSubject(paper.subject);
    if (paper.grade) setGrade(paper.grade);
    setTitle(paper.title);
  };

  const clearSelectedPaper = () => {
    setSelectedPaperId('');
    setSelectedPaperTitle('');
  };

  // 多图上传
  const handleFilesSelect = useCallback(async (files: FileList | File[]) => {
    const fileArray = Array.from(files).filter(f => f.type.startsWith('image/'));
    if (fileArray.length === 0) {
      toast.warning('请选择图片文件');
      return;
    }
    if (images.length + fileArray.length > 10) {
      toast.warning('最多上传10张图片');
      return;
    }

    const newImages: UploadedImage[] = fileArray.map(file => ({
      file,
      preview: URL.createObjectURL(file),
      url: '',
      uploading: true,
      error: '',
    }));

    setImages(prev => [...prev, ...newImages]);

    // 逐个上传
    for (let i = 0; i < newImages.length; i++) {
      const img = newImages[i];
      const formData = new FormData();
      const fileToUpload = await convertHeicToJpeg(img.file);
      formData.append('file', fileToUpload);

      try {
        const res = await apiClient.post('/api/file/upload/grading/homework', formData, {
          headers: { 'Content-Type': undefined as any },
        });
        if ((res.data?.code === 0 || res.data?.code === 200) && res.data?.data?.fileUrl) {
          setImages(prev => prev.map(p =>
            p.preview === img.preview ? { ...p, url: res.data.data.fileUrl, uploading: false } : p
          ));
        } else {
          setImages(prev => prev.map(p =>
            p.preview === img.preview ? { ...p, uploading: false, error: '上传失败' } : p
          ));
        }
      } catch {
        setImages(prev => prev.map(p =>
          p.preview === img.preview ? { ...p, uploading: false, error: '上传失败' } : p
        ));
      }
    }
  }, [images.length]);

  const removeImage = (preview: string) => {
    setImages(prev => {
      const removed = prev.filter(p => p.preview !== preview);
      URL.revokeObjectURL(preview);
      return removed;
    });
  };

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    if (e.dataTransfer.files?.length) {
      handleFilesSelect(e.dataTransfer.files);
    }
  }, [handleFilesSelect]);

  // SSE 提交批改
  const handleSubmit = async () => {
    const uploadedUrls = images.filter(i => i.url && !i.uploading).map(i => i.url);
    if (uploadedUrls.length === 0) {
      toast.warning('请先上传作业图片');
      return;
    }
    if (mode === 'EXAM_PAPER' && !selectedPaperId) {
      toast.warning('请选择试卷');
      return;
    }

    setSubmitting(true);
    setProgress({
      step: 'connecting', message: '正在连接批改服务...', questionResults: [],
      done: false, error: '', submissionId: '',
    });

    try {
      const baseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';

      const body = JSON.stringify({
        gradingMode: mode,
        title: title.trim() || undefined,
        subject: subject || undefined,
        grade: grade || undefined,
        imageUrls: uploadedUrls,
        ...(mode === 'EXAM_PAPER' && selectedPaperId ? { examPaperId: selectedPaperId as unknown as number } : {}),
      });

      const response = await authFetch(`${baseUrl}/api/grading/submit`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body,
      });

      if (!response.ok) {
        const errText = await response.text();
        let errMsg = '提交失败';
        try { errMsg = JSON.parse(errText)?.message || errMsg; } catch {}
        throw new Error(errMsg);
      }

      const contentType = response.headers.get('content-type') || '';
      if (!contentType.includes('text/event-stream')) {
        const text = await response.text();
        let errMsg = '提交失败';
        try {
          const parsed = JSON.parse(text);
          errMsg = parsed?.message || parsed?.data?.message || errMsg;
        } catch {}
        throw new Error(errMsg);
      }

      const reader = response.body?.getReader();
      if (!reader) throw new Error('无法读取响应流');

      const decoder = new TextDecoder();
      let buffer = '';

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        const blocks = buffer.split(/\r?\n\r?\n/);
        buffer = blocks.pop() || '';

        for (const block of blocks) {
          handleSseBlock(block);
        }
      }

      if (buffer.trim()) {
        handleSseBlock(buffer);
      }
    } catch (err: any) {
      setProgress(prev => prev ? { ...prev, error: err?.message || '批改失败', done: true } : null);
      toast.error(err?.message || '批改失败');
    } finally {
      setSubmitting(false);
    }
  };

  const handleSseBlock = (block: string) => {
    let eventName = 'message';
    const dataLines: string[] = [];

    for (const rawLine of block.split(/\r?\n/)) {
      const line = rawLine.trimEnd();
      if (line.startsWith('event:')) {
        eventName = line.slice(6).trim();
      } else if (line.startsWith('data:')) {
        dataLines.push(line.slice(5).trimStart());
      }
    }

    if (dataLines.length === 0) return;
    try {
      handleSseEvent(eventName, JSON.parse(dataLines.join('\n')));
    } catch {}
  };

  const handleSseEvent = (eventName: string, data: any) => {
    if (eventName === 'progress' && data.step === 'ocr') {
      setProgress(prev => prev ? { ...prev, step: 'ocr', message: data.message || '正在识别...' } : prev);
    } else if (eventName === 'progress' && data.step === 'ocr_done') {
      setProgress(prev => prev ? {
        ...prev, step: 'ocr_done',
        message: data.message || '识别完成',
        questionCount: data.questionCount,
      } : prev);
    } else if (eventName === 'grading') {
      setProgress(prev => prev ? {
        ...prev, step: 'grading',
        message: data.message,
        currentIndex: data.index,
        totalQuestions: data.total,
      } : prev);
    } else if (eventName === 'question_graded') {
      setProgress(prev => {
        if (!prev) return prev;
        const qr: QuestionResult = {
          index: data.index,
          questionContent: data.questionContent || '',
          studentAnswer: data.studentAnswer || '',
          standardAnswer: data.standardAnswer || '',
          score: data.score,
          maxScore: data.maxScore || 0,
          comment: data.comment || '',
          errorCategories: data.errorCategories || [],
          knowledgePoints: data.knowledgePoints || [],
        };
        return { ...prev, questionResults: [...prev.questionResults, qr] };
      });
    } else if (eventName === 'done') {
      setProgress(prev => prev ? {
        ...prev, done: true, step: 'done',
        message: '批改完成',
        submissionId: String(data.submissionId),
        totalScore: data.totalScore,
        maxScore: data.maxScore,
        overallComment: data.overallComment,
      } : prev);
    } else if (eventName === 'error') {
      setProgress(prev => prev ? { ...prev, error: data.message, done: true } : prev);
    }
  };

  const uploadedCount = images.filter(i => i.url && !i.uploading).length;
  const hasUploadingImages = images.some(i => i.uploading);
  const needsPaperSelection = mode === 'EXAM_PAPER' && !selectedPaperId;
  const canSubmit = uploadedCount > 0 && !hasUploadingImages && !submitting && !needsPaperSelection;

  return (
    <div className="max-w-5xl mx-auto space-y-8">
      {/* 页头 */}
      <div className="flex items-center gap-4">
        <button onClick={() => navigate(-1)}
          className="p-2.5 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-800 transition-all active:scale-95 group">
          <ArrowLeft size={20} className="text-gray-500 group-hover:text-brand-500 transition-colors" />
        </button>
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white tracking-tight">智能批改</h1>
          <p className="text-sm text-gray-500 dark:text-gray-400">上传作业图片，AI 为你精准批改并提供改进建议</p>
        </div>
      </div>

      {/* 批改进度面板（提交后显示） */}
      {progress && (
        <GradingProgressPanel progress={progress} onViewResult={() => {
          if (progress.submissionId) navigate(`/grading/${progress.submissionId}`);
        }} />
      )}

      {/* 表单（未提交时显示） */}
      {!progress && (
        <>
          {/* 模式选择 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm">
            <div className="flex items-center gap-2 mb-4">
              <div className="w-1.5 h-4 bg-brand-500 rounded-full" />
              <h2 className="text-base font-semibold text-gray-900 dark:text-white">选择批改模式</h2>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <ModeCard
                active={mode === 'GENERAL'}
                onClick={() => setMode('GENERAL')}
                icon={<Sparkles size={24} />}
                title="通用作业助手"
                desc="上传任意作业图片，AI 自动识别学科并批改"
              />
              <ModeCard
                active={mode === 'EXAM_PAPER'}
                onClick={() => setMode('EXAM_PAPER')}
                icon={<FileText size={24} />}
                title="试卷批改"
                desc="关联平台试卷，对照标准答案精准批改"
              />
            </div>
          </div>

          {/* 试卷选择器（试卷批改模式） */}
          {mode === 'EXAM_PAPER' && (
            <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm space-y-4">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <div className="w-1.5 h-4 bg-brand-500 rounded-full" />
                  <h2 className="text-base font-semibold text-gray-900 dark:text-white">选择试卷</h2>
                </div>
                {selectedPaperTitle && (
                  <button onClick={clearSelectedPaper}
                    className="flex items-center gap-1 text-xs text-gray-400 hover:text-red-500 transition-colors">
                    <XCircle size={14} /> 清除选择
                  </button>
                )}
              </div>

              {selectedPaperTitle ? (
                <div className="flex items-center gap-3 p-4 rounded-xl bg-brand-50/50 dark:bg-brand-900/10 border border-brand-100 dark:border-brand-800/30">
                  <FileText size={20} className="text-brand-500 flex-shrink-0" />
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-bold text-gray-900 dark:text-white truncate">{selectedPaperTitle}</p>
                    <p className="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                      {getSubjectName(subject)} {grade || ''}
                    </p>
                  </div>
                  <CheckCircle size={18} className="text-brand-500 flex-shrink-0" />
                </div>
              ) : (
                <>
                  <div className="flex gap-3">
                    <div className="relative flex-1">
                      <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
                      <input type="text" value={paperKeyword} onChange={e => setPaperKeyword(e.target.value)}
                        placeholder="搜索试卷..."
                        className="w-full pl-9 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/40 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-4 focus:ring-brand-500/10 focus:border-brand-500 transition-all" />
                    </div>
                    <div className="relative">
                      <select value={paperSubjectFilter} onChange={e => setPaperSubjectFilter(e.target.value)}
                        className="h-full px-3 py-2.5 bg-gray-50 dark:bg-gray-800/40 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white appearance-none pr-8 focus:outline-none focus:ring-4 focus:ring-brand-500/10 focus:border-brand-500 transition-all cursor-pointer">
                        <option value="" className="dark:bg-gray-900">全部学科</option>
                        {SUBJECT_OPTIONS.map(s => <option key={s.value} value={s.value} className="dark:bg-gray-900">{s.label}</option>)}
                      </select>
                      <ChevronDown size={14} className="absolute right-2.5 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" />
                    </div>
                  </div>

                  <div className="max-h-64 overflow-y-auto space-y-2 pr-1 custom-scrollbar">
                    {papersLoading ? (
                      <div className="flex items-center justify-center py-8">
                        <Loader2 size={20} className="text-brand-500 animate-spin" />
                      </div>
                    ) : papers.length === 0 ? (
                      <div className="text-center py-8 text-gray-400 text-sm">暂无已发布的试卷</div>
                    ) : papers.map(paper => (
                      <button key={paper.id} onClick={() => selectPaper(paper)}
                        className="w-full text-left flex items-center gap-4 px-4 py-3 rounded-xl border border-gray-100 dark:border-gray-800 hover:border-brand-200 dark:hover:border-brand-800/50 hover:bg-brand-50/30 dark:hover:bg-brand-900/10 transition-all group">
                        <div className="p-2 rounded-lg bg-gray-50 dark:bg-gray-800 group-hover:bg-brand-50 dark:group-hover:bg-brand-900/20 transition-colors">
                          <FileText size={18} className="text-gray-400 group-hover:text-brand-500 transition-colors" />
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-semibold text-gray-900 dark:text-white truncate">{paper.title}</p>
                          <div className="flex items-center gap-2 mt-0.5">
                            {paper.subjectName && <span className="text-[10px] px-1.5 py-0.5 bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 rounded font-bold">{paper.subjectName}</span>}
                            {paper.grade && <span className="text-[10px] text-gray-400">{paper.grade}</span>}
                            {paper.totalScore != null && <span className="text-[10px] text-gray-400">{paper.totalScore}分</span>}
                            {paper.durationMin != null && paper.durationMin > 0 && <span className="text-[10px] text-gray-400">{paper.durationMin}分钟</span>}
                          </div>
                        </div>
                        <ChevronRight size={16} className="text-gray-300 group-hover:text-brand-400 transition-colors flex-shrink-0" />
                      </button>
                    ))}
                  </div>
                </>
              )}
            </div>
          )}

          {/* 历史批改记录 */}
          {historyList.length > 0 && (
            <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm space-y-4">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <div className="w-1.5 h-4 bg-brand-500 rounded-full" />
                  <h2 className="text-base font-semibold text-gray-900 dark:text-white">最近批改</h2>
                </div>
                <button onClick={() => navigate('/grading-dashboard')}
                  className="flex items-center gap-1 text-xs font-bold text-brand-500 hover:text-brand-600 transition-colors">
                  <BarChart3 size={14} /> 学习画像
                </button>
              </div>
              {historyLoading ? (
                <div className="flex items-center justify-center py-4">
                  <Loader2 size={18} className="text-brand-500 animate-spin" />
                </div>
              ) : (
                <div className="space-y-2">
                  {historyList.map(item => {
                    const st = STATUS_NAMES[item.status ?? ''] || STATUS_NAMES.PENDING;
                    const hasScore = item.totalScore != null && item.maxScore != null && item.maxScore > 0;
                    const scoreRate = hasScore ? (item.totalScore! / item.maxScore!) : 0;
                    return (
                      <button key={item.submissionId}
                        onClick={() => item.status === 'COMPLETED' && item.submissionId ? navigate(`/grading/${item.submissionId}`) : undefined}
                        className={`w-full text-left flex items-center gap-4 px-4 py-3 rounded-xl border border-gray-100 dark:border-gray-800 transition-all group ${
                          item.status === 'COMPLETED' ? 'hover:border-brand-200 dark:hover:border-brand-800/50 hover:bg-brand-50/30 dark:hover:bg-brand-900/10 cursor-pointer' : 'opacity-70'
                        }`}>
                        <div className={`p-2 rounded-lg flex-shrink-0 ${
                          item.status === 'COMPLETED' ? 'bg-green-50 dark:bg-green-900/20' :
                          item.status === 'FAILED' ? 'bg-red-50 dark:bg-red-900/20' :
                          'bg-gray-50 dark:bg-gray-800'
                        }`}>
                          {item.status === 'COMPLETED' ? <CheckCircle size={18} className="text-green-500" /> :
                           item.status === 'FAILED' ? <XCircle size={18} className="text-red-500" /> :
                           <Clock size={18} className="text-gray-400" />}
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-semibold text-gray-900 dark:text-white truncate">
                            {item.title || (item.gradingMode === 'EXAM_PAPER' ? '试卷批改' : '通用作业批改')}
                          </p>
                          <div className="flex items-center gap-2 mt-0.5">
                            {item.subject && <span className="text-[10px] px-1.5 py-0.5 bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 rounded font-bold">{getSubjectName(item.subject)}</span>}
                            <span className={`text-[10px] px-1.5 py-0.5 rounded font-bold ${st.color}`}>{st.label}</span>
                            {item.createTime && <span className="text-[10px] text-gray-400">{new Date(item.createTime).toLocaleDateString('zh-CN', { month: 'numeric', day: 'numeric', hour: '2-digit', minute: '2-digit' })}</span>}
                          </div>
                        </div>
                        {hasScore && (
                          <div className="text-right flex-shrink-0">
                            <div className={`text-sm font-black tabular-nums ${
                              scoreRate >= 0.8 ? 'text-green-500' : scoreRate >= 0.6 ? 'text-yellow-500' : 'text-red-500'
                            }`}>
                              {item.totalScore}<span className="text-[10px] font-normal text-gray-400">/{item.maxScore}</span>
                            </div>
                          </div>
                        )}
                        {item.status === 'COMPLETED' && (
                          <ChevronRight size={16} className="text-gray-300 group-hover:text-brand-400 transition-colors flex-shrink-0" />
                        )}
                      </button>
                    );
                  })}
                </div>
              )}
            </div>
          )}

          {/* 作业信息 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm space-y-6">
            <div className="flex items-center gap-2">
              <div className="w-1.5 h-4 bg-brand-500 rounded-full" />
              <h2 className="text-base font-semibold text-gray-900 dark:text-white">作业信息</h2>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
              {/* 标题 */}
              <div className="sm:col-span-2">
                <label className="block text-xs font-bold text-gray-400 dark:text-gray-500 uppercase tracking-wider mb-2 ml-1">
                  作业标题 <span className="font-normal opacity-60">(可选)</span>
                </label>
                <input type="text" value={title} onChange={e => setTitle(e.target.value)}
                  placeholder={mode === 'GENERAL' ? '如：人教版三年级数学第五章练习' : '如：期中考试数学试卷'}
                  className="w-full px-4 py-3 bg-gray-50 dark:bg-gray-800/40 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-4 focus:ring-brand-500/10 focus:border-brand-500 transition-all" />
              </div>

              {/* 学科 */}
              <div className="relative">
                <label className="block text-xs font-bold text-gray-400 dark:text-gray-500 uppercase tracking-wider mb-2 ml-1">
                  学科 {mode === 'GENERAL' && <span className="font-normal opacity-60">(AI 自动推断)</span>}
                </label>
                <div className="relative group">
                  <select value={subject} onChange={e => setSubject(e.target.value)}
                    className="w-full px-4 py-3 bg-gray-50 dark:bg-gray-800/40 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white appearance-none focus:outline-none focus:ring-4 focus:ring-brand-500/10 focus:border-brand-500 transition-all cursor-pointer">
                    <option value="" className="dark:bg-gray-900">自动识别（AI推断）</option>
                    {SUBJECT_OPTIONS.map(s => <option key={s.value} value={s.value} className="dark:bg-gray-900">{s.label}</option>)}
                  </select>
                  <ChevronDown size={16} className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none group-hover:text-brand-500 transition-colors" />
                </div>
              </div>

              {/* 年级 */}
              <div className="relative">
                <label className="block text-xs font-bold text-gray-400 dark:text-gray-500 uppercase tracking-wider mb-2 ml-1">
                  年级 <span className="font-normal opacity-60">(可选)</span>
                </label>
                <div className="relative group">
                  <select value={grade} onChange={e => setGrade(e.target.value)}
                    className="w-full px-4 py-3 bg-gray-50 dark:bg-gray-800/40 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white appearance-none focus:outline-none focus:ring-4 focus:ring-brand-500/10 focus:border-brand-500 transition-all cursor-pointer">
                    <option value="" className="dark:bg-gray-900">不指定</option>
                    {GRADES.map(g => <option key={g} value={g} className="dark:bg-gray-900">{g}</option>)}
                  </select>
                  <ChevronDown size={16} className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none group-hover:text-brand-500 transition-colors" />
                </div>
              </div>
            </div>
          </div>

          {/* 图片上传 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm space-y-4">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <div className="w-1.5 h-4 bg-brand-500 rounded-full" />
                <h2 className="text-base font-semibold text-gray-900 dark:text-white">上传作业图片</h2>
              </div>
              <span className="text-xs text-gray-400">{uploadedCount}/10 张</span>
            </div>

            {/* 图片网格 */}
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3">
              {/* 已上传的图片 */}
              {images.map((img) => (
                <div key={img.preview} className="relative aspect-[3/4] rounded-xl overflow-hidden border-2 border-dashed border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/50 group">
                  <img src={img.preview} alt="" className="w-full h-full object-cover" />
                  
                  {/* 上传中遮罩 */}
                  {img.uploading && (
                    <div className="absolute inset-0 bg-black/60 flex flex-col items-center justify-center gap-2">
                      <Loader2 size={32} className="text-white animate-spin" />
                      <p className="text-sm font-medium text-white">上传中...</p>
                    </div>
                  )}
                  
                  {/* 错误遮罩 */}
                  {img.error && (
                    <div className="absolute inset-0 bg-red-500/20 flex flex-col items-center justify-center gap-2">
                      <AlertCircle size={32} className="text-red-500" />
                      <p className="text-xs font-medium text-red-600">{img.error}</p>
                    </div>
                  )}
                  
                  {/* 成功标记 */}
                  {img.url && !img.uploading && !img.error && (
                    <div className="absolute top-2 right-2">
                      <CheckCircle size={20} className="text-green-500 bg-white rounded-full shadow-sm" />
                    </div>
                  )}
                  
                  {/* 悬停操作按钮 */}
                  <div className="absolute inset-0 bg-black/0 hover:bg-black/40 transition-all flex items-center justify-center">
                    <button 
                      type="button"
                      onClick={(e) => { e.stopPropagation(); removeImage(img.preview); }}
                      className="p-2 bg-red-500/90 text-white rounded-lg hover:bg-red-600 transition-colors"
                      title="删除图片"
                    >
                      <X size={18} />
                    </button>
                  </div>
                </div>
              ))}

              {/* 上传按钮 */}
              {images.length < 10 && (
                <div
                  onClick={() => fileInputRef.current?.click()}
                  onDragOver={e => e.preventDefault()}
                  onDrop={handleDrop}
                  className="relative aspect-[3/4] rounded-xl overflow-hidden border-2 border-dashed border-gray-200 dark:border-gray-700 hover:border-brand-400 dark:hover:border-brand-500 bg-gray-50 dark:bg-gray-800/50 cursor-pointer transition-all group"
                >
                  <div className="absolute inset-0 flex flex-col items-center justify-center gap-2">
                    <Image size={32} className="text-gray-300 dark:text-gray-600 group-hover:text-brand-500 transition-colors" />
                    <p className="text-sm text-gray-400 dark:text-gray-500 group-hover:text-brand-500 transition-colors">点击上传</p>
                    <p className="text-xs text-gray-300 dark:text-gray-600 px-2 text-center">JPG/PNG/HEIC</p>
                  </div>
                </div>
              )}
            </div>

            <input ref={fileInputRef} type="file" accept="image/*" multiple
              onChange={e => { if (e.target.files?.length) handleFilesSelect(e.target.files); e.target.value = ''; }}
              className="hidden" />
          </div>

          <div className="space-y-2">
            {needsPaperSelection && (
              <p className="text-sm text-red-500 font-medium text-center">请选择试卷后再开始批改</p>
            )}
            <button onClick={handleSubmit} disabled={!canSubmit}
              className={`w-full py-4 rounded-2xl font-bold text-base transition-all flex items-center justify-center gap-2 group ${
                canSubmit
                  ? 'bg-brand-600 hover:bg-brand-700 text-white shadow-xl shadow-brand-600/20 hover:scale-[1.02] active:scale-[0.98]'
                  : 'bg-gray-100 dark:bg-gray-800 text-gray-400 cursor-not-allowed'
              }`}>
              {hasUploadingImages ? (
                <><Loader2 size={18} className="animate-spin" /> 图片上传中...</>
              ) : (
                <>
                  <BookOpen size={20} />
                  <span>开始批改 {uploadedCount > 0 && `(${uploadedCount} 张图片)`}</span>
                </>
              )}
            </button>
          </div>
        </>
      )}
    </div>
  );
};

// ==================== 子组件 ====================

const ModeCard: React.FC<{
  active: boolean; onClick: () => void;
  icon: React.ReactNode; title: string; desc: string;
}> = ({ active, onClick, icon, title, desc }) => (
  <button onClick={onClick}
    className={`text-left p-4 rounded-xl border-2 transition-all ${
      active
        ? 'border-brand-500 bg-brand-50/50 dark:bg-brand-900/20 ring-2 ring-brand-500/20'
        : 'border-gray-200 dark:border-gray-700 hover:border-gray-300 dark:hover:border-gray-600 bg-white dark:bg-gray-900'
    }`}>
    <div className={`mb-2 ${active ? 'text-brand-600 dark:text-brand-400' : 'text-gray-400'}`}>{icon}</div>
    <h3 className={`text-sm font-semibold mb-1 ${active ? 'text-brand-700 dark:text-brand-300' : 'text-gray-900 dark:text-white'}`}>{title}</h3>
    <p className="text-xs text-gray-500 dark:text-gray-400">{desc}</p>
  </button>
);

const GradingProgressPanel: React.FC<{
  progress: GradingProgress;
  onViewResult: () => void;
}> = ({ progress, onViewResult }) => {
  const totalQ = progress.totalQuestions || progress.questionCount || 0;
  const gradedQ = progress.questionResults.length;
  const pct = totalQ > 0 ? Math.round((gradedQ / totalQ) * 100) : 0;
  const isCompleted = (progress.done || progress.step === 'done') && !progress.error;

  // 判断当前阶段
  const getStageInfo = () => {
    if (isCompleted) {
      return { stage: 'completed', icon: <CheckCircle size={28} className="text-green-500" />, bgClass: 'bg-green-50 dark:bg-green-900/20', title: '批改已完成' };
    }
    if (progress.error) {
      return { stage: 'error', icon: <AlertCircle size={28} className="text-red-500" />, bgClass: 'bg-red-50 dark:bg-red-900/20', title: '批改中断' };
    }
    if (progress.step === 'connecting') {
      return { stage: 'connecting', icon: <Loader2 size={28} className="text-brand-500 animate-spin" />, bgClass: 'bg-brand-50 dark:bg-brand-900/20', title: '连接批改服务' };
    }
    if (progress.step === 'ocr') {
      return { stage: 'ocr', icon: <Loader2 size={28} className="text-blue-500 animate-spin" />, bgClass: 'bg-blue-50 dark:bg-blue-900/20', title: 'OCR 图像识别中' };
    }
    if (progress.step === 'ocr_done') {
      return { stage: 'ocr_done', icon: <CheckCircle size={28} className="text-blue-500" />, bgClass: 'bg-blue-50 dark:bg-blue-900/20', title: '图像识别完成' };
    }
    if (progress.step === 'grading') {
      return { stage: 'grading', icon: <Loader2 size={28} className="text-yellow-500 animate-spin" />, bgClass: 'bg-yellow-50 dark:bg-yellow-900/20', title: 'AI 智能批改中' };
    }
    return { stage: 'processing', icon: <Loader2 size={28} className="text-brand-500 animate-spin" />, bgClass: 'bg-brand-50 dark:bg-brand-900/20', title: '处理中' };
  };

  const stageInfo = getStageInfo();
  const getQuestionSummary = (qr: QuestionResult) => {
    if (qr.comment) return qr.comment;
    if (isCompleted) {
      return qr.standardAnswer ? '批改完成，已生成参考答案' : '批改完成';
    }
    return '正在生成分析...';
  };

  return (
    <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm space-y-6">
      {/* 状态头 */}
      <div className="flex items-center gap-4">
        <div className={`p-3 rounded-2xl shadow-sm ${stageInfo.bgClass}`}>
          {stageInfo.icon}
        </div>
        <div className="flex-1 min-w-0">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white leading-tight">
            {stageInfo.title}
          </h3>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1 truncate">{progress.message}</p>
        </div>
        {isCompleted && progress.totalScore !== undefined && (
          <div className="text-right">
            <div className="text-3xl font-black text-brand-600 dark:text-brand-400 tabular-nums">
              {progress.totalScore}<span className="text-sm font-normal text-gray-400 ml-1">/{progress.maxScore}</span>
            </div>
            <p className="text-[10px] text-gray-400 uppercase tracking-wider font-bold">Total Score</p>
          </div>
        )}
      </div>

      {/* 处理阶段指示器 */}
      {!isCompleted && (
        <div className="flex items-center gap-3">
          {/* OCR 阶段 */}
          <div className="flex-1 flex items-center gap-2">
            <div className={`flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center text-xs font-bold transition-all ${
              progress.step === 'ocr' || progress.step === 'ocr_done' || progress.step === 'grading' || progress.step === 'done'
                ? 'bg-blue-500 text-white'
                : 'bg-gray-200 dark:bg-gray-700 text-gray-400'
            }`}>
              {progress.step === 'ocr' ? <Loader2 size={14} className="animate-spin" /> : '1'}
            </div>
            <div className="flex-1 min-w-0">
              <p className={`text-xs font-bold truncate ${
                progress.step === 'ocr' || progress.step === 'ocr_done' || progress.step === 'grading' || progress.step === 'done'
                  ? 'text-blue-600 dark:text-blue-400'
                  : 'text-gray-400'
              }`}>
                图像识别
              </p>
            </div>
          </div>

          <div className={`h-0.5 w-8 transition-all ${
            progress.step === 'ocr_done' || progress.step === 'grading' || progress.step === 'done'
              ? 'bg-blue-500'
              : 'bg-gray-200 dark:bg-gray-700'
          }`} />

          {/* 批改阶段 */}
          <div className="flex-1 flex items-center gap-2">
            <div className={`flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center text-xs font-bold transition-all ${
              progress.step === 'grading' || progress.step === 'done'
                ? 'bg-yellow-500 text-white'
                : 'bg-gray-200 dark:bg-gray-700 text-gray-400'
            }`}>
              {progress.step === 'grading' ? <Loader2 size={14} className="animate-spin" /> : '2'}
            </div>
            <div className="flex-1 min-w-0">
              <p className={`text-xs font-bold truncate ${
                progress.step === 'grading' || progress.step === 'done'
                  ? 'text-yellow-600 dark:text-yellow-400'
                  : 'text-gray-400'
              }`}>
                AI 批改
              </p>
            </div>
          </div>

          <div className={`h-0.5 w-8 transition-all ${
            progress.step === 'done'
              ? 'bg-green-500'
              : 'bg-gray-200 dark:bg-gray-700'
          }`} />

          {/* 完成阶段 */}
          <div className="flex-1 flex items-center gap-2">
            <div className={`flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center text-xs font-bold transition-all ${
              progress.step === 'done'
                ? 'bg-green-500 text-white'
                : 'bg-gray-200 dark:bg-gray-700 text-gray-400'
            }`}>
              3
            </div>
            <div className="flex-1 min-w-0">
              <p className={`text-xs font-bold truncate ${
                progress.step === 'done'
                  ? 'text-green-600 dark:text-green-400'
                  : 'text-gray-400'
              }`}>
                生成报告
              </p>
            </div>
          </div>
        </div>
      )}

      {/* 进度条 */}
      {!isCompleted && totalQ > 0 && (
        <div className="space-y-2">
          <div className="flex justify-between text-xs font-bold text-gray-400 uppercase tracking-wider">
            <span>Progress</span>
            <span className="text-brand-500 tabular-nums">{gradedQ} / {totalQ} Items ({pct}%)</span>
          </div>
          <div className="w-full h-2.5 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
            <div className="h-full bg-gradient-to-r from-brand-400 to-brand-600 rounded-full transition-all duration-700 ease-out shadow-sm"
              style={{ width: `${pct}%` }} />
          </div>
        </div>
      )}

      {/* 逐题结果 */}
      {progress.questionResults.length > 0 && (
        <div className="space-y-2.5 max-h-80 overflow-y-auto pr-1 custom-scrollbar">
          {progress.questionResults.map((qr) => (
            <div key={qr.index}
              className="group flex items-center gap-4 px-4 py-3 rounded-xl bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
              <div className="flex-shrink-0 w-8 h-8 rounded-full bg-white dark:bg-gray-700 flex items-center justify-center text-xs font-bold text-gray-500 shadow-sm">
                {qr.index}
              </div>
              <div className="flex-1 min-w-0">
                <GradingMarkdown
                  content={getQuestionSummary(qr)}
                  className="text-sm font-medium text-gray-700 dark:text-gray-200 line-clamp-1 [&_p]:truncate"
                />
                {qr.standardAnswer && (
                  <GradingMarkdown
                    content={`参考答案：${qr.standardAnswer}`}
                    className="text-xs text-green-600 dark:text-green-400 mt-1 line-clamp-1 [&_p]:truncate"
                  />
                )}
                {qr.knowledgePoints.length > 0 && (
                  <div className="flex gap-1.5 mt-1.5 flex-wrap">
                    {qr.knowledgePoints.slice(0, 3).map(kp => (
                      <div key={kp} className="text-[10px] px-2 py-0.5 bg-brand-50/80 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400 rounded-md font-medium border border-brand-100/50 dark:border-brand-800/30">
                        <GradingMarkdown content={kp} />
                      </div>
                    ))}
                  </div>
                )}
              </div>
              <div className={`text-sm font-black flex-shrink-0 tabular-nums ${
                qr.score >= qr.maxScore ? 'text-green-500' : qr.score > 0 ? 'text-yellow-500' : 'text-red-500'
              }`}>
                {qr.score}/{qr.maxScore}
              </div>
            </div>
          ))}
        </div>
      )}

      {/* 总评 */}
      {isCompleted && progress.overallComment && (
        <div className="p-4 rounded-xl bg-brand-50/50 dark:bg-brand-900/10 border border-brand-100/50 dark:border-brand-800/30 relative overflow-hidden group">
          <div className="absolute top-0 right-0 p-2 opacity-10 group-hover:opacity-20 transition-opacity">
            <Sparkles size={48} className="text-brand-500" />
          </div>
          <h4 className="text-xs font-bold text-brand-600 dark:text-brand-400 uppercase tracking-widest mb-2 flex items-center gap-1.5">
            <Sparkles size={12} /> AI 核心建议
          </h4>
          <GradingMarkdown
            content={progress.overallComment}
            className="text-sm text-gray-700 dark:text-gray-300 leading-relaxed relative z-10"
          />
        </div>
      )}

      {/* 错误信息 */}
      {progress.error && (
        <div className="p-4 rounded-xl bg-red-50 dark:bg-red-900/10 border border-red-100 dark:border-red-800/30 flex items-start gap-3">
          <AlertCircle size={18} className="text-red-500 flex-shrink-0 mt-0.5" />
          <p className="text-sm text-red-600 dark:text-red-400 leading-relaxed font-medium">{progress.error}</p>
        </div>
      )}

      {/* 操作按钮 */}
      <div className="flex gap-4 pt-2">
        {isCompleted && (
          <button onClick={onViewResult}
            className="flex-[2] py-3 rounded-2xl bg-brand-600 hover:bg-brand-700 text-white font-bold text-sm transition-all shadow-lg shadow-brand-600/20 active:scale-[0.98]">
            查看详细批改报告
          </button>
        )}
        {(isCompleted || progress.error) && (
          <button onClick={() => window.location.reload()}
            className="flex-1 py-3 rounded-2xl border border-gray-200 dark:border-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-800 font-bold text-sm transition-all active:scale-[0.98]">
            {progress.error ? '重试' : '继续批改'}
          </button>
        )}
      </div>
    </div>
  );
};

export default GradingSubmitPage;
