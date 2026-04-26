import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Search, BookOpen, FileText, ChevronLeft, ChevronRight,
  BookMarked, Library, Plus, Trash2, Clock, X,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { BookDTO, UserShelfDTO } from '../api/generated/models';
import { toast } from '../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);
const PAGE_SIZE = 12;

const FILE_TYPE_COLORS: Record<string, string> = {
  PDF: 'bg-rose-100 text-rose-600 dark:bg-rose-900/30 dark:text-rose-400',
  EPUB: 'bg-violet-100 text-violet-600 dark:bg-violet-900/30 dark:text-violet-400',
  TXT: 'bg-sky-100 text-sky-600 dark:bg-sky-900/30 dark:text-sky-400',
  DOCX: 'bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400',
};

function getUserId(): string {
  try {
    const raw = localStorage.getItem('user_info');
    if (!raw) return '';
    return String(JSON.parse(raw)?.id ?? '');
  } catch {
    return '';
  }
}

const BookshelfPage: React.FC = () => {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState<'shelf' | 'library'>('shelf');

  // 用户书架
  const [shelfBooks, setShelfBooks] = useState<UserShelfDTO[]>([]);
  const [shelfLoading, setShelfLoading] = useState(true);

  // 书库浏览
  const [allBooks, setAllBooks] = useState<BookDTO[]>([]);
  const [allBooksLoading, setAllBooksLoading] = useState(true);
  const [allBooksPage, setAllBooksPage] = useState(1);
  const [allBooksHasMore, setAllBooksHasMore] = useState(false);

  // 搜索
  const [searchKeyword, setSearchKeyword] = useState('');
  const [activeKeyword, setActiveKeyword] = useState('');

  // 操作中
  const [addingBookIds, setAddingBookIds] = useState<Set<string>>(new Set());
  const [removingBookIds, setRemovingBookIds] = useState<Set<string>>(new Set());

  // ==================== 数据加载 ====================

  const loadShelf = useCallback(async () => {
    const uid = getUserId();
    if (!uid) {
      setShelfLoading(false);
      return;
    }
    setShelfLoading(true);
    try {
      const res = await api.getUserShelf({ userId: uid as unknown as number, page: 1, size: 100 });
      if (res.data?.code === 0 && res.data.data) {
        setShelfBooks(res.data.data as UserShelfDTO[]);
      }
    } catch {
      // silent
    } finally {
      setShelfLoading(false);
    }
  }, []);

  const loadAllBooks = useCallback(async () => {
    setAllBooksLoading(true);
    try {
      let response;
      if (activeKeyword.trim()) {
        response = await api.searchBooks1({ keyword: activeKeyword.trim(), page: allBooksPage, size: PAGE_SIZE });
      } else {
        response = await api.listBooks({ page: allBooksPage, size: PAGE_SIZE });
      }
      if (response.data?.code === 0) {
        const list = (response.data.data || []) as BookDTO[];
        setAllBooks(list.filter(b => b.status === 'READY'));
        setAllBooksHasMore(list.length >= PAGE_SIZE);
      }
    } catch {
      toast.error('加载书籍失败');
    } finally {
      setAllBooksLoading(false);
    }
  }, [activeKeyword, allBooksPage]);

  useEffect(() => { loadShelf(); }, [loadShelf]);
  useEffect(() => { loadAllBooks(); }, [loadAllBooks]);

  // ==================== 书架操作 ====================

  const addToShelf = async (book: BookDTO) => {
    const uid = getUserId();
    if (!uid || !book.id) return;
    const bookIdStr = String(book.id);
    setAddingBookIds(prev => new Set(prev).add(bookIdStr));
    try {
      await api.addToShelf({ userId: uid as unknown as number, bookId: book.id as unknown as number });
      toast.success(`《${book.title}》已加入书架`);
      loadShelf();
    } catch {
      toast.error('加入书架失败');
    } finally {
      setAddingBookIds(prev => {
        const next = new Set(prev);
        next.delete(bookIdStr);
        return next;
      });
    }
  };

  const removeFromShelf = async (item: UserShelfDTO) => {
    const uid = getUserId();
    if (!uid || !item.bookId) return;
    const bookIdStr = String(item.bookId);
    setRemovingBookIds(prev => new Set(prev).add(bookIdStr));
    try {
      await api.removeFromShelf({ userId: uid as unknown as number, bookId: item.bookId as unknown as number });
      toast.success(`已移出书架`);
      loadShelf();
    } catch {
      toast.error('移出书架失败');
    } finally {
      setRemovingBookIds(prev => {
        const next = new Set(prev);
        next.delete(bookIdStr);
        return next;
      });
    }
  };

  const isInShelf = (bookId: number | undefined) => {
    if (!bookId) return false;
    return shelfBooks.some(s => String(s.bookId) === String(bookId));
  };

  const handleSearch = () => {
    setActiveKeyword(searchKeyword);
    setAllBooksPage(1);
    if (searchKeyword.trim()) {
      setActiveTab('library');
    }
  };

  const clearSearch = () => {
    setSearchKeyword('');
    setActiveKeyword('');
    setAllBooksPage(1);
  };

  const openReader = (bookId: number | undefined) => {
    if (!bookId) return;
    navigate(`/book/${String(bookId)}/read`);
  };

  // ==================== 渲染 ====================

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* 页头 */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
        <div className="px-6 py-5">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 rounded-xl bg-brand-50 dark:bg-brand-900/20 flex items-center justify-center text-brand-600 dark:text-brand-400 border border-brand-100 dark:border-brand-800">
                <BookMarked size={24} />
              </div>
              <div>
                <h1 className="text-2xl font-bold text-gray-900 dark:text-white">我的书架</h1>
                <p className="text-gray-500 dark:text-gray-400 mt-1">
                  {shelfBooks.length > 0 ? `${shelfBooks.length} 本在架` : '管理你的电子书阅读'}
                </p>
              </div>
            </div>
          </div>

          {/* 搜索栏 */}
          <div className="mt-5 flex flex-col md:flex-row items-center gap-3">
            <div className="relative flex-1 w-full group">
              <Search size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" />
              <input
                type="text"
                value={searchKeyword}
                onChange={e => setSearchKeyword(e.target.value)}
                onKeyDown={e => { if (e.key === 'Enter') handleSearch(); }}
                placeholder="搜索书名、作者..."
                className="w-full pl-11 pr-10 py-2.5 rounded-xl border border-transparent bg-gray-50 dark:bg-gray-800/50 text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:border-brand-500/50 outline-none transition-all"
              />
              {searchKeyword && (
                <button onClick={clearSearch} className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300">
                  <X size={16} />
                </button>
              )}
            </div>
            <button
              onClick={handleSearch}
              className="w-full md:w-auto px-8 py-2.5 rounded-xl text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 transition-all active:scale-95 shadow-lg shadow-brand-600/20"
            >
              搜索
            </button>
          </div>

          {/* Tab 切换 */}
          <div className="mt-5 flex gap-1 p-1 bg-gray-50 dark:bg-gray-800/50 rounded-xl w-fit">
            <button
              onClick={() => setActiveTab('shelf')}
              className={`flex items-center gap-2 px-5 py-2 rounded-lg text-sm font-medium transition-all ${
                activeTab === 'shelf'
                  ? 'bg-white dark:bg-gray-700 text-brand-600 dark:text-brand-400 shadow-sm'
                  : 'text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300'
              }`}
            >
              <BookMarked size={16} />
              我的书架
              {shelfBooks.length > 0 && (
                <span className={`text-xs px-1.5 py-0.5 rounded-full ${
                  activeTab === 'shelf'
                    ? 'bg-brand-50 dark:bg-brand-900/30 text-brand-600 dark:text-brand-400'
                    : 'bg-gray-100 dark:bg-gray-700 text-gray-500 dark:text-gray-400'
                }`}>
                  {shelfBooks.length}
                </span>
              )}
            </button>
            <button
              onClick={() => setActiveTab('library')}
              className={`flex items-center gap-2 px-5 py-2 rounded-lg text-sm font-medium transition-all ${
                activeTab === 'library'
                  ? 'bg-white dark:bg-gray-700 text-brand-600 dark:text-brand-400 shadow-sm'
                  : 'text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300'
              }`}
            >
              <Library size={16} />
              书库浏览
            </button>
          </div>
        </div>
      </div>

      {/* 内容区 */}
      {activeTab === 'shelf' ? (
        <ShelfTab
          books={shelfBooks}
          loading={shelfLoading}
          removingIds={removingBookIds}
          onOpen={openReader}
          onRemove={removeFromShelf}
          onGoLibrary={() => setActiveTab('library')}
        />
      ) : (
        <LibraryTab
          books={allBooks}
          loading={allBooksLoading}
          currentPage={allBooksPage}
          hasMore={allBooksHasMore}
          addingIds={addingBookIds}
          isInShelf={isInShelf}
          onPageChange={setAllBooksPage}
          onOpen={openReader}
          onAdd={addToShelf}
        />
      )}
    </div>
  );
};

