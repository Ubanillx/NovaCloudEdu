import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Search, GraduationCap, ChevronLeft, ChevronRight,
  BookOpen, Clock, Users, Star, Play, Filter,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { CourseResponse } from '../api/generated/models';
import { toast } from '../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);
const PAGE_SIZE = 12;

const COURSE_TYPE_FILTERS = [
  { label: '全部', value: -1 },
  { label: '公开课', value: 0 },
  { label: '付费课', value: 1 },
  { label: '会员课', value: 2 },
];

const DIFFICULTY_FILTERS = [
  { label: '全部难度', value: -1 },
  { label: '入门', value: 1, color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' },
  { label: '初级', value: 2, color: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400' },
  { label: '中级', value: 3, color: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400' },
  { label: '高级', value: 4, color: 'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-400' },
  { label: '专家', value: 5, color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400' },
];

const difficultyLabels: Record<number, { text: string; color: string }> = {
  1: { text: '入门', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' },
  2: { text: '初级', color: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400' },
  3: { text: '中级', color: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400' },
  4: { text: '高级', color: 'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-400' },
  5: { text: '专家', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400' },
};

const CourseListPage: React.FC = () => {
  const navigate = useNavigate();
  const [courses, setCourses] = useState<CourseResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [activeKeyword, setActiveKeyword] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [hasMore, setHasMore] = useState(false);
  const [courseTypeFilter, setCourseTypeFilter] = useState(-1);
  const [difficultyFilter, setDifficultyFilter] = useState(-1);
  const [showFilters, setShowFilters] = useState(false);

  const fetchCourses = useCallback(async () => {
    setLoading(true);
    try {
      let response;
      if (activeKeyword.trim()) {
        response = await api.searchCourses({
          keyword: activeKeyword.trim(),
          page: currentPage - 1,
          size: PAGE_SIZE,
        });
      } else {
        response = await api.listCourses({
          status: 1,
          page: currentPage - 1,
          size: PAGE_SIZE,
        });
      }
      if (response.data?.code === 0) {
        let list: CourseResponse[] = (response.data.data || []) as CourseResponse[];
        // 前端过滤课程类型
        if (courseTypeFilter >= 0) {
          list = list.filter(c => c.courseType === courseTypeFilter);
        }
        // 前端过滤难度
        if (difficultyFilter > 0) {
          list = list.filter(c => c.difficulty === difficultyFilter);
        }
        setCourses(list);
        setHasMore((response.data.data || []).length >= PAGE_SIZE);
      }
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '加载课程失败');
    } finally {
      setLoading(false);
    }
  }, [activeKeyword, currentPage, courseTypeFilter, difficultyFilter]);

  useEffect(() => { fetchCourses(); }, [fetchCourses]);

  const handleSearch = () => {
    setActiveKeyword(searchKeyword);
    setCurrentPage(1);
  };

  const handleCourseTypeChange = (value: number) => {
    setCourseTypeFilter(value);
    setCurrentPage(1);
  };

  const handleDifficultyChange = (value: number) => {
    setDifficultyFilter(value);
    setCurrentPage(1);
  };

  const activeFilterCount = (courseTypeFilter >= 0 ? 1 : 0) + (difficultyFilter > 0 ? 1 : 0);

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* 页头 */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
        <div className="px-6 py-5">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 rounded-xl bg-brand-50 dark:bg-brand-900/20 flex items-center justify-center text-brand-600 dark:text-brand-400 border border-brand-100 dark:border-brand-800">
                <GraduationCap size={24} />
              </div>
              <div>
                <h1 className="text-2xl font-bold text-gray-900 dark:text-white">课程中心</h1>
                <p className="text-gray-500 dark:text-gray-400 mt-1">发现优质课程，开启高效学习之旅</p>
              </div>
            </div>
          </div>

          {/* 搜索栏 */}
          <div className="mt-6 flex flex-col md:flex-row items-center gap-4">
            <div className="relative flex-1 w-full group">
              <Search size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" />
              <input
                type="text"
                value={searchKeyword}
                onChange={e => setSearchKeyword(e.target.value)}
                onKeyDown={e => { if (e.key === 'Enter') handleSearch(); }}
                placeholder="搜索课程名称、关键词..."
                className="w-full pl-11 pr-4 py-2.5 rounded-xl border border-transparent bg-gray-50 dark:bg-gray-800/50 text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:border-brand-500/50 outline-none transition-all"
              />
            </div>
            <div className="flex items-center gap-3 w-full md:w-auto">
              <button
                onClick={() => setShowFilters(!showFilters)}
                className={`relative px-4 py-2.5 rounded-xl text-sm font-medium border transition-all active:scale-95 flex items-center gap-2 ${
                  showFilters || activeFilterCount > 0
                    ? 'bg-brand-50 dark:bg-brand-900/20 border-brand-200 dark:border-brand-800 text-brand-600 dark:text-brand-400'
                    : 'bg-gray-50 dark:bg-gray-800/50 border-transparent text-gray-600 dark:text-gray-400 hover:border-gray-200 dark:hover:border-gray-700'
                }`}
              >
                <Filter size={16} />
                筛选
                {activeFilterCount > 0 && (
                  <span className="w-5 h-5 rounded-full bg-brand-500 text-white text-[10px] font-bold flex items-center justify-center">
                    {activeFilterCount}
                  </span>
                )}
              </button>
              <button
                onClick={handleSearch}
                className="flex-1 md:flex-none px-8 py-2.5 rounded-xl text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 transition-all active:scale-95 shadow-lg shadow-brand-600/20"
              >
                搜索
              </button>
            </div>
          </div>

          {/* 筛选面板 */}
          {showFilters && (
            <div className="mt-4 pt-4 border-t border-gray-100 dark:border-gray-800 space-y-4 animate-in slide-in-from-top-2 duration-200">
              {/* 课程类型 */}
              <div className="flex flex-wrap items-center gap-2">
                <span className="text-xs font-medium text-gray-500 dark:text-gray-400 mr-1 w-16 flex-shrink-0">课程类型</span>
                {COURSE_TYPE_FILTERS.map(f => (
                  <button
                    key={f.value}
                    onClick={() => handleCourseTypeChange(f.value)}
                    className={`px-3 py-1.5 rounded-lg text-xs font-medium transition-all ${
                      courseTypeFilter === f.value
                        ? 'bg-brand-500 text-white shadow-sm'
                        : 'bg-gray-50 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 hover:text-brand-600 dark:hover:text-brand-400'
                    }`}
                  >
                    {f.label}
                  </button>
                ))}
              </div>
              {/* 难度等级 */}
              <div className="flex flex-wrap items-center gap-2">
                <span className="text-xs font-medium text-gray-500 dark:text-gray-400 mr-1 w-16 flex-shrink-0">难度等级</span>
                {DIFFICULTY_FILTERS.map(f => (
                  <button
                    key={f.value}
                    onClick={() => handleDifficultyChange(f.value)}
                    className={`px-3 py-1.5 rounded-lg text-xs font-medium transition-all ${
                      difficultyFilter === f.value
                        ? 'bg-brand-500 text-white shadow-sm'
                        : 'bg-gray-50 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 hover:text-brand-600 dark:hover:text-brand-400'
                    }`}
                  >
                    {f.label}
                  </button>
                ))}
              </div>
              {/* 清除筛选 */}
              {activeFilterCount > 0 && (
                <div className="flex justify-end">
                  <button
                    onClick={() => { setCourseTypeFilter(-1); setDifficultyFilter(-1); }}
                    className="text-xs text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors"
                  >
                    清除全部筛选
                  </button>
                </div>
              )}
            </div>
          )}
        </div>
      </div>

      {/* 课程列表 */}
      {loading ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
          {Array.from({ length: 8 }).map((_, i) => (
            <div key={i} className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 overflow-hidden animate-pulse">
              <div className="aspect-video bg-gray-100 dark:bg-gray-800" />
              <div className="p-4 space-y-3">
                <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-3/4" />
                <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-full" />
                <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
              </div>
            </div>
          ))}
        </div>
      ) : courses.length === 0 ? (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm py-16 text-center">
          <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
            <GraduationCap size={32} className="text-gray-300 dark:text-gray-600" />
          </div>
          <p className="text-gray-500 dark:text-gray-400 font-medium">
            {activeKeyword ? `未找到与"${activeKeyword}"相关的课程` : '暂无课程'}
          </p>
          {activeKeyword && (
            <button
              onClick={() => { setSearchKeyword(''); setActiveKeyword(''); setCurrentPage(1); }}
              className="mt-3 text-sm text-brand-600 dark:text-brand-400 hover:underline"
            >
              清除搜索
            </button>
          )}
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
          {courses.map(course => {
            const diff = course.difficulty ? difficultyLabels[course.difficulty] : null;
            return (
              <div
                key={String(course.id)}
                onClick={() => navigate(`/course/${String(course.id)}`)}
                className="group bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden cursor-pointer hover:shadow-lg hover:border-brand-200 dark:hover:border-brand-500/30 transition-all duration-300"
              >
                {/* 封面 */}
                <div className="relative aspect-video overflow-hidden bg-gray-50 dark:bg-gray-800/50">
                  {course.coverImage ? (
                    <img
                      src={course.coverImage}
                      alt={course.title}
                      className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                    />
                  ) : (
                    <div className="w-full h-full bg-gradient-to-br from-brand-100 to-accent-100 dark:from-brand-900/30 dark:to-accent-900/30 flex items-center justify-center">
                      <BookOpen size={36} className="text-brand-300 dark:text-brand-600" />
                    </div>
                  )}
                  {/* 左上角标签 */}
                  <div className="absolute top-2.5 left-2.5 flex gap-1.5">
                    {course.courseType === 0 && (
                      <span className="px-2 py-0.5 rounded-md text-[10px] font-bold bg-green-500/90 text-white backdrop-blur-sm shadow-sm">
                        免费
                      </span>
                    )}
                    {course.courseType === 2 && (
                      <span className="px-2 py-0.5 rounded-md text-[10px] font-bold bg-amber-500/90 text-white backdrop-blur-sm shadow-sm">
                        会员
                      </span>
                    )}
                    {diff && (
                      <span className={`px-2 py-0.5 rounded-md text-[10px] font-bold ${diff.color} backdrop-blur-sm`}>
                        {diff.text}
                      </span>
                    )}
                  </div>
                  {/* 右上角课程类型 */}
                  {course.courseTypeDesc && course.courseType === 1 && (
                    <div className="absolute top-2.5 right-2.5">
                      <span className="px-2 py-0.5 rounded-md text-[10px] font-bold bg-white/90 dark:bg-gray-900/90 text-gray-700 dark:text-gray-300 backdrop-blur-sm shadow-sm">
                        {course.courseTypeDesc}
                      </span>
                    </div>
                  )}
                  {/* 标签 */}
                  {course.tags && course.tags.length > 0 && (
                    <div className="absolute bottom-2.5 left-2.5 flex gap-1">
                      {course.tags.slice(0, 2).map(tag => (
                        <span key={tag} className="bg-black/40 text-white px-1.5 py-0.5 rounded text-[10px] font-medium backdrop-blur-sm">
                          {tag}
                        </span>
                      ))}
                    </div>
                  )}
                  {/* hover 播放按钮 */}
                  <div className="absolute inset-0 bg-black/0 group-hover:bg-black/20 transition-all duration-300 flex items-center justify-center">
                    <div className="w-12 h-12 rounded-full bg-white/0 group-hover:bg-white/90 dark:group-hover:bg-gray-900/90 flex items-center justify-center opacity-0 group-hover:opacity-100 scale-75 group-hover:scale-100 transition-all duration-300 shadow-lg">
                      <Play size={20} className="text-brand-600 dark:text-brand-400 ml-0.5" fill="currentColor" />
                    </div>
                  </div>
                </div>

                {/* 信息 */}
                <div className="p-4">
                  <h3 className="font-bold text-sm text-gray-900 dark:text-white line-clamp-1 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors">
                    {course.title}
                  </h3>
                  <p className="text-xs text-gray-500 dark:text-gray-400 mt-1.5 line-clamp-2 leading-relaxed min-h-[2.5rem]">
                    {course.description || course.subtitle || '暂无简介'}
                  </p>

                  {/* 统计信息 */}
                  <div className="flex items-center gap-3 mt-3 pt-3 border-t border-gray-50 dark:border-gray-800 text-[11px] text-gray-400 dark:text-gray-500">
                    {(course.totalChapters != null && course.totalChapters > 0) && (
                      <span className="flex items-center gap-1">
                        <BookOpen size={12} />
                        {course.totalChapters}章
                      </span>
                    )}
                    {(course.totalDuration != null && course.totalDuration > 0) && (
                      <span className="flex items-center gap-1">
                        <Clock size={12} />
                        {course.totalDuration}分钟
                      </span>
                    )}
                    <span className="flex items-center gap-1">
                      <Users size={12} />
                      {course.studentCount || 0}人
                    </span>
                    {course.ratingScore != null && course.ratingScore > 0 && (
                      <span className="flex items-center gap-1 text-amber-500">
                        <Star size={12} fill="currentColor" />
                        {course.ratingScore.toFixed(1)}
                      </span>
                    )}
                  </div>

                  {/* 底部：价格 + 按钮 */}
                  <div className="flex items-center justify-between mt-3">
                    <div>
                      {course.courseType === 0 ? (
                        <span className="text-sm font-bold text-green-600 dark:text-green-400">免费</span>
                      ) : course.courseType === 2 ? (
                        <span className="text-sm font-bold text-amber-600 dark:text-amber-400">会员专享</span>
                      ) : (
                        <span className="text-sm font-bold text-brand-600 dark:text-brand-400">
                          <span className="text-[10px] font-normal">¥</span>{course.price || 0}
                        </span>
                      )}
                    </div>
                    <span className="text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/30 px-2.5 py-1 rounded-lg text-[11px] font-semibold group-hover:bg-brand-500 group-hover:text-white transition-all">
                      查看详情
                    </span>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* 分页 */}
      {!loading && courses.length > 0 && (
        <div className="flex items-center justify-center gap-3">
          <button
            onClick={() => setCurrentPage(p => Math.max(1, p - 1))}
            disabled={currentPage === 1}
            className="p-2.5 rounded-xl border border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-30 transition-all hover:border-brand-200 dark:hover:border-brand-800"
          >
            <ChevronLeft size={18} />
          </button>
          <div className="px-4 py-2 rounded-xl bg-gray-50 dark:bg-gray-800 border border-gray-100 dark:border-gray-700">
            <span className="text-sm font-bold text-gray-700 dark:text-gray-300">第 {currentPage} 页</span>
          </div>
          <button
            onClick={() => setCurrentPage(p => p + 1)}
            disabled={!hasMore}
            className="p-2.5 rounded-xl border border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-30 transition-all hover:border-brand-200 dark:hover:border-brand-800"
          >
            <ChevronRight size={18} />
          </button>
        </div>
      )}
    </div>
  );
};

export default CourseListPage;
