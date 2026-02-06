import React, { useState, useEffect, useCallback } from 'react';
import { 
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  MessageSquare,
  Clock,
  User,
  Send,
  Trash2,
  CheckCircle,
  AlertCircle,
  HelpCircle,
  XCircle,
  Eye,
  MessageCircle
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { 
  FeedbackResponse, 
  FeedbackDetailResponse,
  FeedbackReplyResponse,
  QueryFeedbackRequest 
} from '../../api/generated/models';
import { toast, TruncateWithTooltip } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 状态配置
const STATUS_OPTIONS = [
  { value: '', label: '全部状态' },
  { value: 0, label: '待处理', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800', icon: AlertCircle },
  { value: 1, label: '处理中', color: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400 border-blue-200 dark:border-blue-800', icon: HelpCircle },
  { value: 2, label: '已解决', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800', icon: CheckCircle },
  { value: 3, label: '已关闭', color: 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700', icon: XCircle },
];

// 反馈类型配置
const FEEDBACK_TYPES = [
  { value: '', label: '全部类型' },
  { value: 'bug', label: 'Bug 报告' },
  { value: 'suggestion', label: '功能建议' },
  { value: 'question', label: '问题咨询' },
  { value: 'complaint', label: '投诉建议' },
  { value: 'other', label: '其他' },
];

// 反馈详情弹窗组件
interface FeedbackDetailModalProps {
  isOpen: boolean;
  onClose: () => void;
  feedback: FeedbackResponse | null;
  onStatusChange: () => void;
}

const FeedbackDetailModal: React.FC<FeedbackDetailModalProps> = ({ isOpen, onClose, feedback, onStatusChange }) => {
  const [detail, setDetail] = useState<FeedbackDetailResponse | null>(null);
  const [replies, setReplies] = useState<FeedbackReplyResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [replyContent, setReplyContent] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [selectedStatus, setSelectedStatus] = useState<number | undefined>(undefined);

  const fetchDetail = useCallback(async () => {
    if (!feedback?.id) return;
    setLoading(true);
    try {
      const response = await api.getFeedbackDetail1({ id: feedback.id });
      if (response.data.code === 0) {
        setDetail(response.data.data || null);
        setReplies(response.data.data?.replies || []);
        setSelectedStatus(response.data.data?.status);
      }
    } catch (error: any) {
      toast.error('获取详情失败');
    } finally {
      setLoading(false);
    }
  }, [feedback?.id]);

  useEffect(() => {
    if (isOpen && feedback?.id) {
      fetchDetail();
      setReplyContent('');
    }
  }, [isOpen, feedback?.id, fetchDetail]);

  const handleReply = async () => {
    if (!replyContent.trim() || !feedback?.id) {
      toast.warning('请输入回复内容');
      return;
    }
    setSubmitting(true);
    try {
      const response = await apiClient.post('/api/feedback/admin/reply', {
        feedbackId: feedback.id,
        content: replyContent,
      });
      if (response.data?.code === 0) {
        toast.success('回复成功');
        setReplyContent('');
        fetchDetail();
      } else {
        toast.error(response.data?.message || '回复失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '回复失败');
    } finally {
      setSubmitting(false);
    }
  };

  const handleStatusChange = async (newStatus: number) => {
    if (!feedback?.id) return;
    try {
      const response = await api.updateFeedbackStatus({
        updateFeedbackStatusRequest: {
          feedbackId: feedback.id,
          status: newStatus,
        }
      });
      if (response.data.code === 0) {
        toast.success('状态更新成功');
        setSelectedStatus(newStatus);
        onStatusChange();
      } else {
        toast.error(response.data.message || '更新失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '更新失败');
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

  const getStatusOption = (status?: number) => {
    return STATUS_OPTIONS.find(s => s.value === status) || STATUS_OPTIONS[1];
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
              <MessageSquare size={20} className="text-brand-600 dark:text-brand-400" />
            </div>
            <div>
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">反馈详情</h3>
              <p className="text-xs text-gray-500">#{feedback?.id}</p>
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
                <div className="flex items-start justify-between">
                  <div>
                    <h4 className="font-bold text-gray-900 dark:text-white text-lg">{detail.title}</h4>
                    <div className="flex items-center gap-3 mt-2 text-sm text-gray-500">
                      <span className="px-2 py-0.5 bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 rounded-lg text-xs font-medium">
                        {FEEDBACK_TYPES.find(t => t.value === detail.feedbackType)?.label || detail.feedbackType}
                      </span>
                      <span className="flex items-center gap-1">
                        <User size={14} />
                        用户 #{detail.userId}
                      </span>
                      <span className="flex items-center gap-1">
                        <Clock size={14} />
                        {formatDateTime(detail.createTime)}
                      </span>
                    </div>
                  </div>
                  {/* 状态选择 */}
                  <select
                    value={selectedStatus ?? ''}
                    onChange={(e) => handleStatusChange(parseInt(e.target.value))}
                    className={`px-3 py-1.5 rounded-lg text-sm font-bold border cursor-pointer ${getStatusOption(selectedStatus).color}`}
                  >
                    {STATUS_OPTIONS.filter(s => s.value !== '').map(opt => (
                      <option key={opt.value} value={opt.value}>{opt.label}</option>
                    ))}
                  </select>
                </div>
                <div className="pt-3 border-t border-gray-200 dark:border-gray-700">
                  <p className="text-gray-700 dark:text-gray-300 whitespace-pre-wrap">{detail.content}</p>
                </div>
                {detail.attachment && (
                  <div className="pt-3 border-t border-gray-200 dark:border-gray-700">
                    <p className="text-xs text-gray-500 mb-2">附件</p>
                    <img src={detail.attachment} alt="附件" className="max-w-full max-h-48 rounded-lg" />
                  </div>
                )}
              </div>

              {/* 回复列表 */}
              <div>
                <h4 className="font-bold text-gray-900 dark:text-white mb-3 flex items-center gap-2">
                  <MessageCircle size={18} />
                  回复记录 ({replies.length})
                </h4>
                <div className="space-y-3 max-h-64 overflow-y-auto">
                  {replies.length > 0 ? (
                    replies.map((reply) => (
                      <div 
                        key={reply.id} 
                        className={`p-4 rounded-xl ${
                          reply.senderRole === 1 
                            ? 'bg-brand-50 dark:bg-brand-900/20 ml-8' 
                            : 'bg-gray-50 dark:bg-gray-800/50 mr-8'
                        }`}
                      >
                        <div className="flex items-center justify-between mb-2">
                          <span className={`text-sm font-medium ${
                            reply.senderRole === 1 
                              ? 'text-brand-600 dark:text-brand-400' 
                              : 'text-gray-600 dark:text-gray-400'
                          }`}>
                            {reply.senderRole === 1 ? '管理员' : '用户'}
                          </span>
                          <span className="text-xs text-gray-400">{formatDateTime(reply.createTime)}</span>
                        </div>
                        <p className="text-gray-700 dark:text-gray-300 text-sm">{reply.content}</p>
                        {reply.attachment && (
                          <img src={reply.attachment} alt="附件" className="mt-2 max-w-full max-h-32 rounded-lg" />
                        )}
                      </div>
                    ))
                  ) : (
                    <div className="text-center py-6 text-gray-400">
                      暂无回复记录
                    </div>
                  )}
                </div>
              </div>
            </>
          ) : (
            <div className="text-center py-12 text-gray-500">加载失败</div>
          )}
        </div>

        {/* 回复输入框 */}
        <div className="flex-shrink-0 p-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <div className="flex gap-3">
            <textarea
              value={replyContent}
              onChange={(e) => setReplyContent(e.target.value)}
              placeholder="输入回复内容..."
              rows={2}
              className="flex-1 px-4 py-2.5 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
            />
            <button
              onClick={handleReply}
              disabled={submitting || !replyContent.trim()}
              className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2 self-end"
            >
              {submitting ? <RefreshCw size={16} className="animate-spin" /> : <Send size={16} />}
              回复
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export const FeedbackManagementPage: React.FC = () => {
  const [feedbacks, setFeedbacks] = useState<FeedbackResponse[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [detailOpen, setDetailOpen] = useState(false);
  const [selectedFeedback, setSelectedFeedback] = useState<FeedbackResponse | null>(null);
  const [queryParams, setQueryParams] = useState<QueryFeedbackRequest>({
    pageNum: 1,
    pageSize: 10,
    feedbackType: '',
    status: undefined,
  });

  const fetchFeedbacks = useCallback(async () => {
    setLoading(true);
    try {
      const params: QueryFeedbackRequest = {
        ...queryParams,
        feedbackType: queryParams.feedbackType || undefined,
      };
      const response = await api.queryFeedbacks({ queryFeedbackRequest: params });
      if (response.data.code === 0) {
        setFeedbacks(response.data.data?.list || []);
        setTotal(response.data.data?.total || 0);
      } else {
        toast.error(response.data.message || '获取反馈列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [queryParams]);

  useEffect(() => {
    fetchFeedbacks();
  }, [fetchFeedbacks]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setQueryParams(prev => ({ ...prev, pageNum: 1 }));
  };

  const handlePageChange = (newPage: number) => {
    setQueryParams(prev => ({ ...prev, pageNum: newPage }));
  };

  const getStatusBadge = (status?: number) => {
    const statusOption = STATUS_OPTIONS.find(s => s.value === status);
    if (!statusOption || statusOption.value === '') return null;
    const Icon = statusOption.icon;
    return (
      <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-lg text-xs font-bold border ${statusOption.color}`}>
        {Icon && <Icon size={12} />}
        {statusOption.label}
      </span>
    );
  };

  const handleDelete = async (feedback: FeedbackResponse) => {
    if (!feedback.id) return;
    if (!window.confirm(`确定要删除该反馈吗？此操作不可恢复。`)) {
      return;
    }
    try {
      const response = await api.deleteFeedback1({ id: feedback.id });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchFeedbacks();
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
    return FEEDBACK_TYPES.find(t => t.value === type)?.label || type || '-';
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">反馈管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">查看和处理用户提交的反馈信息</p>
        </div>
        <div className="flex items-center gap-3">
          <div className="flex items-center gap-2 px-4 py-2 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl">
            <AlertCircle size={18} className="text-amber-600 dark:text-amber-400" />
            <span className="text-sm font-medium text-amber-700 dark:text-amber-400">
              待处理: {feedbacks.filter(f => f.status === 0).length}
            </span>
          </div>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <form onSubmit={handleSearch} className="flex flex-col lg:flex-row gap-4">
          <div className="flex flex-wrap items-center gap-3 flex-1">
            <select 
              value={queryParams.feedbackType ?? ''}
              onChange={(e) => setQueryParams(prev => ({ 
                ...prev, 
                feedbackType: e.target.value,
                pageNum: 1 
              }))}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              {FEEDBACK_TYPES.map(opt => (
                <option key={opt.value} value={opt.value}>{opt.label}</option>
              ))}
            </select>
            <select 
              value={queryParams.status ?? ''}
              onChange={(e) => setQueryParams(prev => ({ 
                ...prev, 
                status: e.target.value === '' ? undefined : parseInt(e.target.value),
                pageNum: 1 
              }))}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              {STATUS_OPTIONS.map(opt => (
                <option key={String(opt.value)} value={opt.value}>{opt.label}</option>
              ))}
            </select>
          </div>
          <button 
            type="button"
            onClick={() => fetchFeedbacks()}
            className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
          >
            <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
          </button>
        </form>
      </div>

      {/* Feedback Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">反馈信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">类型</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">提交时间</th>
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
              ) : feedbacks.length > 0 ? (
                feedbacks.map((item) => (
                  <tr key={item.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-6 py-4">
                      <div className="flex items-start gap-3">
                        <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand-50 to-accent-50 dark:from-gray-800 dark:to-gray-800 flex items-center justify-center flex-shrink-0">
                          <MessageSquare size={18} className="text-brand-600 dark:text-brand-400" />
                        </div>
                        <div className="min-w-0">
                          <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">
                            <TruncateWithTooltip text={item.title || '无标题'} maxWidth={200} />
                          </p>
                          <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">
                            <TruncateWithTooltip text={item.content || ''} maxWidth={280} />
                          </p>
                          <p className="text-xs text-gray-400 dark:text-gray-500 mt-1 flex items-center gap-1">
                            <User size={12} />
                            用户 #{item.userId}
                          </p>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <span className="px-2.5 py-1 bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 rounded-lg text-xs font-medium">
                        {getTypeLabel(item.feedbackType)}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      {getStatusBadge(item.status)}
                    </td>
                    <td className="px-6 py-4">
                      <div className="text-sm text-gray-600 dark:text-gray-300 flex items-center gap-1">
                        <Clock size={14} className="text-gray-400" />
                        {formatDateTime(item.createTime)}
                      </div>
                      {item.processTime && (
                        <div className="text-xs text-gray-400 mt-1">
                          处理于 {formatDateTime(item.processTime)}
                        </div>
                      )}
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button 
                          onClick={() => { setSelectedFeedback(item); setDetailOpen(true); }}
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
                        <MessageSquare size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无反馈数据</p>
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
              disabled={queryParams.pageNum === 1 || loading}
              onClick={() => handlePageChange((queryParams.pageNum || 1) - 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronLeft size={18} />
            </button>
            <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">
              {queryParams.pageNum} / {Math.ceil(total / (queryParams.pageSize || 10)) || 1}
            </span>
            <button 
              disabled={queryParams.pageNum === Math.ceil(total / (queryParams.pageSize || 10)) || loading || total === 0}
              onClick={() => handlePageChange((queryParams.pageNum || 1) + 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>

      {/* 反馈详情弹窗 */}
      <FeedbackDetailModal
        isOpen={detailOpen}
        onClose={() => { setDetailOpen(false); setSelectedFeedback(null); }}
        feedback={selectedFeedback}
        onStatusChange={fetchFeedbacks}
      />
    </div>
  );
};
