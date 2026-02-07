import React, { useState, useEffect, useCallback } from 'react';
import Markdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import rehypeRaw from 'rehype-raw';
import { 
  Search, 
  Plus, 
  Edit2, 
  Trash2, 
  Filter,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  FileText,
  Calendar,
  Eye,
  Heart,
  Bookmark,
  Clock,
  User,
  Link2,
  Sparkles,
  CheckSquare,
  Square,
  Loader
} from 'lucide-react';
import { apiClient, DefaultApi, AIApi, Configuration } from '../../api';
import type { DailyArticleResponse, DailyArticlePageResponse, CreateDailyArticleRequest, UpdateDailyArticleRequest } from '../../api/generated/models';
import { toast, TruncateWithTooltip } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);
const aiApi = new AIApi(new Configuration(), '', apiClient);

// 难度配置
const DIFFICULTY_OPTIONS = [
  { value: 1, label: '简单', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' },
  { value: 2, label: '中等', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800' },
  { value: 3, label: '困难', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800' },
];

// 分类选项
const CATEGORY_OPTIONS = [
  { value: '', label: '全部分类' },
  { value: '励志', label: '励志' },
  { value: '情感', label: '情感' },
  { value: '哲理', label: '哲理' },
  { value: '生活', label: '生活' },
  { value: '科技', label: '科技' },
  { value: '文化', label: '文化' },
  { value: '历史', label: '历史' },
  { value: '自然', label: '自然' },
  { value: '艺术', label: '艺术' },
  { value: '教育', label: '教育' },
];

// 文章表单弹窗组件
interface ArticleFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  article?: DailyArticleResponse | null;
}

const ArticleFormModal: React.FC<ArticleFormModalProps> = ({ isOpen, onClose, onSuccess, article }) => {
  const isEdit = !!article;
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState<CreateDailyArticleRequest>({
    title: '',
    content: '',
    summary: '',
    coverImage: '',
    author: '',
    source: '',
    sourceUrl: '',
    category: '',
    tags: [],
    difficulty: 1,
    readTime: 5,
    publishDate: new Date().toISOString().split('T')[0],
  });
  const [tagsInput, setTagsInput] = useState('');

  useEffect(() => {
    if (article) {
      setFormData({
        title: article.title || '',
        content: article.content || '',
        summary: article.summary || '',
        coverImage: article.coverImage || '',
        author: article.author || '',
        source: article.source || '',
        sourceUrl: article.sourceUrl || '',
        category: article.category || '',
        tags: article.tags || [],
        difficulty: article.difficulty || 1,
        readTime: article.readTime || 5,
        publishDate: article.publishDate || new Date().toISOString().split('T')[0],
      });
      setTagsInput((article.tags || []).join(', '));
    } else {
      setFormData({
        title: '',
        content: '',
        summary: '',
        coverImage: '',
        author: '',
        source: '',
        sourceUrl: '',
        category: '',
        tags: [],
        difficulty: 1,
        readTime: 5,
        publishDate: new Date().toISOString().split('T')[0],
      });
      setTagsInput('');
    }
  }, [article, isOpen]);

  const handleTagsChange = (value: string) => {
    setTagsInput(value);
    const tags = value.split(/[,，]/).map(t => t.trim()).filter(t => t);
    setFormData(prev => ({ ...prev, tags }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.title.trim()) {
      toast.warning('请输入文章标题');
      return;
    }
    if (!formData.content.trim()) {
      toast.warning('请输入文章内容');
      return;
    }
    if (!formData.publishDate) {
      toast.warning('请选择发布日期');
      return;
    }

    setLoading(true);
    try {
      if (isEdit && article?.id) {
        const updateData: UpdateDailyArticleRequest = {
          title: formData.title,
          content: formData.content,
          summary: formData.summary,
          coverImage: formData.coverImage,
          author: formData.author,
          source: formData.source,
          sourceUrl: formData.sourceUrl,
          category: formData.category,
          tags: formData.tags,
          difficulty: formData.difficulty,
          readTime: formData.readTime,
          publishDate: formData.publishDate,
        };
        const response = await api.updateDailyArticle({ id: article.id, updateDailyArticleRequest: updateData });
        if (response.data.code === 0) {
          toast.success('更新成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '更新失败');
        }
      } else {
        const response = await api.createDailyArticle({ createDailyArticleRequest: formData });
        if (response.data.code === 0) {
          toast.success('创建成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '创建失败');
        }
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    } finally {
      setLoading(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-4xl mx-4 max-h-[90vh] overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑文章' : '新增文章'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4 overflow-y-auto max-h-[calc(90vh-140px)]">
          {/* 标题 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文章标题 *</label>
            <input
              type="text"
              value={formData.title}
              onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="输入文章标题"
            />
          </div>

          {/* 摘要 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文章摘要</label>
            <textarea
              value={formData.summary}
              onChange={(e) => setFormData(prev => ({ ...prev, summary: e.target.value }))}
              rows={2}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="输入文章摘要（可选）"
            />
          </div>

          {/* 内容 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文章内容 *</label>
            <textarea
              value={formData.content}
              onChange={(e) => setFormData(prev => ({ ...prev, content: e.target.value }))}
              rows={8}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="输入文章内容"
            />
          </div>

          {/* 封面图片 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">封面图片URL</label>
            <input
              type="text"
              value={formData.coverImage}
              onChange={(e) => setFormData(prev => ({ ...prev, coverImage: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="https://..."
            />
          </div>

          {/* 作者和来源 */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">作者</label>
              <input
                type="text"
                value={formData.author}
                onChange={(e) => setFormData(prev => ({ ...prev, author: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="输入作者名称"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">来源</label>
              <input
                type="text"
                value={formData.source}
                onChange={(e) => setFormData(prev => ({ ...prev, source: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="输入文章来源"
              />
            </div>
          </div>

          {/* 原文链接 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">原文链接</label>
            <input
              type="text"
              value={formData.sourceUrl}
              onChange={(e) => setFormData(prev => ({ ...prev, sourceUrl: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="https://..."
            />
          </div>

          {/* 分类、难度、阅读时间、发布日期 */}
          <div className="grid grid-cols-4 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">分类</label>
              <select
                value={formData.category}
                onChange={(e) => setFormData(prev => ({ ...prev, category: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
              >
                {CATEGORY_OPTIONS.map(opt => (
                  <option key={opt.value} value={opt.value}>{opt.label || '请选择'}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">难度等级 *</label>
              <select
                value={formData.difficulty}
                onChange={(e) => setFormData(prev => ({ ...prev, difficulty: Number(e.target.value) }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
              >
                {DIFFICULTY_OPTIONS.map(opt => (
                  <option key={opt.value} value={opt.value}>{opt.label}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">阅读时间(分钟)</label>
              <input
                type="number"
                min={1}
                value={formData.readTime}
                onChange={(e) => setFormData(prev => ({ ...prev, readTime: Number(e.target.value) }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="5"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">发布日期 *</label>
              <input
                type="date"
                value={formData.publishDate}
                onChange={(e) => setFormData(prev => ({ ...prev, publishDate: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
              />
            </div>
          </div>

          {/* 标签 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">标签（用逗号分隔）</label>
            <input
              type="text"
              value={tagsInput}
              onChange={(e) => handleTagsChange(e.target.value)}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="励志, 成长, 人生"
            />
            {formData.tags && formData.tags.length > 0 && (
              <div className="flex flex-wrap gap-2 mt-2">
                {formData.tags.map((tag, index) => (
                  <span key={index} className="px-2 py-1 bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-400 rounded-lg text-xs font-medium">
                    {tag}
                  </span>
                ))}
              </div>
            )}
          </div>
        </form>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            取消
          </button>
          <button
            onClick={handleSubmit}
            disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {loading && <RefreshCw size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建文章'}
          </button>
        </div>
      </div>
    </div>
  );
};

// 文章详情弹窗
interface ArticleDetailModalProps {
  isOpen: boolean;
  onClose: () => void;
  article: DailyArticleResponse | null;
}

const ArticleDetailModal: React.FC<ArticleDetailModalProps> = ({ isOpen, onClose, article }) => {
  if (!isOpen || !article) return null;

  const difficultyOption = DIFFICULTY_OPTIONS.find(d => d.value === article.difficulty);

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-3xl mx-4 max-h-[90vh] overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">文章详情</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Content */}
        <div className="p-6 space-y-4 overflow-y-auto max-h-[calc(90vh-80px)]">
          {/* 封面图片 */}
          {article.coverImage && (
            <div className="w-full h-48 rounded-xl overflow-hidden bg-gray-100 dark:bg-gray-800">
              <img src={article.coverImage} alt={article.title} className="w-full h-full object-cover" />
            </div>
          )}

          {/* 标题 */}
          <h2 className="text-2xl font-bold text-gray-900 dark:text-white">{article.title}</h2>

          {/* 元信息 */}
          <div className="flex flex-wrap items-center gap-4 text-sm text-gray-500 dark:text-gray-400">
            {article.author && (
              <div className="flex items-center gap-1">
                <User size={14} />
                <span>{article.author}</span>
              </div>
            )}
            {article.publishDate && (
              <div className="flex items-center gap-1">
                <Calendar size={14} />
                <span>{article.publishDate}</span>
              </div>
            )}
            {article.readTime && (
              <div className="flex items-center gap-1">
                <Clock size={14} />
                <span>{article.readTime} 分钟</span>
              </div>
            )}
            {article.source && (
              <div className="flex items-center gap-1">
                <Link2 size={14} />
                <span>{article.source}</span>
              </div>
            )}
          </div>

          {/* 标签信息 */}
          <div className="flex flex-wrap gap-2">
            {difficultyOption && (
              <span className={`px-3 py-1 rounded-lg text-xs font-bold border ${difficultyOption.color}`}>
                {difficultyOption.label}
              </span>
            )}
            {article.category && (
              <span className="px-3 py-1 rounded-lg text-xs font-bold bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-400 border border-brand-200 dark:border-brand-800">
                {article.category}
              </span>
            )}
            {article.tags && article.tags.map((tag, index) => (
              <span key={index} className="px-3 py-1 rounded-lg text-xs font-medium bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400">
                {tag}
              </span>
            ))}
          </div>

          {/* 统计数据 */}
          <div className="flex items-center gap-6 py-3 border-y border-gray-100 dark:border-gray-800">
            <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400">
              <Eye size={16} />
              <span className="text-sm">{article.viewCount || 0} 阅读</span>
            </div>
            <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400">
              <Heart size={16} />
              <span className="text-sm">{article.likeCount || 0} 点赞</span>
            </div>
            <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400">
              <Bookmark size={16} />
              <span className="text-sm">{article.collectCount || 0} 收藏</span>
            </div>
          </div>

          {/* 摘要 */}
          {article.summary && (
            <div className="bg-gray-50 dark:bg-gray-800/50 rounded-xl p-4">
              <p className="text-gray-600 dark:text-gray-300 text-sm leading-relaxed">{article.summary}</p>
            </div>
          )}

          {/* 正文内容 */}
          <div className="prose prose-sm dark:prose-invert max-w-none">
            <Markdown remarkPlugins={[remarkGfm]} rehypePlugins={[rehypeRaw]}>{article.content || ''}</Markdown>
          </div>

          {/* 原文链接 */}
          {article.sourceUrl && (
            <a 
              href={article.sourceUrl} 
              target="_blank" 
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 text-brand-600 hover:text-brand-700 dark:text-brand-400 dark:hover:text-brand-300 text-sm"
            >
              <Link2 size={14} />
              查看原文
            </a>
          )}
        </div>
      </div>
    </div>
  );
};

export const DailyArticleManagementPage: React.FC = () => {
  const [articles, setArticles] = useState<DailyArticleResponse[]>([]);
  const [total, setTotal] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [detailModalOpen, setDetailModalOpen] = useState(false);
  const [editingArticle, setEditingArticle] = useState<DailyArticleResponse | null>(null);
  const [viewingArticle, setViewingArticle] = useState<DailyArticleResponse | null>(null);
  const [selectedIds, setSelectedIds] = useState<Set<number>>(new Set());
  const [aiProcessing, setAiProcessing] = useState<number | null>(null); // 正在处理的文章ID
  const [batchAiProcessing, setBatchAiProcessing] = useState(false);
  const [queryParams, setQueryParams] = useState({
    page: 1,
    size: 10,
    category: '',
    difficulty: undefined as number | undefined,
  });

  const fetchArticles = useCallback(async () => {
    setLoading(true);
    try {
      const response = await api.listArticles({ 
        category: queryParams.category || undefined,
        difficulty: queryParams.difficulty,
        page: queryParams.page,
        size: queryParams.size,
      });
      if (response.data.code === 0) {
        const pageData = response.data.data as DailyArticlePageResponse | undefined;
        setArticles(pageData?.records || []);
        setTotal(pageData?.total || 0);
        setTotalPages(pageData?.totalPages || 0);
      } else {
        toast.error(response.data.message || '获取文章列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [queryParams]);

  useEffect(() => {
    fetchArticles();
  }, [fetchArticles]);

  const handlePageChange = (newPage: number) => {
    setQueryParams(prev => ({ ...prev, page: newPage }));
  };

  const handleDeleteArticle = async (article: DailyArticleResponse) => {
    if (!article.id) return;
    if (!window.confirm(`确定要删除文章 "${article.title}" 吗？此操作不可恢复。`)) {
      return;
    }
    try {
      const response = await api.deleteDailyArticle({ id: article.id });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchArticles();
      } else {
        toast.error(response.data.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '删除失败');
    }
  };

  // AI 处理单篇文章
  const handleAiProcess = async (article: DailyArticleResponse) => {
    if (!article.id) return;
    setAiProcessing(article.id);
    try {
      const response = await aiApi.processArticle({
        aiProcessArticleRequest: {
          articleId: article.id,
          formatContent: true,
          generateSummary: true,
          summaryMaxLength: 150,
        }
      });
      if (response.data.code === 0) {
        toast.success('AI 处理完成');
        fetchArticles();
      } else {
        toast.error(response.data.message || 'AI 处理失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || 'AI 处理失败');
    } finally {
      setAiProcessing(null);
    }
  };

  // 批量 AI 处理
  const handleBatchAiProcess = async () => {
    if (selectedIds.size === 0) {
      toast.warning('请先选择要处理的文章');
      return;
    }
    setBatchAiProcessing(true);
    try {
      const response = await aiApi.batchProcessArticles({
        batchAiProcessRequest: {
          articleIds: Array.from(selectedIds),
          formatContent: true,
          generateSummary: true,
        }
      });
      if (response.data.code === 0) {
        const result = response.data.data as { total?: number; successCount?: number; failCount?: number } | undefined;
        toast.success(`AI 处理完成: 成功 ${result?.successCount || 0}/${result?.total || 0} 篇`);
        setSelectedIds(new Set());
        fetchArticles();
      } else {
        toast.error(response.data.message || '批量处理失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '批量处理失败');
    } finally {
      setBatchAiProcessing(false);
    }
  };

  // 选择/取消选择文章
  const toggleSelect = (id: number) => {
    const newSet = new Set(selectedIds);
    if (newSet.has(id)) {
      newSet.delete(id);
    } else {
      newSet.add(id);
    }
    setSelectedIds(newSet);
  };

  // 全选/取消全选
  const toggleSelectAll = () => {
    if (selectedIds.size === articles.length) {
      setSelectedIds(new Set());
    } else {
      setSelectedIds(new Set(articles.map(a => a.id!).filter(Boolean)));
    }
  };

  const getDifficultyBadge = (difficulty?: number) => {
    const option = DIFFICULTY_OPTIONS.find(d => d.value === difficulty);
    if (!option) return null;
    return (
      <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${option.color}`}>
        {option.label}
      </span>
    );
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">每日美文管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理每日推送的文章内容、难度和分类</p>
        </div>
        <div className="flex items-center gap-3">
          {selectedIds.size > 0 && (
            <button 
              onClick={handleBatchAiProcess}
              disabled={batchAiProcessing}
              className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-purple-500 to-indigo-500 text-white rounded-xl text-sm font-bold hover:from-purple-600 hover:to-indigo-600 shadow-lg shadow-purple-500/20 transition-all active:scale-95 disabled:opacity-50"
            >
              {batchAiProcessing ? <Loader size={18} className="animate-spin" /> : <Sparkles size={18} />}
              <span>AI处理 ({selectedIds.size})</span>
            </button>
          )}
          <button 
            onClick={() => { setEditingArticle(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>新增文章</span>
          </button>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <div className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input 
              type="text" 
              placeholder="搜索文章标题..." 
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select 
              value={queryParams.category}
              onChange={(e) => setQueryParams(prev => ({ ...prev, category: e.target.value, page: 1 }))}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              {CATEGORY_OPTIONS.map(opt => (
                <option key={opt.value} value={opt.value}>{opt.label}</option>
              ))}
            </select>
            <select 
              value={queryParams.difficulty || ''}
              onChange={(e) => setQueryParams(prev => ({ 
                ...prev, 
                difficulty: e.target.value ? Number(e.target.value) : undefined,
                page: 1 
              }))}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              <option value="">全部难度</option>
              {DIFFICULTY_OPTIONS.map(opt => (
                <option key={opt.value} value={opt.value}>{opt.label}</option>
              ))}
            </select>
            <button 
              type="button"
              className="flex items-center gap-2 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-400 transition-colors"
            >
              <Filter size={18} />
              <span>更多筛选</span>
            </button>
            <button 
              type="button"
              onClick={() => fetchArticles()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </div>
      </div>

      {/* Article Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-4 py-4 w-10">
                  <button onClick={toggleSelectAll} className="text-gray-400 hover:text-brand-600">
                    {selectedIds.size === articles.length && articles.length > 0 ? <CheckSquare size={18} /> : <Square size={18} />}
                  </button>
                </th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider min-w-[260px]">文章</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-24">作者</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-20">难度</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-20">分类</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-32">统计</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-28">发布日期</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-36">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={8} className="px-6 py-8 h-16">
                      <div className="flex gap-4">
                        <div className="w-16 h-12 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : articles.length > 0 ? (
                articles.map((article) => (
                  <tr key={article.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-4 py-3">
                      <button 
                        onClick={() => article.id && toggleSelect(article.id)} 
                        className="text-gray-400 hover:text-brand-600"
                      >
                        {article.id && selectedIds.has(article.id) ? <CheckSquare size={18} /> : <Square size={18} />}
                      </button>
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-3">
                        <div className="w-14 h-10 rounded-lg bg-gradient-to-br from-brand-50 to-indigo-50 dark:from-gray-800 dark:to-gray-800 flex items-center justify-center border border-gray-100 dark:border-gray-700 overflow-hidden flex-shrink-0">
                          {article.coverImage ? (
                            <img src={article.coverImage} alt={article.title} className="w-full h-full object-cover" />
                          ) : (
                            <FileText size={18} className="text-brand-500" />
                          )}
                        </div>
                        <div className="min-w-0 flex-1">
                          <button
                            onClick={() => { setViewingArticle(article); setDetailModalOpen(true); }}
                            className="font-bold text-gray-900 dark:text-white hover:text-brand-600 dark:hover:text-brand-400 transition-colors text-left block w-full text-sm"
                          >
                            <TruncateWithTooltip text={article.title || ''} maxWidth={200} />
                          </button>
                          {article.summary && (
                            <TruncateWithTooltip 
                              text={article.summary} 
                              maxWidth={200} 
                              className="text-xs text-gray-400"
                            />
                          )}
                        </div>
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <p className="text-sm text-gray-600 dark:text-gray-300 truncate">{article.author || '-'}</p>
                    </td>
                    <td className="px-4 py-3">
                      {getDifficultyBadge(article.difficulty)}
                    </td>
                    <td className="px-4 py-3">
                      {article.category ? (
                        <span className="px-2.5 py-1 rounded-lg text-xs font-medium bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400">
                          {article.category}
                        </span>
                      ) : (
                        <span className="text-gray-400 text-sm">-</span>
                      )}
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-2 text-xs text-gray-500 dark:text-gray-400">
                        <span className="flex items-center gap-1">
                          <Eye size={12} />
                          {article.viewCount || 0}
                        </span>
                        <span className="flex items-center gap-1">
                          <Heart size={12} />
                          {article.likeCount || 0}
                        </span>
                        <span className="flex items-center gap-1">
                          <Bookmark size={12} />
                          {article.collectCount || 0}
                        </span>
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-1 text-sm text-gray-500 dark:text-gray-400">
                        <Calendar size={14} />
                        <span>{article.publishDate || '-'}</span>
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button 
                          onClick={() => handleAiProcess(article)}
                          disabled={aiProcessing === article.id}
                          className="p-1.5 text-gray-400 hover:text-purple-600 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-all disabled:opacity-50" 
                          title="AI处理"
                        >
                          {aiProcessing === article.id ? <Loader size={16} className="animate-spin" /> : <Sparkles size={16} />}
                        </button>
                        <button 
                          onClick={() => { setViewingArticle(article); setDetailModalOpen(true); }}
                          className="p-1.5 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" 
                          title="查看详情"
                        >
                          <Eye size={16} />
                        </button>
                        <button 
                          onClick={() => { setEditingArticle(article); setModalOpen(true); }}
                          className="p-1.5 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" 
                          title="编辑"
                        >
                          <Edit2 size={16} />
                        </button>
                        <button 
                          onClick={() => handleDeleteArticle(article)}
                          className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" 
                          title="删除"
                        >
                          <Trash2 size={16} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={8} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <FileText size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无文章数据</p>
                      <button
                        onClick={() => { setEditingArticle(null); setModalOpen(true); }}
                        className="mt-4 px-4 py-2 text-sm font-medium text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-colors"
                      >
                        添加第一篇文章
                      </button>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        {articles.length > 0 && (
          <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              显示第 <span className="font-bold text-gray-900 dark:text-white">{(queryParams.page - 1) * queryParams.size + 1}</span> 到 <span className="font-bold text-gray-900 dark:text-white">{Math.min(queryParams.page * queryParams.size, total)}</span> 条结果，共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 条
            </p>
            <div className="flex items-center gap-2">
              <button 
                disabled={queryParams.page === 1 || loading}
                onClick={() => handlePageChange(queryParams.page - 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronLeft size={18} />
              </button>
              <div className="flex items-center gap-1">
                {Array.from({ length: Math.min(5, totalPages || 1) }).map((_, i) => {
                  let pageNum = i + 1;
                  if (totalPages > 5) {
                    const start = Math.max(1, Math.min(queryParams.page - 2, totalPages - 4));
                    pageNum = start + i;
                  }
                  return (
                    <button
                      key={pageNum}
                      onClick={() => handlePageChange(pageNum)}
                      className={`w-10 h-10 rounded-lg text-sm font-bold transition-all ${
                        queryParams.page === pageNum 
                          ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' 
                          : 'text-gray-500 hover:bg-white dark:hover:bg-gray-800 border border-transparent hover:border-gray-200 dark:hover:border-gray-700'
                      }`}
                    >
                      {pageNum}
                    </button>
                  );
                })}
              </div>
              <button 
                disabled={queryParams.page >= totalPages || loading}
                onClick={() => handlePageChange(queryParams.page + 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronRight size={18} />
              </button>
            </div>
          </div>
        )}
      </div>

      {/* 文章表单弹窗 */}
      <ArticleFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingArticle(null); }}
        onSuccess={fetchArticles}
        article={editingArticle}
      />

      {/* 文章详情弹窗 */}
      <ArticleDetailModal
        isOpen={detailModalOpen}
        onClose={() => { setDetailModalOpen(false); setViewingArticle(null); }}
        article={viewingArticle}
      />
    </div>
  );
};
