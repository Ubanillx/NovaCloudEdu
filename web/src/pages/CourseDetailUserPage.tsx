import React, { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import {
  ArrowLeft, BookOpen, Clock, Users, Star, Heart, Play, Lock,
  ChevronDown, ChevronRight, Download, Shield,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type {
  CourseResponse,
  CourseStructureResponse,
  ChapterResponse,
  SectionResponse,
  CourseProgressSummaryResponse,
} from '../api/generated/models';
import { toast } from '../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

type SectionExt = SectionResponse;

const formatDuration = (seconds?: number) => {
  if (!seconds) return '';
  if (seconds >= 3600) {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    return `${h}小时${m > 0 ? `${m}分钟` : ''}`;
  }
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return m > 0 ? `${m}分${s > 0 ? `${s}秒` : ''}` : `${s}秒`;
};

const difficultyLabels: Record<number, { text: string; color: string }> = {
  1: { text: '入门', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' },
  2: { text: '初级', color: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400' },
  3: { text: '中级', color: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400' },
  4: { text: '高级', color: 'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-400' },
  5: { text: '专家', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400' },
};

const CourseDetailUserPage: React.FC = () => {
  const { courseId } = useParams<{ courseId: string }>();
  const navigate = useNavigate();

  const [course, setCourse] = useState<CourseResponse | null>(null);
  const [structure, setStructure] = useState<CourseStructureResponse | null>(null);
  const [progress, setProgress] = useState<CourseProgressSummaryResponse | null>(null);
  const [isFavourited, setIsFavourited] = useState(false);
  const [favouriteCount, setFavouriteCount] = useState(0);
  const [loading, setLoading] = useState(true);
  const [expandedChapters, setExpandedChapters] = useState<Set<string>>(new Set());

  const fetchData = useCallback(async () => {
    if (!courseId) return;
    setLoading(true);
    try {
      const [courseRes, structRes] = await Promise.all([
        api.getCourse({ id: courseId as unknown as number }),
        api.getCourseStructure({ courseId: courseId as unknown as number }),
      ]);

      if (courseRes.data.code === 0 && courseRes.data.data) {
        setCourse(courseRes.data.data);
      }
      if (structRes.data.code === 0 && structRes.data.data) {
        setStructure(structRes.data.data);
        // 默认全部展开
        const ids = new Set((structRes.data.data.chapters || []).map(ch => String(ch.id)));
        setExpandedChapters(ids);
      }

      // 并行加载可选数据
      const [progRes, favCheckRes, favCountRes] = await Promise.allSettled([
        api.getCourseProgressSummary({ courseId: courseId as unknown as number }),
        api.checkFavourite({ courseId: courseId as unknown as number }),
        api.getFavouriteCount({ courseId: courseId as unknown as number }),
      ]);

      if (progRes.status === 'fulfilled' && progRes.value.data.code === 0) {
        setProgress(progRes.value.data.data || null);
      }
      if (favCheckRes.status === 'fulfilled' && favCheckRes.value.data.code === 0) {
        setIsFavourited(!!favCheckRes.value.data.data);
      }
      if (favCountRes.status === 'fulfilled' && favCountRes.value.data.code === 0) {
        setFavouriteCount(Number(favCountRes.value.data.data) || 0);
      }
    } catch {
      toast.error('加载课程信息失败');
    } finally {
      setLoading(false);
    }
  }, [courseId]);

  useEffect(() => { fetchData(); }, [fetchData]);

  const toggleChapter = (chapterId: string) => {
    setExpandedChapters(prev => {
      const next = new Set(prev);
      if (next.has(chapterId)) next.delete(chapterId);
      else next.add(chapterId);
      return next;
    });
  };

  const handleFavourite = async () => {
    if (!courseId) return;
    try {
      const res = await api.favouriteCourse({ courseId: courseId as unknown as number });
      if (res.data.code === 0) {
        setIsFavourited(!isFavourited);
        setFavouriteCount(prev => isFavourited ? prev - 1 : prev + 1);
        toast.success(isFavourited ? '已取消收藏' : '已收藏');
      }
    } catch {
      toast.error('操作失败');
    }
  };

  const handleStartLearn = () => {
    if (!courseId) return;
    // 找到第一个小节
    const chapters = (structure?.chapters || []).sort((a, b) => (a.sort || 0) - (b.sort || 0));
    for (const ch of chapters) {
      const sections = (ch.sections || []).sort((a, b) => (a.sort || 0) - (b.sort || 0));
      if (sections.length > 0) {
        navigate(`/course/${courseId}/learn?section=${sections[0].id}`);
        return;
      }
    }
    toast.warning('课程暂无可学习的小节');
  };

  const handleSectionClick = (section: SectionExt) => {
    if (!courseId) return;
    navigate(`/course/${courseId}/learn?section=${section.id}`);
  };

  if (loading) {
    return (
      <div className="space-y-6 animate-pulse">
        <div className="h-8 bg-gray-200 dark:bg-gray-800 rounded w-48" />
        <div className="aspect-video bg-gray-200 dark:bg-gray-800 rounded-2xl" />
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <div className="lg:col-span-2 space-y-4">
            <div className="h-6 bg-gray-200 dark:bg-gray-800 rounded w-3/4" />
            <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-full" />
            <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-2/3" />
          </div>
          <div className="space-y-4">
            <div className="h-12 bg-gray-200 dark:bg-gray-800 rounded-xl" />
            <div className="h-12 bg-gray-200 dark:bg-gray-800 rounded-xl" />
          </div>
        </div>
      </div>
    );
  }

  if (!course) {
    return (
      <div className="text-center py-20">
        <p className="text-gray-500 dark:text-gray-400 text-lg">课程不存在或已下架</p>
        <button onClick={() => navigate('/')} className="mt-4 text-brand-600 hover:underline">返回首页</button>
      </div>
    );
  }

  const chapters = (structure?.chapters || []).sort((a, b) => (a.sort || 0) - (b.sort || 0));
  const totalSections = chapters.reduce((s, ch) => s + (ch.sections?.length || 0), 0);
  const totalDuration = chapters.reduce(
    (s, ch) => s + (ch.sections || []).reduce((ss, sec) => ss + (sec.duration || 0), 0), 0
  );
  const diff = course.difficulty ? difficultyLabels[course.difficulty] : null;

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* 返回 */}
      <button onClick={() => navigate('/')}
        className="flex items-center gap-2 text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors group">
        <ArrowLeft size={18} className="group-hover:-translate-x-0.5 transition-transform" />
        <span className="text-sm font-medium">返回首页</span>
      </button>

      {/* 顶部布局：封面 + 侧栏操作卡片 */}
      <div className="grid grid-cols-1 xl:grid-cols-3 gap-6">
        <div className="xl:col-span-2 space-y-6">
          {/* 封面 Hero */}
          <div className="relative aspect-video max-h-[420px] rounded-2xl overflow-hidden bg-gray-100 dark:bg-gray-800 shadow-xl ring-1 ring-black/5 dark:ring-white/5">
            {course.coverImage ? (
              <img src={course.coverImage} alt={course.title} className="w-full h-full object-cover" />
            ) : (
              <div className="w-full h-full bg-gradient-to-br from-brand-600 via-brand-500 to-accent-500 flex items-center justify-center">
                <BookOpen size={72} className="text-white/30" />
              </div>
            )}
            <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent" />
            {/* 播放按钮 overlay */}
            <button onClick={handleStartLearn}
              className="absolute inset-0 flex items-center justify-center group/play">
              <div className="w-16 h-16 md:w-20 md:h-20 rounded-full bg-white/20 backdrop-blur-md flex items-center justify-center border border-white/30 transition-all group-hover/play:scale-110 group-hover/play:bg-white/30 group-active/play:scale-95">
                <Play size={28} className="text-white ml-1" fill="currentColor" />
              </div>
            </button>
            {/* 封面底部信息 */}
            <div className="absolute bottom-0 left-0 right-0 p-6">
              <div className="flex flex-wrap items-center gap-2 mb-2">
                {diff && (
                  <span className={`px-2 py-0.5 rounded-md text-[10px] font-bold ${diff.color}`}>{diff.text}</span>
                )}
                {course.courseType === 0 && (
                  <span className="px-2 py-0.5 rounded-md text-[10px] font-bold bg-green-500/20 text-green-300 backdrop-blur-sm">免费</span>
                )}
              </div>
              <h1 className="text-2xl md:text-3xl font-bold text-white drop-shadow-lg leading-tight">{course.title}</h1>
              {course.subtitle && (
                <p className="text-white/70 mt-1.5 text-sm md:text-base line-clamp-2">{course.subtitle}</p>
              )}
            </div>
          </div>

          {/* 课程概览 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm">
            {/* 统计信息行 */}
            <div className="flex flex-wrap items-center gap-x-5 gap-y-2 mb-4">
              {course.courseTypeDesc && (
                <span className="px-2.5 py-1 rounded-lg text-xs font-bold bg-brand-50 text-brand-600 dark:bg-brand-900/30 dark:text-brand-400">
                  {course.courseTypeDesc}
                </span>
              )}
              <div className="flex items-center gap-1.5 text-sm text-gray-500 dark:text-gray-400">
                <BookOpen size={14} className="text-gray-400" />
                <span>{chapters.length} 章 · {totalSections} 节</span>
              </div>
              {totalDuration > 0 && (
                <div className="flex items-center gap-1.5 text-sm text-gray-500 dark:text-gray-400">
                  <Clock size={14} className="text-gray-400" />
                  <span>{formatDuration(totalDuration)}</span>
                </div>
              )}
              <div className="flex items-center gap-1.5 text-sm text-gray-500 dark:text-gray-400">
                <Users size={14} className="text-gray-400" />
                <span>{course.studentCount || 0} 人学习</span>
              </div>
              {course.ratingScore && course.ratingScore > 0 && (
                <div className="flex items-center gap-1.5 text-sm">
                  <Star size={14} className="text-amber-400" fill="currentColor" />
                  <span className="font-semibold text-amber-600 dark:text-amber-400">{course.ratingScore.toFixed(1)}</span>
                </div>
              )}
            </div>
            {/* 描述 */}
            {course.description && (
              <p className="text-gray-600 dark:text-gray-300 text-sm leading-relaxed">{course.description}</p>
            )}
            {/* 标签 */}
            {course.tags && course.tags.length > 0 && (
              <div className="flex flex-wrap gap-2 mt-4 pt-4 border-t border-gray-50 dark:border-gray-800">
                {course.tags.map(tag => (
                  <span key={tag} className="px-2.5 py-1 bg-gray-50 dark:bg-gray-800 text-gray-500 dark:text-gray-400 rounded-lg text-xs font-medium">{tag}</span>
                ))}
              </div>
            )}
          </div>

          {/* 课程目录 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
            <div className="px-6 py-4 border-b border-gray-100 dark:border-gray-800 flex items-center justify-between">
              <h2 className="text-lg font-bold text-gray-900 dark:text-white">课程目录</h2>
              <span className="text-xs font-medium text-gray-400">{chapters.length} 章 · {totalSections} 节</span>
            </div>
            {chapters.length > 0 ? (
              <div className="divide-y divide-gray-50 dark:divide-gray-800/50">
                {chapters.map((chapter: ChapterResponse, ci: number) => {
                  const chId = String(chapter.id);
                  const isExpanded = expandedChapters.has(chId);
                  const sections = ((chapter.sections || []) as SectionExt[]).sort((a, b) => (a.sort || 0) - (b.sort || 0));

                  return (
                    <div key={chId}>
                      <button onClick={() => toggleChapter(chId)}
                        className="w-full flex items-center gap-3 px-6 py-4 hover:bg-gray-50 dark:hover:bg-gray-800/30 transition-colors text-left group">
                        <div className={`w-7 h-7 rounded-lg flex items-center justify-center flex-shrink-0 transition-colors ${
                          isExpanded ? 'bg-brand-500 text-white' : 'bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400'
                        }`}>
                          {isExpanded ? <ChevronDown size={14} /> : <span className="text-xs font-bold">{ci + 1}</span>}
                        </div>
                        <div className="flex-1 min-w-0">
                          <span className="text-sm font-semibold text-gray-900 dark:text-white">{chapter.title}</span>
                          <span className="ml-2 text-xs text-gray-400">{sections.length} 小节</span>
                        </div>
                        <ChevronRight size={16} className={`text-gray-300 dark:text-gray-600 transition-transform duration-200 ${isExpanded ? 'rotate-90' : ''}`} />
                      </button>
                      {isExpanded && sections.length > 0 && (
                        <div className="pb-2 animate-fadeIn">
                          {sections.map((section, si) => (
                            <button key={String(section.id)} onClick={() => handleSectionClick(section)}
                              className="w-full flex items-center gap-3 px-6 pl-16 py-3 hover:bg-brand-50/50 dark:hover:bg-brand-900/10 transition-colors text-left group/sec">
                              <div className="w-6 h-6 rounded-full flex items-center justify-center flex-shrink-0 bg-gray-100 dark:bg-gray-800 group-hover/sec:bg-brand-100 dark:group-hover/sec:bg-brand-900/30 transition-colors">
                                {section.isFree ? (
                                  <Play size={11} className="text-brand-600 dark:text-brand-400 ml-0.5" fill="currentColor" />
                                ) : (
                                  <Lock size={11} className="text-gray-400" />
                                )}
                              </div>
                              <div className="flex-1 min-w-0">
                                <span className="text-sm text-gray-700 dark:text-gray-300 group-hover/sec:text-brand-600 dark:group-hover/sec:text-brand-400 transition-colors">
                                  {si + 1}. {section.title}
                                </span>
                              </div>
                              <div className="flex items-center gap-2 flex-shrink-0">
                                {section.isFree && (
                                  <span className="px-1.5 py-0.5 text-[10px] font-bold bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 rounded">免费</span>
                                )}
                                {section.transcodeStatus === 2 && (
                                  <Shield size={12} className="text-emerald-500" />
                                )}
                                {section.resourceUrl && (
                                  <Download size={12} className="text-gray-300 dark:text-gray-600" />
                                )}
                                {section.duration && section.duration > 0 && (
                                  <span className="text-xs text-gray-400 tabular-nums">{formatDuration(section.duration)}</span>
                                )}
                              </div>
                            </button>
                          ))}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            ) : (
              <div className="py-16 text-center">
                <div className="w-14 h-14 rounded-2xl bg-gray-100 dark:bg-gray-800 flex items-center justify-center mx-auto mb-3">
                  <BookOpen size={28} className="text-gray-300 dark:text-gray-600" />
                </div>
                <p className="text-gray-400 dark:text-gray-500 text-sm">课程内容正在筹备中...</p>
              </div>
            )}
          </div>
        </div>

        {/* 右栏 */}
        <div className="space-y-4 xl:sticky xl:top-20">
          {/* 操作卡片 */}
          <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-6 shadow-sm sticky top-20 space-y-4">
            {/* 价格 */}
            <div className="text-center pb-3 border-b border-gray-50 dark:border-gray-800">
              {course.courseType === 0 ? (
                <div className="flex items-center justify-center gap-2">
                  <span className="text-2xl font-bold text-green-600 dark:text-green-400">免费课程</span>
                </div>
              ) : (
                <div className="flex items-baseline justify-center gap-0.5">
                  <span className="text-sm text-gray-400">¥</span>
                  <span className="text-3xl font-black text-brand-600 dark:text-brand-400 tabular-nums">{course.price || 0}</span>
                </div>
              )}
            </div>

            {/* 开始学习 */}
            <button onClick={handleStartLearn}
              className="w-full py-3 bg-gradient-to-r from-brand-600 to-brand-500 text-white rounded-xl text-sm font-bold hover:from-brand-700 hover:to-brand-600 shadow-lg shadow-brand-600/25 transition-all active:scale-[0.97] flex items-center justify-center gap-2 group">
              <Play size={18} fill="currentColor" className="group-hover:scale-110 transition-transform" />
              {progress && (progress.completionRate || 0) > 0 ? '继续学习' : '开始学习'}
            </button>

            {/* 收藏 */}
            <button onClick={handleFavourite}
              className={`w-full py-2.5 rounded-xl text-sm font-medium border transition-all active:scale-[0.97] flex items-center justify-center gap-2 ${
                isFavourited
                  ? 'bg-red-50 dark:bg-red-900/10 border-red-200 dark:border-red-800 text-red-500 dark:text-red-400'
                  : 'bg-gray-50 dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-400 hover:border-red-200 hover:text-red-500 dark:hover:border-red-800 dark:hover:text-red-400'
              }`}>
              <Heart size={16} fill={isFavourited ? 'currentColor' : 'none'} className={isFavourited ? 'animate-bounceIn' : ''} />
              {isFavourited ? '已收藏' : '收藏课程'} ({favouriteCount})
            </button>

            {/* 学习进度 */}
            {progress && (progress.completionRate || 0) > 0 && (
              <div className="pt-3 border-t border-gray-100 dark:border-gray-800">
                <div className="flex items-center justify-between text-sm mb-2">
                  <span className="text-gray-500 dark:text-gray-400">学习进度</span>
                  <span className="font-bold text-brand-600 dark:text-brand-400 tabular-nums">
                    {Math.round(progress.completionRate || 0)}%
                  </span>
                </div>
                <div className="w-full h-2 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
                  <div className="h-full bg-gradient-to-r from-brand-500 to-brand-400 rounded-full transition-all duration-700 ease-out"
                    style={{ width: `${progress.completionRate || 0}%` }} />
                </div>
                <p className="text-xs text-gray-400 mt-1.5">
                  已完成 {progress.completedSections || 0} / {progress.totalSections || 0} 小节
                </p>
              </div>
            )}

            {/* 课程信息 */}
            <div className="pt-3 border-t border-gray-100 dark:border-gray-800 space-y-2.5">
              <div className="flex justify-between text-sm">
                <span className="text-gray-400 flex items-center gap-1.5"><BookOpen size={13} />章节</span>
                <span className="text-gray-700 dark:text-gray-300 font-medium">{chapters.length} 章</span>
              </div>
              <div className="flex justify-between text-sm">
                <span className="text-gray-400 flex items-center gap-1.5"><Play size={13} />小节</span>
                <span className="text-gray-700 dark:text-gray-300 font-medium">{totalSections} 节</span>
              </div>
              {totalDuration > 0 && (
                <div className="flex justify-between text-sm">
                  <span className="text-gray-400 flex items-center gap-1.5"><Clock size={13} />时长</span>
                  <span className="text-gray-700 dark:text-gray-300 font-medium">{formatDuration(totalDuration)}</span>
                </div>
              )}
              <div className="flex justify-between text-sm">
                <span className="text-gray-400 flex items-center gap-1.5"><Users size={13} />学员</span>
                <span className="text-gray-700 dark:text-gray-300 font-medium">{course.studentCount || 0} 人</span>
              </div>
              {course.ratingScore && course.ratingScore > 0 && (
                <div className="flex justify-between text-sm">
                  <span className="text-gray-400 flex items-center gap-1.5"><Star size={13} />评分</span>
                  <span className="text-amber-600 dark:text-amber-400 font-medium flex items-center gap-1">
                    {course.ratingScore.toFixed(1)}
                    <Star size={12} fill="currentColor" className="text-amber-400" />
                  </span>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CourseDetailUserPage;
