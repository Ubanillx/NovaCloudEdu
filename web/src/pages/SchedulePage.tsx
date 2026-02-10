import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Calendar, ChevronLeft, ChevronRight, MapPin, User, Clock,
  Plus, Pencil, Trash2, X, Check, Loader2, ArrowLeft,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type {
  ClassScheduleItemResponse,
  AddScheduleItemRequest,
  UpdateScheduleItemRequest,
} from '../api/generated/models';
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

const WEEK_DAYS = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
const SECTIONS_PER_DAY = 12;
const TOTAL_WEEKS = 20;
const WEEK_TYPES = ['每周', '单周', '双周'];
const COLOR_OPTIONS = [
  { hex: '#5B8FF9', label: '蓝色' },
  { hex: '#5AD8A6', label: '绿色' },
  { hex: '#5D7092', label: '灰蓝' },
  { hex: '#F6BD16', label: '黄色' },
  { hex: '#E86452', label: '红色' },
  { hex: '#6DC8EC', label: '天蓝' },
  { hex: '#945FB9', label: '紫色' },
  { hex: '#FF9845', label: '橙色' },
];

// Tailwind 课程颜色映射
const COURSE_COLORS = [
  { bg: 'bg-blue-50 dark:bg-blue-900/20', border: 'border-blue-200 dark:border-blue-800', text: 'text-blue-600 dark:text-blue-400', sub: 'text-blue-500/70 dark:text-blue-400/60' },
  { bg: 'bg-emerald-50 dark:bg-emerald-900/20', border: 'border-emerald-200 dark:border-emerald-800', text: 'text-emerald-600 dark:text-emerald-400', sub: 'text-emerald-500/70 dark:text-emerald-400/60' },
  { bg: 'bg-violet-50 dark:bg-violet-900/20', border: 'border-violet-200 dark:border-violet-800', text: 'text-violet-600 dark:text-violet-400', sub: 'text-violet-500/70 dark:text-violet-400/60' },
  { bg: 'bg-amber-50 dark:bg-amber-900/20', border: 'border-amber-200 dark:border-amber-800', text: 'text-amber-600 dark:text-amber-400', sub: 'text-amber-500/70 dark:text-amber-400/60' },
  { bg: 'bg-rose-50 dark:bg-rose-900/20', border: 'border-rose-200 dark:border-rose-800', text: 'text-rose-600 dark:text-rose-400', sub: 'text-rose-500/70 dark:text-rose-400/60' },
  { bg: 'bg-cyan-50 dark:bg-cyan-900/20', border: 'border-cyan-200 dark:border-cyan-800', text: 'text-cyan-600 dark:text-cyan-400', sub: 'text-cyan-500/70 dark:text-cyan-400/60' },
  { bg: 'bg-purple-50 dark:bg-purple-900/20', border: 'border-purple-200 dark:border-purple-800', text: 'text-purple-600 dark:text-purple-400', sub: 'text-purple-500/70 dark:text-purple-400/60' },
  { bg: 'bg-orange-50 dark:bg-orange-900/20', border: 'border-orange-200 dark:border-orange-800', text: 'text-orange-600 dark:text-orange-400', sub: 'text-orange-500/70 dark:text-orange-400/60' },
];

function hashCode(str: string): number {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = ((hash << 5) - hash) + str.charCodeAt(i);
    hash |= 0;
  }
  return Math.abs(hash);
}

function getCourseColor(courseName: string) {
  return COURSE_COLORS[hashCode(courseName) % COURSE_COLORS.length];
}

function getTodayWeekday(): number {
  const day = new Date().getDay();
  return day === 0 ? 7 : day;
}

function getItemsForWeek(items: ClassScheduleItemResponse[], week: number): ClassScheduleItemResponse[] {
  return items.filter((item) => {
    const startWeek = item.startWeek ?? 1;
    const endWeek = item.endWeek ?? TOTAL_WEEKS;
    const weekType = item.weekType ?? 0;
    if (week < startWeek || week > endWeek) return false;
    if (weekType === 1 && week % 2 === 0) return false;
    if (weekType === 2 && week % 2 === 1) return false;
    return true;
  });
}

