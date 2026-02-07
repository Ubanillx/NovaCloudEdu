import React, { useCallback } from 'react';
import { ChevronRight, Clock, Eye, Heart } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { DailyArticleResponse } from '../../api/generated/models';
import { useCache } from '../../hooks/useCache';

const api = new DefaultApi(new Configuration(), '', apiClient);

const DIFFICULTY_LABELS: Record<number, { label: string; color: string }> = {
  1: { label: '简单', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' },
  2: { label: '中等', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400' },
  3: { label: '困难', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400' },
};

export const DailyArticleSection: React.FC = () => {
  const navigate = useNavigate();

  const todayKey = new Date().toISOString().split('T')[0];

  const fetcher = useCallback(async () => {
    const response = await api.getTodayArticles({ size: 3 });
    if (response.data.code === 0 && response.data.data) {
      return response.data.data as DailyArticleResponse[];
    }
    return [];
  }, []);

  const { data: articles, loading } = useCache<DailyArticleResponse[]>({
    cacheKey: `daily_articles_${todayKey}`,
    fetcher,
    expiryMs: 60 * 60 * 1000,
  });

  if (loading) {
    return (
      <div>
        <div className="flex items-center justify-between mb-6">
          <div className="h-7 bg-gray-200 dark:bg-gray-800 rounded w-28 animate-pulse" />
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {Array.from({ length: 2 }).map((_, i) => (
            <div key={i} className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 overflow-hidden animate-pulse">
              <div className="w-full h-36 bg-gray-200 dark:bg-gray-800" />
              <div className="p-4 space-y-2">
                <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-20" />
                <div className="h-5 bg-gray-200 dark:bg-gray-800 rounded w-3/4" />
                <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-full" />
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  if (!articles || articles.length === 0) {
    return null;
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <h2 className="text-2xl font-bold text-gray-900 dark:text-white">每日美文</h2>
        <button
          onClick={() => navigate('/daily-articles')}
          className="text-brand-600 hover:text-brand-700 dark:text-brand-400 dark:hover:text-brand-300 text-sm font-medium flex items-center gap-1"
        >
          查看全部
          <ChevronRight size={16} />
        </button>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {articles.map((article) => {
          const diff = article.difficulty ? DIFFICULTY_LABELS[article.difficulty] : null;
          return (
            <div
              key={article.id}
              onClick={() => navigate(`/daily-article/${article.id}`)}
              className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 hover:border-brand-300 dark:hover:border-brand-700 transition-colors cursor-pointer group overflow-hidden"
            >
              {/* 封面图 - 仅有图时显示 */}
              {article.coverImage && (
                <div className="w-full h-40 overflow-hidden">
                  <img
                    src={article.coverImage}
                    alt={article.title}
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                  />
                </div>
              )}

              {/* 内容区 */}
              <div className="p-4">
                <div className="flex items-center gap-2 mb-2">
                  {article.category && (
                    <span className="text-xs font-semibold text-brand-600 bg-brand-50 dark:bg-brand-900/30 dark:text-brand-400 px-2 py-0.5 rounded">
                      {article.category}
                    </span>
                  )}
                  {diff && (
                    <span className={`text-xs font-semibold px-2 py-0.5 rounded ${diff.color}`}>
                      {diff.label}
                    </span>
                  )}
                  {article.readTime && (
                    <span className="text-xs text-gray-400 dark:text-gray-500 flex items-center gap-1">
                      <Clock size={11} />
                      {article.readTime} 分钟
                    </span>
                  )}
                </div>
                <h3 className="font-bold text-lg mb-1 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors line-clamp-1 text-gray-900 dark:text-white">
                  {article.title}
                </h3>
                <p className="text-sm text-gray-500 dark:text-gray-400 line-clamp-2 mb-2">
                  {article.summary || ''}
                </p>
                <div className="flex items-center gap-3 text-xs text-gray-400 dark:text-gray-500">
                  {article.author && <span>{article.author}</span>}
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
            </div>
          );
        })}
      </div>
    </div>
  );
};
