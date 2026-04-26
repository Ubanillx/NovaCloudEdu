import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import {
  Search, BookOpen, FileText, MessageSquare, BookMarked,
  ChevronLeft, ChevronRight, Sparkles, TrendingUp,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { SearchResultDTO, PageResult, SearchSuggestionDTO } from '../api/generated/models';
import { toast } from '../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);
const PAGE_SIZE = 20;

// 推荐热搜词
const HOT_KEYWORDS = ['斗破苍穹', '更改', '编程入门', '数学', '英语', '科学实验'];

// 搜索类型 Tab
const SEARCH_TABS = [
  { key: 'all', label: '全部', icon: Sparkles },
  { key: 'book', label: '书籍', icon: BookOpen },
  { key: 'chapter', label: '章节', icon: BookMarked },
  { key: 'post', label: '帖子', icon: MessageSquare },
] as const;

type SearchType = (typeof SEARCH_TABS)[number]['key'];

// ─── 高亮文本渲染 ────────────────────────────────────────────────────────────

const HighlightText: React.FC<{ html: string }> = ({ html }) => (
  <span
    dangerouslySetInnerHTML={{ __html: html }}
    className="[&_em]:text-brand-600 [&_em]:dark:text-brand-400 [&_em]:font-semibold [&_em]:not-italic"
  />
);

const getHighlight = (item: SearchResultDTO, field: string): string | null => {
  const highlights = item.highlights;
  if (!highlights || !highlights[field] || highlights[field].length === 0) return null;
  return highlights[field][0];
};

// ─── 书籍结果卡片 ─────────────────────────────────────────────────────────────

const FILE_TYPE_COLORS: Record<string, string> = {
  PDF: 'bg-rose-100 text-rose-600 dark:bg-rose-900/30 dark:text-rose-400',
  EPUB: 'bg-violet-100 text-violet-600 dark:bg-violet-900/30 dark:text-violet-400',
  TXT: 'bg-sky-100 text-sky-600 dark:bg-sky-900/30 dark:text-sky-400',
  DOCX: 'bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400',
};

const BookResultCard: React.FC<{ item: SearchResultDTO; onClick: () => void }> = ({ item, onClick }) => {
  const fileType = item.fileType?.toUpperCase() || 'TXT';
  const colorClass = FILE_TYPE_COLORS[fileType] || FILE_TYPE_COLORS.TXT;
  const titleHtml = getHighlight(item, 'title') || item.title || '未知书名';
  const authorHtml = getHighlight(item, 'author') || item.author || '未知作者';

  return (
    <div
      onClick={onClick}
      className="group flex gap-4 p-4 bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm cursor-pointer hover:shadow-sm hover:border-brand-200 dark:hover:border-brand-500/30 transition-all duration-300"
    >
      {/* 封面 */}
      <div className="flex-shrink-0 w-20 h-28 rounded-xl bg-gray-50 dark:bg-gray-800/50 border border-gray-100 dark:border-gray-700 overflow-hidden flex items-center justify-center">
        {item.coverUrl ? (
          <img src={item.coverUrl} alt={item.title || ''} className="w-full h-full object-cover" />
        ) : (
          <FileText size={28} className="text-gray-300 dark:text-gray-600" />
        )}
      </div>
      {/* 信息 */}
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2 mb-1">
          <span className={`px-1.5 py-0.5 rounded text-[10px] font-bold ${colorClass}`}>{fileType}</span>
          <span className="px-1.5 py-0.5 rounded text-[10px] font-medium bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400">书籍</span>
        </div>
        <h3 className="font-bold text-base text-gray-900 dark:text-white line-clamp-1 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors">
          <HighlightText html={titleHtml} />
        </h3>
        <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
          <HighlightText html={authorHtml} />
        </p>
        {item.totalChapters != null && item.totalChapters > 0 && (
          <p className="text-xs text-gray-400 dark:text-gray-500 mt-2">{item.totalChapters} 章</p>
        )}
      </div>
    </div>
  );
};

// ─── 章节结果卡片 ─────────────────────────────────────────────────────────────

const ChapterResultCard: React.FC<{ item: SearchResultDTO; onClick: () => void }> = ({ item, onClick }) => {
  const titleHtml = getHighlight(item, 'title') || item.title || '未知章节';
  const contentHtml = getHighlight(item, 'content') || item.content || '';

  return (
    <div
      onClick={onClick}
      className="group p-4 bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm cursor-pointer hover:shadow-sm hover:border-brand-200 dark:hover:border-brand-500/30 transition-all duration-300"
    >
      <div className="flex items-center gap-2 mb-2">
        <span className="px-1.5 py-0.5 rounded text-[10px] font-medium bg-amber-50 text-amber-600 dark:bg-amber-900/20 dark:text-amber-400">章节</span>
        {item.bookTitle && (
          <span className="text-xs text-gray-400 dark:text-gray-500 truncate">
            来自《{item.bookTitle}》
            {item.chapterIndex != null && ` · 第${item.chapterIndex}章`}
          </span>
        )}
      </div>
      <h3 className="font-bold text-base text-gray-900 dark:text-white line-clamp-1 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors">
        <HighlightText html={titleHtml} />
      </h3>
      {contentHtml && (
        <p className="text-sm text-gray-500 dark:text-gray-400 mt-2 line-clamp-2">
          <HighlightText html={contentHtml} />
        </p>
      )}
    </div>
  );
};

// ─── 帖子结果卡片 ─────────────────────────────────────────────────────────────

const PostResultCard: React.FC<{ item: SearchResultDTO; onClick: () => void }> = ({ item, onClick }) => {
  const titleHtml = getHighlight(item, 'title') || item.title || '未知帖子';
  const contentHtml = getHighlight(item, 'content') || item.content || '';

  return (
    <div
      onClick={onClick}
      className="group p-4 bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm cursor-pointer hover:shadow-sm hover:border-brand-200 dark:hover:border-brand-500/30 transition-all duration-300"
    >
      <div className="flex items-center gap-2 mb-2">
        <span className="px-1.5 py-0.5 rounded text-[10px] font-medium bg-green-50 text-green-600 dark:bg-green-900/20 dark:text-green-400">帖子</span>
        {item.postType && (
          <span className="text-xs text-gray-400 dark:text-gray-500">{item.postType}</span>
        )}
      </div>
      <h3 className="font-bold text-base text-gray-900 dark:text-white line-clamp-1 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors">
        <HighlightText html={titleHtml} />
      </h3>
      {contentHtml && (
        <p className="text-sm text-gray-500 dark:text-gray-400 mt-2 line-clamp-2">
          <HighlightText html={contentHtml} />
        </p>
      )}
      <div className="flex items-center gap-4 mt-3 text-xs text-gray-400 dark:text-gray-500">
        {item.tags && item.tags.length > 0 && (
          <div className="flex items-center gap-1 flex-wrap">
            {item.tags.slice(0, 3).map(tag => (
              <span key={tag} className="px-1.5 py-0.5 bg-gray-50 dark:bg-gray-800 rounded text-[10px]">{tag}</span>
            ))}
          </div>
        )}
        <div className="flex items-center gap-3 ml-auto">
          {item.thumbNum != null && <span>{item.thumbNum} 赞</span>}
          {item.commentNum != null && <span>{item.commentNum} 评</span>}
          {item.favourNum != null && <span>{item.favourNum} 收藏</span>}
        </div>
      </div>
    </div>
  );
};

// ─── 主页面 ──────────────────────────────────────────────────────────────────

const SearchResultsPage: React.FC = () => {
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();
  const queryFromUrl = searchParams.get('q') || '';
  const typeFromUrl = (searchParams.get('type') || 'all') as SearchType;

  const [keyword, setKeyword] = useState(queryFromUrl);
  const [activeType, setActiveType] = useState<SearchType>(typeFromUrl);
  const [results, setResults] = useState<SearchResultDTO[]>([]);
  const [total, setTotal] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(false);

  // 预测词相关
  const [suggestions, setSuggestions] = useState<SearchSuggestionDTO[]>([]);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [selectedSuggestIndex, setSelectedSuggestIndex] = useState(-1);
  const suggestTimer = useRef<ReturnType<typeof setTimeout>>(undefined);
  const suggestBoxRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLInputElement>(null);

  // URL 参数变化时同步
  useEffect(() => {
    const q = searchParams.get('q') || '';
    const t = (searchParams.get('type') || 'all') as SearchType;
    setKeyword(q);
    setActiveType(t);
    setCurrentPage(1);
  }, [searchParams]);

  // 预测词请求（防抖 300ms）
  const fetchSuggestions = useCallback((q: string) => {
    if (suggestTimer.current) clearTimeout(suggestTimer.current);
    if (!q.trim()) {
      setSuggestions([]);
      setShowSuggestions(false);
      return;
    }
    suggestTimer.current = setTimeout(async () => {
      try {
        const res = await api.suggest({ q: q.trim() });
        if (res.data?.code === 0 && res.data.data) {
          setSuggestions(res.data.data);
          setShowSuggestions(res.data.data.length > 0);
        }
      } catch {
        // 静默失败
      }
    }, 300);
  }, []);

  // 点击外部关闭下拉
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (suggestBoxRef.current && !suggestBoxRef.current.contains(e.target as Node) &&
          inputRef.current && !inputRef.current.contains(e.target as Node)) {
        setShowSuggestions(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  // 执行搜索
  const doSearch = useCallback(async () => {
    if (!queryFromUrl.trim()) {
      setResults([]);
      setTotal(0);
      setTotalPages(0);
      return;
    }
    setLoading(true);
    try {
      const response = await api.searchAll({
        q: queryFromUrl.trim(),
        type: activeType === 'all' ? undefined : activeType,
        page: currentPage,
        size: PAGE_SIZE,
      });
      if (response.data?.code === 0 && response.data.data) {
        const pageResult = response.data.data as PageResult;
        setResults(pageResult.items || []);
        setTotal(pageResult.total || 0);
        setTotalPages(pageResult.totalPages || 0);
      } else {
        setResults([]);
        setTotal(0);
        setTotalPages(0);
      }
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '搜索失败');
      setResults([]);
    } finally {
      setLoading(false);
    }
  }, [queryFromUrl, activeType, currentPage]);

  useEffect(() => {
    doSearch();
  }, [doSearch]);

  // 提交搜索
  const handleSearch = (q?: string) => {
    const searchWord = (q ?? keyword).trim();
    if (!searchWord) return;
    setShowSuggestions(false);
    setSuggestions([]);
    setSelectedSuggestIndex(-1);
    setKeyword(searchWord);
    setSearchParams({ q: searchWord, type: activeType });
  };

  // 输入变化
  const handleInputChange = (value: string) => {
    setKeyword(value);
    setSelectedSuggestIndex(-1);
    fetchSuggestions(value);
  };

  // 键盘导航
  const handleInputKeyDown = (e: React.KeyboardEvent) => {
    if (!showSuggestions || suggestions.length === 0) {
      if (e.key === 'Enter') handleSearch();
      return;
    }
    if (e.key === 'ArrowDown') {
      e.preventDefault();
      setSelectedSuggestIndex(prev => Math.min(prev + 1, suggestions.length - 1));
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      setSelectedSuggestIndex(prev => Math.max(prev - 1, -1));
    } else if (e.key === 'Enter') {
      e.preventDefault();
      if (selectedSuggestIndex >= 0 && selectedSuggestIndex < suggestions.length) {
        handleSearch(suggestions[selectedSuggestIndex].text || '');
      } else {
        handleSearch();
      }
    } else if (e.key === 'Escape') {
      setShowSuggestions(false);
    }
  };

  // 类型标签颜色
  const suggestTypeColor = (type?: string) => {
    switch (type) {
      case 'book': return 'bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400';
      case 'chapter': return 'bg-amber-50 text-amber-600 dark:bg-amber-900/20 dark:text-amber-400';
      case 'post': return 'bg-green-50 text-green-600 dark:bg-green-900/20 dark:text-green-400';
      default: return 'bg-gray-50 text-gray-500 dark:bg-gray-800 dark:text-gray-400';
    }
  };
  const suggestTypeLabel = (type?: string) => {
    switch (type) {
      case 'book': return '书籍';
      case 'chapter': return '章节';
      case 'post': return '帖子';
      default: return '';
    }
  };

  // 切换 Tab
  const handleTabChange = (type: SearchType) => {
    setActiveType(type);
    setCurrentPage(1);
    setSearchParams({ q: queryFromUrl, type });
  };

  // 翻页
  const handlePageChange = (page: number) => {
    setCurrentPage(page);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  // 点击结果跳转
  const handleResultClick = (item: SearchResultDTO) => {
    switch (item.type) {
      case 'book':
        navigate(`/book/${String(item.id)}/read`);
        break;
      case 'chapter':
        navigate(`/book/${String(item.bookId)}/read`);
        break;
      case 'post':
        navigate(`/circle/post/${String(item.id)}`);
        break;
      default:
        break;
    }
  };

  // 渲染结果卡片
  const renderResultCard = (item: SearchResultDTO, index: number) => {
    const key = `${item.type}-${String(item.id)}-${index}`;
    switch (item.type) {
      case 'book':
        return <BookResultCard key={key} item={item} onClick={() => handleResultClick(item)} />;
      case 'chapter':
        return <ChapterResultCard key={key} item={item} onClick={() => handleResultClick(item)} />;
      case 'post':
        return <PostResultCard key={key} item={item} onClick={() => handleResultClick(item)} />;
      default:
        return null;
    }
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* 搜索头部 */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
        <div className="px-6 py-5">
          <div className="flex items-center gap-3 mb-5">
            <div className="w-12 h-12 rounded-xl bg-brand-50 dark:bg-brand-900/20 flex items-center justify-center text-brand-600 dark:text-brand-400 border border-brand-100 dark:border-brand-800">
              <Search size={24} />
            </div>
            <div>
              <h1 className="text-2xl font-bold text-gray-900 dark:text-white">搜索</h1>
              {queryFromUrl && !loading && (
                <p className="text-gray-500 dark:text-gray-400 mt-0.5 text-sm">
                  共找到 <span className="font-semibold text-brand-600 dark:text-brand-400">{total}</span> 条结果
                </p>
              )}
            </div>
          </div>

          {/* 搜索输入框 */}
          <div className="flex flex-col md:flex-row items-center gap-4">
            <div className="relative flex-1 w-full group">
              <Search size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors z-10" />
              <input
                ref={inputRef}
                type="text"
                value={keyword}
                onChange={e => handleInputChange(e.target.value)}
                onKeyDown={handleInputKeyDown}
                onFocus={() => { if (suggestions.length > 0) setShowSuggestions(true); }}
                placeholder="搜索书籍、章节、帖子..."
                autoComplete="off"
                className="w-full pl-11 pr-4 py-2.5 rounded-xl border border-transparent bg-gray-50 dark:bg-gray-800/50 text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:border-brand-500/50 outline-none transition-all"
              />
              {/* 预测词下拉 */}
              {showSuggestions && suggestions.length > 0 && (
                <div
                  ref={suggestBoxRef}
                  className="absolute top-full left-0 right-0 mt-1 bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-700 shadow-xl z-50 overflow-hidden animate-in fade-in slide-in-from-top-2 duration-200"
                >
                  {suggestions.map((s, i) => (
                    <button
                      key={`${s.text}-${i}`}
                      onMouseDown={(e) => { e.preventDefault(); handleSearch(s.text || ''); }}
                      onMouseEnter={() => setSelectedSuggestIndex(i)}
                      className={`w-full flex items-center gap-3 px-4 py-2.5 text-left text-sm transition-colors ${
                        i === selectedSuggestIndex
                          ? 'bg-brand-50 dark:bg-brand-900/20'
                          : 'hover:bg-gray-50 dark:hover:bg-gray-800/50'
                      }`}
                    >
                      <Search size={14} className="text-gray-400 flex-shrink-0" />
                      <span className="flex-1 text-gray-700 dark:text-gray-200 truncate">{s.text}</span>
                      {s.type && (
                        <span className={`px-1.5 py-0.5 rounded text-[10px] font-medium flex-shrink-0 ${suggestTypeColor(s.type)}`}>
                          {suggestTypeLabel(s.type)}
                        </span>
                      )}
                    </button>
                  ))}
                </div>
              )}
            </div>
            <button
              onClick={() => handleSearch()}
              className="w-full md:w-auto px-8 py-2.5 rounded-xl text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 transition-all active:scale-95 shadow-lg shadow-brand-600/20"
            >
              搜索
            </button>
          </div>

          {/* 推荐热搜词 */}
          {!queryFromUrl.trim() && (
            <div className="flex items-center gap-2 mt-4 flex-wrap">
              <TrendingUp size={14} className="text-gray-400" />
              <span className="text-xs text-gray-400 dark:text-gray-500">热搜:</span>
              {HOT_KEYWORDS.map(tag => (
                <button
                  key={tag}
                  onClick={() => handleSearch(tag)}
                  className="px-2.5 py-1 rounded-lg text-xs font-medium bg-gray-50 dark:bg-gray-800/50 text-gray-600 dark:text-gray-400 hover:bg-brand-50 hover:text-brand-600 dark:hover:bg-brand-900/20 dark:hover:text-brand-400 transition-colors"
                >
                  {tag}
                </button>
              ))}
            </div>
          )}

          {/* Tab 切换 */}
          <div className="flex items-center gap-2 mt-5 overflow-x-auto">
            {SEARCH_TABS.map(tab => {
              const Icon = tab.icon;
              const isActive = activeType === tab.key;
              return (
                <button
                  key={tab.key}
                  onClick={() => handleTabChange(tab.key)}
                  className={`flex items-center gap-1.5 px-4 py-2 rounded-xl text-sm font-medium transition-all whitespace-nowrap ${
                    isActive
                      ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20'
                      : 'bg-gray-50 dark:bg-gray-800/50 text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700'
                  }`}
                >
                  <Icon size={16} />
                  {tab.label}
                </button>
              );
            })}
          </div>
        </div>
      </div>

      {/* 搜索结果 */}
      {loading ? (
        <div className="space-y-4">
          {Array.from({ length: 5 }).map((_, i) => (
            <div key={i} className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 p-4 animate-pulse">
              <div className="flex gap-4">
                <div className="w-20 h-28 rounded-xl bg-gray-100 dark:bg-gray-800 flex-shrink-0" />
                <div className="flex-1 space-y-3">
                  <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                  <div className="h-5 bg-gray-100 dark:bg-gray-800 rounded w-3/4" />
                  <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
                </div>
              </div>
            </div>
          ))}
        </div>
      ) : !queryFromUrl.trim() ? (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm py-20 text-center">
          <div className="w-20 h-20 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
            <Search size={36} className="text-gray-300 dark:text-gray-600" />
          </div>
          <p className="text-gray-500 dark:text-gray-400 font-medium text-lg">输入关键词开始搜索</p>
          <p className="text-gray-400 dark:text-gray-500 text-sm mt-1">支持搜索书籍、章节内容、圈子帖子</p>
        </div>
      ) : results.length === 0 ? (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm py-20 text-center">
          <div className="w-20 h-20 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
            <Search size={36} className="text-gray-300 dark:text-gray-600" />
          </div>
          <p className="text-gray-500 dark:text-gray-400 font-medium text-lg">未找到相关结果</p>
          <p className="text-gray-400 dark:text-gray-500 text-sm mt-1">换个关键词试试吧</p>
        </div>
      ) : (
        <div className="space-y-4">
          {results.map((item, index) => renderResultCard(item, index))}
        </div>
      )}

      {/* 分页 */}
      {!loading && results.length > 0 && totalPages > 1 && (
        <div className="flex items-center justify-center gap-3">
          <button
            onClick={() => handlePageChange(Math.max(1, currentPage - 1))}
            disabled={currentPage === 1}
            className="p-2.5 rounded-xl border border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-30 transition-all hover:border-brand-200 dark:hover:border-brand-800"
          >
            <ChevronLeft size={18} />
          </button>
          <div className="px-4 py-2 rounded-xl bg-gray-50 dark:bg-gray-800 border border-gray-100 dark:border-gray-700">
            <span className="text-sm font-bold text-gray-700 dark:text-gray-300">
              第 {currentPage} / {totalPages} 页
            </span>
          </div>
          <button
            onClick={() => handlePageChange(Math.min(totalPages, currentPage + 1))}
            disabled={currentPage >= totalPages}
            className="p-2.5 rounded-xl border border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-30 transition-all hover:border-brand-200 dark:hover:border-brand-800"
          >
            <ChevronRight size={18} />
          </button>
        </div>
      )}
    </div>
  );
};

export default SearchResultsPage;
