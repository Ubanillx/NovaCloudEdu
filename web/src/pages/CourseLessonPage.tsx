import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useParams, useNavigate, useSearchParams } from 'react-router-dom';
import {
  ArrowLeft, ChevronDown, ChevronRight, Play, CheckCircle2,
  Download, SkipBack, SkipForward, BookOpen, Menu, X,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type {
  CourseStructureResponse,
  ChapterResponse,
  SectionResponse,
} from '../api/generated/models';
import { toast, ArtPlayerWrapper, FocusMonitor } from '../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

type SectionExt = SectionResponse;

const formatDuration = (seconds?: number) => {
  if (!seconds) return '';
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return m > 0 ? `${m}:${s.toString().padStart(2, '0')}` : `0:${s.toString().padStart(2, '0')}`;
};

// 从结构中提取扁平化的小节列表
const flattenSections = (chapters: ChapterResponse[]): { section: SectionExt; chapter: ChapterResponse }[] => {
  const result: { section: SectionExt; chapter: ChapterResponse }[] = [];
  const sorted = [...chapters].sort((a, b) => (a.sort || 0) - (b.sort || 0));
  for (const ch of sorted) {
    const sections = ((ch.sections || []) as SectionExt[]).sort((a, b) => (a.sort || 0) - (b.sort || 0));
    for (const sec of sections) {
      result.push({ section: sec, chapter: ch });
    }
  }
  return result;
};

const CourseLessonPage: React.FC = () => {
  const { courseId } = useParams<{ courseId: string }>();
  const [searchParams, setSearchParams] = useSearchParams();
  const navigate = useNavigate();

  const [structure, setStructure] = useState<CourseStructureResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [expandedChapters, setExpandedChapters] = useState<Set<string>>(new Set());
  const [completedSections, setCompletedSections] = useState<Set<string>>(new Set());
  const [initialSeek, setInitialSeek] = useState(0);
  const lastSaveRef = useRef<number>(0);

  const currentSectionId = searchParams.get('section') || '';

  // 加载课程结构
  const fetchStructure = useCallback(async () => {
    if (!courseId) return;
    setLoading(true);
    try {
      const res = await api.getCourseStructure({ courseId: courseId as unknown as number });
      if (res.data.code === 0 && res.data.data) {
        setStructure(res.data.data);
        const ids = new Set((res.data.data.chapters || []).map(ch => String(ch.id)));
        setExpandedChapters(ids);
      } else {
        toast.error('加载课程失败');
      }
    } catch {
      toast.error('网络错误');
    } finally {
      setLoading(false);
    }
  }, [courseId]);

  useEffect(() => { fetchStructure(); }, [fetchStructure]);

  // 加载学习进度
  useEffect(() => {
    if (!courseId) return;
    api.getCourseProgress({ courseId: courseId as unknown as number })
      .then(res => {
        if (res.data.code === 0 && res.data.data) {
          const progList = Array.isArray(res.data.data) ? res.data.data : [];
          const completed = new Set<string>();
          let seekPos = 0;
          for (const p of progList) {
            if (p.isCompleted) completed.add(String(p.sectionId));
            if (String(p.sectionId) === currentSectionId && p.lastPosition) {
              seekPos = p.lastPosition;
            }
          }
          setCompletedSections(completed);
          setInitialSeek(seekPos);
        }
      })
      .catch(() => {});
  }, [courseId, currentSectionId]);

  // 扁平化小节
  const chapters = (structure?.chapters || []).sort((a, b) => (a.sort || 0) - (b.sort || 0));
  const flatList = flattenSections(chapters);
  const currentIndex = flatList.findIndex(item => String(item.section.id) === currentSectionId);
  const currentItem = currentIndex >= 0 ? flatList[currentIndex] : null;
  const currentSection = currentItem?.section;
  const currentChapter = currentItem?.chapter;

  // 如果没有指定 section 且已加载结构，自动选择第一个
  useEffect(() => {
    if (!currentSectionId && flatList.length > 0 && !loading) {
      setSearchParams({ section: String(flatList[0].section.id) }, { replace: true });
    }
  }, [currentSectionId, flatList.length, loading, setSearchParams]);

  // 切换小节
  const goToSection = (sectionId: string) => {
    setInitialSeek(0);
    setSearchParams({ section: sectionId });
  };

  const goPrev = () => {
    if (currentIndex > 0) goToSection(String(flatList[currentIndex - 1].section.id));
  };

  const goNext = () => {
    if (currentIndex < flatList.length - 1) goToSection(String(flatList[currentIndex + 1].section.id));
  };

  // 保存进度
  const saveProgress = useCallback((currentTime: number, duration: number) => {
    if (!courseId || !currentSectionId || duration <= 0) return;
    const now = Date.now();
    if (now - lastSaveRef.current < 10000) return; // 至少间隔10秒
    lastSaveRef.current = now;

    const progress = Math.round((currentTime / duration) * 100);
    api.updateProgress1({
      updateProgressRequest: {
        courseId: courseId as unknown as number,
        sectionId: currentSectionId as unknown as number,
        lastPosition: Math.round(currentTime),
        watchDuration: Math.round(currentTime),
        progress: Math.min(progress, 100),
      },
    }).catch(() => {});

    // 自动标记完成（≥90%）
    if (progress >= 90 && !completedSections.has(currentSectionId)) {
      api.completeSection({
        sectionId: currentSectionId as unknown as number,
        courseId: courseId as unknown as number,
      }).then(() => {
        setCompletedSections(prev => new Set([...prev, currentSectionId]));
      }).catch(() => {});
    }
  }, [courseId, currentSectionId, completedSections]);

  // 手动标记完成
  const handleMarkComplete = async () => {
    if (!courseId || !currentSectionId) return;
    try {
      const res = await api.completeSection({
        sectionId: currentSectionId as unknown as number,
        courseId: courseId as unknown as number,
      });
      if (res.data.code === 0) {
        setCompletedSections(prev => new Set([...prev, currentSectionId]));
        toast.success('已标记完成');
      }
    } catch {
      toast.error('操作失败');
    }
  };

  const toggleChapter = (chapterId: string) => {
    setExpandedChapters(prev => {
      const next = new Set(prev);
      if (next.has(chapterId)) next.delete(chapterId);
      else next.add(chapterId);
      return next;
    });
  };

  // 获取视频 URL
  const videoUrl = currentSection?.hlsUrl || currentSection?.videoUrl || '';

  // 完成进度百分比
  const completionPercent = flatList.length > 0 ? Math.round((completedSections.size / flatList.length) * 100) : 0;

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 dark:bg-gray-950 flex items-center justify-center">
        <div className="text-gray-400 flex flex-col items-center gap-3">
          <div className="w-8 h-8 border-2 border-brand-500 border-t-transparent rounded-full animate-spin" />
          <span className="text-sm">加载课程中...</span>
        </div>
      </div>
    );
  }

  return (
    <div className="h-screen bg-gray-50 dark:bg-gray-950 flex flex-col overflow-hidden">
      {/* 顶栏 */}
      <header className="h-13 bg-white dark:bg-gray-900/95 backdrop-blur-sm border-b border-gray-200 dark:border-gray-800 flex items-center px-4 gap-3 flex-shrink-0 z-20">
        <button onClick={() => navigate(`/course/${courseId}`)}
          className="flex items-center gap-1.5 text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors text-sm group">
          <ArrowLeft size={16} className="group-hover:-translate-x-0.5 transition-transform" />
          <span className="hidden sm:inline">返回课程</span>
        </button>
        <div className="h-4 w-px bg-gray-200 dark:bg-gray-700" />
        <div className="flex-1 min-w-0 flex items-center gap-1.5 text-sm text-gray-500 dark:text-gray-400 truncate">
          <span className="truncate max-w-[140px]">{structure?.course?.title}</span>
          {currentChapter && (
            <>
              <ChevronRight size={14} className="text-gray-300 dark:text-gray-600 flex-shrink-0" />
              <span className="truncate max-w-[120px]">{currentChapter.title}</span>
            </>
          )}
          {currentSection && (
            <>
              <ChevronRight size={14} className="text-gray-300 dark:text-gray-600 flex-shrink-0" />
              <span className="truncate font-semibold text-gray-900 dark:text-white">{currentSection.title}</span>
            </>
          )}
        </div>
        <div className="flex items-center gap-2">
          {/* 进度指示器 */}
          <div className="hidden md:flex items-center gap-2">
            <div className="w-20 h-1.5 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
              <div className="h-full bg-brand-500 rounded-full transition-all duration-500"
                style={{ width: `${completionPercent}%` }} />
            </div>
            <span className="text-xs text-gray-400 font-medium tabular-nums">{completionPercent}%</span>
          </div>
          <button onClick={() => setSidebarOpen(!sidebarOpen)}
            className="p-1.5 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
            title={sidebarOpen ? '收起目录' : '展开目录'}>
            {sidebarOpen ? <X size={18} /> : <Menu size={18} />}
          </button>
        </div>
      </header>

      {/* 主体 */}
      <div className="flex flex-1 overflow-hidden">
        {/* 视频 + 信息区域 */}
        <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
          {/* 播放器 */}
          <div className="flex-1 bg-black flex items-center justify-center min-h-0">
            {videoUrl ? (
              <ArtPlayerWrapper
                key={videoUrl}
                url={videoUrl}
                poster={structure?.course?.coverImage}
                initialSeek={initialSeek}
                thumbnails={currentSection?.thumbnailUrl && currentSection?.thumbnailCount
                  ? { url: currentSection.thumbnailUrl, number: currentSection.thumbnailCount, column: 10 }
                  : undefined}
                onProgress={saveProgress}
                onEnded={() => {
                  if (!completedSections.has(currentSectionId)) {
                    handleMarkComplete();
                  }
                  // 自动跳下一节
                  if (currentIndex < flatList.length - 1) {
                    setTimeout(() => goNext(), 1500);
                  }
                }}
                className="!rounded-none w-full h-full"
                style={{ aspectRatio: undefined }}
              />
            ) : (
              <div className="w-full h-full flex items-center justify-center bg-gradient-to-b from-gray-900 to-gray-950">
                <div className="text-center text-gray-500">
                  <div className="w-16 h-16 rounded-2xl bg-gray-800/50 flex items-center justify-center mx-auto mb-4">
                    <BookOpen size={32} className="opacity-50" />
                  </div>
                  <p className="text-sm">该小节暂无视频</p>
                  <p className="text-xs text-gray-600 mt-1">请选择其他小节观看</p>
                </div>
              </div>
            )}
          </div>

          {/* 底部信息栏 */}
          <div className="flex-shrink-0 px-5 py-3 bg-white dark:bg-gray-900/95 backdrop-blur-sm border-t border-gray-100 dark:border-gray-800">
            <div className="flex items-center justify-between gap-4">
              {/* 左侧：标题+描述 */}
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2">
                  <h2 className="text-sm font-bold text-gray-900 dark:text-white truncate">
                    {currentSection?.title || '请选择小节'}
                  </h2>
                  {currentSection?.duration && currentSection.duration > 0 && (
                    <span className="text-xs text-gray-400 flex-shrink-0 tabular-nums">
                      {formatDuration(currentSection.duration)}
                    </span>
                  )}
                </div>
                {currentSection?.description && (
                  <p className="text-xs text-gray-500 dark:text-gray-400 mt-0.5 truncate">{currentSection.description}</p>
                )}
              </div>

              {/* 右侧：操作按钮 */}
              <div className="flex items-center gap-2 flex-shrink-0">
                <button onClick={goPrev} disabled={currentIndex <= 0}
                  className="p-2 rounded-lg text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 disabled:opacity-30 disabled:cursor-not-allowed transition-all"
                  title="上一节">
                  <SkipBack size={16} />
                </button>
                <button onClick={goNext} disabled={currentIndex >= flatList.length - 1}
                  className="p-2 rounded-lg text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 disabled:opacity-30 disabled:cursor-not-allowed transition-all"
                  title="下一节">
                  <SkipForward size={16} />
                </button>
                <div className="h-5 w-px bg-gray-200 dark:bg-gray-700" />
                <FocusMonitor enabled={!!videoUrl} />
                <div className="h-5 w-px bg-gray-200 dark:bg-gray-700" />
                {currentSection?.resourceUrl && (
                  <a href={currentSection.resourceUrl} target="_blank" rel="noopener noreferrer"
                    className="flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg text-xs font-medium text-brand-600 dark:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 transition-all"
                    title="下载课件">
                    <Download size={14} />
                    <span className="hidden sm:inline">课件</span>
                  </a>
                )}
                {currentSection && (
                  <button onClick={handleMarkComplete}
                    disabled={completedSections.has(currentSectionId)}
                    className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-semibold transition-all ${
                      completedSections.has(currentSectionId)
                        ? 'bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400'
                        : 'bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-brand-50 hover:text-brand-600 dark:hover:bg-brand-900/20 dark:hover:text-brand-400'
                    }`}>
                    <CheckCircle2 size={13} />
                    {completedSections.has(currentSectionId) ? '已完成' : '完成'}
                  </button>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* 侧边目录 */}
        <aside className={`bg-white/95 dark:bg-gray-900/95 backdrop-blur-sm border-l border-gray-200 dark:border-gray-800 shadow-[0_10px_30px_rgba(0,0,0,0.05)] flex-shrink-0 flex flex-col overflow-hidden transition-all duration-300 ease-in-out ${
          sidebarOpen ? 'w-72 xl:w-80' : 'w-0 border-l-0'
        } fixed lg:relative right-0 top-13 bottom-0 lg:top-auto lg:bottom-auto lg:right-auto z-10 ${sidebarOpen ? '' : 'lg:w-0'}`}>
          {/* 目录头 */}
          <div className="px-5 py-4 border-b border-gray-100 dark:border-gray-800 flex-shrink-0">
            <div className="flex items-center justify-between gap-3">
              <div>
                <p className="text-[12px] uppercase tracking-wide text-gray-400 dark:text-gray-500">课程目录</p>
                <h3 className="text-lg font-semibold text-gray-900 dark:text-white leading-6">进度与章节</h3>
              </div>
              <span className="text-[11px] font-semibold text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 px-2 py-1 rounded-md leading-none">
                {completedSections.size}/{flatList.length}
              </span>
            </div>
            {/* 进度条 */}
            <div className="mt-3 w-full h-1.5 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
              <div className="h-full bg-gradient-to-r from-brand-500 to-brand-400 rounded-full transition-all duration-700 ease-out"
                style={{ width: `${completionPercent}%` }} />
            </div>
          </div>

          {/* 目录列表 */}
          <div className="flex-1 overflow-y-auto custom-scrollbar">
            {chapters.map((chapter, ci) => {
              const chId = String(chapter.id);
              const isExpanded = expandedChapters.has(chId);
              const sections = ((chapter.sections || []) as SectionExt[]).sort((a, b) => (a.sort || 0) - (b.sort || 0));
              const chapterCompleted = sections.filter(s => completedSections.has(String(s.id))).length;

              return (
                <div key={chId} className="border-b border-gray-50 dark:border-gray-800/40">
                  <button onClick={() => toggleChapter(chId)}
                    className="w-full flex items-center gap-3 px-5 py-3.5 hover:bg-gray-50 dark:hover:bg-gray-800/40 transition-colors text-left group">
                    <div className={`w-6 h-6 rounded-lg flex items-center justify-center flex-shrink-0 transition-colors ${
                      isExpanded ? 'bg-brand-500 text-white' : 'bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400'
                    }`}>
                      {isExpanded
                        ? <ChevronDown size={12} />
                        : <ChevronRight size={12} />
                      }
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 text-[12px] text-gray-500 dark:text-gray-400">
                        <span className="px-2 py-0.5 rounded-full bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 font-semibold">第{ci + 1}章</span>
                        <span className="tabular-nums">{chapterCompleted}/{sections.length}</span>
                      </div>
                      <p className="text-base font-semibold text-gray-800 dark:text-gray-200 truncate mt-1 leading-5">{chapter.title}</p>
                    </div>
                  </button>
                  {isExpanded && (
                    <div className="pb-1">
                      {sections.map((section, si) => {
                        const secId = String(section.id);
                        const isCurrent = secId === currentSectionId;
                        const isCompleted = completedSections.has(secId);

                        return (
                          <button key={secId} onClick={() => goToSection(secId)}
                            className={`w-full flex items-center gap-3 pl-12 pr-4 py-2.5 text-left transition-all group/item ${
                              isCurrent
                                ? 'bg-brand-50/80 dark:bg-brand-900/20 border-l-2 border-brand-500'
                                : 'hover:bg-gray-50 dark:hover:bg-gray-800/30'
                            }`}>
                            <div className={`w-6 h-6 rounded-full flex items-center justify-center flex-shrink-0 transition-all ${
                              isCompleted
                                ? 'bg-green-100 dark:bg-green-900/30'
                                : isCurrent
                                  ? 'bg-brand-100 dark:bg-brand-900/30'
                                  : 'bg-gray-100 dark:bg-gray-800 group-hover/item:bg-gray-200 dark:group-hover/item:bg-gray-700'
                            }`}>
                              {isCompleted ? (
                                <CheckCircle2 size={12} className="text-green-500" />
                              ) : isCurrent ? (
                                <Play size={10} className="text-brand-500" fill="currentColor" />
                              ) : (
                                <span className="text-[11px] font-semibold text-gray-400">{si + 1}</span>
                              )}
                            </div>
                            <span className={`text-sm truncate flex-1 transition-colors leading-5 ${
                              isCurrent
                                ? 'font-semibold text-brand-600 dark:text-brand-400'
                                : isCompleted
                                  ? 'text-gray-500 dark:text-gray-500'
                                  : 'text-gray-600 dark:text-gray-400 group-hover/item:text-gray-900 dark:group-hover/item:text-gray-200'
                            }`}>
                              {section.title}
                            </span>
                            {section.duration && section.duration > 0 && (
                              <span className="text-[11px] text-gray-400 flex-shrink-0 tabular-nums">{formatDuration(section.duration)}</span>
                            )}
                          </button>
                        );
                      })}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </aside>

        {/* 移动端侧边栏遮罩 */}
        {sidebarOpen && (
          <div className="fixed inset-0 bg-black/20 z-[9] lg:hidden" onClick={() => setSidebarOpen(false)} />
        )}
      </div>
    </div>
  );
};

export default CourseLessonPage;
