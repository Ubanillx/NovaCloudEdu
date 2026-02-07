import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, Megaphone, Eye, Clock, ChevronLeft, ChevronRight } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { AnnouncementListResponse } from '../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

const AnnouncementListPage: React.FC = () => {
  const navigate = useNavigate();
  const [announcements, setAnnouncements] = useState<AnnouncementListResponse[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [pageNum, setPageNum] = useState(1);
  const pageSize = 10;

  const fetchList = useCallback(async () => {
    setLoading(true);
    try {
      const response = await api.getAnnouncementList({ pageNum, pageSize });
      if (response.data.code === 0 && response.data.data) {
        setAnnouncements(response.data.data.records || []);
        setTotal(response.data.data.total || 0);
      }
    } catch {
      // 静默处理
    } finally {
      setLoading(false);
    }
  }, [pageNum]);

  useEffect(() => {
    fetchList();
  }, [fetchList]);

  const totalPages = Math.ceil(total / pageSize) || 1;

  const formatTime = (dateStr?: string) => {
    if (!dateStr) return '';
    return new Date(dateStr).toLocaleDateString('zh-CN', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    });
  };

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

      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-200 dark:border-gray-800 shadow-sm overflow-hidden">
        {/* 头部 */}
        <div className="px-6 py-5 border-b border-gray-100 dark:border-gray-800">
          <h1 className="text-xl font-bold text-gray-900 dark:text-white flex items-center gap-2">
            <Megaphone size={22} className="text-warning" />
            全部公告
          </h1>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">共 {total} 条公告</p>
        </div>

        {/* 列表 */}
        <div className="divide-y divide-gray-100 dark:divide-gray-800">
          {loading ? (
            Array.from({ length: 5 }).map((_, i) => (
              <div key={i} className="px-6 py-4 animate-pulse">
                <div className="flex gap-4">
                  <div className="flex-1 space-y-2">
                    <div className="h-5 bg-gray-100 dark:bg-gray-800 rounded w-3/4" />
                    <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                  </div>
                  <div className="w-16 h-16 bg-gray-100 dark:bg-gray-800 rounded-lg flex-shrink-0" />
                </div>
              </div>
            ))
          ) : announcements.length > 0 ? (
            announcements.map((item) => (
              <div
                key={item.id}
                onClick={() => item.id && navigate(`/announcement/${item.id}`)}
                className="px-6 py-4 hover:bg-gray-50 dark:hover:bg-gray-800/50 cursor-pointer transition-colors group"
              >
                <div className="flex gap-4">
                  <div className="flex-1 min-w-0">
                    <div className="flex items-start gap-2">
                      {!item.isRead && (
                        <span className="mt-2 w-2 h-2 rounded-full bg-error flex-shrink-0" />
                      )}
                      <h3 className="text-base font-bold text-gray-900 dark:text-white group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors line-clamp-2">
                        {item.title}
                      </h3>
                    </div>
                    <div className="flex items-center gap-4 mt-2 text-xs text-gray-400 dark:text-gray-500">
                      <span className="flex items-center gap-1">
                        <Clock size={12} />
                        {formatTime(item.createTime)}
                      </span>
                      {item.viewCount !== undefined && item.viewCount > 0 && (
                        <span className="flex items-center gap-1">
                          <Eye size={12} />
                          {item.viewCount} 浏览
                        </span>
                      )}
                    </div>
                  </div>
                  {item.coverImage && (
                    <div className="w-20 h-16 rounded-lg overflow-hidden flex-shrink-0">
                      <img src={item.coverImage} alt="" className="w-full h-full object-cover" />
                    </div>
                  )}
                </div>
              </div>
            ))
          ) : (
            <div className="px-6 py-12 text-center">
              <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
                <Megaphone size={32} className="text-gray-300 dark:text-gray-600" />
              </div>
              <p className="text-gray-500 dark:text-gray-400 font-medium">暂无公告</p>
            </div>
          )}
        </div>

        {/* 分页 */}
        {total > pageSize && (
          <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              第 {pageNum} / {totalPages} 页
            </p>
            <div className="flex items-center gap-2">
              <button
                disabled={pageNum === 1 || loading}
                onClick={() => setPageNum((p) => p - 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronLeft size={18} />
              </button>
              <button
                disabled={pageNum >= totalPages || loading}
                onClick={() => setPageNum((p) => p + 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronRight size={18} />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default AnnouncementListPage;