// ===================== 编辑表单默认值 =====================
interface FormData {
  courseName: string;
  teacherName: string;
  location: string;
  remark: string;
  dayOfWeek: number;
  startSection: number;
  endSection: number;
  startWeek: number;
  endWeek: number;
  weekType: number;
  courseType: number;
  color: string;
}

function defaultFormData(dayOfWeek?: number, section?: number): FormData {
  return {
    courseName: '',
    teacherName: '',
    location: '',
    remark: '',
    dayOfWeek: dayOfWeek ?? 1,
    startSection: section ?? 1,
    endSection: section ? Math.min(section + 1, 12) : 2,
    startWeek: 1,
    endWeek: 20,
    weekType: 0,
    courseType: 0,
    color: COLOR_OPTIONS[0].hex,
  };
}

function formDataFromItem(item: ClassScheduleItemResponse): FormData {
  return {
    courseName: item.courseName ?? '',
    teacherName: item.teacherName ?? '',
    location: item.location ?? '',
    remark: item.remark ?? '',
    dayOfWeek: item.dayOfWeek ?? 1,
    startSection: item.startSection ?? 1,
    endSection: item.endSection ?? 2,
    startWeek: item.startWeek ?? 1,
    endWeek: item.endWeek ?? 20,
    weekType: item.weekType ?? 0,
    courseType: item.courseType ?? 0,
    color: item.color ?? COLOR_OPTIONS[0].hex,
  };
}

