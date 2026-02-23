import React, { useState, useEffect, useCallback } from 'react';
import MarkdownRenderer from '../../components/chat/MarkdownRenderer';
import { 
  Search, 
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  FileText,
  Clock,
  User,
  Trash2,
  Eye,
  Heart,
  MessageCircle,
  Bookmark,
  Tag,
  MapPin
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { 
  PostResponse, 
  PostDetailResponse
} from '../../api/generated/models';
import { toast, TruncateWithTooltip } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 帖子类型配置
const POST_TYPES = [
  { value: '', label: '全部类型' },
  { value: 'discussion', label: '讨论' },
  { value: 'question', label: '提问' },
  { value: 'share', label: '分享' },
  { value: 'announcement', label: '公告' },
];

// 帖子详情弹窗组件
interface PostDetailModalProps {
  isOpen: boolean;
  onClose: () => void;
  post: PostResponse | null;
}

const PostDetailModal: React.FC<PostDetailModalProps> = ({ isOpen, onClose, post }) => {
  const [detail, setDetail] = useState<PostDetailResponse | null>(null);
  const [loading, setLoading] = useState(false);

  const fetchDetail = useCallback(async () => {
    if (!post?.id) return;
    setLoading(true);
    try {
      const response = await api.getPostDetail({ postId: post.id });
      if (response.data.code === 0) {
        setDetail(response.data.data || null);
      }
    } catch (error: any) {
      toast.error('获取详情失败');
    } finally {
      setLoading(false);
    }
  }, [post?.id]);

  useEffect(() => {
    if (isOpen && post?.id) {
      fetchDetail();
    }
  }, [isOpen, post?.id, fetchDetail]);

  const formatDateTime = (dateStr?: string) => {
    if (!dateStr) return '-';
    return new Date(dateStr).toLocaleString('zh-CN', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-3xl mx-4 max-h-[90vh] overflow-hidden animate-in zoom-in-95 duration-200 flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800 flex-shrink-0">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-brand-50 dark:bg-brand-900/20 flex items-center justify-center">
              <FileText size={20} className="text-brand-600 dark:text-brand-400" />
            </div>
            <div>
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">帖子详情</h3>
              <p className="text-xs text-gray-500">#{post?.id}</p>
            </div>
          </div>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Content */}
        <div className="flex-1 overflow-y-auto p-6 space-y-6">
          {loading ? (
            <div className="flex items-center justify-center py-12">
              <RefreshCw size={32} className="animate-spin text-brand-600" />
            </div>
          ) : detail ? (
            <>
              {/* 基本信息 */}
              <div className="bg-gray-50 dark:bg-gray-800/50 rounded-xl p-4 space-y-3">
                <div>
                  <h4 className="font-bold text-gray-900 dark:text-white text-xl">{detail.title}</h4>
                  <div className="flex items-center gap-4 mt-2 text-sm text-gray-500">
                    <span className="px-2 py-0.5 bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 rounded-lg text-xs font-medium">
                      {POST_TYPES.find(t => t.value === detail.postType)?.label || detail.postType || '帖子'}
                    </span>
                    <span className="flex items-center gap-1">
                      <User size={14} />
                      用户 #{detail.userId}
                    </span>
                    <span className="flex items-center gap-1">
                      <Clock size={14} />
                      {formatDateTime(detail.createTime)}
                    </span>
                    {detail.ipAddress && (
                      <span className="flex items-center gap-1">
                        <MapPin size={14} />
                        {detail.ipAddress}
                      </span>
                    )}
                  </div>
                </div>
                
                {/* 标签 */}
                {detail.tags && detail.tags.length > 0 && (
                  <div className="flex items-center gap-2 flex-wrap">
                    <Tag size={14} className="text-gray-400" />
                    {detail.tags.map((tag, index) => (
                      <span key={index} className="px-2 py-0.5 bg-gray-200 dark:bg-gray-700 text-gray-600 dark:text-gray-300 rounded text-xs">
                        {tag}
                      </span>
                    ))}
                  </div>
                )}
                
                {/* 内容 */}
                <div className="pt-3 border-t border-gray-200 dark:border-gray-700 prose prose-sm dark:prose-invert max-w-none">
                  <MarkdownRenderer content={detail.content || ''} />
                </div>
              </div>

              {/* 互动数据 */}
              <div className="grid grid-cols-3 gap-4">
                <div className="bg-red-50 dark:bg-red-900/20 p-4 rounded-xl text-center">
                  <div className="flex items-center justify-center gap-2 text-red-600 dark:text-red-400 mb-1">
                    <Heart size={18} />
                    <span className="text-2xl font-bold">{detail.thumbNum || 0}</span>
                  </div>
                  <p className="text-xs text-gray-500">点赞数</p>
                </div>
                <div className="bg-amber-50 dark:bg-amber-900/20 p-4 rounded-xl text-center">
                  <div className="flex items-center justify-center gap-2 text-amber-600 dark:text-amber-400 mb-1">
                    <Bookmark size={18} />
                    <span className="text-2xl font-bold">{detail.favourNum || 0}</span>
                  </div>
                  <p className="text-xs text-gray-500">收藏数</p>
                </div>
                <div className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-xl text-center">
                  <div className="flex items-center justify-center gap-2 text-blue-600 dark:text-blue-400 mb-1">
                    <MessageCircle size={18} />
                    <span className="text-2xl font-bold">{detail.commentNum || 0}</span>
                  </div>
                  <p className="text-xs text-gray-500">评论数</p>
                </div>
              </div>

              {/* 更新时间 */}
              {detail.updateTime && detail.updateTime !== detail.createTime && (
                <div className="text-xs text-gray-400 text-right">
                  最后更新于 {formatDateTime(detail.updateTime)}
                </div>
              )}
            </>
          ) : (
            <div className="text-center py-12 text-gray-500">加载失败</div>
          )}
        </div>

        {/* Footer */}
        <div className="flex-shrink-0 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button
            onClick={onClose}
            className="w-full px-4 py-2 bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 text-sm font-medium rounded-xl hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors"
          >
            关闭
          </button>
        </div>
      </div>
    </div>
  );
};

export const PostManagementPage: React.FC = () => {
  const [posts, setPosts] = useState<PostResponse[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [detailOpen, setDetailOpen] = useState(false);
  const [selectedPost, setSelectedPost] = useState<PostResponse | null>(null);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [selectedType, setSelectedType] = useState('');
  const [pageNum, setPageNum] = useState(1);
  const [pageSize] = useState(10);

  const fetchPosts = useCallback(async () => {
    setLoading(true);
    try {
      let response;
      if (searchKeyword.trim()) {
        response = await api.searchPosts({ 
          keyword: searchKeyword.trim(), 
          pageNum, 
          pageSize 
        });
      } else if (selectedType) {
        response = await api.getPostListByType({ 
          postType: selectedType, 
          pageNum, 
          pageSize 
        });
      } else {
        response = await api.getPostList({ pageNum, pageSize });
      }
      
      if (response.data.code === 0) {
        setPosts(response.data.data?.posts || []);
        setTotal(response.data.data?.total || 0);
      } else {
        toast.error(response.data.message || '获取帖子列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [searchKeyword, selectedType, pageNum, pageSize]);

  useEffect(() => {
    fetchPosts();
  }, [fetchPosts]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setPageNum(1);
  };

  const handlePageChange = (newPage: number) => {
    setPageNum(newPage);
  };

  const handleDelete = async (post: PostResponse) => {
    if (!post.id) return;
    if (!window.confirm(`确定要删除帖子 "${post.title}" 吗？此操作不可恢复。`)) {
      return;
    }
    try {
      const response = await api.adminDeletePost({ postId: post.id as unknown as number });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchPosts();
      } else {
        toast.error(response.data.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    }
  };

  const formatDateTime = (dateStr?: string) => {
    if (!dateStr) return '-';
    return new Date(dateStr).toLocaleString('zh-CN', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  const getTypeLabel = (type?: string) => {
    return POST_TYPES.find(t => t.value === type)?.label || type || '-';
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">帖子管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">查看和管理用户发布的帖子内容</p>
        </div>
        <div className="flex items-center gap-3">
          <div className="flex items-center gap-2 px-4 py-2 bg-brand-50 dark:bg-brand-900/20 border border-brand-200 dark:border-brand-800 rounded-xl">
            <FileText size={18} className="text-brand-600 dark:text-brand-400" />
            <span className="text-sm font-medium text-brand-700 dark:text-brand-400">
              共 {total} 篇帖子
            </span>
          </div>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <form onSubmit={handleSearch} className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input 
              type="text" 
              placeholder="搜索帖子标题或内容..." 
              value={searchKeyword}
              onChange={(e) => setSearchKeyword(e.target.value)}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select 
              value={selectedType}
              onChange={(e) => { setSelectedType(e.target.value); setPageNum(1); }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              {POST_TYPES.map(opt => (
                <option key={opt.value} value={opt.value}>{opt.label}</option>
              ))}
            </select>
            <button 
              type="submit"
              className="px-4 py-2.5 bg-brand-600 text-white rounded-xl text-sm font-medium hover:bg-brand-700 transition-colors"
            >
              搜索
            </button>
            <button 
              type="button"
              onClick={() => fetchPosts()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </form>
      </div>

      {/* Post Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">帖子信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">类型</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">互动数据</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">发布时间</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={5} className="px-6 py-8 h-20">
                      <div className="flex gap-4">
                        <div className="w-10 h-10 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : posts.length > 0 ? (
                posts.map((item) => (
                  <tr key={item.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-6 py-4">
                      <div className="flex items-start gap-3">
                        <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand-50 to-accent-50 dark:from-gray-800 dark:to-gray-800 flex items-center justify-center flex-shrink-0">
                          <FileText size={18} className="text-brand-600 dark:text-brand-400" />
                        </div>
                        <div className="min-w-0">
                          <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">
                            <TruncateWithTooltip text={item.title || '无标题'} maxWidth={200} />
                          </p>
                          <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">
                            <TruncateWithTooltip text={item.content || ''} maxWidth={280} />
                          </p>
                          <div className="flex items-center gap-2 mt-1">
                            <span className="text-xs text-gray-400 flex items-center gap-1">
                              <User size={12} />
                              #{item.userId}
                            </span>
                            {item.tags && item.tags.length > 0 && (
                              <div className="flex items-center gap-1">
                                {item.tags.slice(0, 2).map((tag, idx) => (
                                  <span key={idx} className="px-1.5 py-0.5 bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400 rounded text-xs">
                                    {tag}
                                  </span>
                                ))}
                                {item.tags.length > 2 && (
                                  <span className="text-xs text-gray-400">+{item.tags.length - 2}</span>
                                )}
                              </div>
                            )}
                          </div>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <span className="px-2.5 py-1 bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 rounded-lg text-xs font-medium">
                        {getTypeLabel(item.postType)}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-4 text-sm">
                        <span className="flex items-center gap-1 text-red-500">
                          <Heart size={14} />
                          {item.thumbNum || 0}
                        </span>
                        <span className="flex items-center gap-1 text-amber-500">
                          <Bookmark size={14} />
                          {item.favourNum || 0}
                        </span>
                        <span className="flex items-center gap-1 text-blue-500">
                          <MessageCircle size={14} />
                          {item.commentNum || 0}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="text-sm text-gray-600 dark:text-gray-300 flex items-center gap-1">
                        <Clock size={14} className="text-gray-400" />
                        {formatDateTime(item.createTime)}
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button 
                          onClick={() => { setSelectedPost(item); setDetailOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" 
                          title="查看详情"
                        >
                          <Eye size={18} />
                        </button>
                        <button 
                          onClick={() => handleDelete(item)}
                          className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" 
                          title="删除"
                        >
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
                        <FileText size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无帖子数据</p>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
          <p className="text-sm text-gray-500 dark:text-gray-400">
            共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 条记录
          </p>
          <div className="flex items-center gap-2">
            <button 
              disabled={pageNum === 1 || loading}
              onClick={() => handlePageChange(pageNum - 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronLeft size={18} />
            </button>
            <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">
              {pageNum} / {Math.ceil(total / pageSize) || 1}
            </span>
            <button 
              disabled={pageNum === Math.ceil(total / pageSize) || loading || total === 0}
              onClick={() => handlePageChange(pageNum + 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>

      {/* 帖子详情弹窗 */}
      <PostDetailModal
        isOpen={detailOpen}
        onClose={() => { setDetailOpen(false); setSelectedPost(null); }}
        post={selectedPost}
      />
    </div>
  );
};
