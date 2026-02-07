import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, Search, ChevronLeft, ChevronRight, FileText, Calendar, Clock, Eye, Heart } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { DailyArticleResponse, DailyArticlePageResponse } from '../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

const CACHE_PREFIX = 'nova_cache_';

const DIFFICULTY_OPTIONS = [
  { value: 1, label: '简单', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' },
  { value: 2, label: '中等', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400' },
  { value: 3, label: '困难', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400' },
];

const CATEGORY_OPTIONS = [
  '励志', '情感', '哲理', '生活', '科技', '文化', '历史', '自然', '艺术', '教育',
];

function getCacheKey(page: number, size: number, category: string, difficulty: string): string {
  return `article_list_${page}_${size}_${category}_${difficulty}`;
}

function getListCache(key: string): { articles: DailyArticleResponse[]; total: number; totalPages: number } | null {
  try {
    const raw = localStorage.getItem(CACHE_PREFIX + key);
    if (!raw) return null;
    const entry = JSON.parse(raw);
    if (Date.now() > entry.timestamp + entry.expiry) {
      localStorage.removeItem(CACHE_PREFIX + key);
      return null;
    }
    return entry.data;
  } catch {
    return null;
  }
}

function setListCache(key: string, data: { articles: DailyArticleResponse[]; total: number; totalPages: number }): void {
  try {
    const entry = { data, timestamp: Date.now(), expiry: 30 * 60 * 1000 };
    localStorage.setItem(CACHE_PREFIX + key, JSON.stringify(entry));
  } catch {
    // ignore
  }
}

const DailyArticleListPage: React.FC = () => {
  const navigate = useNavigate();
  const [articles, setArticles] = useState<DailyArticleResponse[]>([]);
  const [total, setTotal] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [category, setCategory] = useState('');
  const [difficulty, setDifficulty] = useState('');
  const size = 9;

  const fetchArticles = useCallback(async () => {
    const cacheKey = getCacheKey(page, size, category, difficulty);
    const cached = getListCache(cacheKey);
    if (cached) {
      setArticles(cached.articles);
      setTotal(cached.total);
      setTotalPages(cached.totalPages);
      setLoading(false);
      return;
    }

    setLoading(true);
    try {
      const response = await api.listArticles({
        category: category || undefined,
        difficulty: difficulty ? Number(difficulty) : undefined,
        page,
        size,
      });
      if (response.data.code === 0) {
        const pageData = response.data.data as DailyArticlePageResponse | undefined;
        const result = {
          articles: pageData?.records || [],
          total: pageData?.total || 0,
          totalPages: pageData?.totalPages || 0,
        };
        setArticles(result.articles);
        setTotal(result.total);
        setTotalPages(result.totalPages);
        setListCache(cacheKey, result);
      }
    } catch {
      // 静默处理
    } finally {
      setLoading(false);
    }
  }, [page, category, difficulty]);

  useEffect(() => {
    fetchArticles();
  }, [fetchArticles]);

  return (
    <div className="animate-in fade-in duration-500 space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center gap-2 text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors group"
        >
          <ArrowLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
        </button>
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">每日美文</h1>
          <p className="text-sm text-gray-500 dark:text-gray-400">品读好文，提升素养</p>
        </div>
      </div>

      {/* Filter */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm">
        <div className="flex flex-col sm:flex-row gap-3">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={18} />
            <input
              type="text"
              placeholder="搜索文章..."
              className="w-full pl-11 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all text-sm"
              disabled
            />
          </div>
          <div className="flex gap-2 flex-wrap">
            <select
              value={category}
              onChange={(e) => { setCategory(e.target.value); setPage(1); }}
              className="px-3 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              <option value="">全部分类</option>
              {CATEGORY_OPTIONS.map((c) => (
                <option key={c} value={c}>{c}</option>
              ))}
            </select>
            <select
              value={difficulty}
              onChange={(e) => { setDifficulty(e.target.value); setPage(1); }}
              className="px-3 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              <option value="">全部难度</option>
              {DIFFICULTY_OPTIONS.map((d) => (
                <option key={d.value} value={d.value}>{d.label}</option>
              ))}
            </select>
          </div>
        </div>
      </div>

      {/* Article Cards */}
      {loading ? (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 overflow-hidden animate-pulse">
              <div className="aspect-video bg-gray-200 dark:bg-gray-800" />
              <div className="p-4 space-y-2">
                <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-16" />
                <div className="h-5 bg-gray-200 dark:bg-gray-800 rounded w-3/4" />
                <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-full" />
              </div>
            </div>
          ))}
        </div>
      ) : articles.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {articles.map((article) => {
            const diff = DIFFICULTY_OPTIONS.find((d) => d.value === article.difficulty);
            return (
              <div
                key={article.id}
                onClick={() => navigate(`/daily-article/${article.id}`)}
                className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 overflow-hidden hover:shadow-lg hover:border-brand-300 dark:hover:border-brand-700 transition-all cursor-pointer group"
              >
                {/* Cover */}
                <div className="relative aspect-video overflow-hidden bg-gray-100 dark:bg-gray-800">
                  {article.coverImage ? (
                    <img
                      src={article.coverImage}
                      alt={article.title}
                      className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                    />
                  ) : (
                    <div className="w-full h-full flex items-center justify-center">
                      <FileText size={40} className="text-gray-300 dark:text-gray-600" />
                    </div>
                  )}
                  {/* Badges */}
                  <div className="absolute top-2 left-2 flex gap-1">
                    {article.category && (
                      <span className="bg-white/90 dark:bg-gray-900/90 px-2 py-1 rounded text-xs font-semibold text-brand-600 dark:text-brand-400 backdrop-blur-sm">
                        {article.category}
                      </span>
                    )}
                    {diff && (
                      <span className={`px-2 py-1 rounded text-xs font-semibold backdrop-blur-sm ${diff.color}`}>
                        {diff.label}
                      </span>
                    )}
                  </div>
                </div>

                {/* Content */}
                <div className="p-4">
                  <h3 className="font-bold text-lg mb-2 line-clamp-2 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors text-gray-900 dark:text-white">
                    {article.title}
                  </h3>
                  {article.summary && (
                    <p className="text-sm text-gray-500 dark:text-gray-400 line-clamp-2 mb-3">{article.summary}</p>
                  )}
                  <div className="flex items-center justify-between text-xs text-gray-400 dark:text-gray-500">
                    <div className="flex items-center gap-3">
                      {article.author && <span>{article.author}</span>}
                      {article.readTime && (
                        <span className="flex items-center gap-1">
                          <Clock size={11} />
                          {article.readTime}分钟
                        </span>
                      )}
                    </div>
                    <div className="flex items-center gap-2">
                      {article.viewCount !== undefined && article.viewCount > 0 && (
                        <span className="flex items-center gap-1">
                          <Eye size={11} />
                          {article.viewCount}
                        </span>
                      )}
                      {article.likeCount !== undefined && article.likeCount > 0 && (
                        <span className="flex items-center gap-1">
                          <Heart size={11} />
                          {article.likeCount}
                        </span>
                      )}
                    </div>
                  </div>
                  {article.publishDate && (
                    <div className="flex items-center gap-1 text-xs text-gray-400 mt-2">
                      <Calendar size={11} />
                      {article.publishDate}
                    </div>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      ) : (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-200 dark:border-gray-800 p-12 text-center">
          <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
            <FileText size={32} className="text-gray-300" />
          </div>
          <p className="text-gray-500 dark:text-gray-400 font-medium">暂无文章数据</p>
        </div>
      )}

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between">
          <p className="text-sm text-gray-500 dark:text-gray-400">
            共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 篇文章
          </p>
          <div className="flex items-center gap-2">
            <button
              disabled={page === 1}
              onClick={() => setPage((p) => p - 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
            >
              <ChevronLeft size={18} />
            </button>
            <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">
              {page} / {totalPages}
            </span>
            <button
              disabled={page === totalPages}
              onClick={() => setPage((p) => p + 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default DailyArticleListPage;
