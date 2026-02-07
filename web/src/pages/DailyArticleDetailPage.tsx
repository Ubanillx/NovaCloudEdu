import React, { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import Markdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import rehypeRaw from 'rehype-raw';
import { ArrowLeft, Calendar, Clock, Eye, Heart, Bookmark, User, Link2, FileText, MessageSquareText, X } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { DailyArticleResponse } from '../api/generated/models';
import { ArticleChatPanel } from './ArticleChatPage';
import { useSider } from '../context/SiderContext';
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

const CACHE_PREFIX = 'nova_cache_';

const DIFFICULTY_OPTIONS = [
  { value: 1, label: '简单', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' },
  { value: 2, label: '中等', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800' },
  { value: 3, label: '困难', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800' },
];

function getCachedArticleFromList(id: string): DailyArticleResponse | null {
  try {
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key?.startsWith(CACHE_PREFIX + 'daily_articles_')) {
        const raw = localStorage.getItem(key);
        if (!raw) continue;
        const entry = JSON.parse(raw);
        const articles: DailyArticleResponse[] = entry.data;
        if (Array.isArray(articles)) {
          const found = articles.find((a) => String(a.id) === id);
          if (found) return found;
        }
      }
    }
  } catch {
    // ignore
  }
  return null;
}

function cacheArticleDetail(article: DailyArticleResponse): void {
  try {
    const key = `${CACHE_PREFIX}daily_article_detail_${article.id}`;
    const entry = { data: article, timestamp: Date.now(), expiry: 60 * 60 * 1000 };
    localStorage.setItem(key, JSON.stringify(entry));
  } catch {
    // ignore
  }
}

function getCachedArticleDetail(id: string): DailyArticleResponse | null {
  try {
    const key = `${CACHE_PREFIX}daily_article_detail_${id}`;
    const raw = localStorage.getItem(key);
    if (!raw) return null;
    const entry = JSON.parse(raw);
    if (Date.now() > entry.timestamp + entry.expiry) {
      localStorage.removeItem(key);
      return null;
    }
    return entry.data;
  } catch {
    return null;
  }
}

const DailyArticleDetailPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { setSiderHidden } = useSider();
  const [article, setArticle] = useState<DailyArticleResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const [isLiked, setIsLiked] = useState(false);
  const [isCollected, setIsCollected] = useState(false);
  const [likeCount, setLikeCount] = useState(0);
  const [collectCount, setCollectCount] = useState(0);
  const [actionLoading, setActionLoading] = useState(false);
  const [chatOpen, setChatOpen] = useState(false);

  // 聊天打开时隐藏侧边栏，关闭或离开页面时恢复
  useEffect(() => {
    setSiderHidden(chatOpen);
  }, [chatOpen, setSiderHidden]);

  useEffect(() => {
    return () => setSiderHidden(false);
  }, [setSiderHidden]);

  const toggleChat = () => setChatOpen((prev) => !prev);

  const fetchDetail = useCallback(async () => {
    if (!id) return;
    setLoading(true);
    setError(null);

    const cached = getCachedArticleDetail(id) || getCachedArticleFromList(id);
    if (cached) {
      setArticle(cached);
      setLikeCount(cached.likeCount || 0);
      setCollectCount(cached.collectCount || 0);
      setLoading(false);
      try {
        const response = await api.getDailyArticle({ id: id as unknown as number });
        if (response.data.code === 0 && response.data.data) {
          setArticle(response.data.data);
          setLikeCount(response.data.data.likeCount || 0);
          setCollectCount(response.data.data.collectCount || 0);
          cacheArticleDetail(response.data.data);
        }
      } catch { /* 已有缓存，静默 */ }
      return;
    }

    try {
      const response = await api.getDailyArticle({ id: id as unknown as number });
      if (response.data.code === 0 && response.data.data) {
        setArticle(response.data.data);
        setLikeCount(response.data.data.likeCount || 0);
        setCollectCount(response.data.data.collectCount || 0);
        cacheArticleDetail(response.data.data);
      } else {
        setError(response.data.message || '获取文章详情失败');
      }
    } catch {
      setError('网络错误，请稍后重试');
    } finally {
      setLoading(false);
    }
  }, [id]);

  useEffect(() => {
    fetchDetail();
  }, [fetchDetail]);

  // 标记已读
  useEffect(() => {
    if (!id || loading) return;
    api.markAsRead({ articleId: id as unknown as number }).catch(() => {});
  }, [id, loading]);

  const handleToggleLike = async () => {
    if (!id || actionLoading) return;
    setActionLoading(true);
    try {
      await api.toggleLike({ articleId: id as unknown as number });
      setIsLiked((prev) => !prev);
      setLikeCount((prev) => prev + (isLiked ? -1 : 1));
    } catch { toast.error('操作失败'); }
    finally { setActionLoading(false); }
  };

  const handleToggleCollect = async () => {
    if (!id || actionLoading) return;
    setActionLoading(true);
    try {
      await api.toggleCollect1({ articleId: id as unknown as number });
      setIsCollected((prev) => !prev);
      setCollectCount((prev) => prev + (isCollected ? -1 : 1));
    } catch { toast.error('操作失败'); }
    finally { setActionLoading(false); }
  };

  if (loading) {
    return (
      <div className="max-w-3xl mx-auto animate-pulse space-y-6">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 bg-gray-200 dark:bg-gray-800 rounded-lg" />
          <div className="h-5 bg-gray-200 dark:bg-gray-800 rounded w-20" />
        </div>
        <div className="h-48 bg-gray-200 dark:bg-gray-800 rounded-xl" />
        <div className="h-8 bg-gray-200 dark:bg-gray-800 rounded w-2/3" />
        <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-1/3" />
        <div className="space-y-3">
          <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-full" />
          <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-5/6" />
          <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-4/6" />
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="max-w-3xl mx-auto">
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-200 dark:border-gray-800 p-12 text-center">
          <div className="w-16 h-16 bg-error-bg dark:bg-error/10 rounded-full flex items-center justify-center mx-auto mb-4">
            <FileText size={32} className="text-error" />
          </div>
          <h2 className="text-xl font-bold text-gray-900 dark:text-white mb-2">加载失败</h2>
          <p className="text-gray-500 dark:text-gray-400 mb-6">{error}</p>
          <div className="flex items-center justify-center gap-3">
            <button
              onClick={() => navigate(-1)}
              className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white border border-gray-200 dark:border-gray-700 rounded-xl transition-colors"
            >
              返回
            </button>
            <button
              onClick={fetchDetail}
              className="px-4 py-2 text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 rounded-xl transition-colors"
            >
              重试
            </button>
          </div>
        </div>
      </div>
    );
  }

  if (!article) return null;

  const difficultyOption = DIFFICULTY_OPTIONS.find((d) => d.value === article.difficulty);

  return (
    <div className="flex gap-6 animate-in fade-in duration-500">
      {/* 文章区域 */}
      <div className="flex-1 min-w-0">
        {/* 返回按钮 */}
        <button
          onClick={() => navigate(-1)}
          className="flex items-center gap-2 text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 mb-6 transition-colors group"
        >
          <ArrowLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
          返回
        </button>

        {/* 文章卡片 */}
        <article className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-200 dark:border-gray-800 shadow-sm overflow-hidden">
          {/* 封面图 */}
          {article.coverImage && (
            <div className="w-full aspect-[3/1] overflow-hidden">
              <img
                src={article.coverImage}
                alt={article.title || ''}
                className="w-full h-full object-cover"
              />
            </div>
          )}

          {/* 内容区 */}
          <div className="p-6 md:p-8">
            {/* 标签 */}
            <div className="flex flex-wrap items-center gap-2 mb-4">
              {article.category && (
                <span className="px-3 py-1 bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 rounded-full text-xs font-bold">
                  {article.category}
                </span>
              )}
              {difficultyOption && (
                <span className={`px-3 py-1 rounded-full text-xs font-bold border ${difficultyOption.color}`}>
                  {difficultyOption.label}
                </span>
              )}
              {article.tags && article.tags.map((tag, index) => (
                <span key={index} className="px-3 py-1 bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 rounded-full text-xs font-medium">
                  {tag}
                </span>
              ))}
            </div>

            {/* 标题 */}
            <h1 className="text-2xl md:text-3xl font-black text-gray-900 dark:text-white mb-4 leading-tight">
              {article.title}
            </h1>

            {/* 元信息 */}
            <div className="flex flex-wrap items-center gap-4 text-sm text-gray-400 dark:text-gray-500 mb-6">
              {article.author && (
                <span className="flex items-center gap-1.5">
                  <User size={14} />
                  {article.author}
                </span>
              )}
              {article.publishDate && (
                <span className="flex items-center gap-1.5">
                  <Calendar size={14} />
                  {article.publishDate}
                </span>
              )}
              {article.readTime && (
                <span className="flex items-center gap-1.5">
                  <Clock size={14} />
                  {article.readTime} 分钟阅读
                </span>
              )}
              {article.source && (
                <span className="flex items-center gap-1.5">
                  <Link2 size={14} />
                  {article.source}
                </span>
              )}
            </div>

            {/* 互动操作栏（包含 AI 按钮） */}
            <div className="flex items-center gap-2 py-4 border-y border-gray-100 dark:border-gray-800 mb-6">
              <button
                onClick={handleToggleLike}
                disabled={actionLoading}
                className={`flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-medium transition-all active:scale-95 ${
                  isLiked
                    ? 'bg-red-50 dark:bg-red-900/20 text-red-500 border border-red-200 dark:border-red-800'
                    : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 border border-gray-200 dark:border-gray-700 hover:border-red-300 hover:text-red-500'
                }`}
              >
                <Heart size={16} className={isLiked ? 'fill-current' : ''} />
                <span>{likeCount}</span>
              </button>
              <button
                onClick={handleToggleCollect}
                disabled={actionLoading}
                className={`flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-medium transition-all active:scale-95 ${
                  isCollected
                    ? 'bg-amber-50 dark:bg-amber-900/20 text-amber-500 border border-amber-200 dark:border-amber-800'
                    : 'bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 border border-gray-200 dark:border-gray-700 hover:border-amber-300 hover:text-amber-500'
                }`}
              >
                <Bookmark size={16} className={isCollected ? 'fill-current' : ''} />
                <span>{collectCount}</span>
              </button>
              <div className="flex items-center gap-2 px-4 py-2 text-gray-400 dark:text-gray-500 text-sm">
                <Eye size={16} />
                <span>{article.viewCount || 0}</span>
              </div>

              {/* AI 讨论按钮 - 页面内联 */}
              <button
                onClick={toggleChat}
                className={`flex items-center gap-2 px-4 py-2 rounded-xl text-sm font-bold transition-all active:scale-95 ml-auto ${
                  chatOpen
                    ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20'
                    : 'bg-gradient-to-r from-brand-50 to-accent-50 dark:from-brand-900/20 dark:to-accent-900/20 text-brand-600 dark:text-brand-400 border border-brand-200 dark:border-brand-800 hover:shadow-md'
                }`}
              >
                {chatOpen ? <X size={16} /> : <MessageSquareText size={16} />}
                <span>{chatOpen ? '关闭讨论' : 'AI 讨论'}</span>
              </button>
            </div>

            {/* 摘要 */}
            {article.summary && (
              <div className="bg-gray-50 dark:bg-gray-800/50 rounded-xl p-5 mb-6">
                <p className="text-gray-600 dark:text-gray-300 text-sm leading-relaxed italic">{article.summary}</p>
              </div>
            )}

            {/* 正文 */}
            <div className="prose prose-gray dark:prose-invert max-w-none text-gray-700 dark:text-gray-300 leading-relaxed">
              <Markdown remarkPlugins={[remarkGfm]} rehypePlugins={[rehypeRaw]}>{article.content || ''}</Markdown>
            </div>

            {/* 原文链接 */}
            {article.sourceUrl && (
              <div className="mt-8 pt-6 border-t border-gray-100 dark:border-gray-800">
                <a
                  href={article.sourceUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-2 text-brand-600 hover:text-brand-700 dark:text-brand-400 dark:hover:text-brand-300 text-sm font-medium"
                >
                  <Link2 size={14} />
                  查看原文
                </a>
              </div>
            )}
          </div>
        </article>
      </div>

      {/* AI 聊天面板 - 从右侧划入 */}
      <div
        className={`transition-all duration-300 ease-in-out overflow-hidden flex-shrink-0 ${
          chatOpen ? 'w-[420px] opacity-100' : 'w-0 opacity-0'
        }`}
      >
        <div className="w-[420px] h-[calc(100vh-8rem)] sticky top-20">
          <ArticleChatPanel
            articleId={id || ''}
            articleTitle={article.title || '文章'}
            open={chatOpen}
          />
        </div>
      </div>
    </div>
  );
};

export default DailyArticleDetailPage;
