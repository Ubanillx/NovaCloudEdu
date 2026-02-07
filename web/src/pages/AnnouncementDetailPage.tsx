import React, { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { ArrowLeft, Calendar, Eye, Megaphone } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { AnnouncementDetailResponse } from '../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

const AnnouncementDetailPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [announcement, setAnnouncement] = useState<AnnouncementDetailResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchDetail = useCallback(async () => {
    if (!id) return;
    setLoading(true);
    setError(null);
    try {
      // json-bigint 已将 Long ID 转为 string，URL 参数也是 string
      // 不可用 Number() 转换，否则精度丢失；API 方法内部会 String(id) 拼接到 URL，string 兼容
      const response = await api.getAnnouncementDetail({ id: id as unknown as number });
      if (response.data.code === 0 && response.data.data) {
        setAnnouncement(response.data.data);
      } else {
        setError(response.data.message || '获取公告详情失败');
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

  const formatDateTime = (dateStr?: string) => {
    if (!dateStr) return '';
    return new Date(dateStr).toLocaleString('zh-CN', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  if (loading) {
    return (
      <div className="max-w-3xl mx-auto animate-pulse space-y-6">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 bg-gray-200 dark:bg-gray-800 rounded-lg" />
          <div className="h-5 bg-gray-200 dark:bg-gray-800 rounded w-20" />
        </div>
        <div className="h-8 bg-gray-200 dark:bg-gray-800 rounded w-2/3" />
        <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-1/3" />
        <div className="h-48 bg-gray-200 dark:bg-gray-800 rounded-xl" />
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
            <Megaphone size={32} className="text-error" />
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

  if (!announcement) return null;

  return (
    <div className="max-w-3xl mx-auto animate-in fade-in duration-500">
      {/* 返回按钮 */}
      <button
        onClick={() => navigate(-1)}
        className="flex items-center gap-2 text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 mb-6 transition-colors group"
      >
        <ArrowLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
        返回
      </button>

      {/* 公告卡片 */}
      <article className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-200 dark:border-gray-800 shadow-sm overflow-hidden">
        {/* 封面图 */}
        {announcement.coverImage && (
          <div className="w-full aspect-[3/1] overflow-hidden">
            <img
              src={announcement.coverImage}
              alt={announcement.title || ''}
              className="w-full h-full object-cover"
            />
          </div>
        )}

        {/* 内容区 */}
        <div className="p-6 md:p-8">
          {/* 标签 */}
          <div className="flex items-center gap-2 mb-4">
            <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-warning-bg dark:bg-warning-dark/20 text-warning dark:text-warning-dark rounded-full text-xs font-bold">
              <Megaphone size={12} />
              系统公告
            </span>
          </div>

          {/* 标题 */}
          <h1 className="text-2xl md:text-3xl font-black text-gray-900 dark:text-white mb-4 leading-tight">
            {announcement.title}
          </h1>

          {/* 元信息 */}
          <div className="flex flex-wrap items-center gap-4 text-sm text-gray-400 dark:text-gray-500 mb-8 pb-6 border-b border-gray-100 dark:border-gray-800">
            {announcement.createTime && (
              <span className="flex items-center gap-1.5">
                <Calendar size={14} />
                {formatDateTime(announcement.createTime)}
              </span>
            )}
            {announcement.viewCount !== undefined && (
              <span className="flex items-center gap-1.5">
                <Eye size={14} />
                {announcement.viewCount} 次浏览
              </span>
            )}
          </div>

          {/* 正文 */}
          <div className="prose prose-gray dark:prose-invert max-w-none text-gray-700 dark:text-gray-300 leading-relaxed whitespace-pre-wrap">
            {announcement.content}
          </div>
        </div>
      </article>
    </div>
  );
};

export default AnnouncementDetailPage;
