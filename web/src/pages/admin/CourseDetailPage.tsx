import React, { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import {
  ArrowLeft,
  Plus,
  Edit2,
  Trash2,
  ChevronDown,
  ChevronRight,
  GripVertical,
  BookOpen,
  Play,
  Clock,
  RefreshCw,
  X,
  Eye,
  EyeOff,
  FileVideo,
  FileText,
  Shield,
  ShieldAlert,
  Loader2,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type {
  CourseStructureResponse,
  ChapterResponse,
  SectionResponse,
  CreateChapterRequest,
  UpdateChapterRequest,
  CreateSectionRequest,
  UpdateSectionRequest,
} from '../../api/generated/models';
import { toast, FileUploadField } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 扩展 SectionResponse 类型以包含后端新增的 HLS 字段
type SectionResponseExt = SectionResponse & {
  hlsUrl?: string;
  transcodeStatus?: number; // 0-未转码, 1-转码中, 2-已完成, 3-失败
};

// ============ 格式化时长 ============
const formatDuration = (seconds?: number) => {
  if (!seconds) return '0分0秒';
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return m > 0 ? `${m}分${s}秒` : `${s}秒`;
};

// ============ 小节表单弹窗 ============
interface SectionFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  courseId: string;
  chapterId: string;
  section?: SectionResponseExt | null;
}

const SectionFormModal: React.FC<SectionFormModalProps> = ({
  isOpen, onClose, onSuccess, courseId, chapterId, section,
}) => {
  const isEdit = !!section;
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    videoUrl: '',
    duration: 0,
    sort: 0,
    isFree: false,
    resourceUrl: '',
  });

  useEffect(() => {
    if (section) {
      setFormData({
        title: section.title || '',
        description: section.description || '',
        videoUrl: section.videoUrl || '',
        duration: section.duration || 0,
        sort: section.sort || 0,
        isFree: section.isFree || false,
        resourceUrl: section.resourceUrl || '',
      });
    } else {
      setFormData({
        title: '', description: '', videoUrl: '',
        duration: 0, sort: 0, isFree: false, resourceUrl: '',
      });
    }
  }, [section, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.title.trim()) { toast.warning('请输入小节标题'); return; }

    setLoading(true);
    try {
      if (isEdit && section?.id) {
        const req: UpdateSectionRequest = {
          title: formData.title,
          description: formData.description || undefined,
          videoUrl: formData.videoUrl || undefined,
          duration: formData.duration,
          sort: formData.sort,
          isFree: formData.isFree,
          resourceUrl: formData.resourceUrl || undefined,
        };
        const res = await api.updateSection1({
          courseId: courseId as unknown as number,
          sectionId: section.id as unknown as number,
          updateSectionRequest: req,
        });
        if (res.data.code === 0) { toast.success('更新成功'); onSuccess(); onClose(); }
        else toast.error(res.data.message || '更新失败');
      } else {
        const req: CreateSectionRequest = {
          chapterId: chapterId as unknown as number,
          title: formData.title,
          description: formData.description || undefined,
          videoUrl: formData.videoUrl || undefined,
          duration: formData.duration,
          sort: formData.sort,
          isFree: formData.isFree,
          resourceUrl: formData.resourceUrl || undefined,
        };
        const res = await api.createSection({
          courseId: courseId as unknown as number,
          createSectionRequest: req,
        });
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
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200 max-h-[90vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑小节' : '新增小节'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4 overflow-y-auto">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">小节标题 *</label>
            <input type="text" value={formData.title}
              onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="请输入小节标题" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">小节描述</label>
            <textarea value={formData.description} rows={2}
              onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="小节描述信息" />
          </div>
          <FileUploadField
            label="课程视频"
            value={formData.videoUrl}
            onChange={(url) => {
              setFormData(prev => ({ ...prev, videoUrl: url }));
              // 上传视频后自动获取时长
              if (url) {
                const video = document.createElement('video');
                video.preload = 'metadata';
                video.onloadedmetadata = () => {
                  if (video.duration && isFinite(video.duration)) {
                    setFormData(prev => ({ ...prev, duration: Math.round(video.duration) }));
                  }
                  URL.revokeObjectURL(video.src);
                };
                video.src = url;
              }
            }}
            businessType="course/video"
            accept="video/*"
            maxSize={500 * 1024 * 1024}
            placeholder="点击或拖拽视频文件到此处上传"
            hint="支持 mp4/webm/mov，最大 500MB"
          />
          <FileUploadField
            label="课件资料"
            value={formData.resourceUrl}
            onChange={(url) => setFormData(prev => ({ ...prev, resourceUrl: url }))}
            businessType="course/material"
            accept="*/*"
            maxSize={50 * 1024 * 1024}
            placeholder="点击或拖拽课件文件到此处上传"
            hint="支持 PDF/Word/PPT 等，最大 50MB"
          />
          <div className="grid grid-cols-3 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">时长(秒)</label>
              <input type="number" value={formData.duration} min={0}
                onChange={(e) => setFormData(prev => ({ ...prev, duration: Number(e.target.value) || 0 }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="0" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">排序</label>
              <input type="number" value={formData.sort} min={0}
                onChange={(e) => setFormData(prev => ({ ...prev, sort: Number(e.target.value) || 0 }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="0" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">是否免费</label>
              <button type="button"
                onClick={() => setFormData(prev => ({ ...prev, isFree: !prev.isFree }))}
                className={`w-full px-4 py-2.5 rounded-xl text-sm font-bold border transition-all flex items-center justify-center gap-2 ${
                  formData.isFree
                    ? 'bg-green-50 dark:bg-green-900/20 border-green-300 dark:border-green-800 text-green-700 dark:text-green-400'
                    : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400'
                }`}>
                {formData.isFree ? <Eye size={16} /> : <EyeOff size={16} />}
                {formData.isFree ? '免费' : '付费'}
              </button>
            </div>
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
            {loading && <Loader2 size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建小节'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ============ 章节表单弹窗 ============
interface ChapterFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  courseId: string;
  chapter?: ChapterResponse | null;
}

const ChapterFormModal: React.FC<ChapterFormModalProps> = ({
  isOpen, onClose, onSuccess, courseId, chapter,
}) => {
  const isEdit = !!chapter;
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    sort: 0,
  });

  useEffect(() => {
    if (chapter) {
      setFormData({
        title: chapter.title || '',
        description: chapter.description || '',
        sort: chapter.sort || 0,
      });
    } else {
      setFormData({ title: '', description: '', sort: 0 });
    }
  }, [chapter, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.title.trim()) { toast.warning('请输入章节标题'); return; }

    setLoading(true);
    try {
      if (isEdit && chapter?.id) {
        const req: UpdateChapterRequest = {
          title: formData.title,
          description: formData.description || undefined,
          sort: formData.sort,
        };
        const res = await api.updateChapter({
          courseId: courseId as unknown as number,
          chapterId: chapter.id as unknown as number,
          updateChapterRequest: req,
        });
        if (res.data.code === 0) { toast.success('更新成功'); onSuccess(); onClose(); }
        else toast.error(res.data.message || '更新失败');
      } else {
        const req: CreateChapterRequest = {
          title: formData.title,
          description: formData.description || undefined,
          sort: formData.sort,
        };
        const res = await api.createChapter({
          courseId: courseId as unknown as number,
          createChapterRequest: req,
        });
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
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑章节' : '新增章节'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">章节标题 *</label>
            <input type="text" value={formData.title}
              onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="请输入章节标题" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">章节描述</label>
            <textarea value={formData.description} rows={3}
              onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="章节描述信息" />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">排序</label>
            <input type="number" value={formData.sort} min={0}
              onChange={(e) => setFormData(prev => ({ ...prev, sort: Number(e.target.value) || 0 }))}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
              placeholder="数字越小排序越靠前" />
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
            {loading && <Loader2 size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建章节'}
          </button>
        </div>
      </div>
    </div>
  );
};

// ============ 小节卡片 ============
interface SectionCardProps {
  section: SectionResponseExt;
  index: number;
  courseId: string;
  onEdit: () => void;
  onRefresh: () => void;
}

const SectionCard: React.FC<SectionCardProps> = ({ section, index, courseId, onEdit, onRefresh }) => {
  const handleDelete = async () => {
    if (!section.id) return;
    if (!window.confirm(`确定要删除小节 "${section.title}" 吗？`)) return;
    try {
      const res = await api.deleteSection1({
        courseId: courseId as unknown as number,
        sectionId: section.id as unknown as number,
      });
      if (res.data.code === 0) { toast.success('删除成功'); onRefresh(); }
      else toast.error(res.data.message || '删除失败');
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    }
  };

  return (
    <div className="group flex items-center gap-3 px-4 py-3 bg-gray-50/80 dark:bg-gray-800/40 rounded-xl hover:bg-gray-100/80 dark:hover:bg-gray-800/60 transition-all border border-transparent hover:border-gray-200 dark:hover:border-gray-700">
      {/* 拖拽手柄 */}
      <div className="text-gray-300 dark:text-gray-600 cursor-grab">
        <GripVertical size={16} />
      </div>

      {/* 序号 */}
      <div className="w-7 h-7 rounded-lg bg-brand-50 dark:bg-brand-900/20 flex items-center justify-center flex-shrink-0">
        <span className="text-xs font-bold text-brand-600 dark:text-brand-400">{index + 1}</span>
      </div>

      {/* 图标 */}
      <div className="flex-shrink-0">
        {section.videoUrl ? (
          <FileVideo size={18} className="text-blue-500" />
        ) : section.resourceUrl ? (
          <FileText size={18} className="text-orange-500" />
        ) : (
          <Play size={18} className="text-gray-400" />
        )}
      </div>

      {/* 信息 */}
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2">
          <p className="text-sm font-medium text-gray-900 dark:text-white truncate">{section.title}</p>
          {section.isFree && (
            <span className="px-1.5 py-0.5 text-[10px] font-bold bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 rounded-md border border-green-200 dark:border-green-800">
              免费
            </span>
          )}
        </div>
        {section.description && (
          <p className="text-xs text-gray-500 dark:text-gray-400 truncate mt-0.5">{section.description}</p>
        )}
      </div>

      {/* 转码状态 */}
      {section.transcodeStatus === 1 && (
        <span className="flex items-center gap-1 px-1.5 py-0.5 text-[10px] font-bold bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400 rounded-md border border-yellow-200 dark:border-yellow-800 flex-shrink-0">
          <Loader2 size={10} className="animate-spin" />
          转码中
        </span>
      )}
      {section.transcodeStatus === 2 && (
        <span className="flex items-center gap-1 px-1.5 py-0.5 text-[10px] font-bold bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400 rounded-md border border-emerald-200 dark:border-emerald-800 flex-shrink-0">
          <Shield size={10} />
          已加密
        </span>
      )}
      {section.transcodeStatus === 3 && (
        <span className="flex items-center gap-1 px-1.5 py-0.5 text-[10px] font-bold bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 rounded-md border border-red-200 dark:border-red-800 flex-shrink-0">
          <ShieldAlert size={10} />
          转码失败
        </span>
      )}

      {/* 时长 */}
      <div className="flex items-center gap-1 text-xs text-gray-400 dark:text-gray-500 flex-shrink-0">
        <Clock size={12} />
        <span>{formatDuration(section.duration)}</span>
      </div>

      {/* 操作按钮 */}
      <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity flex-shrink-0">
        <button onClick={onEdit}
          className="p-1.5 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" title="编辑">
          <Edit2 size={14} />
        </button>
        <button onClick={handleDelete}
          className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" title="删除">
          <Trash2 size={14} />
        </button>
      </div>
    </div>
  );
};

// ============ 章节卡片 ============
interface ChapterCardProps {
  chapter: ChapterResponse;
  index: number;
  courseId: string;
  onEditChapter: () => void;
  onAddSection: () => void;
  onEditSection: (section: SectionResponseExt) => void;
  onRefresh: () => void;
}

const ChapterCard: React.FC<ChapterCardProps> = ({
  chapter, index, courseId, onEditChapter, onAddSection, onEditSection, onRefresh,
}) => {
  const [isExpanded, setIsExpanded] = useState(true);
  const sections = (chapter.sections || []) as SectionResponseExt[];

  const handleDeleteChapter = async () => {
    if (!chapter.id) return;
    if (sections.length > 0) {
      toast.warning('请先删除该章节下的所有小节');
      return;
    }
    if (!window.confirm(`确定要删除章节 "${chapter.title}" 吗？`)) return;
    try {
      const res = await api.deleteChapter({
        courseId: courseId as unknown as number,
        chapterId: chapter.id as unknown as number,
      });
      if (res.data.code === 0) { toast.success('删除成功'); onRefresh(); }
      else toast.error(res.data.message || '删除失败');
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    }
  };

  const totalDuration = sections.reduce((sum, s) => sum + (s.duration || 0), 0);

  return (
    <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300 hover:shadow-md">
      {/* 章节头 */}
      <div className="flex items-center gap-3 px-5 py-4 cursor-pointer select-none" onClick={() => setIsExpanded(!isExpanded)}>
        {/* 展开/折叠 */}
        <button className="text-gray-400 hover:text-brand-600 transition-colors">
          {isExpanded ? <ChevronDown size={20} /> : <ChevronRight size={20} />}
        </button>

        {/* 序号徽章 */}
        <div className="w-8 h-8 rounded-xl bg-gradient-to-br from-brand-500 to-indigo-600 flex items-center justify-center flex-shrink-0 shadow-sm">
          <span className="text-sm font-bold text-white">{index + 1}</span>
        </div>

        {/* 章节信息 */}
        <div className="flex-1 min-w-0">
          <h3 className="text-base font-bold text-gray-900 dark:text-white truncate">{chapter.title}</h3>
          {chapter.description && (
            <p className="text-xs text-gray-500 dark:text-gray-400 truncate mt-0.5">{chapter.description}</p>
          )}
        </div>

        {/* 统计信息 */}
        <div className="flex items-center gap-4 text-xs text-gray-400 dark:text-gray-500 flex-shrink-0">
          <div className="flex items-center gap-1">
            <BookOpen size={14} />
            <span>{sections.length} 小节</span>
          </div>
          {totalDuration > 0 && (
            <div className="flex items-center gap-1">
              <Clock size={14} />
              <span>{formatDuration(totalDuration)}</span>
            </div>
          )}
        </div>

        {/* 操作按钮 */}
        <div className="flex items-center gap-1 flex-shrink-0" onClick={(e) => e.stopPropagation()}>
          <button onClick={onAddSection}
            className="p-2 text-gray-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all" title="添加小节">
            <Plus size={18} />
          </button>
          <button onClick={onEditChapter}
            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" title="编辑章节">
            <Edit2 size={18} />
          </button>
          <button onClick={handleDeleteChapter}
            className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" title="删除章节">
            <Trash2 size={18} />
          </button>
        </div>
      </div>

      {/* 小节列表 */}
      {isExpanded && (
        <div className="px-5 pb-4">
          {sections.length > 0 ? (
            <div className="space-y-2 ml-6">
              {sections
                .sort((a, b) => (a.sort || 0) - (b.sort || 0))
                .map((section, si) => (
                  <SectionCard
                    key={String(section.id)}
                    section={section}
                    index={si}
                    courseId={courseId}
                    onEdit={() => onEditSection(section)}
                    onRefresh={onRefresh}
                  />
                ))}
            </div>
          ) : (
            <div className="ml-6 py-6 text-center">
              <p className="text-sm text-gray-400 dark:text-gray-500">暂无小节</p>
              <button onClick={onAddSection}
                className="mt-2 text-sm text-brand-600 dark:text-brand-400 hover:underline font-medium">
                + 添加第一个小节
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

// ============ 课程详情编辑主页面 ============
export const CourseDetailPage: React.FC = () => {
  const { courseId } = useParams<{ courseId: string }>();
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [structure, setStructure] = useState<CourseStructureResponse | null>(null);

  // 章节弹窗状态
  const [chapterModalOpen, setChapterModalOpen] = useState(false);
  const [editingChapter, setEditingChapter] = useState<ChapterResponse | null>(null);

  // 小节弹窗状态
  const [sectionModalOpen, setSectionModalOpen] = useState(false);
  const [editingSection, setEditingSection] = useState<SectionResponseExt | null>(null);
  const [currentChapterId, setCurrentChapterId] = useState<string>('');

  const fetchStructure = useCallback(async () => {
    if (!courseId) return;
    setLoading(true);
    try {
      const res = await api.getCourseStructure({ courseId: courseId as unknown as number });
      if (res.data.code === 0) {
        setStructure(res.data.data || null);
      } else {
        toast.error(res.data.message || '获取课程结构失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [courseId]);

  useEffect(() => { fetchStructure(); }, [fetchStructure]);

  const course = structure?.course;
  const chapters = (structure?.chapters || []).sort((a, b) => (a.sort || 0) - (b.sort || 0));

  const totalSections = chapters.reduce((sum, ch) => sum + (ch.sections?.length || 0), 0);
  const totalDuration = chapters.reduce(
    (sum, ch) => sum + (ch.sections || []).reduce((s, sec) => s + (sec.duration || 0), 0), 0
  );

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div className="flex items-center gap-4">
          <button onClick={() => navigate('/admin/courses')}
            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-xl transition-all">
            <ArrowLeft size={22} />
          </button>
          <div>
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
              {course?.title || '课程详情'}
            </h1>
            <p className="text-gray-500 dark:text-gray-400 mt-1">
              管理课程的章节和小节内容结构
            </p>
          </div>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={fetchStructure}
            className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all border border-gray-200 dark:border-gray-700">
            <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
          </button>
          <button onClick={() => { setEditingChapter(null); setChapterModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2.5 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">
            <Plus size={18} />
            <span>新增章节</span>
          </button>
        </div>
      </div>

      {/* 课程概览卡片 */}
      {course && (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm p-6 transition-all duration-300">
          <div className="flex items-start gap-5">
            {/* 封面图 */}
            <div className="w-28 h-20 rounded-xl bg-gradient-to-br from-brand-50 to-indigo-50 dark:from-gray-800 dark:to-gray-800 border border-gray-100 dark:border-gray-700 overflow-hidden flex-shrink-0">
              {course.coverImage ? (
                <img src={course.coverImage} alt="" className="w-full h-full object-cover" />
              ) : (
                <div className="w-full h-full flex items-center justify-center">
                  <BookOpen size={28} className="text-gray-300 dark:text-gray-600" />
                </div>
              )}
            </div>
            {/* 信息 */}
            <div className="flex-1 min-w-0">
              <h2 className="text-lg font-bold text-gray-900 dark:text-white">{course.title}</h2>
              {course.subtitle && (
                <p className="text-sm text-gray-500 dark:text-gray-400 mt-0.5">{course.subtitle}</p>
              )}
              {course.description && (
                <p className="text-sm text-gray-500 dark:text-gray-400 mt-1 line-clamp-2">{course.description}</p>
              )}
            </div>
            {/* 统计 */}
            <div className="flex items-center gap-6 flex-shrink-0">
              <div className="text-center">
                <p className="text-2xl font-bold text-brand-600 dark:text-brand-400">{chapters.length}</p>
                <p className="text-xs text-gray-400 mt-1">章节</p>
              </div>
              <div className="text-center">
                <p className="text-2xl font-bold text-indigo-600 dark:text-indigo-400">{totalSections}</p>
                <p className="text-xs text-gray-400 mt-1">小节</p>
              </div>
              <div className="text-center">
                <p className="text-2xl font-bold text-emerald-600 dark:text-emerald-400">
                  {totalDuration > 3600
                    ? `${Math.floor(totalDuration / 3600)}h${Math.floor((totalDuration % 3600) / 60)}m`
                    : totalDuration > 60
                      ? `${Math.floor(totalDuration / 60)}m`
                      : `${totalDuration}s`}
                </p>
                <p className="text-xs text-gray-400 mt-1">总时长</p>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* 章节列表 */}
      {loading ? (
        <div className="space-y-4">
          {Array.from({ length: 3 }).map((_, i) => (
            <div key={i} className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 animate-pulse">
              <div className="flex items-center gap-4">
                <div className="w-8 h-8 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                <div className="flex-1 space-y-2">
                  <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                  <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                </div>
              </div>
              <div className="mt-4 ml-12 space-y-2">
                <div className="h-10 bg-gray-50 dark:bg-gray-800/50 rounded-xl" />
                <div className="h-10 bg-gray-50 dark:bg-gray-800/50 rounded-xl" />
              </div>
            </div>
          ))}
        </div>
      ) : chapters.length > 0 ? (
        <div className="space-y-4">
          {chapters.map((chapter, ci) => (
            <ChapterCard
              key={String(chapter.id)}
              chapter={chapter}
              index={ci}
              courseId={courseId!}
              onEditChapter={() => { setEditingChapter(chapter); setChapterModalOpen(true); }}
              onAddSection={() => {
                setCurrentChapterId(String(chapter.id));
                setEditingSection(null);
                setSectionModalOpen(true);
              }}
              onEditSection={(section) => {
                setCurrentChapterId(String(chapter.id));
                setEditingSection(section);
                setSectionModalOpen(true);
              }}
              onRefresh={fetchStructure}
            />
          ))}
        </div>
      ) : (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm py-16">
          <div className="flex flex-col items-center">
            <div className="w-20 h-20 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
              <BookOpen size={40} className="text-gray-300 dark:text-gray-600" />
            </div>
            <p className="text-gray-500 dark:text-gray-400 font-medium text-lg">暂无章节</p>
            <p className="text-gray-400 dark:text-gray-500 text-sm mt-1">点击上方「新增章节」开始构建课程内容</p>
            <button onClick={() => { setEditingChapter(null); setChapterModalOpen(true); }}
              className="mt-4 flex items-center gap-2 px-5 py-2.5 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95">
              <Plus size={18} />
              <span>新增章节</span>
            </button>
          </div>
        </div>
      )}

      {/* 章节表单弹窗 */}
      <ChapterFormModal
        isOpen={chapterModalOpen}
        onClose={() => { setChapterModalOpen(false); setEditingChapter(null); }}
        onSuccess={fetchStructure}
        courseId={courseId!}
        chapter={editingChapter}
      />

      {/* 小节表单弹窗 */}
      <SectionFormModal
        isOpen={sectionModalOpen}
        onClose={() => { setSectionModalOpen(false); setEditingSection(null); }}
        onSuccess={fetchStructure}
        courseId={courseId!}
        chapterId={currentChapterId}
        section={editingSection}
      />
    </div>
  );
};
