import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Search, BookOpen, FileText, ChevronLeft, ChevronRight,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { BookDTO } from '../api/generated/models';
import { toast } from '../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);
const PAGE_SIZE = 12;

const FILE_TYPE_ICONS: Record<string, string> = {
  PDF: 'bg-rose-100 text-rose-600 dark:bg-rose-900/30 dark:text-rose-400',
  EPUB: 'bg-violet-100 text-violet-600 dark:bg-violet-900/30 dark:text-violet-400',
  TXT: 'bg-sky-100 text-sky-600 dark:bg-sky-900/30 dark:text-sky-400',
  DOCX: 'bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400',
};

const EbookListPage: React.FC = () => {
  const navigate = useNavigate();
  const [books, setBooks] = useState<BookDTO[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [activeKeyword, setActiveKeyword] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [hasMore, setHasMore] = useState(false);

  const fetchBooks = useCallback(async () => {
    setLoading(true);
    try {
      let response;
      if (activeKeyword.trim()) {
        response = await api.searchBooks1({
          keyword: activeKeyword.trim(),
          page: currentPage,
          size: PAGE_SIZE,
        });
      } else {
        response = await api.listBooks({
          page: currentPage,
          size: PAGE_SIZE,
        });
      }
      if (response.data?.code === 0) {
        const list: BookDTO[] = (response.data.data || []) as BookDTO[];
        setBooks(list.filter((b) => b.status === 'READY'));
        setHasMore(list.length >= PAGE_SIZE);
      }
    } catch (e: any) {
      toast.error(e?.response?.data?.message || '加载书籍失败');
    } finally {
      setLoading(false);
    }
  }, [activeKeyword, currentPage]);

  useEffect(() => { fetchBooks(); }, [fetchBooks]);

  const handleSearch = () => {
    setActiveKeyword(searchKeyword);
    setCurrentPage(1);
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* 页头 */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
        <div className="px-6 py-5">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 rounded-xl bg-brand-50 dark:bg-brand-900/20 flex items-center justify-center text-brand-600 dark:text-brand-400 border border-brand-100 dark:border-brand-800">
                <BookOpen size={24} />
              </div>
              <div>
                <h1 className="text-2xl font-bold text-gray-900 dark:text-white">电子书</h1>
                <p className="text-gray-500 dark:text-gray-400 mt-1">探索丰富的电子书资源，开启阅读之旅</p>
              </div>
            </div>
          </div>

          <div className="mt-6 flex flex-col md:flex-row items-center gap-4">
            <div className="relative flex-1 w-full group">
              <Search size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" />
              <input
                type="text"
                value={searchKeyword}
                onChange={e => setSearchKeyword(e.target.value)}
                onKeyDown={e => { if (e.key === 'Enter') handleSearch(); }}
                placeholder="搜索书名、作者、关键词..."
                className="w-full pl-11 pr-4 py-2.5 rounded-xl border border-transparent bg-gray-50 dark:bg-gray-800/50 text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:border-brand-500/50 outline-none transition-all"
              />
            </div>
            <button
              onClick={handleSearch}
              className="w-full md:w-auto px-8 py-2.5 rounded-xl text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 transition-all active:scale-95 shadow-lg shadow-brand-600/20"
            >
              搜索
            </button>
          </div>
        </div>
      </div>

      {/* 书籍列表 */}
      {loading ? (
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
      ) : books.length === 0 ? (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm py-16 text-center">
          <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
            <BookOpen size={32} className="text-gray-300 dark:text-gray-600" />
          </div>
          <p className="text-gray-500 dark:text-gray-400 font-medium">暂无电子书</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
          {books.map(book => {
            const fileType = book.fileType?.toUpperCase() || 'TXT';
            const colorClass = FILE_TYPE_ICONS[fileType] || FILE_TYPE_ICONS.TXT;
            return (
              <div
                key={String(book.id)}
                onClick={() => navigate(`/book/${String(book.id)}/read`)}
                className="group bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden cursor-pointer hover:shadow-lg hover:border-brand-200 dark:hover:border-brand-500/30 transition-all duration-300"
              >
                {/* 封面区域 */}
                <div className="relative h-48 bg-gray-50 dark:bg-gray-800/50 flex items-center justify-center overflow-hidden border-b border-gray-50 dark:border-gray-800">
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
                </div>

                {/* 信息区域 */}
                <div className="p-4">
                  <h3 className="font-bold text-sm text-gray-900 dark:text-white line-clamp-1 group-hover:text-brand-600 dark:group-hover:text-brand-400 transition-colors">
                    {book.title}
                  </h3>
                  <p className="text-xs text-gray-500 dark:text-gray-400 mt-1 line-clamp-1">
                    {book.author || '未知作者'}
                  </p>
                  <div className="flex items-center gap-3 mt-3 text-[10px] text-gray-400 dark:text-gray-500">
                    {book.totalChapters != null && book.totalChapters > 0 && (
                      <span>{book.totalChapters} 章</span>
                    )}
                    {book.wordCount != null && book.wordCount > 0 && (
                      <span>{(book.wordCount / 10000).toFixed(1)} 万字</span>
                    )}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* 分页 */}
      {!loading && books.length > 0 && (
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

export default EbookListPage;
