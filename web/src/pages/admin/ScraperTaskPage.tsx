import React, { useState, useEffect, useCallback } from 'react';
import { 
  Search, 
  RefreshCw,
  Clock,
  CheckCircle,
  XCircle,
  AlertCircle,
  ChevronLeft,
  ChevronRight,
  FileText,
  Loader,
  Play,
  Eye
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { ScraperTaskResponse, ScraperTaskPageResponse, ScraperConfigResponse } from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

const statusConfig: Record<string, { icon: React.ElementType; color: string; bgColor: string; label: string }> = {
  PENDING: { icon: Clock, color: 'text-yellow-600', bgColor: 'bg-yellow-100 dark:bg-yellow-900/30', label: '等待中' },
  RUNNING: { icon: Loader, color: 'text-blue-600', bgColor: 'bg-blue-100 dark:bg-blue-900/30', label: '运行中' },
  SUCCESS: { icon: CheckCircle, color: 'text-green-600', bgColor: 'bg-green-100 dark:bg-green-900/30', label: '成功' },
  PARTIAL: { icon: AlertCircle, color: 'text-orange-600', bgColor: 'bg-orange-100 dark:bg-orange-900/30', label: '部分成功' },
  FAILED: { icon: XCircle, color: 'text-red-600', bgColor: 'bg-red-100 dark:bg-red-900/30', label: '失败' },
};

const getStatusDisplay = (status?: string) => {
  return statusConfig[status || ''] || statusConfig.PENDING;
};

const formatDuration = (ms?: number) => {
  if (!ms) return '-';
  if (ms < 1000) return `${ms}ms`;
  if (ms < 60000) return `${(ms / 1000).toFixed(1)}s`;
  return `${Math.floor(ms / 60000)}m ${Math.floor((ms % 60000) / 1000)}s`;
};

const formatDateTime = (dateStr?: string) => {
  if (!dateStr) return '-';
  try {
    const date = new Date(dateStr);
    return date.toLocaleString('zh-CN', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
    });
  } catch {
    return dateStr;
  }
};

interface TaskDetailModalProps {
  isOpen: boolean;
  onClose: () => void;
  task: ScraperTaskResponse | null;
}

const TaskDetailModal: React.FC<TaskDetailModalProps> = ({ isOpen, onClose, task }) => {
  if (!isOpen || !task) return null;

  const statusDisplay = getStatusDisplay(task.status);
  const StatusIcon = statusDisplay.icon;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">任务详情</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <XCircle size={20} />
          </button>
        </div>
        
        <div className="p-6 space-y-4">
          {/* Status */}
          <div className="flex items-center gap-3">
            <div className={`p-3 rounded-xl ${statusDisplay.bgColor}`}>
              <StatusIcon size={24} className={`${statusDisplay.color} ${task.status === 'RUNNING' ? 'animate-spin' : ''}`} />
            </div>
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">任务状态</p>
              <p className={`text-lg font-semibold ${statusDisplay.color}`}>{statusDisplay.label}</p>
            </div>
          </div>

          {/* Info Grid */}
          <div className="grid grid-cols-2 gap-4">
            <div className="bg-gray-50 dark:bg-gray-800 rounded-xl p-4">
              <p className="text-sm text-gray-500 dark:text-gray-400">配置名称</p>
              <p className="font-medium text-gray-900 dark:text-white">{task.configName || '-'}</p>
            </div>
            <div className="bg-gray-50 dark:bg-gray-800 rounded-xl p-4">
              <p className="text-sm text-gray-500 dark:text-gray-400">执行耗时</p>
              <p className="font-medium text-gray-900 dark:text-white">{formatDuration(task.durationMs)}</p>
            </div>
          </div>

          {/* Article Stats */}
          <div className="grid grid-cols-3 gap-4">
            <div className="text-center p-4 bg-blue-50 dark:bg-blue-900/20 rounded-xl">
              <p className="text-2xl font-bold text-blue-600 dark:text-blue-400">{task.totalArticles || 0}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">总文章数</p>
            </div>
            <div className="text-center p-4 bg-green-50 dark:bg-green-900/20 rounded-xl">
              <p className="text-2xl font-bold text-green-600 dark:text-green-400">{task.successCount || 0}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">成功</p>
            </div>
            <div className="text-center p-4 bg-red-50 dark:bg-red-900/20 rounded-xl">
              <p className="text-2xl font-bold text-red-600 dark:text-red-400">{task.failCount || 0}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">失败</p>
            </div>
          </div>

          {/* Time Info */}
          <div className="space-y-2">
            <div className="flex justify-between text-sm">
              <span className="text-gray-500 dark:text-gray-400">开始时间</span>
              <span className="text-gray-900 dark:text-white">{formatDateTime(task.startTime)}</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-gray-500 dark:text-gray-400">结束时间</span>
              <span className="text-gray-900 dark:text-white">{formatDateTime(task.endTime)}</span>
            </div>
            <div className="flex justify-between text-sm">
              <span className="text-gray-500 dark:text-gray-400">创建时间</span>
              <span className="text-gray-900 dark:text-white">{formatDateTime(task.createTime)}</span>
            </div>
          </div>

          {/* Error Message */}
          {task.errorMessage && (
            <div className="bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-xl p-4">
              <p className="text-sm font-medium text-red-800 dark:text-red-300 mb-1">错误信息</p>
              <p className="text-sm text-red-600 dark:text-red-400 break-words">{task.errorMessage}</p>
            </div>
          )}

          {/* Created Articles */}
          {task.createdArticleIds && task.createdArticleIds.length > 0 && (
            <div className="bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-xl p-4">
              <p className="text-sm font-medium text-green-800 dark:text-green-300 mb-2">已创建文章ID</p>
              <div className="flex flex-wrap gap-2">
                {task.createdArticleIds.slice(0, 10).map((id) => (
                  <span key={id} className="px-2 py-1 text-xs bg-green-100 dark:bg-green-900/50 text-green-700 dark:text-green-300 rounded">
                    #{id}
                  </span>
                ))}
                {task.createdArticleIds.length > 10 && (
                  <span className="px-2 py-1 text-xs text-gray-500 dark:text-gray-400">
                    +{task.createdArticleIds.length - 10} 更多
                  </span>
                )}
              </div>
            </div>
          )}
        </div>

        <div className="flex items-center justify-end px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50 dark:bg-gray-900/50">
          <button
            onClick={onClose}
            className="px-6 py-2.5 bg-brand-600 hover:bg-brand-700 text-white text-sm font-medium rounded-xl transition-colors"
          >
            关闭
          </button>
        </div>
      </div>
    </div>
  );
};

