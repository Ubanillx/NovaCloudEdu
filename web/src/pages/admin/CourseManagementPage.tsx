import React, { useState, useEffect, useCallback, useRef } from 'react';
import {
  Search,
  Plus,
  Edit2,
  Trash2,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  BookOpen,
  ArrowUpCircle,
  ArrowDownCircle,
  DollarSign,
  Star,
  Users,
  Upload,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type {
  CourseResponse,
  CreateCourseRequest,
  UpdateCourseRequest,
  TeacherResponse,
} from '../../api/generated/models';
import { toast } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// ============ 课程类型 / 难度 / 状态映射 ============

const COURSE_TYPE_MAP: Record<number, string> = { 0: '公开课', 1: '付费课', 2: '会员课' };
const DIFFICULTY_MAP: Record<number, string> = { 1: '入门', 2: '初级', 3: '中级', 4: '高级', 5: '专家' };
const STATUS_MAP: Record<number, string> = { 0: '未发布', 1: '已发布', 2: '已下架' };

const getStatusBadge = (status?: number) => {
  switch (status) {
    case 1: return 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800';
    case 2: return 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800';
    default: return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700';
  }
};

const getDifficultyBadge = (difficulty?: number) => {
  switch (difficulty) {
    case 1: case 2: return 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400 border-blue-200 dark:border-blue-800';
    case 3: return 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400 border-yellow-200 dark:border-yellow-800';
    case 4: case 5: return 'bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-400 border-purple-200 dark:border-purple-800';
    default: return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700';
  }
};

// ============ 课程表单弹窗 ============

interface CourseFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  course?: CourseResponse | null;
  teachers: TeacherResponse[];
}

