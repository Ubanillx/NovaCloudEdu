import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  Search,
  Upload,
  Trash2,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  Eye,
  BookOpen,
  FileText,
  Loader2,
  Pencil,
  Lock,
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { BookDTO, ChapterDTO, ChapterContentDTO } from '../../api/generated/models';
import { toast, TruncateWithTooltip, ImageUploadArea } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// ─── 上传弹窗 ───────────────────────────────────────────────────────────────────

interface UploadBookModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

const UploadBookModal: React.FC<UploadBookModalProps> = ({ isOpen, onClose, onSuccess }) => {
  const [loading, setLoading] = useState(false);
  const [title, setTitle] = useState('');
  const [author, setAuthor] = useState('');
  const [file, setFile] = useState<File | null>(null);
  const [cover, setCover] = useState<File | null>(null);
  const [coverPreview, setCoverPreview] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (isOpen) {
      setTitle('');
      setAuthor('');
      setFile(null);
      setCover(null);
      setCoverPreview(null);
      if (fileInputRef.current) fileInputRef.current.value = '';
    }
  }, [isOpen]);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const selected = e.target.files?.[0] ?? null;
    if (selected) {
      setFile(selected);
      // 自动填充书名（去掉扩展名）
      if (!title.trim()) {
        const nameWithoutExt = selected.name.replace(/\.[^/.]+$/, '');
        setTitle(nameWithoutExt);
      }
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!file) {
      toast.warning('请选择文件');
      return;
    }
    if (!title.trim()) {
      toast.warning('请输入书名');
      return;
    }

    const userInfoStr = localStorage.getItem('user_info');
    const userInfo = userInfoStr ? JSON.parse(userInfoStr) : null;
    const adminId = String(userInfo?.id ?? '');
    if (!adminId) {
      toast.error('无法获取管理员ID');
      return;
    }

    setLoading(true);
    try {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('title', title.trim());
      if (author.trim()) formData.append('author', author.trim());
      if (cover) formData.append('cover', cover);
      formData.append('adminId', adminId);

      const response = await apiClient.post('/api/books/upload', formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
      });

      if (response.data?.code === 0) {
        toast.success('书籍上传成功，正在后台解析...');
        onSuccess();
        onClose();
      } else {
        toast.error(response.data?.message || '上传失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '上传失败');
    } finally {
      setLoading(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">上传书籍</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>
        <form onSubmit={handleSubmit}>
          <div className="p-6 space-y-4">
            {/* 文件选择 */}
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">文件 *</label>
              <input
                ref={fileInputRef}
                type="file"
                accept=".epub,.docx,.doc,.txt,.pdf"
                onChange={handleFileChange}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all file:mr-4 file:py-1 file:px-3 file:rounded-lg file:border-0 file:text-sm file:font-medium file:bg-brand-50 file:text-brand-700 dark:file:bg-brand-900/20 dark:file:text-brand-400 hover:file:bg-brand-100 dark:hover:file:bg-brand-900/30 cursor-pointer"
              />
              <p className="mt-1 text-xs text-gray-400">支持 EPUB、DOCX、TXT、PDF 格式</p>
            </div>
            {/* 书名 */}
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">书名 *</label>
              <input
                type="text"
                value={title}
                onChange={e => setTitle(e.target.value)}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="请输入书名"
              />
            </div>
            {/* 作者 */}
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">作者</label>
              <input
                type="text"
                value={author}
                onChange={e => setAuthor(e.target.value)}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="请输入作者（可选）"
              />
            </div>
            {/* 封面 */}
            <ImageUploadArea
              label="封面图片"
              value={coverPreview || ''}
              onFileSelect={(file) => {
                setCover(file);
                const reader = new FileReader();
                reader.onload = (ev) => setCoverPreview(ev.target?.result as string);
                reader.readAsDataURL(file);
              }}
              onChange={() => { setCoverPreview(null); setCover(null); }}
              placeholder="点击选择封面图片（可选）"
            />
          </div>
          <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
            <button type="button" onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">
              取消
            </button>
            <button
              type="submit"
              disabled={loading}
              className="flex items-center gap-2 px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95"
            >
              {loading && <Loader2 size={16} className="animate-spin" />}
              {loading ? '上传中...' : '上传'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

// ─── 编辑书籍弹窗 ────────────────────────────────────────────────

interface EditBookModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  book: BookDTO | null;
}

const EditBookModal: React.FC<EditBookModalProps> = ({ isOpen, onClose, onSuccess, book }) => {
  const [loading, setLoading] = useState(false);
  const [title, setTitle] = useState('');
  const [author, setAuthor] = useState('');
  const [cover, setCover] = useState<File | null>(null);
  const [coverPreview, setCoverPreview] = useState<string | null>(null);
  useEffect(() => {
    if (isOpen && book) {
      setTitle(book.title || '');
      setAuthor(book.author || '');
      setCover(null);
      setCoverPreview(book.coverUrl || null);
    }
  }, [isOpen, book]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!book) return;
    if (!title.trim()) {
      toast.warning('书名不能为空');
      return;
    }
    setLoading(true);
    try {
      const res = await api.updateBook({
        bookId: book.id as unknown as number,
        requestBody: {
          title: title.trim(),
          author: author.trim(),
        },
      });
      if (res.data?.code !== 0) {
        toast.error(res.data?.message || '修改失败');
        return;
      }

      if (cover) {
        const fd = new FormData();
        fd.append('cover', cover);
        const coverRes = await apiClient.put(`/api/books/${String(book.id)}/cover`, fd, {
          headers: { 'Content-Type': 'multipart/form-data' },
        });
        if (coverRes.data?.code !== 0) {
          toast.error(coverRes.data?.message || '封面更新失败');
          return;
        }
      }

      toast.success(cover ? '信息与封面已更新' : '信息已更新');
      onSuccess();
      onClose();
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '修改失败');
    } finally {
      setLoading(false);
    }
  };

  if (!isOpen || !book) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">编辑书籍</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>
        <form onSubmit={handleSubmit}>
          <div className="p-6 space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">书名 *</label>
              <input
                type="text"
                value={title}
                onChange={e => setTitle(e.target.value)}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="请输入书名"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">作者</label>
              <input
                type="text"
                value={author}
                onChange={e => setAuthor(e.target.value)}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="请输入作者（可选）"
              />
            </div>
            <ImageUploadArea
              label="封面"
              value={coverPreview || ''}
              onFileSelect={(file) => {
                setCover(file);
                const reader = new FileReader();
                reader.onload = (ev) => setCoverPreview(ev.target?.result as string);
                reader.readAsDataURL(file);
              }}
              onChange={() => { setCoverPreview(null); setCover(null); }}
              placeholder="点击上传封面（可选）"
            />
          </div>
          <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
            <button type="button" onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">
              取消
            </button>
            <button
              type="submit"
              disabled={loading}
              className="flex items-center gap-2 px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95"
            >
              {loading && <Loader2 size={16} className="animate-spin" />}
              {loading ? '保存中...' : '保存'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

// ─── 章节预览弹窗 ────────────────────────────────────────────────

interface ChapterPreviewModalProps {
  isOpen: boolean;
  onClose: () => void;
  book: BookDTO | null;
}

const ChapterPreviewModal: React.FC<ChapterPreviewModalProps> = ({ isOpen, onClose, book }) => {
  const navigate = useNavigate();
  const [chapters, setChapters] = useState<ChapterDTO[]>([]);
  const [loading, setLoading] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState<number | null>(null);
  const [contentData, setContentData] = useState<ChapterContentDTO | null>(null);
  const [contentLoading, setContentLoading] = useState(false);

  useEffect(() => {
    if (isOpen && book?.id) {
      setSelectedIndex(null);
      setContentData(null);
      fetchChapters();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isOpen, book?.id]);

  const fetchChapters = async () => {
    if (!book?.id) return;
    setLoading(true);
    try {
      const response = await api.getBookChapters({ bookId: book.id as unknown as number });
      if (response.data?.code === 0) {
        setChapters(response.data.data || []);
      } else {
        toast.error(response.data?.message || '获取章节失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '获取章节失败');
    } finally {
      setLoading(false);
    }
  };

  const fetchChapterContent = async (chapterIndex: number) => {
    if (!book?.id) return;
    setSelectedIndex(chapterIndex);
    setContentLoading(true);
    setContentData(null);
    try {
      const response = await api.getChapterContent({
        bookId: book.id as unknown as number,
        chapterIndex,
      });
      if (response.data?.code === 0) {
        setContentData(response.data.data || null);
      } else {
        toast.error(response.data?.message || '获取章节内容失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '获取章节内容失败');
    } finally {
      setContentLoading(false);
    }
  };

  if (!isOpen || !book) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-6xl mx-4 overflow-hidden animate-in zoom-in-95 duration-200 h-[85vh] flex flex-col">
        {/* 头部 */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800 flex-shrink-0">
          <div>
            <h3 className="text-lg font-bold text-gray-900 dark:text-white">{book.title}</h3>
            <p className="text-sm text-gray-500 dark:text-gray-400 mt-0.5">
              {book.author && `${book.author} · `}共 {chapters.length} 章
            </p>
          </div>
          <div className="flex items-center gap-2">
            <button
              onClick={() => { onClose(); navigate(`/book/${String(book.id)}/read`); }}
              className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-xs font-bold text-white bg-brand-600 hover:bg-brand-700 transition-all active:scale-95 shadow-lg shadow-brand-600/20"
            >
              <BookOpen size={14} />
              进入阅读
            </button>
            <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
              <X size={20} />
            </button>
          </div>
        </div>

        {/* 左右分栏 */}
        <div className="flex-1 flex min-h-0">
          {/* 左侧：章节列表 */}
          <div className="w-72 flex-shrink-0 border-r border-gray-100 dark:border-gray-800 overflow-y-auto">
            {loading ? (
              <div className="flex items-center justify-center py-12">
                <Loader2 size={24} className="animate-spin text-brand-600" />
              </div>
            ) : chapters.length === 0 ? (
              <div className="text-center py-12 text-gray-400 dark:text-gray-500">
                <BookOpen size={36} className="mx-auto mb-2 opacity-50" />
                <p className="text-sm">暂无章节</p>
              </div>
            ) : (
              <div className="py-2">
                {chapters.map((ch, idx) => {
                  const ci = ch.chapterIndex ?? idx;
                  const isActive = selectedIndex === ci;
                  return (
                    <button
                      key={String(ch.id ?? idx)}
                      onClick={() => fetchChapterContent(ci)}
                      className={`w-full flex items-center gap-3 px-4 py-3 text-left transition-all ${
                        isActive
                          ? 'bg-brand-50 dark:bg-brand-900/20 border-r-2 border-brand-500'
                          : 'hover:bg-gray-50 dark:hover:bg-gray-800/50'
                      }`}
                    >
                      <span className={`flex-shrink-0 w-7 h-7 flex items-center justify-center rounded-lg text-xs font-bold ${
                        isActive
                          ? 'bg-brand-500 text-white'
                          : 'bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400'
                      }`}>
                        {ci + 1}
                      </span>
                      <div className="flex-1 min-w-0">
                        <p className={`text-sm truncate ${
                          isActive
                            ? 'font-bold text-brand-700 dark:text-brand-400'
                            : 'font-medium text-gray-700 dark:text-gray-300'
                        }`}>
                          {ch.title || `第 ${ci + 1} 章`}
                        </p>
                        {ch.wordCount != null && ch.wordCount > 0 && (
                          <p className="text-xs text-gray-400 dark:text-gray-500 mt-0.5">
                            {ch.wordCount.toLocaleString()} 字
                          </p>
                        )}
                      </div>
                    </button>
                  );
                })}
              </div>
            )}
          </div>

          {/* 右侧：内容预览 */}
          <div className="flex-1 overflow-y-auto">
            {selectedIndex === null ? (
              <div className="flex flex-col items-center justify-center h-full text-gray-400 dark:text-gray-500">
                <Eye size={48} className="mb-3 opacity-30" />
                <p className="text-sm">点击左侧章节预览内容</p>
              </div>
            ) : contentLoading ? (
              <div className="flex items-center justify-center h-full">
                <Loader2 size={24} className="animate-spin text-brand-600" />
                <span className="ml-2 text-gray-500 dark:text-gray-400">加载章节内容...</span>
              </div>
            ) : contentData ? (
              <div className="p-6">
                <h2 className="text-xl font-bold text-gray-900 dark:text-white mb-1">
                  {contentData.title || `第 ${(contentData.chapterIndex ?? 0) + 1} 章`}
                </h2>
                {contentData.wordCount != null && contentData.wordCount > 0 && (
                  <p className="text-xs text-gray-400 dark:text-gray-500 mb-4">
                    {contentData.wordCount.toLocaleString()} 字
                  </p>
                )}
                <div
                  className="prose prose-sm dark:prose-invert max-w-none text-gray-700 dark:text-gray-300 leading-relaxed [&_p]:mb-3 [&_p]:indent-8"
                  dangerouslySetInnerHTML={{ __html: contentData.content || '<p>暂无内容</p>' }}
                />
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center h-full text-gray-400 dark:text-gray-500">
                <FileText size={48} className="mb-3 opacity-30" />
                <p className="text-sm">章节内容为空</p>
              </div>
            )}
          </div>
        </div>

        {/* 底部 */}
        <div className="flex items-center justify-end px-6 py-3 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50 flex-shrink-0">
          <button onClick={onClose} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">
            关闭
          </button>
        </div>
      </div>
    </div>
  );
};

// ─── 工具函数 ────────────────────────────────────────────────────────────────────

const formatFileSize = (bytes?: number): string => {
  if (!bytes || bytes === 0) return '-';
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
};

const getStatusBadge = (status?: string) => {
  switch (status) {
    case 'UPLOADED':
      return { text: '已上传', className: 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400 border-blue-200 dark:border-blue-800' };
    case 'PROCESSING':
      return { text: '解析中', className: 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400 border-yellow-200 dark:border-yellow-800', spinning: true };
    case 'READY':
      return { text: '就绪', className: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' };
    case 'FAILED':
      return { text: '解析失败', className: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800' };
    default:
      return { text: status || '未知', className: 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700' };
  }
};

const getFileTypeBadge = (fileType?: string) => {
  switch (fileType?.toUpperCase()) {
    case 'EPUB':
      return 'bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-400 border-purple-200 dark:border-purple-800';
    case 'PDF':
      return 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800';
    case 'DOCX':
    case 'DOC':
      return 'bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-400 border-brand-200 dark:border-brand-800';
    case 'TXT':
      return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700';
    default:
      return 'bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-400 border-gray-200 dark:border-gray-700';
  }
};

const formatDate = (dateStr?: string): string => {
  if (!dateStr) return '-';
  try {
    const d = new Date(dateStr);
    return d.toLocaleDateString('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit' })
      + ' ' + d.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit' });
  } catch {
    return dateStr;
  }
};

// ─── 主页面 ──────────────────────────────────────────────────────────────────────

const PAGE_SIZE = 20;

export const BookManagementPage: React.FC = () => {
  const [books, setBooks] = useState<BookDTO[]>([]);
  const [loading, setLoading] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const [hasMore, setHasMore] = useState(false);
  const [searchKeyword, setSearchKeyword] = useState('');
  const [activeKeyword, setActiveKeyword] = useState('');
  const [fileTypeFilter, setFileTypeFilter] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [uploadModalOpen, setUploadModalOpen] = useState(false);
  const [previewBook, setPreviewBook] = useState<BookDTO | null>(null);
  const [editBook, setEditBook] = useState<BookDTO | null>(null);

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
        let list: BookDTO[] = (response.data.data || []) as BookDTO[];
        // 前端筛选文件类型
        if (fileTypeFilter) {
          list = list.filter(b => b.fileType?.toUpperCase() === fileTypeFilter);
        }
        // 前端筛选状态
        if (statusFilter) {
          list = list.filter(b => b.status === statusFilter);
        }
        setBooks(list);
        setHasMore(((response.data.data || []) as BookDTO[]).length >= PAGE_SIZE);
      } else {
        toast.error(response.data?.message || '获取书籍列表失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [currentPage, activeKeyword, fileTypeFilter, statusFilter]);

  useEffect(() => {
    fetchBooks();
  }, [fetchBooks]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setCurrentPage(1);
    setActiveKeyword(searchKeyword);
  };

  const handlePageChange = (newPage: number) => {
    setCurrentPage(newPage);
  };

  const handleDelete = async (book: BookDTO) => {
    if (!book.id) return;
    if (!window.confirm(`确定要删除书籍"${book.title}"吗？此操作不可恢复。`)) return;

    try {
      const response = await api.deleteBook({ bookId: book.id as unknown as number });
      if (response.data?.code === 0) {
        toast.success('删除成功');
        fetchBooks();
      } else {
        toast.error(response.data?.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '删除失败');
    }
  };

  const handleEncryptAll = async (book: BookDTO) => {
    if (!book.id) return;
    if (!window.confirm(`确定要加密书籍"${book.title}"的所有章节吗？`)) return;

    try {
      const response = await api.encryptAllChapters({ bookId: book.id as unknown as number });
      if (response.data?.code === 0) {
        toast.success(`已加密 ${response.data.data || 0} 个章节`);
        fetchBooks();
      } else {
        toast.error(response.data?.message || '加密失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '加密失败');
    }
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* 页头区域 */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">电子书管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">上传、管理和查看系统中的电子书资源</p>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => setUploadModalOpen(true)}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Upload size={18} />
            <span>上传书籍</span>
          </button>
        </div>
      </div>

      {/* 搜索筛选栏 */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <form onSubmit={handleSearch} className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input
              type="text"
              placeholder="搜索书名、作者..."
              value={searchKeyword}
              onChange={e => setSearchKeyword(e.target.value)}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select
              value={fileTypeFilter}
              onChange={e => { setFileTypeFilter(e.target.value); setCurrentPage(1); }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              <option value="">全部类型</option>
              <option value="EPUB">EPUB</option>
              <option value="PDF">PDF</option>
              <option value="DOCX">DOCX</option>
              <option value="TXT">TXT</option>
            </select>
            <select
              value={statusFilter}
              onChange={e => { setStatusFilter(e.target.value); setCurrentPage(1); }}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              <option value="">全部状态</option>
              <option value="UPLOADED">已上传</option>
              <option value="PROCESSING">解析中</option>
              <option value="READY">就绪</option>
              <option value="FAILED">解析失败</option>
            </select>
            <button
              type="button"
              onClick={() => fetchBooks()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
              title="刷新"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </form>
      </div>

      {/* 表格区域 */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-20">封面</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider min-w-[180px]">书名</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-24">作者</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-28">类型</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-24">状态</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-20 text-center">章节数</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-24 text-right">字数</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-24 text-right">文件大小</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider min-w-[140px]">上传时间</th>
                <th className="px-4 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider w-[200px]">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading && books.length === 0 ? (
                <tr>
                  <td colSpan={10} className="px-6 py-16 text-center">
                    <Loader2 size={24} className="animate-spin text-brand-600 mx-auto mb-2" />
                    <p className="text-gray-400 dark:text-gray-500">加载中...</p>
                  </td>
                </tr>
              ) : books.length === 0 ? (
                <tr>
                  <td colSpan={10} className="px-6 py-16 text-center">
                    <FileText size={48} className="mx-auto mb-3 text-gray-300 dark:text-gray-600" />
                    <p className="text-gray-400 dark:text-gray-500">暂无书籍数据</p>
                  </td>
                </tr>
              ) : (
                books.map(book => {
                  const statusBadge = getStatusBadge(book.status);
                  const fileTypeBadge = getFileTypeBadge(book.fileType);
                  return (
                    <tr key={String(book.id)} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                      <td className="px-4 py-3">
                        <div className="w-12 h-16 rounded-lg bg-gray-50 dark:bg-gray-800/50 border border-gray-100 dark:border-gray-700 overflow-hidden flex items-center justify-center">
                          {book.coverUrl ? (
                            <img src={book.coverUrl} alt={book.title || ''} className="w-full h-full object-cover" />
                          ) : (
                            <FileText size={18} className="text-gray-300 dark:text-gray-600" />
                          )}
                        </div>
                      </td>
                      <td className="px-4 py-4">
                        <TruncateWithTooltip
                          text={book.title || ''}
                          maxWidth={180}
                          className="font-bold text-gray-900 dark:text-white group-hover:text-brand-600 transition-colors"
                        />
                      </td>
                      <td className="px-4 py-4">
                        <span className="text-sm text-gray-600 dark:text-gray-300">{book.author || '-'}</span>
                      </td>
                      <td className="px-4 py-4">
                        <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold border ${fileTypeBadge}`}>
                          {book.fileType?.toUpperCase() || '-'}
                        </span>
                      </td>
                      <td className="px-4 py-4">
                        <span className={`inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-bold border ${statusBadge.className}`}>
                          {statusBadge.spinning && <Loader2 size={12} className="animate-spin" />}
                          {statusBadge.text}
                        </span>
                      </td>
                      <td className="px-4 py-4 text-center">
                        <span className="text-sm text-gray-600 dark:text-gray-300">{book.totalChapters ?? '-'}</span>
                      </td>
                      <td className="px-4 py-4 text-right">
                        <span className="text-sm text-gray-600 dark:text-gray-300">
                          {book.wordCount ? book.wordCount.toLocaleString() : '-'}
                        </span>
                      </td>
                      <td className="px-4 py-4 text-right">
                        <span className="text-sm text-gray-600 dark:text-gray-300">{formatFileSize(book.fileSize)}</span>
                      </td>
                      <td className="px-4 py-4">
                        <span className="text-sm text-gray-500 dark:text-gray-400">{formatDate(book.createTime)}</span>
                      </td>
                      <td className="px-4 py-4">
                        <div className="flex items-center gap-1.5 opacity-0 group-hover:opacity-100 transition-opacity">
                          <button
                            onClick={() => setEditBook(book)}
                            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                            title="编辑"
                          >
                            <Pencil size={18} />
                          </button>
                          <button
                            onClick={() => setPreviewBook(book)}
                            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all"
                            title="查看章节"
                          >
                            <Eye size={18} />
                          </button>
                          <button
                            onClick={() => handleEncryptAll(book)}
                            className="p-2 text-gray-400 hover:text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded-lg transition-all"
                            title="加密所有章节"
                          >
                            <Lock size={18} />
                          </button>
                          <button
                            onClick={() => handleDelete(book)}
                            className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                            title="删除"
                          >
                            <Trash2 size={18} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>

        {/* 分页栏 */}
        <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
          <p className="text-sm text-gray-500 dark:text-gray-400">
            第 <span className="font-bold text-gray-900 dark:text-white">{currentPage}</span> 页
            {books.length > 0 && <>，本页 <span className="font-bold text-gray-900 dark:text-white">{books.length}</span> 条</>}
          </p>
          <div className="flex items-center gap-2">
            <button
              onClick={() => handlePageChange(currentPage - 1)}
              disabled={currentPage === 1}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
            >
              <ChevronLeft size={18} />
            </button>
            <span className="px-4 py-2 text-sm font-medium text-gray-900 dark:text-white">
              {currentPage}
            </span>
            <button
              onClick={() => handlePageChange(currentPage + 1)}
              disabled={!hasMore}
              className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        </div>
      </div>

      {/* 上传弹窗 */}
      <UploadBookModal
        isOpen={uploadModalOpen}
        onClose={() => setUploadModalOpen(false)}
        onSuccess={() => fetchBooks()}
      />

      {/* 编辑弹窗 */}
      <EditBookModal
        isOpen={!!editBook}
        onClose={() => setEditBook(null)}
        onSuccess={() => fetchBooks()}
        book={editBook}
      />

      {/* 章节预览弹窗 */}
      <ChapterPreviewModal
        isOpen={!!previewBook}
        onClose={() => setPreviewBook(null)}
        book={previewBook}
      />
    </div>
  );
};

export default BookManagementPage;
