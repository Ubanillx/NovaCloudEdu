import React, { useState, useEffect, useCallback, useRef } from 'react';
import {
  Search,
  Edit2,
  Trash2,
  AlertTriangle,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  GraduationCap,
  CheckCircle2,
  XCircle,
  UserCheck,
  FileText,
  User,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type {
  TeacherResponse,
  UpdateTeacherRequest,
  TeacherApplicationResponse,
  ReviewApplicationRequest,
  UserPublicResponse,
} from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// ============ 状态映射 ============

const APP_STATUS_MAP: Record<number, string> = { 0: '待审核', 1: '已通过', 2: '已拒绝' };

const getAppStatusBadge = (status?: number) => {
  switch (status) {
    case 0: return 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400 border-yellow-200 dark:border-yellow-800';
    case 1: return 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800';
    case 2: return 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800';
    default: return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700';
  }
};

// ============ 编辑讲师弹窗 ============

interface TeacherEditModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  teacher: TeacherResponse | null;
}

const TeacherEditModal: React.FC<TeacherEditModalProps> = ({ isOpen, onClose, onSuccess, teacher }) => {
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({ name: '', introduction: '', expertise: '' });

  useEffect(() => {
    if (teacher) {
      setFormData({
        name: teacher.name || '',
        introduction: teacher.introduction || '',
        expertise: (teacher.expertise || []).join(', '),
      });
    }
  }, [teacher, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!teacher?.id || !formData.name.trim()) { toast.warning('讲师姓名不能为空'); return; }
    setLoading(true);
    try {
      const expertiseArr = formData.expertise ? formData.expertise.split(/[,，]/).map(t => t.trim()).filter(Boolean) : [];
      const req: UpdateTeacherRequest = {
        name: formData.name,
        introduction: formData.introduction || undefined,
        expertise: expertiseArr,
      };
      const res = await api.updateTeacher({ id: teacher.id as unknown as number, updateTeacherRequest: req });
      if (res.data.code === 0) { toast.success('更新成功'); onSuccess(); onClose(); }
      else toast.error(res.data.message || '更新失败');
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    } finally { setLoading(false); }
  };

  if (!isOpen || !teacher) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">编辑讲师信息</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>
        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">讲师姓名 *</label>
            <input type="text" value={formData.name}
              onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="讲师姓名" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">讲师简介</label>
            <textarea value={formData.introduction} rows={3}
              onChange={(e) => setFormData(prev => ({ ...prev, introduction: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="讲师简介" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">专业领域（逗号分隔）</label>
            <input type="text" value={formData.expertise}
              onChange={(e) => setFormData(prev => ({ ...prev, expertise: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="数学, 物理, 编程" />
          </div>
        </form>
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button type="button" onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
          <button onClick={handleSubmit} disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2">
            {loading && <RefreshCw size={16} className="animate-spin" />}
            保存修改
          </button>
        </div>
      </div>
    </div>
  );
};

// ============ 移除讲师确认弹窗 ============

interface RemoveConfirmModalProps {
  isOpen: boolean;
  onClose: () => void;
  onConfirm: () => void;
  teacher: TeacherResponse | null;
  loading: boolean;
}

const RemoveConfirmModal: React.FC<RemoveConfirmModalProps> = ({ isOpen, onClose, onConfirm, teacher, loading }) => {
  if (!isOpen || !teacher) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">确认移除讲师</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>
        <div className="p-6">
          <div className="flex items-start gap-4">
            <div className="w-12 h-12 rounded-xl bg-red-50 dark:bg-red-900/20 flex items-center justify-center flex-shrink-0">
              <AlertTriangle size={24} className="text-red-500" />
            </div>
            <div>
              <p className="text-sm text-gray-700 dark:text-gray-300">
                确定要移除讲师 <span className="font-bold text-gray-900 dark:text-white">{teacher.name}</span> 吗？
              </p>
              <p className="text-xs text-gray-500 dark:text-gray-400 mt-2">
                移除后该用户角色将降为学生，需要重新申请才能再次成为讲师。
              </p>
            </div>
          </div>
        </div>
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button type="button" onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">取消</button>
          <button onClick={onConfirm} disabled={loading}
            className="px-6 py-2 bg-red-600 text-white text-sm font-bold rounded-xl hover:bg-red-700 shadow-lg shadow-red-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2">
            {loading && <RefreshCw size={16} className="animate-spin" />}
            <Trash2 size={16} /> 确认移除
          </button>
        </div>
      </div>
    </div>
  );
};

// ============ 审核弹窗 ============

interface ReviewModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  application: TeacherApplicationResponse | null;
}

const ReviewModal: React.FC<ReviewModalProps> = ({ isOpen, onClose, onSuccess, application }) => {
  const [loading, setLoading] = useState(false);
  const [rejectReason, setRejectReason] = useState('');

  useEffect(() => { setRejectReason(''); }, [isOpen]);

  const handleReview = async (approved: boolean) => {
    if (!application?.id) return;
    if (!approved && !rejectReason.trim()) { toast.warning('请输入拒绝原因'); return; }
    setLoading(true);
    try {
      const req: ReviewApplicationRequest = {
        applicationId: application.id as unknown as number,
        approved,
        rejectReason: approved ? undefined : rejectReason.trim(),
      };
      const res = await api.reviewApplication({ reviewApplicationRequest: req });
      if (res.data.code === 0) { toast.success(approved ? '已通过' : '已拒绝'); onSuccess(); onClose(); }
      else toast.error(res.data.message || '操作失败');
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally { setLoading(false); }
  };

  if (!isOpen || !application) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">审核讲师申请</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>
        <div className="p-6 space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <span className="text-xs text-gray-400 font-medium">申请人</span>
              <p className="text-sm font-bold text-gray-900 dark:text-white">{application.name || '-'}</p>
            </div>
            <div>
              <span className="text-xs text-gray-400 font-medium">状态</span>
              <p><span className={`px-2 py-0.5 rounded-lg text-xs font-bold border ${getAppStatusBadge(application.status)}`}>
                {APP_STATUS_MAP[application.status ?? 0] || '未知'}
              </span></p>
            </div>
          </div>
          <div>
            <span className="text-xs text-gray-400 font-medium">简介</span>
            <p className="text-sm text-gray-700 dark:text-gray-300 mt-1">{application.introduction || '-'}</p>
          </div>
          <div>
            <span className="text-xs text-gray-400 font-medium">专业领域</span>
            <div className="flex flex-wrap gap-1 mt-1">
              {(application.expertise || []).map((e, i) => (
                <span key={i} className="px-2 py-0.5 text-xs font-medium bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400 rounded-lg">{e}</span>
              ))}
              {(!application.expertise || application.expertise.length === 0) && <span className="text-sm text-gray-400">-</span>}
            </div>
          </div>
          {application.certificateUrl && (
            <div>
              <span className="text-xs text-gray-400 font-medium">资质证书</span>
              <a href={application.certificateUrl} target="_blank" rel="noopener noreferrer"
                className="text-sm text-brand-600 hover:underline block mt-1">{application.certificateUrl}</a>
            </div>
          )}
          {application.status === 0 && (
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">拒绝原因（拒绝时必填）</label>
              <textarea value={rejectReason} rows={2}
                onChange={(e) => setRejectReason(e.target.value)}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
                placeholder="如拒绝，请输入原因..." />
            </div>
          )}
        </div>
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button type="button" onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">关闭</button>
          {application.status === 0 && (
            <>
              <button onClick={() => handleReview(false)} disabled={loading}
                className="px-5 py-2 bg-red-600 text-white text-sm font-bold rounded-xl hover:bg-red-700 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2">
                {loading && <RefreshCw size={16} className="animate-spin" />}
                <XCircle size={16} /> 拒绝
              </button>
              <button onClick={() => handleReview(true)} disabled={loading}
                className="px-5 py-2 bg-green-600 text-white text-sm font-bold rounded-xl hover:bg-green-700 shadow-lg shadow-green-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2">
                {loading && <RefreshCw size={16} className="animate-spin" />}
                <CheckCircle2 size={16} /> 通过
              </button>
            </>
          )}
        </div>
      </div>
    </div>
  );
};

// ============ 教师管理主页面 ============

export const TeacherManagementPage: React.FC = () => {
  const [activeTab, setActiveTab] = useState<'teachers' | 'applications'>('teachers');

  // 讲师列表状态
  const [teachers, setTeachers] = useState<TeacherResponse[]>([]);
  const [teacherLoading, setTeacherLoading] = useState(false);
  const [teacherPage, setTeacherPage] = useState(1);
  const [teacherHasMore, setTeacherHasMore] = useState(true);
  const [teacherKeyword, setTeacherKeyword] = useState('');
  const [editModalOpen, setEditModalOpen] = useState(false);
  const [editingTeacher, setEditingTeacher] = useState<TeacherResponse | null>(null);
  const [removeModalOpen, setRemoveModalOpen] = useState(false);
  const [removingTeacher, setRemovingTeacher] = useState<TeacherResponse | null>(null);
  const [removeLoading, setRemoveLoading] = useState(false);

  // 申请列表状态
  const [applications, setApplications] = useState<TeacherApplicationResponse[]>([]);
  const [appLoading, setAppLoading] = useState(false);
  const [appPage, setAppPage] = useState(1);
  const [appHasMore, setAppHasMore] = useState(true);
  const [appStatusFilter, setAppStatusFilter] = useState<number | undefined>(undefined);
  const [reviewModalOpen, setReviewModalOpen] = useState(false);
  const [reviewingApp, setReviewingApp] = useState<TeacherApplicationResponse | null>(null);

  // 用户信息缓存
  const [userMap, setUserMap] = useState<Record<string, UserPublicResponse>>({});
  const userMapRef = useRef(userMap);
  userMapRef.current = userMap;

  const fetchUserInfos = useCallback(async (userIds: (number | undefined)[]) => {
    const ids = userIds.filter((id): id is number => id != null);
    const uniqueIds = [...new Set(ids.map(id => String(id)))].filter(id => !userMapRef.current[id]);
    if (uniqueIds.length === 0) return;
    const results = await Promise.allSettled(
      uniqueIds.map(id => api.getUserPublicInfo({ id: id as unknown as number }))
    );
    const newMap: Record<string, UserPublicResponse> = {};
    results.forEach((r, i) => {
      if (r.status === 'fulfilled' && r.value.data.code === 0 && r.value.data.data) {
        newMap[uniqueIds[i]] = r.value.data.data;
      }
    });
    if (Object.keys(newMap).length > 0) {
      setUserMap(prev => ({ ...prev, ...newMap }));
    }
  }, []);

  const pageSize = 10;

  const fetchTeachers = useCallback(async () => {
    setTeacherLoading(true);
    try {
      const res = await api.listTeachers({ page: teacherPage, size: pageSize, keyword: teacherKeyword || undefined });
      if (res.data.code === 0) {
        const list = res.data.data || [];
        setTeachers(list);
        setTeacherHasMore(list.length >= pageSize);
        fetchUserInfos(list.map(t => t.userId));
      } else toast.error(res.data.message || '获取讲师列表失败');
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally { setTeacherLoading(false); }
  }, [teacherPage, teacherKeyword, fetchUserInfos]);

  const fetchApplications = useCallback(async () => {
    setAppLoading(true);
    try {
      const res = await api.listApplications({ status: appStatusFilter, page: appPage, size: pageSize });
      if (res.data.code === 0) {
        const list = res.data.data || [];
        setApplications(list);
        setAppHasMore(list.length >= pageSize);
        fetchUserInfos(list.map(a => a.userId));
      } else toast.error(res.data.message || '获取申请列表失败');
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally { setAppLoading(false); }
  }, [appPage, appStatusFilter, fetchUserInfos]);

  const handleRemoveTeacher = useCallback(async () => {
    if (!removingTeacher?.id) return;
    setRemoveLoading(true);
    try {
      const res = await api.removeTeacher({ id: removingTeacher.id as unknown as number });
      if (res.data.code === 0) {
        toast.success('已移除讲师');
        setRemoveModalOpen(false);
        setRemovingTeacher(null);
        fetchTeachers();
      } else toast.error(res.data.message || '移除失败');
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    } finally { setRemoveLoading(false); }
  }, [removingTeacher, fetchTeachers]);

  useEffect(() => { if (activeTab === 'teachers') fetchTeachers(); }, [fetchTeachers, activeTab]);
  useEffect(() => { if (activeTab === 'applications') fetchApplications(); }, [fetchApplications, activeTab]);

  const tabClasses = (active: boolean) =>
    `px-6 py-3 text-sm font-bold rounded-xl transition-all ${active
      ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20'
      : 'text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-brand-600'}`;

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">教师管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理讲师信息和审核讲师申请</p>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex items-center gap-2">
        <button onClick={() => setActiveTab('teachers')} className={tabClasses(activeTab === 'teachers')}>
          <span className="flex items-center gap-2"><GraduationCap size={16} /> 讲师列表</span>
        </button>
        <button onClick={() => setActiveTab('applications')} className={tabClasses(activeTab === 'applications')}>
          <span className="flex items-center gap-2"><FileText size={16} /> 申请审核</span>
        </button>
      </div>

      {/* ============ 讲师列表 Tab ============ */}
      {activeTab === 'teachers' && (
        <>
          {/* Filter */}
          <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
            <div className="flex flex-col lg:flex-row gap-4">
              <div className="flex-1 relative group">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
                <input type="text" value={teacherKeyword}
                  onChange={(e) => { setTeacherKeyword(e.target.value); setTeacherPage(1); }}
                  placeholder="搜索讲师姓名..."
                  className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all" />
              </div>
              <div className="flex flex-wrap items-center gap-3">
                <button type="button" onClick={() => fetchTeachers()}
                  className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all">
                  <RefreshCw size={20} className={teacherLoading ? 'animate-spin' : ''} />
                </button>
              </div>
            </div>
          </div>

          {/* Table */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full text-left border-collapse admin-table">
                <thead>
                  <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800">
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">讲师信息</th>
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">专业领域</th>
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">关联用户</th>
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">创建时间</th>
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
                  {teacherLoading ? (
                    Array.from({ length: 5 }).map((_, i) => (
                      <tr key={i} className="animate-pulse">
                        <td colSpan={5} className="px-6 py-8 h-16">
                          <div className="flex gap-4"><div className="w-10 h-10 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                            <div className="space-y-2 flex-1"><div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" /><div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" /></div>
                          </div>
                        </td>
                      </tr>
                    ))
                  ) : teachers.length > 0 ? (
                    teachers.map((t) => (
                      <tr key={String(t.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                        <td className="px-6 py-4">
                          <div className="flex items-center gap-3">
                            <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand-50 to-indigo-50 dark:from-gray-800 dark:to-gray-800 border border-gray-100 dark:border-gray-700 flex items-center justify-center">
                              <GraduationCap size={20} className="text-brand-500" />
                            </div>
                            <div>
                              <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">{t.name || '未设置'}</p>
                              {t.introduction && <p className="text-xs text-gray-500 dark:text-gray-400 truncate max-w-[200px]">{t.introduction}</p>}
                            </div>
                          </div>
                        </td>
                        <td className="px-6 py-4">
                          <div className="flex flex-wrap gap-1">
                            {(t.expertise || []).slice(0, 4).map((e, i) => (
                              <span key={i} className="px-2 py-0.5 text-xs font-medium bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400 rounded-lg">{e}</span>
                            ))}
                            {(!t.expertise || t.expertise.length === 0) && <span className="text-sm text-gray-400">-</span>}
                          </div>
                        </td>
                        <td className="px-6 py-4">
                          {t.userId ? (() => {
                            const u = userMap[String(t.userId)];
                            return u ? (
                              <div className="flex items-center gap-2.5">
                                {u.userAvatar ? (
                                  <img src={u.userAvatar} alt="" className="w-8 h-8 rounded-lg object-cover border border-gray-100 dark:border-gray-700" />
                                ) : (
                                  <div className="w-8 h-8 rounded-lg bg-gray-100 dark:bg-gray-800 flex items-center justify-center">
                                    <User size={16} className="text-gray-400" />
                                  </div>
                                )}
                                <div>
                                  <p className="text-sm font-medium text-gray-900 dark:text-white">{u.userName || '未设置'}</p>
                                  <p className="text-xs text-gray-400">{u.role === 'admin' ? '管理员' : u.role === 'teacher' ? '教师' : '学生'}</p>
                                </div>
                              </div>
                            ) : (
                              <span className="text-xs text-gray-400">加载中...</span>
                            );
                          })() : <span className="text-sm text-gray-400">-</span>}
                        </td>
                        <td className="px-6 py-4 text-sm text-gray-500 dark:text-gray-400">
                          {t.createTime ? new Date(t.createTime).toLocaleDateString() : '-'}
                        </td>
                        <td className="px-6 py-4">
                          <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                            <button onClick={() => { setEditingTeacher(t); setEditModalOpen(true); }}
                              className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" title="编辑">
                              <Edit2 size={18} />
                            </button>
                            <button onClick={() => { setRemovingTeacher(t); setRemoveModalOpen(true); }}
                              className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" title="移除讲师">
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
                            <GraduationCap size={32} className="text-gray-300" />
                          </div>
                          <p className="text-gray-500 dark:text-gray-400 font-medium">暂无讲师数据</p>
                        </div>
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>

            {/* Pagination */}
            <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between">
              <p className="text-sm text-gray-500 dark:text-gray-400">
                第 <span className="font-bold text-gray-900 dark:text-white">{teacherPage}</span> 页
                {teachers.length > 0 && <>，当前 <span className="font-bold text-gray-900 dark:text-white">{teachers.length}</span> 条</>}
              </p>
              <div className="flex items-center gap-2">
                <button disabled={teacherPage === 1 || teacherLoading} onClick={() => setTeacherPage(p => p - 1)}
                  className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
                  <ChevronLeft size={18} />
                </button>
                <button disabled={!teacherHasMore || teacherLoading} onClick={() => setTeacherPage(p => p + 1)}
                  className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
                  <ChevronRight size={18} />
                </button>
              </div>
            </div>
          </div>
        </>
      )}

      {/* ============ 申请审核 Tab ============ */}
      {activeTab === 'applications' && (
        <>
          {/* Filter */}
          <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm">
            <div className="flex items-center justify-between gap-3">
              <select value={appStatusFilter ?? ''}
                onChange={(e) => { setAppStatusFilter(e.target.value === '' ? undefined : Number(e.target.value)); setAppPage(1); }}
                className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer">
                <option value="">所有状态</option>
                <option value={0}>待审核</option>
                <option value={1}>已通过</option>
                <option value={2}>已拒绝</option>
              </select>
              <button type="button" onClick={() => fetchApplications()}
                className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all">
                <RefreshCw size={20} className={appLoading ? 'animate-spin' : ''} />
              </button>
            </div>
          </div>

          {/* Table */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full text-left border-collapse admin-table">
                <thead>
                  <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800">
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">申请人</th>
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">专业领域</th>
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">申请时间</th>
                    <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
                  {appLoading ? (
                    Array.from({ length: 5 }).map((_, i) => (
                      <tr key={i} className="animate-pulse">
                        <td colSpan={5} className="px-6 py-8 h-16">
                          <div className="flex gap-4"><div className="w-10 h-10 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                            <div className="space-y-2 flex-1"><div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" /></div>
                          </div>
                        </td>
                      </tr>
                    ))
                  ) : applications.length > 0 ? (
                    applications.map((app) => (
                      <tr key={String(app.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                        <td className="px-6 py-4">
                          <div className="flex items-center gap-3">
                            {(() => {
                              const u = app.userId ? userMap[String(app.userId)] : null;
                              return u?.userAvatar ? (
                                <img src={u.userAvatar} alt="" className="w-10 h-10 rounded-xl object-cover border border-gray-100 dark:border-gray-700" />
                              ) : (
                                <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-yellow-50 to-orange-50 dark:from-gray-800 dark:to-gray-800 border border-gray-100 dark:border-gray-700 flex items-center justify-center">
                                  <UserCheck size={20} className="text-yellow-500" />
                                </div>
                              );
                            })()}
                            <div>
                              <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors">{app.name || '未设置'}</p>
                              {(() => {
                                const u = app.userId ? userMap[String(app.userId)] : null;
                                return u ? (
                                  <p className="text-xs text-gray-500 dark:text-gray-400">用户：{u.userName || '未设置'}</p>
                                ) : (
                                  app.introduction && <p className="text-xs text-gray-500 dark:text-gray-400 truncate max-w-[200px]">{app.introduction}</p>
                                );
                              })()}
                            </div>
                          </div>
                        </td>
                        <td className="px-6 py-4">
                          <div className="flex flex-wrap gap-1">
                            {(app.expertise || []).slice(0, 3).map((e, i) => (
                              <span key={i} className="px-2 py-0.5 text-xs font-medium bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400 rounded-lg">{e}</span>
                            ))}
                          </div>
                        </td>
                        <td className="px-6 py-4">
                          <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${getAppStatusBadge(app.status)}`}>
                            {APP_STATUS_MAP[app.status ?? 0] || '未知'}
                          </span>
                          {app.status === 2 && app.rejectReason && (
                            <p className="text-xs text-red-500 mt-1 truncate max-w-[150px]" title={app.rejectReason}>原因：{app.rejectReason}</p>
                          )}
                        </td>
                        <td className="px-6 py-4 text-sm text-gray-500 dark:text-gray-400">
                          {app.createTime ? new Date(app.createTime).toLocaleDateString() : '-'}
                        </td>
                        <td className="px-6 py-4">
                          <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                            <button onClick={() => { setReviewingApp(app); setReviewModalOpen(true); }}
                              className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                              title={app.status === 0 ? '审核' : '查看详情'}>
                              {app.status === 0 ? <CheckCircle2 size={18} /> : <Search size={18} />}
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
                          <p className="text-gray-500 dark:text-gray-400 font-medium">暂无申请数据</p>
                        </div>
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>

            {/* Pagination */}
            <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between">
              <p className="text-sm text-gray-500 dark:text-gray-400">
                第 <span className="font-bold text-gray-900 dark:text-white">{appPage}</span> 页
                {applications.length > 0 && <>，当前 <span className="font-bold text-gray-900 dark:text-white">{applications.length}</span> 条</>}
              </p>
              <div className="flex items-center gap-2">
                <button disabled={appPage === 1 || appLoading} onClick={() => setAppPage(p => p - 1)}
                  className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
                  <ChevronLeft size={18} />
                </button>
                <button disabled={!appHasMore || appLoading} onClick={() => setAppPage(p => p + 1)}
                  className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
                  <ChevronRight size={18} />
                </button>
              </div>
            </div>
          </div>
        </>
      )}

      {/* Modals */}
      <TeacherEditModal
        isOpen={editModalOpen}
        onClose={() => { setEditModalOpen(false); setEditingTeacher(null); }}
        onSuccess={fetchTeachers}
        teacher={editingTeacher}
      />
      <RemoveConfirmModal
        isOpen={removeModalOpen}
        onClose={() => { setRemoveModalOpen(false); setRemovingTeacher(null); }}
        onConfirm={handleRemoveTeacher}
        teacher={removingTeacher}
        loading={removeLoading}
      />
      <ReviewModal
        isOpen={reviewModalOpen}
        onClose={() => { setReviewModalOpen(false); setReviewingApp(null); }}
        onSuccess={fetchApplications}
        application={reviewingApp}
      />
    </div>
  );
};