export const ScraperTaskPage: React.FC = () => {
  const [tasks, setTasks] = useState<ScraperTaskResponse[]>([]);
  const [configs, setConfigs] = useState<ScraperConfigResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [configFilter, setConfigFilter] = useState<number | 'all'>('all');
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedTask, setSelectedTask] = useState<ScraperTaskResponse | null>(null);
  const [isDetailModalOpen, setIsDetailModalOpen] = useState(false);
  const pageSize = 10;

  const fetchTasks = useCallback(async () => {
    setLoading(true);
    try {
      const response = await api.getAllTasks({ page: 1, size: 100 });
      if (response.data.code === 0 && response.data.data) {
        const pageData = response.data.data as ScraperTaskPageResponse;
        setTasks(pageData.records || []);
      }
    } catch (error) {
      toast.error('获取任务列表失败');
    } finally {
      setLoading(false);
    }
  }, []);

  const fetchConfigs = useCallback(async () => {
    try {
      const response = await api.getAllConfigs();
      if (response.data.code === 0 && response.data.data) {
        setConfigs(response.data.data);
      }
    } catch (error) {
      console.error('获取配置列表失败', error);
    }
  }, []);

  useEffect(() => {
    fetchTasks();
    fetchConfigs();
  }, [fetchTasks, fetchConfigs]);

  const handleExecuteAll = async () => {
    try {
      await api.executeAllTasks();
      toast.success('已触发所有配置的抓取任务');
      setTimeout(fetchTasks, 2000);
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '执行失败');
    }
  };

  const filteredTasks = tasks.filter(task => {
    const matchesSearch = 
      task.configName?.toLowerCase().includes(searchTerm.toLowerCase()) ||
      task.statusDescription?.toLowerCase().includes(searchTerm.toLowerCase());
    
    const matchesStatus = statusFilter === 'all' || task.status === statusFilter;
    
    const matchesConfig = configFilter === 'all' || task.configId === configFilter;

    return matchesSearch && matchesStatus && matchesConfig;
  });

  const totalPages = Math.ceil(filteredTasks.length / pageSize);
  const paginatedTasks = filteredTasks.slice(
    (currentPage - 1) * pageSize,
    currentPage * pageSize
  );

  const statusOptions = [
    { value: 'all', label: '全部状态' },
    { value: 'PENDING', label: '等待中' },
    { value: 'RUNNING', label: '运行中' },
    { value: 'SUCCESS', label: '成功' },
    { value: 'PARTIAL', label: '部分成功' },
    { value: 'FAILED', label: '失败' },
  ];

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">抓取任务管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">查看和监控网页抓取任务的执行状态</p>
        </div>
        <button
          onClick={handleExecuteAll}
          className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-xl text-sm font-bold hover:bg-green-700 shadow-lg shadow-green-600/20 transition-all active:scale-95"
        >
          <Play size={18} />
          执行所有配置
        </button>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-blue-100 dark:bg-blue-900/30 rounded-xl">
              <FileText size={20} className="text-blue-600 dark:text-blue-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">{tasks.length}</p>
              <p className="text-xs text-gray-500 dark:text-gray-400">总任务数</p>
            </div>
          </div>
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-yellow-100 dark:bg-yellow-900/30 rounded-xl">
              <Loader size={20} className="text-yellow-600 dark:text-yellow-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">
                {tasks.filter(t => t.status === 'RUNNING' || t.status === 'PENDING').length}
              </p>
              <p className="text-xs text-gray-500 dark:text-gray-400">进行中</p>
            </div>
          </div>
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-green-100 dark:bg-green-900/30 rounded-xl">
              <CheckCircle size={20} className="text-green-600 dark:text-green-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">
                {tasks.filter(t => t.status === 'SUCCESS' || t.status === 'PARTIAL').length}
              </p>
              <p className="text-xs text-gray-500 dark:text-gray-400">已完成</p>
            </div>
          </div>
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-red-100 dark:bg-red-900/30 rounded-xl">
              <XCircle size={20} className="text-red-600 dark:text-red-400" />
            </div>
            <div>
              <p className="text-2xl font-bold text-gray-900 dark:text-white">
                {tasks.filter(t => t.status === 'FAILED').length}
              </p>
              <p className="text-xs text-gray-500 dark:text-gray-400">失败</p>
            </div>
          </div>
        </div>
      </div>

      {/* Search & Filters */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <div className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input
              type="text"
              placeholder="搜索配置名称..."
              value={searchTerm}
              onChange={(e) => {
                setSearchTerm(e.target.value);
                setCurrentPage(1);
              }}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select
              value={statusFilter}
              onChange={(e) => {
                setStatusFilter(e.target.value);
                setCurrentPage(1);
              }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              {statusOptions.map(opt => (
                <option key={opt.value} value={opt.value}>{opt.label}</option>
              ))}
            </select>
            <select
              value={configFilter}
              onChange={(e) => {
                setConfigFilter(e.target.value === 'all' ? 'all' : Number(e.target.value));
                setCurrentPage(1);
              }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              <option value="all">全部配置</option>
              {configs.map(config => (
                <option key={config.id} value={config.id}>{config.name}</option>
              ))}
            </select>
            <button
              onClick={fetchTasks}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </div>
      </div>

      {/* Tasks Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">任务ID</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">配置名称</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">文章统计</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">耗时</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">创建时间</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                <tr>
                  <td colSpan={7} className="px-6 py-16 text-center">
                    <RefreshCw className="w-8 h-8 text-brand-600 animate-spin mx-auto mb-3" />
                    <p className="text-gray-500 dark:text-gray-400">加载中...</p>
                  </td>
                </tr>
              ) : paginatedTasks.length === 0 ? (
                <tr>
                  <td colSpan={7} className="px-6 py-16 text-center">
                    <FileText className="w-12 h-12 text-gray-300 dark:text-gray-600 mx-auto mb-3" />
                    <p className="text-gray-500 dark:text-gray-400">暂无任务数据</p>
                  </td>
                </tr>
              ) : (
                paginatedTasks.map((task) => {
                  const statusDisplay = getStatusDisplay(task.status);
                  const StatusIcon = statusDisplay.icon;
                  
                  return (
                    <tr key={task.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                      <td className="px-6 py-4">
                        <span className="text-sm font-mono text-gray-600 dark:text-gray-400">#{task.id}</span>
                      </td>
                      <td className="px-6 py-4">
                        <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">{task.configName || '-'}</p>
                      </td>
                      <td className="px-6 py-4">
                        <span className={`inline-flex items-center gap-1.5 px-2.5 py-1 text-xs font-medium rounded-full ${statusDisplay.bgColor} ${statusDisplay.color}`}>
                          <StatusIcon size={12} className={task.status === 'RUNNING' ? 'animate-spin' : ''} />
                          {statusDisplay.label}
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2 text-sm">
                          <span className="text-green-600 dark:text-green-400">{task.successCount || 0}</span>
                          <span className="text-gray-400">/</span>
                          <span className="text-gray-600 dark:text-gray-300">{task.totalArticles || 0}</span>
                          {(task.failCount || 0) > 0 && (
                            <>
                              <span className="text-gray-400">/</span>
                              <span className="text-red-600 dark:text-red-400">{task.failCount}</span>
                            </>
                          )}
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-600 dark:text-gray-400">
                          {formatDuration(task.durationMs)}
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-500 dark:text-gray-400">
                          {formatDateTime(task.createTime)}
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                          <button
                            onClick={() => {
                              setSelectedTask(task);
                              setIsDetailModalOpen(true);
                            }}
                            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                            title="查看详情"
                          >
                            <Eye size={18} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              共 <span className="font-bold text-gray-900 dark:text-white">{filteredTasks.length}</span> 条记录
            </p>
            <div className="flex items-center gap-2">
              <button
                onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
                disabled={currentPage === 1}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
              >
                <ChevronLeft size={18} />
              </button>
              <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">
                {currentPage} / {totalPages}
              </span>
              <button
                onClick={() => setCurrentPage(p => Math.min(totalPages, p + 1))}
                disabled={currentPage === totalPages}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
              >
                <ChevronRight size={18} />
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Detail Modal */}
      <TaskDetailModal
        isOpen={isDetailModalOpen}
        onClose={() => setIsDetailModalOpen(false)}
        task={selectedTask}
      />
    </div>
  );
};