// ==================== 我的书架 Tab ====================

interface ShelfTabProps {
  books: UserShelfDTO[];
  loading: boolean;
  removingIds: Set<string>;
  onOpen: (bookId: number | undefined) => void;
  onRemove: (item: UserShelfDTO) => void;
  onGoLibrary: () => void;
}

const ShelfTab: React.FC<ShelfTabProps> = ({ books, loading, removingIds, onOpen, onRemove, onGoLibrary }) => {
  if (loading) {
    return (
      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 gap-5">
        {Array.from({ length: 6 }).map((_, i) => (
          <div key={i} className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 overflow-hidden animate-pulse">
            <div className="aspect-[3/4] bg-gray-100 dark:bg-gray-800" />
            <div className="p-3 space-y-2">
              <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-3/4" />
              <div className="h-2 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
            </div>
          </div>
        ))}
      </div>
    );
  }

  if (books.length === 0) {
    return (
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm py-20 text-center">
        <div className="w-20 h-20 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-5">
          <BookMarked size={36} className="text-gray-300 dark:text-gray-600" />
        </div>
        <p className="text-gray-900 dark:text-white font-semibold text-lg mb-2">书架空空如也</p>
        <p className="text-gray-500 dark:text-gray-400 text-sm mb-6">去书库浏览添加感兴趣的书籍吧</p>
        <button
          onClick={onGoLibrary}
          className="inline-flex items-center gap-2 px-6 py-2.5 rounded-xl text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 transition-all active:scale-95 shadow-lg shadow-brand-600/20"
        >
          <Library size={16} />
          浏览书库
        </button>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 gap-5">
      {books.map(item => {
        const progress = item.readingProgress != null && item.readingProgress > 0
          ? Math.min(item.readingProgress, 100)
          : 0;
        const bookIdStr = String(item.bookId);
        const isRemoving = removingIds.has(bookIdStr);

        return (
          <div
            key={bookIdStr}
            className="group bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden cursor-pointer hover:shadow-sm hover:border-brand-200 dark:hover:border-brand-500/30 transition-all duration-300"
          >
            {/* 封面 */}
            <div
              className="relative aspect-[3/4] bg-gray-50 dark:bg-gray-800/50 overflow-hidden"
              onClick={() => onOpen(item.bookId)}
            >
              {item.bookCoverUrl ? (
                <img
                  src={item.bookCoverUrl}
                  alt={item.bookTitle}
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                />
              ) : (
                <div className="w-full h-full flex flex-col items-center justify-center gap-2 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700">
                  <BookOpen size={32} className="text-brand-300 dark:text-brand-600" />
                  <span className="text-[10px] text-brand-400 dark:text-brand-500 font-medium">暂无封面</span>
                </div>
              )}

              {/* 阅读进度条 */}
              {progress > 0 && (
                <div className="absolute bottom-0 left-0 right-0 h-1 bg-black/20">
                  <div
                    className="h-full bg-brand-500 transition-all"
                    style={{ width: `${progress}%` }}
                  />
                </div>
              )}

              {/* 移出书架按钮 */}
              <button
                onClick={e => { e.stopPropagation(); onRemove(item); }}
                disabled={isRemoving}
                className="absolute top-2 right-2 w-7 h-7 rounded-lg bg-black/40 hover:bg-red-500 text-white flex items-center justify-center transition-all backdrop-blur-sm disabled:opacity-50"
                title="移出书架"
              >
                <Trash2 size={13} />
              </button>
            </div>

            {/* 信息 */}
            <div className="p-3" onClick={() => onOpen(item.bookId)}>
              <h3 className="font-semibold text-xs text-gray-900 dark:text-white line-clamp-2 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors leading-tight">
                {item.bookTitle || '未知书名'}
              </h3>
              <div className="flex items-center justify-between mt-1.5">
                <p className="text-[10px] text-gray-500 dark:text-gray-400 line-clamp-1 flex-1">
                  {item.bookAuthor || ''}
                </p>
                {progress > 0 && (
                  <span className="text-[10px] font-semibold text-brand-600 dark:text-brand-400 ml-1 flex-shrink-0">
                    {progress}%
                  </span>
                )}
              </div>
              {item.lastReadTime && (
                <div className="flex items-center gap-1 mt-1.5 text-[10px] text-gray-400 dark:text-gray-500">
                  <Clock size={10} />
                  <span>{formatRelativeTime(item.lastReadTime)}</span>
                </div>
              )}
            </div>
          </div>
        );
      })}
    </div>
  );
};

// ==================== 书库浏览 Tab ====================

interface LibraryTabProps {
  books: BookDTO[];
  loading: boolean;
  currentPage: number;
  hasMore: boolean;
  addingIds: Set<string>;
  isInShelf: (bookId: number | undefined) => boolean;
  onPageChange: (page: number) => void;
  onOpen: (bookId: number | undefined) => void;
  onAdd: (book: BookDTO) => void;
}

const LibraryTab: React.FC<LibraryTabProps> = ({
  books, loading, currentPage, hasMore, addingIds,
  isInShelf, onPageChange, onOpen, onAdd,
}) => {
  if (loading) {
    return (
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
        {Array.from({ length: 8 }).map((_, i) => (
          <div key={i} className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 overflow-hidden animate-pulse">
            <div className="h-40 bg-gray-100 dark:bg-gray-800" />
            <div className="p-4 space-y-2">
              <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-3/4" />
              <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/2" />
            </div>
          </div>
        ))}
      </div>
    );
  }

  if (books.length === 0) {
    return (
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm py-16 text-center">
        <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
          <BookOpen size={32} className="text-gray-300 dark:text-gray-600" />
        </div>
        <p className="text-gray-500 dark:text-gray-400 font-medium">暂无电子书</p>
      </div>
    );
  }

  return (
    <>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
        {books.map(book => {
          const fileType = book.fileType?.toUpperCase() || 'TXT';
          const colorClass = FILE_TYPE_COLORS[fileType] || FILE_TYPE_COLORS.TXT;
          const bookIdStr = String(book.id);
          const inShelf = isInShelf(book.id);
          const isAdding = addingIds.has(bookIdStr);

          return (
            <div
              key={bookIdStr}
              className="group bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden cursor-pointer hover:shadow-sm hover:border-brand-200 dark:hover:border-brand-500/30 transition-all duration-300"
            >
              {/* 封面 */}
              <div
                className="relative h-48 bg-gray-50 dark:bg-gray-800/50 flex items-center justify-center overflow-hidden border-b border-gray-50 dark:border-gray-800"
                onClick={() => onOpen(book.id)}
              >
                {book.coverUrl ? (
                  <img src={book.coverUrl} alt={book.title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" />
                ) : (
                  <div className="flex flex-col items-center gap-2">
                    <FileText size={36} className="text-gray-300 dark:text-gray-600 group-hover:text-brand-400 transition-colors" />
                  </div>
                )}
                <span className={`absolute top-3 right-3 px-2 py-0.5 rounded-md text-[10px] font-bold border ${colorClass} border-current/10 backdrop-blur-sm`}>
                  {fileType}
                </span>

                {/* 在架标记 */}
                {inShelf && (
                  <div className="absolute top-3 left-3 w-6 h-6 rounded-lg bg-brand-500 text-white flex items-center justify-center shadow-md">
                    <BookMarked size={12} />
                  </div>
                )}
              </div>

              {/* 信息 */}
              <div className="p-4">
                <div onClick={() => onOpen(book.id)}>
                  <h3 className="font-bold text-sm text-gray-900 dark:text-white line-clamp-1 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors">
                    {book.title}
                  </h3>
                  <p className="text-xs text-gray-500 dark:text-gray-400 mt-1 line-clamp-1">
                    {book.author || '未知作者'}
                  </p>
                </div>
                <div className="flex items-center justify-between mt-3">
                  <div className="flex items-center gap-3 text-[10px] text-gray-400 dark:text-gray-500">
                    {book.totalChapters != null && book.totalChapters > 0 && (
                      <span>{book.totalChapters} 章</span>
                    )}
                    {book.wordCount != null && book.wordCount > 0 && (
                      <span>{(book.wordCount / 10000).toFixed(1)} 万字</span>
                    )}
                  </div>
                  {!inShelf ? (
                    <button
                      onClick={e => { e.stopPropagation(); onAdd(book); }}
                      disabled={isAdding}
                      className="flex items-center gap-1 px-2.5 py-1 rounded-lg text-[11px] font-semibold text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/40 transition-all active:scale-95 disabled:opacity-50"
                    >
                      <Plus size={12} />
                      {isAdding ? '添加中...' : '加入书架'}
                    </button>
                  ) : (
                    <span className="flex items-center gap-1 px-2.5 py-1 rounded-lg text-[11px] font-semibold text-emerald-600 dark:text-emerald-400 bg-emerald-50 dark:bg-emerald-900/20">
                      <BookMarked size={12} />
                      已在架
                    </span>
                  )}
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* 分页 */}
      <div className="flex items-center justify-center gap-3">
        <button
          onClick={() => onPageChange(Math.max(1, currentPage - 1))}
          disabled={currentPage === 1}
          className="p-2.5 rounded-xl border border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-30 transition-all hover:border-brand-200 dark:hover:border-brand-800"
        >
          <ChevronLeft size={18} />
        </button>
        <div className="px-4 py-2 rounded-xl bg-gray-50 dark:bg-gray-800 border border-gray-100 dark:border-gray-700">
          <span className="text-sm font-bold text-gray-700 dark:text-gray-300">第 {currentPage} 页</span>
        </div>
        <button
          onClick={() => onPageChange(currentPage + 1)}
          disabled={!hasMore}
          className="p-2.5 rounded-xl border border-gray-200 dark:border-gray-700 text-gray-500 dark:text-gray-400 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-30 transition-all hover:border-brand-200 dark:hover:border-brand-800"
        >
          <ChevronRight size={18} />
        </button>
      </div>
    </>
  );
};

// ==================== 工具函数 ====================

function formatRelativeTime(dateStr: string): string {
  try {
    const date = new Date(dateStr);
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffMin = Math.floor(diffMs / 60000);
    if (diffMin < 1) return '刚刚';
    if (diffMin < 60) return `${diffMin} 分钟前`;
    const diffHour = Math.floor(diffMin / 60);
    if (diffHour < 24) return `${diffHour} 小时前`;
    const diffDay = Math.floor(diffHour / 24);
    if (diffDay < 30) return `${diffDay} 天前`;
    const diffMonth = Math.floor(diffDay / 30);
    if (diffMonth < 12) return `${diffMonth} 个月前`;
    return `${Math.floor(diffMonth / 12)} 年前`;
  } catch {
    return '';
  }
}

export default BookshelfPage;