// ===================== 主组件 =====================
const SchedulePage: React.FC = () => {
  const navigate = useNavigate();
  const [items, setItems] = useState<ClassScheduleItemResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [currentWeek, setCurrentWeek] = useState(1);

  // 编辑状态
  const [editItem, setEditItem] = useState<ClassScheduleItemResponse | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [formData, setFormData] = useState<FormData>(defaultFormData());
  const [submitting, setSubmitting] = useState(false);

  // 详情面板
  const [selectedCourse, setSelectedCourse] = useState<ClassScheduleItemResponse | null>(null);

  const todayWeekday = getTodayWeekday();

  const fetchSchedule = useCallback(async () => {
    try {
      const res = await api.getMySchedule();
      if (res.data.code === 0 && res.data.data) {
        setItems(res.data.data);
      }
    } catch { /* ignore */ }
    finally { setLoading(false); }
  }, []);

  useEffect(() => { fetchSchedule(); }, [fetchSchedule]);

  const weekItems = getItemsForWeek(items, currentWeek);

  const maxSection = Math.max(8, ...weekItems.map((i) => i.endSection ?? i.startSection ?? 1));
  const displaySections = Math.min(maxSection, SECTIONS_PER_DAY);

  // ---- 打开添加表单 ----
  const openAdd = (dayOfWeek?: number, section?: number) => {
    setEditItem(null);
    setFormData(defaultFormData(dayOfWeek, section));
    setShowForm(true);
    setSelectedCourse(null);
  };

  // ---- 打开编辑表单 ----
  const openEdit = (item: ClassScheduleItemResponse) => {
    setEditItem(item);
    setFormData(formDataFromItem(item));
    setShowForm(true);
    setSelectedCourse(null);
  };

  // ---- 提交 ----
  const handleSubmit = async () => {
    if (!formData.courseName.trim()) {
      toast.warning('请输入课程名称');
      return;
    }
    setSubmitting(true);
    try {
      if (editItem) {
        // 编辑 — ID 使用 as unknown as number 避免精度丢失
        const id = editItem.id as unknown as number;
        const req: UpdateScheduleItemRequest = {
          courseName: formData.courseName.trim(),
          teacherName: formData.teacherName.trim() || undefined,
          location: formData.location.trim() || undefined,
          dayOfWeek: formData.dayOfWeek,
          startSection: formData.startSection,
          endSection: formData.endSection,
          startWeek: formData.startWeek,
          endWeek: formData.endWeek,
          weekType: formData.weekType,
          color: formData.color,
          remark: formData.remark.trim() || undefined,
        };
        await api.updateItem({ id, updateScheduleItemRequest: req });
        toast.success('课程更新成功');
      } else {
        // 添加
        const req: AddScheduleItemRequest = {
          settingId: 1 as unknown as number, // 默认配置
          courseType: 1, // CUSTOM: 用户手动添加的课程固定为1
          courseName: formData.courseName.trim(),
          teacherName: formData.teacherName.trim() || undefined,
          location: formData.location.trim() || undefined,
          dayOfWeek: formData.dayOfWeek,
          startSection: formData.startSection,
          endSection: formData.endSection,
          startWeek: formData.startWeek,
          endWeek: formData.endWeek,
          weekType: formData.weekType,
          color: formData.color,
          remark: formData.remark.trim() || undefined,
        };
        await api.addItem({ addScheduleItemRequest: req });
        toast.success('课程添加成功');
      }
      setShowForm(false);
      setEditItem(null);
      fetchSchedule();
    } catch (e: unknown) {
      toast.error(`保存失败: ${e instanceof Error ? e.message : '未知错误'}`);
    } finally {
      setSubmitting(false);
    }
  };

  // ---- 删除 ----
  const handleDelete = async (item: ClassScheduleItemResponse) => {
    if (!window.confirm(`确定要删除「${item.courseName}」吗？`)) return;
    try {
      const id = item.id as unknown as number;
      await api.deleteItem({ id });
      toast.success('删除成功');
      setSelectedCourse(null);
      fetchSchedule();
    } catch {
      toast.error('删除失败');
    }
  };

  // ---- 表单字段更新 ----
  const updateForm = (patch: Partial<FormData>) => {
    setFormData((prev) => {
      const next = { ...prev, ...patch };
      // 保证 endSection >= startSection
      if (patch.startSection !== undefined && next.endSection < next.startSection) {
        next.endSection = next.startSection;
      }
      // 保证 endWeek >= startWeek
      if (patch.startWeek !== undefined && next.endWeek < next.startWeek) {
        next.endWeek = next.startWeek;
      }
      return next;
    });
  };

  // ===================== 渲染 =====================
  return (
    <div className="max-w-6xl mx-auto space-y-6">
      {/* 页头 */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <button
            onClick={() => navigate('/')}
            className="p-2 rounded-xl hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-500 transition-colors"
          >
            <ArrowLeft size={20} />
          </button>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">我的课表</h1>
        </div>

        <div className="flex items-center gap-3">
          {/* 周次选择器 */}
          <div className="flex items-center gap-1.5">
            <button
              onClick={() => setCurrentWeek((w) => Math.max(1, w - 1))}
              disabled={currentWeek <= 1}
              className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-400 disabled:opacity-30 transition-colors"
            >
              <ChevronLeft size={18} />
            </button>
            <span className="text-sm font-semibold text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 px-4 py-1.5 rounded-full min-w-[80px] text-center select-none">
              第 {currentWeek} 周
            </span>
            <button
              onClick={() => setCurrentWeek((w) => Math.min(TOTAL_WEEKS, w + 1))}
              disabled={currentWeek >= TOTAL_WEEKS}
              className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-400 disabled:opacity-30 transition-colors"
            >
              <ChevronRight size={18} />
            </button>
          </div>

          <button
            onClick={() => openAdd()}
            className="flex items-center gap-1.5 px-4 py-2 bg-brand-600 hover:bg-brand-700 text-white text-sm font-semibold rounded-xl shadow-sm transition-colors"
          >
            <Plus size={16} />
            添加课程
          </button>
        </div>
      </div>

      {/* 课程表格 */}
      <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm overflow-hidden">
        {loading ? (
          <div className="flex items-center justify-center py-32">
            <Loader2 size={24} className="animate-spin text-brand-500" />
            <span className="ml-2 text-sm text-gray-500">加载课表中...</span>
          </div>
        ) : (
          <>
            {/* 表头 */}
            <div className="grid" style={{ gridTemplateColumns: '48px repeat(7, 1fr)' }}>
              <div className="h-11 flex items-center justify-center bg-gray-50 dark:bg-gray-800/50 border-b border-r border-gray-200 dark:border-gray-800">
                <span className="text-xs text-gray-400 dark:text-gray-500">节</span>
              </div>
              {WEEK_DAYS.map((day, index) => {
                const isToday = index + 1 === todayWeekday;
                return (
                  <div
                    key={day}
                    className={`h-11 flex items-center justify-center border-b border-gray-200 dark:border-gray-800 ${
                      index < 6 ? 'border-r' : ''
                    } ${isToday ? 'bg-brand-50 dark:bg-brand-900/20' : 'bg-gray-50 dark:bg-gray-800/50'}`}
                  >
                    <span className={`text-sm font-medium ${
                      isToday ? 'text-brand-600 dark:text-brand-400 font-bold' : 'text-gray-600 dark:text-gray-400'
                    }`}>
                      {day}
                    </span>
                    {isToday && <span className="ml-1 w-1.5 h-1.5 rounded-full bg-brand-500 dark:bg-brand-400" />}
                  </div>
                );
              })}
            </div>

            {/* 表体 */}
            <div className="flex">
              {/* 节次列 */}
              <div className="flex-shrink-0" style={{ width: 48 }}>
                {Array.from({ length: displaySections }, (_, i) => (
                  <div
                    key={i}
                    className={`h-16 flex items-center justify-center bg-gray-50 dark:bg-gray-800/50 border-r border-gray-200 dark:border-gray-800 ${
                      i < displaySections - 1 ? 'border-b' : ''
                    }`}
                  >
                    <span className="text-xs text-gray-400 dark:text-gray-500 font-medium">{i + 1}</span>
                  </div>
                ))}
              </div>

              {/* 7天列 */}
              {Array.from({ length: 7 }, (_, dayIndex) => {
                const dayOfWeek = dayIndex + 1;
                const isToday = dayOfWeek === todayWeekday;
                const dayCourses = weekItems.filter((item) => item.dayOfWeek === dayOfWeek);

                return (
                  <div
                    key={dayIndex}
                    className={`flex-1 min-w-0 relative ${dayIndex < 6 ? 'border-r border-gray-200 dark:border-gray-800' : ''}`}
                  >
                    {/* 背景网格 + 点击添加 */}
                    {Array.from({ length: displaySections }, (_, i) => (
                      <div
                        key={i}
                        onClick={() => openAdd(dayOfWeek, i + 1)}
                        className={`h-16 cursor-pointer group/cell ${
                          i < displaySections - 1 ? 'border-b border-gray-200 dark:border-gray-800' : ''
                        } ${isToday ? 'bg-brand-50/30 dark:bg-brand-900/5' : ''} hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors`}
                      >
                        <div className="w-full h-full flex items-center justify-center opacity-0 group-hover/cell:opacity-100 transition-opacity">
                          <Plus size={14} className="text-gray-300 dark:text-gray-600" />
                        </div>
                      </div>
                    ))}

                    {/* 课程卡片（绝对定位） */}
                    {dayCourses.map((course) => {
                      const startSection = course.startSection ?? 1;
                      const endSection = course.endSection ?? startSection;
                      const span = endSection - startSection + 1;
                      const top = (startSection - 1) * 64;
                      const height = span * 64;
                      const color = getCourseColor(course.courseName ?? '');
                      const isSelected = String(selectedCourse?.id) === String(course.id);

                      return (
                        <button
                          key={String(course.id)}
                          onClick={(e) => {
                            e.stopPropagation();
                            setSelectedCourse(isSelected ? null : course);
                          }}
                          style={{ top: top + 3, height: height - 6, left: 3, right: 3 }}
                          className={`absolute rounded-lg ${color.bg} border ${color.border} p-2 flex flex-col overflow-hidden cursor-pointer hover:shadow-md transition-all text-left ${
                            isSelected ? 'ring-2 ring-brand-500 shadow-lg' : ''
                          }`}
                        >
                          <span className={`text-xs font-semibold ${color.text} leading-tight line-clamp-2`}>
                            {course.courseName ?? '未命名'}
                          </span>
                          {course.location && (
                            <span className={`text-[10px] ${color.sub} mt-0.5 truncate flex items-center gap-0.5`}>
                              <MapPin size={9} className="flex-shrink-0" />
                              {course.location}
                            </span>
                          )}
                          {course.teacherName && span >= 2 && (
                            <span className={`text-[10px] ${color.sub} truncate flex items-center gap-0.5`}>
                              <User size={9} className="flex-shrink-0" />
                              {course.teacherName}
                            </span>
                          )}
                        </button>
                      );
                    })}
                  </div>
                );
              })}
            </div>
          </>
        )}
      </div>

      {/* 课程详情面板 */}
      {selectedCourse && !showForm && (
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm p-5">
          <div className="flex items-start justify-between mb-4">
            <h3 className="text-lg font-bold text-gray-900 dark:text-white">
              {selectedCourse.courseName ?? '未命名课程'}
            </h3>
            <button
              onClick={() => setSelectedCourse(null)}
              className="p-1 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-400 transition-colors"
            >
              <X size={18} />
            </button>
          </div>

          <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-5">
            <DetailItem icon={<Clock size={14} />} label="时间" value={`${WEEK_DAYS[(selectedCourse.dayOfWeek ?? 1) - 1]} 第${selectedCourse.startSection}-${selectedCourse.endSection}节`} />
            {selectedCourse.location && (
              <DetailItem icon={<MapPin size={14} />} label="地点" value={selectedCourse.location} />
            )}
            {selectedCourse.teacherName && (
              <DetailItem icon={<User size={14} />} label="教师" value={selectedCourse.teacherName} />
            )}
            <DetailItem icon={<Calendar size={14} />} label="周次" value={`第${selectedCourse.startWeek ?? 1}-${selectedCourse.endWeek ?? 20}周${selectedCourse.weekType === 1 ? ' (单周)' : selectedCourse.weekType === 2 ? ' (双周)' : ''}`} />
          </div>

          {selectedCourse.remark && (
            <p className="text-sm text-gray-500 dark:text-gray-400 mb-5 bg-gray-50 dark:bg-gray-800/50 rounded-lg p-3">
              {selectedCourse.remark}
            </p>
          )}

          <div className="flex gap-3">
            <button
              onClick={() => openEdit(selectedCourse)}
              className="flex items-center gap-1.5 px-4 py-2 text-sm font-medium text-brand-600 border border-brand-200 dark:border-brand-800 rounded-xl hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-colors"
            >
              <Pencil size={14} /> 编辑
            </button>
            <button
              onClick={() => handleDelete(selectedCourse)}
              className="flex items-center gap-1.5 px-4 py-2 text-sm font-medium text-red-600 border border-red-200 dark:border-red-800 rounded-xl hover:bg-red-50 dark:hover:bg-red-900/20 transition-colors"
            >
              <Trash2 size={14} /> 删除
            </button>
          </div>
        </div>
      )}

      {/* 添加/编辑表单 Modal */}
      {showForm && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm" onClick={() => setShowForm(false)}>
          <div
            className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-200 dark:border-gray-800 shadow-2xl w-full max-w-2xl max-h-[90vh] overflow-y-auto mx-4"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Modal 头 */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-200 dark:border-gray-800 sticky top-0 bg-white dark:bg-gray-900 z-10">
              <h2 className="text-lg font-bold text-gray-900 dark:text-white">
                {editItem ? '编辑课程' : '添加课程'}
              </h2>
              <button
                onClick={() => setShowForm(false)}
                className="p-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-400 transition-colors"
              >
                <X size={20} />
              </button>
            </div>

            {/* 表单内容 */}
            <div className="px-6 py-5 space-y-6">
              {/* 基本信息 */}
              <FormSection title="基本信息">
                <FormInput label="课程名称" required value={formData.courseName} onChange={(v) => updateForm({ courseName: v })} placeholder="请输入课程名称" />
                <div className="grid grid-cols-2 gap-4">
                  <FormInput label="授课教师" value={formData.teacherName} onChange={(v) => updateForm({ teacherName: v })} placeholder="选填" />
                  <FormInput label="上课地点" value={formData.location} onChange={(v) => updateForm({ location: v })} placeholder="选填" />
                </div>
              </FormSection>

              {/* 上课时间 */}
              <FormSection title="上课时间">
                <div>
                  <label className="text-sm text-gray-500 dark:text-gray-400 mb-2 block">星期</label>
                  <div className="flex gap-2">
                    {WEEK_DAYS.map((d, i) => (
                      <button
                        key={d}
                        onClick={() => updateForm({ dayOfWeek: i + 1 })}
                        className={`flex-1 py-2 rounded-lg text-sm font-medium transition-colors ${
                          formData.dayOfWeek === i + 1
                            ? 'bg-brand-600 text-white shadow-sm'
                            : 'bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700'
                        }`}
                      >
                        {d}
                      </button>
                    ))}
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <FormSelect
                    label="开始节次"
                    value={formData.startSection}
                    options={Array.from({ length: 12 }, (_, i) => ({ value: i + 1, label: `第 ${i + 1} 节` }))}
                    onChange={(v) => updateForm({ startSection: v })}
                  />
                  <FormSelect
                    label="结束节次"
                    value={formData.endSection}
                    options={Array.from({ length: 12 - formData.startSection + 1 }, (_, i) => ({
                      value: formData.startSection + i,
                      label: `第 ${formData.startSection + i} 节`,
                    }))}
                    onChange={(v) => updateForm({ endSection: v })}
                  />
                </div>
              </FormSection>

              {/* 周次设置 */}
              <FormSection title="周次设置">
                <div className="grid grid-cols-2 gap-4">
                  <FormSelect
                    label="开始周"
                    value={formData.startWeek}
                    options={Array.from({ length: 20 }, (_, i) => ({ value: i + 1, label: `第 ${i + 1} 周` }))}
                    onChange={(v) => updateForm({ startWeek: v })}
                  />
                  <FormSelect
                    label="结束周"
                    value={formData.endWeek}
                    options={Array.from({ length: 20 - formData.startWeek + 1 }, (_, i) => ({
                      value: formData.startWeek + i,
                      label: `第 ${formData.startWeek + i} 周`,
                    }))}
                    onChange={(v) => updateForm({ endWeek: v })}
                  />
                </div>
                <div>
                  <label className="text-sm text-gray-500 dark:text-gray-400 mb-2 block">周类型</label>
                  <div className="flex gap-2">
                    {WEEK_TYPES.map((t, i) => (
                      <button
                        key={t}
                        onClick={() => updateForm({ weekType: i })}
                        className={`flex-1 py-2 rounded-lg text-sm font-medium transition-colors ${
                          formData.weekType === i
                            ? 'bg-brand-600 text-white shadow-sm'
                            : 'bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700'
                        }`}
                      >
                        {t}
                      </button>
                    ))}
                  </div>
                </div>
              </FormSection>

              {/* 其他设置 */}
              <FormSection title="其他设置">
                <div>
                  <label className="text-sm text-gray-500 dark:text-gray-400 mb-2 block">课程颜色</label>
                  <div className="flex gap-3 flex-wrap">
                    {COLOR_OPTIONS.map((c) => (
                      <button
                        key={c.hex}
                        onClick={() => updateForm({ color: c.hex })}
                        className={`w-9 h-9 rounded-full transition-all flex items-center justify-center ${
                          formData.color === c.hex ? 'ring-2 ring-offset-2 ring-gray-900 dark:ring-white dark:ring-offset-gray-900 scale-110' : 'hover:scale-105'
                        }`}
                        style={{ backgroundColor: c.hex }}
                        title={c.label}
                      >
                        {formData.color === c.hex && <Check size={16} className="text-white" />}
                      </button>
                    ))}
                  </div>
                </div>
                <FormInput label="备注" value={formData.remark} onChange={(v) => updateForm({ remark: v })} placeholder="添加备注信息（选填）" multiline />
              </FormSection>
            </div>

            {/* 底部按钮 */}
            <div className="flex gap-3 px-6 py-4 border-t border-gray-200 dark:border-gray-800 sticky bottom-0 bg-white dark:bg-gray-900">
              <button
                onClick={() => setShowForm(false)}
                className="flex-1 py-2.5 rounded-xl border border-gray-200 dark:border-gray-700 text-sm font-medium text-gray-600 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors"
              >
                取消
              </button>
              <button
                onClick={handleSubmit}
                disabled={submitting || !formData.courseName.trim()}
                className="flex-1 py-2.5 rounded-xl bg-brand-600 hover:bg-brand-700 text-white text-sm font-bold shadow-sm transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
              >
                {submitting ? <Loader2 size={16} className="animate-spin" /> : <Check size={16} />}
                {editItem ? '保存修改' : '添加课程'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

// ===================== 子组件 =====================

const DetailItem: React.FC<{ icon: React.ReactNode; label: string; value: string }> = ({ icon, label, value }) => (
  <div className="flex items-start gap-2">
    <span className="text-gray-400 mt-0.5 flex-shrink-0">{icon}</span>
    <div className="min-w-0">
      <div className="text-[10px] uppercase tracking-wider text-gray-400 dark:text-gray-500 font-bold">{label}</div>
      <div className="text-sm text-gray-700 dark:text-gray-300 truncate">{value}</div>
    </div>
  </div>
);

const FormSection: React.FC<{ title: string; children: React.ReactNode }> = ({ title, children }) => (
  <div className="space-y-4">
    <h4 className="text-sm font-bold text-gray-900 dark:text-white flex items-center gap-2">
      <span className="w-1 h-4 bg-brand-500 rounded-full" />
      {title}
    </h4>
    {children}
  </div>
);

const FormInput: React.FC<{
  label: string;
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
  required?: boolean;
  multiline?: boolean;
}> = ({ label, value, onChange, placeholder, required, multiline }) => (
  <div>
    <label className="text-sm text-gray-500 dark:text-gray-400 mb-1.5 block">
      {label}
      {required && <span className="text-red-500 ml-0.5">*</span>}
    </label>
    {multiline ? (
      <textarea
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        rows={3}
        className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl outline-none focus:border-brand-500 dark:focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 text-gray-900 dark:text-white placeholder-gray-400 transition-all resize-none"
      />
    ) : (
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl outline-none focus:border-brand-500 dark:focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 text-gray-900 dark:text-white placeholder-gray-400 transition-all"
      />
    )}
  </div>
);

const FormSelect: React.FC<{
  label: string;
  value: number;
  options: { value: number; label: string }[];
  onChange: (v: number) => void;
}> = ({ label, value, options, onChange }) => (
  <div>
    <label className="text-sm text-gray-500 dark:text-gray-400 mb-1.5 block">{label}</label>
    <select
      value={value}
      onChange={(e) => onChange(Number(e.target.value))}
      className="w-full px-3 py-2 text-sm bg-gray-50 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl outline-none focus:border-brand-500 dark:focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 text-gray-900 dark:text-white transition-all appearance-none cursor-pointer"
    >
      {options.map((opt) => (
        <option key={opt.value} value={opt.value}>{opt.label}</option>
      ))}
    </select>
  </div>
);

export default SchedulePage;