const CourseFormModal: React.FC<CourseFormModalProps> = ({ isOpen, onClose, onSuccess, course, teachers }) => {
  const isEdit = !!course;
  const [loading, setLoading] = useState(false);
  const [uploading, setUploading] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [formData, setFormData] = useState({
    title: '',
    subtitle: '',
    description: '',
    coverImage: '',
    price: 0,
    courseType: 0,
    difficulty: 1,
    teacherId: '' as string,
    tags: '' as string,
  });

  useEffect(() => {
    if (course) {
      setFormData({
        title: course.title || '',
        subtitle: course.subtitle || '',
        description: course.description || '',
        coverImage: course.coverImage || '',
        price: course.price || 0,
        courseType: course.courseType || 0,
        difficulty: course.difficulty || 1,
        teacherId: course.teacherId ? String(course.teacherId) : '',
        tags: (course.tags || []).join(', '),
      });
    } else {
      setFormData({
        title: '', subtitle: '', description: '', coverImage: '',
        price: 0, courseType: 0, difficulty: 1, teacherId: '', tags: '',
      });
    }
  }, [course, isOpen]);

  const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (!file.type.startsWith('image/')) { toast.error('请选择图片文件'); return; }
    if (file.size > 10 * 1024 * 1024) { toast.error('图片大小不能超过 10MB'); return; }
    setUploading(true);
    try {
      const fd = new FormData();
      fd.append('file', file);
      const response = await apiClient.post('/api/file/upload/course/cover', fd, {
        headers: { 'Content-Type': 'multipart/form-data' }
      });
      if (response.data?.code === 0 && response.data?.data?.fileUrl) {
        setFormData(prev => ({ ...prev, coverImage: response.data.data.fileUrl }));
        toast.success('上传成功');
      } else {
        toast.error(response.data?.message || '上传失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '上传失败');
    } finally {
      setUploading(false);
      if (fileInputRef.current) fileInputRef.current.value = '';
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.title.trim()) { toast.warning('请输入课程标题'); return; }

    setLoading(true);
    try {
      const tagsArr = formData.tags ? formData.tags.split(/[,，]/).map(t => t.trim()).filter(Boolean) : undefined;
      if (isEdit && course?.id) {
        const req: UpdateCourseRequest = {
          title: formData.title,
          subtitle: formData.subtitle || undefined,
          description: formData.description || undefined,
          coverImage: formData.coverImage || undefined,
          price: formData.price || undefined,
          courseType: formData.courseType,
          difficulty: formData.difficulty,
          tags: tagsArr,
        };
        const res = await api.updateCourse({ id: course.id as unknown as number, updateCourseRequest: req });
        if (res.data.code === 0) { toast.success('更新成功'); onSuccess(); onClose(); }
        else toast.error(res.data.message || '更新失败');
      } else {
        if (!formData.teacherId) { toast.warning('请选择讲师'); setLoading(false); return; }
        const req: CreateCourseRequest = {
          title: formData.title,
          subtitle: formData.subtitle || undefined,
          description: formData.description || undefined,
          coverImage: formData.coverImage || undefined,
          price: formData.price || undefined,
          courseType: formData.courseType,
          difficulty: formData.difficulty,
          teacherId: formData.teacherId as unknown as number,
          tags: tagsArr,
        };
        const res = await api.createCourse({ createCourseRequest: req });
        if (res.data.code === 0) { toast.success('创建成功'); onSuccess(); onClose(); }
        else toast.error(res.data.message || '创建失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '操作失败');
    } finally {
      setLoading(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑课程' : '新增课程'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4 overflow-y-auto">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">课程标题 *</label>
            <input type="text" value={formData.title}
              onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="请输入课程标题" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">课程副标题</label>
            <input type="text" value={formData.subtitle}
              onChange={(e) => setFormData(prev => ({ ...prev, subtitle: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="课程副标题" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">课程描述</label>
            <textarea value={formData.description} rows={3}
              onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="课程描述信息" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">封面图片</label>
            <input ref={fileInputRef} type="file" accept="image/*" onChange={handleImageUpload} className="hidden" />
            <div
              onClick={() => { if (!uploading && !formData.coverImage) fileInputRef.current?.click(); }}
              onDragOver={(e) => { e.preventDefault(); e.stopPropagation(); }}
              onDragEnter={(e) => { e.preventDefault(); e.stopPropagation(); }}
              onDrop={(e) => {
                e.preventDefault(); e.stopPropagation();
                if (uploading) return;
                const file = e.dataTransfer.files?.[0];
                if (file) {
                  const dt = new DataTransfer(); dt.items.add(file);
                  if (fileInputRef.current) { fileInputRef.current.files = dt.files; fileInputRef.current.dispatchEvent(new Event('change', { bubbles: true })); }
                }
              }}
              className={`relative w-full aspect-video rounded-xl overflow-hidden border-2 border-dashed transition-all ${
                formData.coverImage
                  ? 'border-gray-200 dark:border-gray-700'
                  : 'border-gray-300 dark:border-gray-600 hover:border-brand-400 dark:hover:border-brand-500 cursor-pointer'
              } bg-gray-50 dark:bg-gray-800/50`}
            >
              {formData.coverImage ? (
                <>
                  <img src={formData.coverImage} alt="封面预览" className="w-full h-full object-cover" />
                  <div className="absolute inset-0 bg-black/0 hover:bg-black/40 transition-all group flex items-center justify-center">
                    <div className="opacity-0 group-hover:opacity-100 transition-opacity flex items-center gap-2">
                      <button type="button" onClick={(e) => { e.stopPropagation(); fileInputRef.current?.click(); }}
                        className="p-2 bg-white/90 text-gray-700 rounded-lg hover:bg-white transition-colors" title="更换图片">
                        <Upload size={18} />
                      </button>
                      <button type="button" onClick={(e) => { e.stopPropagation(); setFormData(prev => ({ ...prev, coverImage: '' })); }}
                        className="p-2 bg-red-500/90 text-white rounded-lg hover:bg-red-600 transition-colors" title="删除图片">
                        <X size={18} />
                      </button>
                    </div>
                  </div>
                </>
              ) : (
                <div className="absolute inset-0 flex flex-col items-center justify-center gap-2">
                  {uploading ? (
                    <>
                      <RefreshCw size={32} className="text-brand-500 animate-spin" />
                      <p className="text-sm font-medium text-brand-500">上传中...</p>
                    </>
                  ) : (
                    <>
                      <Upload size={32} className="text-gray-300 dark:text-gray-600" />
                      <p className="text-sm text-gray-400 dark:text-gray-500">点击或拖拽图片到此处上传</p>
                      <p className="text-xs text-gray-300 dark:text-gray-600">推荐 16:9 比例，不超过 10MB</p>
                    </>
                  )}
                </div>
              )}
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">课程类型 *</label>
              <select value={formData.courseType}
                onChange={(e) => setFormData(prev => ({ ...prev, courseType: Number(e.target.value) }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                <option value={0}>公开课</option>
                <option value={1}>付费课</option>
                <option value={2}>会员课</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">难度等级 *</label>
              <select value={formData.difficulty}
                onChange={(e) => setFormData(prev => ({ ...prev, difficulty: Number(e.target.value) }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                <option value={1}>入门</option>
                <option value={2}>初级</option>
                <option value={3}>中级</option>
                <option value={4}>高级</option>
                <option value={5}>专家</option>
              </select>
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">价格</label>
              <input type="number" value={formData.price} min={0} step={0.01}
                onChange={(e) => setFormData(prev => ({ ...prev, price: parseFloat(e.target.value) || 0 }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="0.00" />
            </div>
            {!isEdit && (
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">讲师 *</label>
                <select value={formData.teacherId}
                  onChange={(e) => setFormData(prev => ({ ...prev, teacherId: e.target.value }))}
                  className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer">
                  <option value="">请选择讲师</option>
                  {teachers.map(t => (
                    <option key={String(t.id)} value={String(t.id)}>{t.name}</option>
                  ))}
                </select>
              </div>
            )}
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">标签（逗号分隔）</label>
            <input type="text" value={formData.tags}
              onChange={(e) => setFormData(prev => ({ ...prev, tags: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="前端, React, TypeScript" />
          </div>
        </form>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button type="button" onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">
            取消
          </button>
          <button onClick={handleSubmit} disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2">
            {loading && <RefreshCw size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建课程'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ============ 课程管理主页面 ============

export const CourseManagementPage: React.FC = () => {
  const [courses, setCourses] = useState<CourseResponse[]>([]);
  const [teachers, setTeachers] = useState<TeacherResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingCourse, setEditingCourse] = useState<CourseResponse | null>(null);
  const [page, setPage] = useState(1);
  const [statusFilter, setStatusFilter] = useState<number | undefined>(undefined);
  const [keyword, setKeyword] = useState('');
  const [hasMore, setHasMore] = useState(true);
  const pageSize = 10;

  const fetchCourses = useCallback(async () => {
    setLoading(true);
    try {
      let res;
      if (keyword.trim()) {
        res = await api.searchCourses({ keyword: keyword.trim(), page, size: pageSize });
      } else {
        res = await api.listCourses({ status: statusFilter, page, size: pageSize });
      }
      if (res.data.code === 0) {
        const list = res.data.data || [];
        setCourses(list);
        setHasMore(list.length >= pageSize);
      } else {
        toast.error(res.data.message || '获取课程列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [page, statusFilter, keyword]);

  const fetchTeachers = useCallback(async () => {
    try {
      const res = await api.listTeachers({ page: 1, size: 100 });
      if (res.data.code === 0) setTeachers(res.data.data || []);
    } catch { /* ignore */ }
  }, []);

  useEffect(() => { fetchCourses(); }, [fetchCourses]);
  useEffect(() => { fetchTeachers(); }, [fetchTeachers]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setPage(1);
  };

  const handleDelete = async (course: CourseResponse) => {
    if (!course.id) return;
    if (!window.confirm(`确定要删除课程 "${course.title}" 吗？此操作不可恢复。`)) return;
    try {
      const res = await api.deleteCourse({ id: course.id as unknown as number });
      if (res.data.code === 0) { toast.success('删除成功'); fetchCourses(); }
      else toast.error(res.data.message || '删除失败');
    } catch (error: any) { toast.error(error?.response?.data?.message || '网络错误'); }
  };

  const handlePublish = async (course: CourseResponse) => {
    if (!course.id) return;
    try {
      const res = await api.publishCourse({ id: course.id as unknown as number });
      if (res.data.code === 0) { toast.success('发布成功'); fetchCourses(); }
      else toast.error(res.data.message || '发布失败');
    } catch (error: any) { toast.error(error?.response?.data?.message || '网络错误'); }
  };

  const handleTakeOffline = async (course: CourseResponse) => {
    if (!course.id) return;
    try {
      const res = await api.takeOffline({ id: course.id as unknown as number });
      if (res.data.code === 0) { toast.success('下架成功'); fetchCourses(); }
      else toast.error(res.data.message || '下架失败');
    } catch (error: any) { toast.error(error?.response?.data?.message || '网络错误'); }
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">课程管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理平台所有课程的信息、状态和发布</p>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => { setEditingCourse(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">
            <Plus size={18} />
            <span>新增课程</span>
          </button>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <form onSubmit={handleSearch} className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input type="text" placeholder="搜索课程标题..."
              value={keyword}
              onChange={(e) => setKeyword(e.target.value)}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all" />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select value={statusFilter ?? ''}
              onChange={(e) => { setStatusFilter(e.target.value === '' ? undefined : Number(e.target.value)); setPage(1); }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer">
              <option value="">所有状态</option>
              <option value={0}>未发布</option>
              <option value={1}>已发布</option>
              <option value={2}>已下架</option>
            </select>
            <button type="button" onClick={() => fetchCourses()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all">
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </form>
      </div>

      {/* Course Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">课程信息</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">类型 / 难度</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">状态</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">数据</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">创建时间</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={6} className="px-6 py-8 h-20">
                      <div className="flex gap-4">
                        <div className="w-16 h-12 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : courses.length > 0 ? (
                courses.map((course) => (
                  <tr key={String(course.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-4">
                        <div className="w-16 h-12 rounded-xl bg-gradient-to-br from-brand-50 to-indigo-50 dark:from-gray-800 dark:to-gray-800 border border-gray-100 dark:border-gray-700 overflow-hidden flex-shrink-0">
                          {course.coverImage ? (
                            <img src={course.coverImage} alt="" className="w-full h-full object-cover" />
                          ) : (
                            <div className="w-full h-full flex items-center justify-center">
                              <BookOpen size={20} className="text-gray-400" />
                            </div>
                          )}
                        </div>
                        <div className="min-w-0">
                          <p className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors truncate max-w-[200px]">
                            {course.title}
                          </p>
                          {course.subtitle && (
                            <p className="text-xs text-gray-500 dark:text-gray-400 truncate max-w-[200px]">{course.subtitle}</p>
                          )}
                          {course.tags && course.tags.length > 0 && (
                            <div className="flex gap-1 mt-1 flex-wrap">
                              {course.tags.slice(0, 3).map((tag, i) => (
                                <span key={i} className="px-1.5 py-0.5 text-[10px] font-medium bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400 rounded">
                                  {tag}
                                </span>
                              ))}
                            </div>
                          )}
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="space-y-1">
                        <span className="px-2 py-0.5 rounded-lg text-xs font-bold border bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-400 border-brand-200 dark:border-brand-800">
                          {COURSE_TYPE_MAP[course.courseType ?? 0] || '未知'}
                        </span>
                        <br />
                        <span className={`px-2 py-0.5 rounded-lg text-xs font-bold border ${getDifficultyBadge(course.difficulty)}`}>
                          {DIFFICULTY_MAP[course.difficulty ?? 1] || '未知'}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${getStatusBadge(course.status)}`}>
                        {STATUS_MAP[course.status ?? 0] || '未知'}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="space-y-1 text-xs text-gray-500 dark:text-gray-400">
                        <div className="flex items-center gap-1"><Users size={12} /><span>{course.studentCount ?? 0} 学习</span></div>
                        <div className="flex items-center gap-1"><Star size={12} className="text-yellow-500" /><span>{course.ratingScore ?? '-'}</span></div>
                        {(course.price ?? 0) > 0 && (
                          <div className="flex items-center gap-1"><DollarSign size={12} /><span>¥{course.price}</span></div>
                        )}
                      </div>
                    </td>
                    <td className="px-6 py-4 text-sm text-gray-500 dark:text-gray-400">
                      {course.createTime ? new Date(course.createTime).toLocaleDateString() : '-'}
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button onClick={() => { setEditingCourse(course); setModalOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" title="编辑">
                          <Edit2 size={18} />
                        </button>
                        {(course.status === 0 || course.status === 2) && (
                          <button onClick={() => handlePublish(course)}
                            className="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"
                            title={course.status === 2 ? '上架' : '发布'}>
                            <ArrowUpCircle size={18} />
                          </button>
                        )}
                        {course.status === 1 && (
                          <button onClick={() => handleTakeOffline(course)}
                            className="p-2 text-gray-400 hover:text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded-lg transition-all" title="下架">
                            <ArrowDownCircle size={18} />
                          </button>
                        )}
                        <button onClick={() => handleDelete(course)}
                          className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" title="删除">
                          <Trash2 size={18} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <BookOpen size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无课程数据</p>
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
            第 <span className="font-bold text-gray-900 dark:text-white">{page}</span> 页
            {courses.length > 0 && <>，当前 <span className="font-bold text-gray-900 dark:text-white">{courses.length}</span> 条</>}
          </p>
          <div className="flex items-center gap-2">
            <button disabled={page === 1 || loading} onClick={() => setPage(p => p - 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
              <ChevronLeft size={18} />
            </button>
            <button disabled={!hasMore || loading} onClick={() => setPage(p => p + 1)}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all">
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>

      {/* 课程表单弹窗 */}
      <CourseFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingCourse(null); }}
        onSuccess={fetchCourses}
        course={editingCourse}
        teachers={teachers}
      />
    </div>
  );
};
