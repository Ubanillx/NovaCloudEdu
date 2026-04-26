import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { Calendar, ChevronLeft, ChevronRight, MapPin, User, Clock, Pencil } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { ClassScheduleItemResponse } from '../../api/generated/models';

const api = new DefaultApi(new Configuration(), '', apiClient);

const WEEK_DAYS = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
const SECTIONS_PER_DAY = 12;
const TOTAL_WEEKS = 20;

// 课程颜色
const COURSE_COLORS = [
  { bg: 'bg-blue-50 dark:bg-blue-900/20', border: 'border-blue-200 dark:border-blue-800', text: 'text-blue-600 dark:text-blue-400', subText: 'text-blue-500/70 dark:text-blue-400/60' },
  { bg: 'bg-emerald-50 dark:bg-emerald-900/20', border: 'border-emerald-200 dark:border-emerald-800', text: 'text-emerald-600 dark:text-emerald-400', subText: 'text-emerald-500/70 dark:text-emerald-400/60' },
  { bg: 'bg-violet-50 dark:bg-violet-900/20', border: 'border-violet-200 dark:border-violet-800', text: 'text-violet-600 dark:text-violet-400', subText: 'text-violet-500/70 dark:text-violet-400/60' },
  { bg: 'bg-amber-50 dark:bg-amber-900/20', border: 'border-amber-200 dark:border-amber-800', text: 'text-amber-600 dark:text-amber-400', subText: 'text-amber-500/70 dark:text-amber-400/60' },
  { bg: 'bg-rose-50 dark:bg-rose-900/20', border: 'border-rose-200 dark:border-rose-800', text: 'text-rose-600 dark:text-rose-400', subText: 'text-rose-500/70 dark:text-rose-400/60' },
  { bg: 'bg-cyan-50 dark:bg-cyan-900/20', border: 'border-cyan-200 dark:border-cyan-800', text: 'text-cyan-600 dark:text-cyan-400', subText: 'text-cyan-500/70 dark:text-cyan-400/60' },
  { bg: 'bg-purple-50 dark:bg-purple-900/20', border: 'border-purple-200 dark:border-purple-800', text: 'text-purple-600 dark:text-purple-400', subText: 'text-purple-500/70 dark:text-purple-400/60' },
  { bg: 'bg-orange-50 dark:bg-orange-900/20', border: 'border-orange-200 dark:border-orange-800', text: 'text-orange-600 dark:text-orange-400', subText: 'text-orange-500/70 dark:text-orange-400/60' },
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

function getWeekTypeText(weekType?: number): string {
  switch (weekType) {
    case 1: return '(单周)';
    case 2: return '(双周)';
    default: return '';
  }
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

export const CourseScheduleCard: React.FC = () => {
  const navigate = useNavigate();
  const [items, setItems] = useState<ClassScheduleItemResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [currentWeek, setCurrentWeek] = useState(1);
  const [selectedCourse, setSelectedCourse] = useState<ClassScheduleItemResponse | null>(null);

  const fetchSchedule = useCallback(async () => {
    try {
      const res = await api.getMySchedule();
      if (res.data.code === 0 && res.data.data) {
        setItems(res.data.data);
      }
    } catch { /* ignore */ }
    finally { setLoading(false); }
  }, []);

  useEffect(() => {
    fetchSchedule();
  }, [fetchSchedule]);

  const weekItems = getItemsForWeek(items, currentWeek);
  const todayWeekday = getTodayWeekday();

  // 计算实际需要显示的最大节次（至少显示到第8节，最多12节）
  const maxSection = Math.max(
    8,
    ...weekItems.map((item) => item.endSection ?? item.startSection ?? 1)
  );
  const displaySections = Math.min(maxSection, SECTIONS_PER_DAY);

  // Loading skeleton
  if (loading) {
    return (
      <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm p-5 animate-pulse">
        <div className="h-5 bg-gray-200 dark:bg-gray-800 rounded w-24 mb-4" />
        <div className="h-[300px] bg-gray-100 dark:bg-gray-800 rounded-xl" />
      </div>
    );
  }

  return (
    <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm overflow-hidden">
      {/* Header */}
      <div className="px-5 pt-5 pb-3 flex items-center justify-between">
        <h3 className="font-bold text-base flex items-center gap-2 text-gray-900 dark:text-white">
          <span className="w-1 h-5 bg-brand-600 rounded-full" />
          我的课表
        </h3>

        <div className="flex items-center gap-3">
          {/* 管理课表链接 */}
          <button
            onClick={() => navigate('/schedule')}
            className="flex items-center gap-1 text-xs font-medium text-brand-600 dark:text-brand-400 hover:text-brand-700 dark:hover:text-brand-300 transition-colors"
          >
            <Pencil size={12} />
            管理课表
          </button>

          {/* 周次选择器 */}
          <div className="flex items-center gap-1.5">
            <button
              onClick={() => setCurrentWeek((w) => Math.max(1, w - 1))}
              disabled={currentWeek <= 1}
              className="p-1 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-400 disabled:opacity-30 transition-colors"
            >
              <ChevronLeft size={16} />
            </button>
            <span className="text-sm font-semibold text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 px-3 py-1 rounded-full min-w-[72px] text-center select-none">
              第 {currentWeek} 周
            </span>
            <button
              onClick={() => setCurrentWeek((w) => Math.min(TOTAL_WEEKS, w + 1))}
              disabled={currentWeek >= TOTAL_WEEKS}
              className="p-1 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-400 disabled:opacity-30 transition-colors"
            >
              <ChevronRight size={16} />
            </button>
          </div>
        </div>
      </div>

      {/* 课程表格 */}
      <div className="px-5 pb-5">
        <div className="border border-gray-200 dark:border-gray-800 rounded-xl overflow-hidden">
          {/* 表头 - 星期 */}
          <div className="grid" style={{ gridTemplateColumns: '40px repeat(7, 1fr)' }}>
            {/* 左上角 */}
            <div className="h-10 flex items-center justify-center bg-gray-50 dark:bg-gray-800/50 border-b border-r border-gray-200 dark:border-gray-800">
              <span className="text-[10px] text-gray-400 dark:text-gray-500">节</span>
            </div>
            {/* 星期列头 */}
            {WEEK_DAYS.map((day, index) => {
              const isToday = index + 1 === todayWeekday;
              return (
                <div
                  key={day}
                  className={`h-10 flex items-center justify-center border-b border-gray-200 dark:border-gray-800 ${
                    index < 6 ? 'border-r' : ''
                  } ${isToday ? 'bg-brand-50 dark:bg-brand-900/20' : 'bg-gray-50 dark:bg-gray-800/50'}`}
                >
                  <span className={`text-xs font-medium ${
                    isToday
                      ? 'text-brand-600 dark:text-brand-400 font-bold'
                      : 'text-gray-600 dark:text-gray-400'
                  }`}>
                    {day}
                  </span>
                  {isToday && (
                    <span className="ml-1 w-1.5 h-1.5 rounded-full bg-brand-500 dark:bg-brand-400" />
                  )}
                </div>
              );
            })}
          </div>

          {/* 表体 - 节次列 + 7天列（绝对定位课程卡片） */}
          <div className="flex">
            {/* 节次号列 */}
            <div className="flex-shrink-0" style={{ width: 40 }}>
              {Array.from({ length: displaySections }, (_, i) => (
                <div
                  key={i}
                  className={`h-14 flex items-center justify-center bg-gray-50 dark:bg-gray-800/50 border-r border-gray-200 dark:border-gray-800 ${
                    i < displaySections - 1 ? 'border-b' : ''
                  }`}
                >
                  <span className="text-[11px] text-gray-400 dark:text-gray-500 font-medium">{i + 1}</span>
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
                  {/* 背景网格行 */}
                  {Array.from({ length: displaySections }, (_, i) => (
                    <div
                      key={i}
                      className={`h-14 ${i < displaySections - 1 ? 'border-b border-gray-200 dark:border-gray-800' : ''} ${
                        isToday ? 'bg-brand-50/30 dark:bg-brand-900/5' : ''
                      }`}
                    />
                  ))}

                  {/* 课程卡片（绝对定位） */}
                  {dayCourses.map((course) => {
                    const startSection = course.startSection ?? 1;
                    const endSection = course.endSection ?? startSection;
                    const span = endSection - startSection + 1;
                    const top = (startSection - 1) * 56;
                    const height = span * 56;
                    const color = getCourseColor(course.courseName ?? '');

                    return (
                      <button
                        key={String(course.id)}
                        onClick={() => setSelectedCourse(selectedCourse?.id === course.id ? null : course)}
                        style={{ top: top + 3, height: height - 6, left: 3, right: 3 }}
                        className={`absolute rounded-lg ${color.bg} border ${color.border} p-1.5 flex flex-col overflow-hidden cursor-pointer hover:shadow-sm transition-shadow text-left`}
                      >
                        <span className={`text-[11px] font-semibold ${color.text} leading-tight line-clamp-2`}>
                          {course.courseName ?? '未命名'}
                        </span>
                        {course.location && (
                          <span className={`text-[9px] ${color.subText} mt-0.5 truncate flex items-center gap-0.5`}>
                            <MapPin size={8} className="flex-shrink-0" />
                            {course.location}
                          </span>
                        )}
                        {course.teacherName && span >= 2 && (
                          <span className={`text-[9px] ${color.subText} truncate flex items-center gap-0.5`}>
                            <User size={8} className="flex-shrink-0" />
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
        </div>
      </div>

      {/* 课程详情浮层 */}
      {selectedCourse && (
        <div className="border-t border-gray-100 dark:border-gray-800 px-5 py-4 bg-gray-50/50 dark:bg-gray-800/30">
          <div className="flex items-start justify-between gap-3">
            <div className="flex-1 min-w-0">
              <h4 className="font-semibold text-sm text-gray-900 dark:text-white mb-2 truncate">
                {selectedCourse.courseName ?? '未命名课程'}
              </h4>
              <div className="space-y-1.5">
                <div className="flex items-center gap-2 text-xs text-gray-500 dark:text-gray-400">
                  <Clock size={12} className="text-gray-400 flex-shrink-0" />
                  <span>
                    {WEEK_DAYS[(selectedCourse.dayOfWeek ?? 1) - 1]} 第{selectedCourse.startSection}-{selectedCourse.endSection}节
                  </span>
                </div>
                {selectedCourse.location && (
                  <div className="flex items-center gap-2 text-xs text-gray-500 dark:text-gray-400">
                    <MapPin size={12} className="text-gray-400 flex-shrink-0" />
                    <span>{selectedCourse.location}</span>
                  </div>
                )}
                {selectedCourse.teacherName && (
                  <div className="flex items-center gap-2 text-xs text-gray-500 dark:text-gray-400">
                    <User size={12} className="text-gray-400 flex-shrink-0" />
                    <span>{selectedCourse.teacherName}</span>
                  </div>
                )}
                {(selectedCourse.startWeek || selectedCourse.endWeek) && (
                  <div className="flex items-center gap-2 text-xs text-gray-500 dark:text-gray-400">
                    <Calendar size={12} className="text-gray-400 flex-shrink-0" />
                    <span>第{selectedCourse.startWeek ?? 1}-{selectedCourse.endWeek ?? TOTAL_WEEKS}周 {getWeekTypeText(selectedCourse.weekType)}</span>
                  </div>
                )}
                {selectedCourse.remark && (
                  <p className="text-xs text-gray-400 dark:text-gray-500 mt-1 line-clamp-2">{selectedCourse.remark}</p>
                )}
              </div>
            </div>
            <button
              onClick={() => setSelectedCourse(null)}
              className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 text-xs px-2 py-1 rounded hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors flex-shrink-0"
            >
              关闭
            </button>
          </div>
        </div>
      )}

      {/* 无课程提示 */}
      {items.length === 0 && !loading && (
        <div className="px-5 pb-5">
          <div className="text-center py-8">
            <Calendar size={36} className="text-gray-300 dark:text-gray-700 mx-auto mb-2" />
            <p className="text-sm text-gray-400 dark:text-gray-500">暂无课程安排</p>
            <button
              onClick={() => navigate('/schedule')}
              className="text-xs text-brand-600 dark:text-brand-400 hover:text-brand-700 mt-1.5 font-medium"
            >
              前往添加课程 →
            </button>
          </div>
        </div>
      )}
    </div>
  );
};
