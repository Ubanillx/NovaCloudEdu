import React, { useState, useEffect, useCallback } from 'react';
import { Megaphone, ChevronRight, Eye, Clock } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { AnnouncementListResponse } from '../../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

interface AnnouncementSectionProps {
  maxItems?: number;
}

export const AnnouncementSection: React.FC<AnnouncementSectionProps> = ({ maxItems = 5 }) => {
  const [announcements, setAnnouncements] = useState<AnnouncementListResponse[]>([]);
  const [unreadCount, setUnreadCount] = useState(0);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  const fetchAnnouncements = useCallback(async () => {
    setLoading(true);
    try {
      const response = await api.getAnnouncementList({ pageNum: 1, pageSize: maxItems });
      if (response.data.code === 0 && response.data.data) {
        setAnnouncements(response.data.data.records || []);
        setUnreadCount(response.data.data.unreadCount || 0);
      }
    } catch {
      // 静默处理
    } finally {
      setLoading(false);
    }
  }, [maxItems]);

  useEffect(() => {
    fetchAnnouncements();
  }, [fetchAnnouncements]);

  const formatTime = (dateStr?: string) => {
    if (!dateStr) return '';
    const date = new Date(dateStr);
    const now = new Date();
    const diff = now.getTime() - date.getTime();
    const minutes = Math.floor(diff / 60000);
    const hours = Math.floor(diff / 3600000);
    const days = Math.floor(diff / 86400000);

    if (minutes < 1) return '刚刚';
    if (minutes < 60) return `${minutes}分钟前`;
    if (hours < 24) return `${hours}小时前`;
    if (days < 7) return `${days}天前`;
    return date.toLocaleDateString('zh-CN', { month: '2-digit', day: '2-digit' });
  };

  const handleClick = (id?: number) => {
    if (id) {
      navigate(`/announcement/${id}`);
    }
  };

  if (loading) {
    return (
      <div className="bg-white dark:bg-gray-900 p-6 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <div className="h-6 w-24 bg-gray-100 dark:bg-gray-800 rounded animate-pulse" />
        </div>
        <div className="space-y-4">
          {Array.from({ length: 3 }).map((_, i) => (
            <div key={i} className="animate-pulse">
              <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-3/4 mb-2" />
              <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
            </div>
          ))}
        </div>
      </div>
    );
  }

  if (announcements.length === 0) {
    return null;
  }

  return (
    <div className="bg-white dark:bg-gray-900 p-6 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm">
      <div className="flex items-center justify-between mb-4">
        <h3 className="font-bold text-lg flex items-center gap-2 text-gray-900 dark:text-white">
          <span className="w-1 h-6 bg-warning rounded-full" />
          最新公告
          {unreadCount > 0 && (
            <span className="ml-1 px-2 py-0.5 text-xs font-bold bg-error text-white rounded-full">
              {unreadCount > 99 ? '99+' : unreadCount}
            </span>
          )}
        </h3>
        <button
          onClick={() => navigate('/announcements')}
          className="text-xs text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 flex items-center gap-0.5 transition-colors"
        >
          更多
          <ChevronRight size={14} />
        </button>
      </div>

      <div className="space-y-3">
        {announcements.map((item) => (
          <div
            key={item.id}
            onClick={() => handleClick(item.id)}
            className="group pb-3 border-b border-gray-100 dark:border-gray-800 last:border-0 last:pb-0 cursor-pointer"
          >
            <div className="flex gap-3">
              <div className="w-8 h-8 rounded-full bg-warning-bg dark:bg-warning-dark/20 text-warning dark:text-warning-dark flex items-center justify-center flex-shrink-0 mt-0.5">
                <Megaphone size={14} />
              </div>
              <div className="flex-1 min-w-0">
                <div className="flex items-start gap-2">
                  {!item.isRead && (
                    <span className="mt-1.5 w-2 h-2 rounded-full bg-error flex-shrink-0" />
                  )}
                  <p className="text-sm font-medium text-gray-800 dark:text-gray-200 leading-tight group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors line-clamp-2">
                    {item.title}
                  </p>
                </div>
                <div className="flex items-center gap-3 mt-1.5 text-xs text-gray-400 dark:text-gray-500">
                  <span className="flex items-center gap-1">
                    <Clock size={11} />
                    {formatTime(item.createTime)}
                  </span>
                  {item.viewCount !== undefined && item.viewCount > 0 && (
                    <span className="flex items-center gap-1">
                      <Eye size={11} />
                      {item.viewCount}
                    </span>
                  )}
                </div>
              </div>
              {item.coverImage && (
                <div className="w-12 h-12 rounded-lg overflow-hidden flex-shrink-0">
                  <img src={item.coverImage} alt="" className="w-full h-full object-cover" />
                </div>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
