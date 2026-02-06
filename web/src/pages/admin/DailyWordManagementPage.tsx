import React, { useState, useEffect, useCallback } from 'react';
import { 
  Search, 
  Plus, 
  Edit2, 
  Trash2, 
  Filter,
  ChevronLeft,
  ChevronRight,
  RefreshCw,
  X,
  BookOpen,
  Calendar,
  Volume2,
  Star,
  FileText
} from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { DailyWordResponse, DailyWordPageResponse, CreateDailyWordRequest, UpdateDailyWordRequest } from '../../api/generated/models';
import { toast, TruncateWithTooltip } from '../../components/ui';

const api = new DefaultApi(new Configuration(), '', apiClient);

// 难度配置
const DIFFICULTY_OPTIONS = [
  { value: 1, label: '简单', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' },
  { value: 2, label: '中等', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800' },
  { value: 3, label: '困难', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800' },
];

// 分类选项
const CATEGORY_OPTIONS = [
  { value: '', label: '全部分类' },
  { value: '小学三年级', label: '小学三年级' },
  { value: '小学四年级', label: '小学四年级' },
  { value: '小学五年级', label: '小学五年级' },
  { value: '小学六年级', label: '小学六年级' },
  { value: '初中七年级', label: '初中七年级' },
  { value: '初中八年级', label: '初中八年级' },
  { value: '初中九年级', label: '初中九年级' },
  { value: '初中', label: '初中' },
  { value: '初中(乱序)', label: '初中(乱序)' },
  { value: '外研社初中', label: '外研社初中' },
  { value: '高中', label: '高中' },
  { value: '高中(乱序)', label: '高中(乱序)' },
  { value: '北师高中', label: '北师高中' },
  { value: '四级', label: '四级' },
  { value: '四级(乱序)', label: '四级(乱序)' },
  { value: '专四', label: '专四' },
  { value: '专四(乱序)', label: '专四(乱序)' },
  { value: '六级', label: '六级' },
  { value: '六级(乱序)', label: '六级(乱序)' },
  { value: '考研', label: '考研' },
  { value: '考研(乱序)', label: '考研(乱序)' },
  { value: '专八', label: '专八' },
  { value: '专八(乱序)', label: '专八(乱序)' },
  { value: '托福', label: '托福' },
  { value: '雅思', label: '雅思' },
  { value: '雅思(乱序)', label: '雅思(乱序)' },
  { value: 'GRE', label: 'GRE' },
  { value: 'GMAT', label: 'GMAT' },
  { value: 'GMAT(乱序)', label: 'GMAT(乱序)' },
  { value: 'SAT', label: 'SAT' },
  { value: 'BEC商务英语', label: 'BEC商务英语' },
];

// 单词表单弹窗组件
interface WordFormModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  word?: DailyWordResponse | null;
}

const WordFormModal: React.FC<WordFormModalProps> = ({ isOpen, onClose, onSuccess, word }) => {
  const isEdit = !!word;
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState<CreateDailyWordRequest>({
    word: '',
    pronunciationUs: '',
    pronunciationUk: '',
    audioUrlUs: '',
    audioUrlUk: '',
    translation: '',
    example: '',
    exampleTranslation: '',
    difficulty: 1,
    category: '',
    notes: '',
    publishDate: new Date().toISOString().split('T')[0],
  });

  useEffect(() => {
    if (word) {
      setFormData({
        word: word.word || '',
        pronunciationUs: word.pronunciationUs || '',
        pronunciationUk: word.pronunciationUk || '',
        audioUrlUs: word.audioUrlUs || '',
        audioUrlUk: word.audioUrlUk || '',
        translation: word.translation || '',
        example: word.example || '',
        exampleTranslation: word.exampleTranslation || '',
        difficulty: word.difficulty || 1,
        category: word.category || '',
        notes: word.notes || '',
        publishDate: word.publishDate || new Date().toISOString().split('T')[0],
      });
    } else {
      setFormData({
        word: '',
        pronunciationUs: '',
        pronunciationUk: '',
        audioUrlUs: '',
        audioUrlUk: '',
        translation: '',
        example: '',
        exampleTranslation: '',
        difficulty: 1,
        category: '',
        notes: '',
        publishDate: new Date().toISOString().split('T')[0],
      });
    }
  }, [word, isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.word.trim()) {
      toast.warning('请输入单词');
      return;
    }
    if (!formData.translation.trim()) {
      toast.warning('请输入翻译');
      return;
    }
    if (!formData.publishDate) {
      toast.warning('请选择发布日期');
      return;
    }

    setLoading(true);
    try {
      if (isEdit && word?.id) {
        const updateData: UpdateDailyWordRequest = {
          word: formData.word,
          pronunciationUs: formData.pronunciationUs,
          pronunciationUk: formData.pronunciationUk,
          audioUrlUs: formData.audioUrlUs,
          audioUrlUk: formData.audioUrlUk,
          translation: formData.translation,
          example: formData.example,
          exampleTranslation: formData.exampleTranslation,
          difficulty: formData.difficulty,
          category: formData.category,
          notes: formData.notes,
          publishDate: formData.publishDate,
        };
        const response = await api.updateDailyWord({ id: word.id, updateDailyWordRequest: updateData });
        if (response.data.code === 0) {
          toast.success('更新成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '更新失败');
        }
      } else {
        const response = await api.createDailyWord({ createDailyWordRequest: formData });
        if (response.data.code === 0) {
          toast.success('创建成功');
          onSuccess();
          onClose();
        } else {
          toast.error(response.data.message || '创建失败');
        }
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
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-2xl mx-4 max-h-[90vh] overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">
            {isEdit ? '编辑单词' : '新增单词'}
          </h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4 overflow-y-auto max-h-[calc(90vh-140px)]">
          {/* 基本信息 */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">单词 *</label>
              <input
                type="text"
                value={formData.word}
                onChange={(e) => setFormData(prev => ({ ...prev, word: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="输入英文单词"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">翻译 *</label>
              <input
                type="text"
                value={formData.translation}
                onChange={(e) => setFormData(prev => ({ ...prev, translation: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="输入中文翻译"
              />
            </div>
          </div>

          {/* 音标 */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">美式音标</label>
              <input
                type="text"
                value={formData.pronunciationUs}
                onChange={(e) => setFormData(prev => ({ ...prev, pronunciationUs: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="/həˈloʊ/"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">英式音标</label>
              <input
                type="text"
                value={formData.pronunciationUk}
                onChange={(e) => setFormData(prev => ({ ...prev, pronunciationUk: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="/həˈləʊ/"
              />
            </div>
          </div>

          {/* 音频URL */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">美式发音URL</label>
              <input
                type="text"
                value={formData.audioUrlUs}
                onChange={(e) => setFormData(prev => ({ ...prev, audioUrlUs: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="https://..."
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">英式发音URL</label>
              <input
                type="text"
                value={formData.audioUrlUk}
                onChange={(e) => setFormData(prev => ({ ...prev, audioUrlUk: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                placeholder="https://..."
              />
            </div>
          </div>

          {/* 例句 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">例句</label>
            <textarea
              value={formData.example}
              onChange={(e) => setFormData(prev => ({ ...prev, example: e.target.value }))}
              rows={2}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="输入英文例句"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">例句翻译</label>
            <textarea
              value={formData.exampleTranslation}
              onChange={(e) => setFormData(prev => ({ ...prev, exampleTranslation: e.target.value }))}
              rows={2}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="输入例句中文翻译"
            />
          </div>

          {/* 难度、分类、发布日期 */}
          <div className="grid grid-cols-3 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">难度等级 *</label>
              <select
                value={formData.difficulty}
                onChange={(e) => setFormData(prev => ({ ...prev, difficulty: Number(e.target.value) }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
              >
                {DIFFICULTY_OPTIONS.map(opt => (
                  <option key={opt.value} value={opt.value}>{opt.label}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">分类</label>
              <select
                value={formData.category}
                onChange={(e) => setFormData(prev => ({ ...prev, category: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
              >
                {CATEGORY_OPTIONS.map(opt => (
                  <option key={opt.value} value={opt.value}>{opt.label}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">发布日期 *</label>
              <input
                type="date"
                value={formData.publishDate}
                onChange={(e) => setFormData(prev => ({ ...prev, publishDate: e.target.value }))}
                className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
              />
            </div>
          </div>

          {/* 笔记 */}
          <div>
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">备注/笔记</label>
            <textarea
              value={formData.notes}
              onChange={(e) => setFormData(prev => ({ ...prev, notes: e.target.value }))}
              rows={2}
              className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all resize-none"
              placeholder="输入助记技巧或其他备注"
            />
          </div>
        </form>

        {/* Footer */}
        <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
          <button
            type="button"
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors"
          >
            取消
          </button>
          <button
            onClick={handleSubmit}
            disabled={loading}
            className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95 flex items-center gap-2"
          >
            {loading && <RefreshCw size={16} className="animate-spin" />}
            {isEdit ? '保存修改' : '创建单词'}
          </button>
        </div>
      </div>
    </div>
  );
};

// 单词详情弹窗
interface WordDetailModalProps {
  isOpen: boolean;
  onClose: () => void;
  word: DailyWordResponse | null;
}

const WordDetailModal: React.FC<WordDetailModalProps> = ({ isOpen, onClose, word }) => {
  if (!isOpen || !word) return null;

  const difficultyOption = DIFFICULTY_OPTIONS.find(d => d.value === word.difficulty);

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={onClose} />
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-lg mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
          <h3 className="text-lg font-bold text-gray-900 dark:text-white">单词详情</h3>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Content */}
        <div className="p-6 space-y-4">
          {/* 单词和翻译 */}
          <div className="text-center pb-4 border-b border-gray-100 dark:border-gray-800">
            <h2 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">{word.word}</h2>
            <p className="text-lg text-brand-600 dark:text-brand-400">{word.translation}</p>
          </div>

          {/* 音标 */}
          {(word.pronunciationUs || word.pronunciationUk) && (
            <div className="flex items-center justify-center gap-6">
              {word.pronunciationUs && (
                <div className="flex items-center gap-2">
                  <span className="text-xs text-gray-400">美</span>
                  <span className="text-gray-600 dark:text-gray-300">{word.pronunciationUs}</span>
                  {word.audioUrlUs && (
                    <button className="p-1 text-brand-500 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded">
                      <Volume2 size={16} />
                    </button>
                  )}
                </div>
              )}
              {word.pronunciationUk && (
                <div className="flex items-center gap-2">
                  <span className="text-xs text-gray-400">英</span>
                  <span className="text-gray-600 dark:text-gray-300">{word.pronunciationUk}</span>
                  {word.audioUrlUk && (
                    <button className="p-1 text-brand-500 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded">
                      <Volume2 size={16} />
                    </button>
                  )}
                </div>
              )}
            </div>
          )}

          {/* 例句 */}
          {word.example && (
            <div className="bg-gray-50 dark:bg-gray-800/50 rounded-xl p-4">
              <p className="text-gray-800 dark:text-gray-200 italic mb-2">"{word.example}"</p>
              {word.exampleTranslation && (
                <p className="text-sm text-gray-500 dark:text-gray-400">{word.exampleTranslation}</p>
              )}
            </div>
          )}

          {/* 标签信息 */}
          <div className="flex flex-wrap gap-2">
            {difficultyOption && (
              <span className={`px-3 py-1 rounded-lg text-xs font-bold border ${difficultyOption.color}`}>
                {difficultyOption.label}
              </span>
            )}
            {word.category && (
              <span className="px-3 py-1 rounded-lg text-xs font-bold bg-brand-100 text-brand-700 dark:bg-brand-900/30 dark:text-brand-400 border border-brand-200 dark:border-brand-800">
                {word.category}
              </span>
            )}
            {word.publishDate && (
              <span className="px-3 py-1 rounded-lg text-xs font-medium bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400 flex items-center gap-1">
                <Calendar size={12} />
                {word.publishDate}
              </span>
            )}
          </div>

          {/* 笔记 */}
          {word.notes && (
            <div className="bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 rounded-xl p-4">
              <div className="flex items-start gap-2">
                <FileText size={16} className="text-amber-500 mt-0.5 flex-shrink-0" />
                <p className="text-sm text-amber-800 dark:text-amber-200">{word.notes}</p>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export const DailyWordManagementPage: React.FC = () => {
  const [words, setWords] = useState<DailyWordResponse[]>([]);
  const [total, setTotal] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [loading, setLoading] = useState(false);
  const [modalOpen, setModalOpen] = useState(false);
  const [detailModalOpen, setDetailModalOpen] = useState(false);
  const [editingWord, setEditingWord] = useState<DailyWordResponse | null>(null);
  const [viewingWord, setViewingWord] = useState<DailyWordResponse | null>(null);
  const [queryParams, setQueryParams] = useState({
    page: 1,
    size: 10,
    category: '',
    difficulty: undefined as number | undefined,
    keyword: '',
  });

  const fetchWords = useCallback(async () => {
    setLoading(true);
    try {
      // 如果有关键词，使用搜索接口
      if (queryParams.keyword.trim()) {
        const response = await api.searchWords({ 
          keyword: queryParams.keyword,
          page: queryParams.page,
          size: queryParams.size,
        });
        if (response.data.code === 0) {
          const pageData = response.data.data as DailyWordPageResponse | undefined;
          setWords(pageData?.records || []);
          setTotal(pageData?.total || 0);
          setTotalPages(pageData?.totalPages || 0);
        } else {
          toast.error(response.data.message || '搜索失败');
        }
      } else {
        // 否则使用列表接口
        const response = await api.listWords({ 
          category: queryParams.category || undefined,
          difficulty: queryParams.difficulty,
          page: queryParams.page,
          size: queryParams.size,
        });
        if (response.data.code === 0) {
          const pageData = response.data.data as DailyWordPageResponse | undefined;
          setWords(pageData?.records || []);
          setTotal(pageData?.total || 0);
          setTotalPages(pageData?.totalPages || 0);
        } else {
          toast.error(response.data.message || '获取单词列表失败');
        }
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '网络错误');
    } finally {
      setLoading(false);
    }
  }, [queryParams]);

  useEffect(() => {
    fetchWords();
  }, [fetchWords]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setQueryParams(prev => ({ ...prev, page: 1 }));
  };

  const handlePageChange = (newPage: number) => {
    setQueryParams(prev => ({ ...prev, page: newPage }));
  };

  const handleDeleteWord = async (word: DailyWordResponse) => {
    if (!word.id) return;
    if (!window.confirm(`确定要删除单词 "${word.word}" 吗？此操作不可恢复。`)) {
      return;
    }
    try {
      const response = await api.deleteDailyWord({ id: word.id });
      if (response.data.code === 0) {
        toast.success('删除成功');
        fetchWords();
      } else {
        toast.error(response.data.message || '删除失败');
      }
    } catch (error: any) {
      toast.error(error?.response?.data?.message || '删除失败');
    }
  };

  const getDifficultyBadge = (difficulty?: number) => {
    const option = DIFFICULTY_OPTIONS.find(d => d.value === difficulty);
    if (!option) return null;
    return (
      <span className={`px-2.5 py-1 rounded-lg text-xs font-bold border ${option.color}`}>
        {option.label}
      </span>
    );
  };

  return (
    <div className="space-y-6 animate-in fade-in duration-500">
      {/* Page Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">每日单词管理</h1>
          <p className="text-gray-500 dark:text-gray-400 mt-1">管理每日推送的单词内容、难度和分类</p>
        </div>
        <div className="flex items-center gap-3">
          <button 
            onClick={() => { setEditingWord(null); setModalOpen(true); }}
            className="flex items-center gap-2 px-4 py-2 bg-brand-600 text-white rounded-xl text-sm font-bold hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
          >
            <Plus size={18} />
            <span>新增单词</span>
          </button>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white dark:bg-gray-900 p-4 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm transition-all duration-300">
        <form onSubmit={handleSearch} className="flex flex-col lg:flex-row gap-4">
          <div className="flex-1 relative group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-brand-500 transition-colors" size={20} />
            <input 
              type="text" 
              placeholder="搜索单词、翻译..." 
              value={queryParams.keyword}
              onChange={(e) => setQueryParams(prev => ({ ...prev, keyword: e.target.value }))}
              className="w-full pl-12 pr-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-gray-900 dark:text-white placeholder-gray-400 outline-none transition-all"
            />
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <select 
              value={queryParams.category}
              onChange={(e) => setQueryParams(prev => ({ ...prev, category: e.target.value, page: 1 }))}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              {CATEGORY_OPTIONS.map(opt => (
                <option key={opt.value} value={opt.value}>{opt.label}</option>
              ))}
            </select>
            <select 
              value={queryParams.difficulty || ''}
              onChange={(e) => setQueryParams(prev => ({ 
                ...prev, 
                difficulty: e.target.value ? Number(e.target.value) : undefined,
                page: 1 
              }))}
              className="px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-transparent focus:border-brand-500/50 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 outline-none cursor-pointer"
            >
              <option value="">全部难度</option>
              {DIFFICULTY_OPTIONS.map(opt => (
                <option key={opt.value} value={opt.value}>{opt.label}</option>
              ))}
            </select>
            <button 
              type="button"
              className="flex items-center gap-2 px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-400 transition-colors"
            >
              <Filter size={18} />
              <span>更多筛选</span>
            </button>
            <button 
              type="button"
              onClick={() => fetchWords()}
              className="p-2.5 bg-gray-50 dark:bg-gray-800/50 hover:bg-brand-50 dark:hover:bg-brand-900/20 text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 rounded-xl transition-all"
            >
              <RefreshCw size={20} className={loading ? 'animate-spin' : ''} />
            </button>
          </div>
        </form>
      </div>

      {/* Word Table */}
      <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden transition-all duration-300">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse admin-table">
            <thead>
              <tr className="bg-gray-50/50 dark:bg-gray-800/50 border-b border-gray-100 dark:border-gray-800 transition-colors duration-300">
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">单词</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">翻译</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">难度</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">分类</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">发布日期</th>
                <th className="px-6 py-4 text-xs font-bold text-gray-400 uppercase tracking-wider">操作</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50 dark:divide-gray-800">
              {loading ? (
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    <td colSpan={6} className="px-6 py-8 h-16">
                      <div className="flex gap-4">
                        <div className="w-10 h-10 bg-gray-100 dark:bg-gray-800 rounded-xl" />
                        <div className="space-y-2 flex-1">
                          <div className="h-4 bg-gray-100 dark:bg-gray-800 rounded w-1/4" />
                          <div className="h-3 bg-gray-100 dark:bg-gray-800 rounded w-1/3" />
                        </div>
                      </div>
                    </td>
                  </tr>
                ))
              ) : words.length > 0 ? (
                words.map((word) => (
                  <tr key={word.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors group">
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div>
                          <button
                            onClick={() => { setViewingWord(word); setDetailModalOpen(true); }}
                            className="font-bold text-gray-900 dark:text-white hover:text-brand-600 dark:hover:text-brand-400 transition-colors text-left"
                          >
                            {word.word}
                          </button>
                          {word.pronunciationUs && (
                            <p className="text-xs text-gray-400">{word.pronunciationUs}</p>
                          )}
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <TruncateWithTooltip 
                        text={word.translation || ''} 
                        maxWidth={200} 
                        className="text-gray-600 dark:text-gray-300"
                      />
                    </td>
                    <td className="px-6 py-4">
                      {getDifficultyBadge(word.difficulty)}
                    </td>
                    <td className="px-6 py-4">
                      {word.category ? (
                        <span className="px-2.5 py-1 rounded-lg text-xs font-medium bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400">
                          {word.category}
                        </span>
                      ) : (
                        <span className="text-gray-400">-</span>
                      )}
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2 text-sm text-gray-500 dark:text-gray-400">
                        <Calendar size={14} />
                        <span>{word.publishDate || '-'}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button 
                          onClick={() => { setViewingWord(word); setDetailModalOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" 
                          title="查看详情"
                        >
                          <Star size={18} />
                        </button>
                        <button 
                          onClick={() => { setEditingWord(word); setModalOpen(true); }}
                          className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-all" 
                          title="编辑"
                        >
                          <Edit2 size={18} />
                        </button>
                        <button 
                          onClick={() => handleDeleteWord(word)}
                          className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" 
                          title="删除"
                        >
                          <Trash2 size={18} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mb-4">
                        <BookOpen size={32} className="text-gray-300" />
                      </div>
                      <p className="text-gray-500 dark:text-gray-400 font-medium">暂无单词数据</p>
                      <button
                        onClick={() => { setEditingWord(null); setModalOpen(true); }}
                        className="mt-4 px-4 py-2 text-sm font-medium text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-lg transition-colors"
                      >
                        添加第一个单词
                      </button>
                    </div>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        {words.length > 0 && (
          <div className="px-6 py-4 bg-gray-50/50 dark:bg-gray-800/50 border-t border-gray-100 dark:border-gray-800 flex items-center justify-between transition-colors duration-300">
            <p className="text-sm text-gray-500 dark:text-gray-400">
              显示第 <span className="font-bold text-gray-900 dark:text-white">{(queryParams.page - 1) * queryParams.size + 1}</span> 到 <span className="font-bold text-gray-900 dark:text-white">{Math.min(queryParams.page * queryParams.size, total)}</span> 条结果，共 <span className="font-bold text-gray-900 dark:text-white">{total}</span> 条
            </p>
            <div className="flex items-center gap-2">
              <button 
                disabled={queryParams.page === 1 || loading}
                onClick={() => handlePageChange(queryParams.page - 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronLeft size={18} />
              </button>
              <div className="flex items-center gap-1">
                {Array.from({ length: Math.min(5, totalPages || 1) }).map((_, i) => {
                  // 计算要显示的页码，使当前页尽量居中
                  let pageNum = i + 1;
                  if (totalPages > 5) {
                    const start = Math.max(1, Math.min(queryParams.page - 2, totalPages - 4));
                    pageNum = start + i;
                  }
                  return (
                    <button
                      key={pageNum}
                      onClick={() => handlePageChange(pageNum)}
                      className={`w-10 h-10 rounded-lg text-sm font-bold transition-all ${
                        queryParams.page === pageNum 
                          ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' 
                          : 'text-gray-500 hover:bg-white dark:hover:bg-gray-800 border border-transparent hover:border-gray-200 dark:hover:border-gray-700'
                      }`}
                    >
                      {pageNum}
                    </button>
                  );
                })}
              </div>
              <button 
                disabled={queryParams.page >= totalPages || loading}
                onClick={() => handlePageChange(queryParams.page + 1)}
                className="p-2 border border-gray-200 dark:border-gray-700 rounded-lg text-gray-500 hover:bg-white dark:hover:bg-gray-800 disabled:opacity-50 transition-all"
              >
                <ChevronRight size={18} />
              </button>
            </div>
          </div>
        )}
      </div>

      {/* 单词表单弹窗 */}
      <WordFormModal
        isOpen={modalOpen}
        onClose={() => { setModalOpen(false); setEditingWord(null); }}
        onSuccess={fetchWords}
        word={editingWord}
      />

      {/* 单词详情弹窗 */}
      <WordDetailModal
        isOpen={detailModalOpen}
        onClose={() => { setDetailModalOpen(false); setViewingWord(null); }}
        word={viewingWord}
      />
    </div>
  );
};
