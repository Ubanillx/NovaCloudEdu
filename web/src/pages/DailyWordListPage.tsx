import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft, Volume2, ChevronLeft, ChevronRight, BookOpen, Settings2, BookmarkPlus, RefreshCw } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { DailyWordResponse } from '../api/generated/models';
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

const SETTINGS_KEY = 'nova_daily_word_settings';
const CACHE_KEY = 'nova_cache_today_words';

const SIZE_OPTIONS = [5, 10, 15, 20, 30];
const TYPE_OPTIONS = ['初中', '高中', '四级', '六级', '考研', '托福', '雅思', 'GRE'];

function loadSettings(): { size: number; type: string } {
  try {
    const raw = localStorage.getItem(SETTINGS_KEY);
    if (raw) return JSON.parse(raw);
  } catch { /* ignore */ }
  return { size: 10, type: '' };
}

function saveSettings(size: number, type: string) {
  localStorage.setItem(SETTINGS_KEY, JSON.stringify({ size, type }));
}

function getCachedWords(size: number, type: string): DailyWordResponse[] | null {
  try {
    const raw = localStorage.getItem(CACHE_KEY);
    if (!raw) return null;
    const entry = JSON.parse(raw);
    const today = new Date().toISOString().split('T')[0];
    if (entry.date !== today || entry.size !== size || entry.type !== type) return null;
    return entry.data;
  } catch { return null; }
}

function cacheWords(words: DailyWordResponse[], size: number, type: string) {
  const today = new Date().toISOString().split('T')[0];
  localStorage.setItem(CACHE_KEY, JSON.stringify({ data: words, size, type, date: today }));
}

const INDEX_SESSION_KEY = 'nova_daily_word_index';

const DailyWordListPage: React.FC = () => {
  const navigate = useNavigate();
  const audioRef = useRef<HTMLAudioElement | null>(null);

  const [settings] = useState(loadSettings);
  const [wordSize, setWordSize] = useState(settings.size);
  const [wordType, setWordType] = useState(settings.type);
  const [words, setWords] = useState<DailyWordResponse[]>([]);
  const [currentIndex, _setCurrentIndex] = useState(() => {
    const saved = sessionStorage.getItem(INDEX_SESSION_KEY);
    return saved ? parseInt(saved, 10) || 0 : 0;
  });
  const [loading, setLoading] = useState(true);
  const [showSettings, setShowSettings] = useState(false);

  const setCurrentIndex = (valOrFn: number | ((prev: number) => number)) => {
    _setCurrentIndex((prev) => {
      const next = typeof valOrFn === 'function' ? valOrFn(prev) : valOrFn;
      sessionStorage.setItem(INDEX_SESSION_KEY, String(next));
      return next;
    });
  };

  const fetchWords = useCallback(async (size: number, type: string, force = false) => {
    if (!force) {
      const cached = getCachedWords(size, type);
      if (cached && cached.length > 0) {
        setWords(cached);
        setLoading(false);
        return;
      }
    }
    setLoading(true);
    try {
      const res = await api.getTodayWords({ size, type: type || undefined });
      if (res.data.code === 0 && res.data.data) {
        const list = res.data.data as DailyWordResponse[];
        setWords(list);
        cacheWords(list, size, type);
      }
    } catch { /* ignore */ }
    finally { setLoading(false); }
  }, []);

  useEffect(() => {
    fetchWords(wordSize, wordType);
  }, [fetchWords, wordSize, wordType]);

  // 确保 index 不越界
  useEffect(() => {
    if (words.length > 0 && currentIndex >= words.length) {
      setCurrentIndex(words.length - 1);
    }
  }, [words, currentIndex]);

  const applySettings = (size: number, type: string) => {
    setWordSize(size);
    setWordType(type);
    saveSettings(size, type);
    setShowSettings(false);
    // 清缓存强制刷新
    localStorage.removeItem(CACHE_KEY);
    fetchWords(size, type, true);
  };

  const playAudio = (url?: string) => {
    if (!url) return;
    if (audioRef.current) audioRef.current.pause();
    audioRef.current = new Audio(url);
    audioRef.current.play().catch(() => {});
  };

  const handleAddToWordBook = async (word: DailyWordResponse, e: React.MouseEvent) => {
    e.stopPropagation();
    if (!word.id) return;
    try {
      await api.addToWordBook({ wordId: word.id });
      toast.success('已加入生词本');
    } catch { toast.error('操作失败'); }
  };

  const progress = words.length > 0 ? (currentIndex + 1) / words.length : 0;
  const currentWord = words[currentIndex];

  return (
    <div className="max-w-3xl mx-auto animate-in fade-in duration-500 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <button
            onClick={() => navigate(-1)}
            className="flex items-center gap-2 text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors group"
          >
            <ArrowLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
          </button>
          <div>
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white">每日单词</h1>
            <p className="text-sm text-gray-500 dark:text-gray-400">
              {wordType || '综合'} · 每日 {wordSize} 词
            </p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <button
            onClick={() => fetchWords(wordSize, wordType, true)}
            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-xl transition-colors"
            title="刷新"
          >
            <RefreshCw size={18} />
          </button>
          <button
            onClick={() => setShowSettings(!showSettings)}
            className="p-2 text-gray-400 hover:text-brand-600 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-xl transition-colors"
            title="设置"
          >
            <Settings2 size={18} />
          </button>
        </div>
      </div>

      {/* 设置面板 */}
      {showSettings && (
        <SettingsPanel
          currentSize={wordSize}
          currentType={wordType}
          onApply={applySettings}
          onClose={() => setShowSettings(false)}
        />
      )}

      {/* 进度条 */}
      {words.length > 0 && (
        <div>
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm font-medium text-gray-500 dark:text-gray-400">
              {currentIndex + 1} / {words.length}
            </span>
            {wordType && (
              <span className="text-xs font-bold text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 px-2 py-0.5 rounded-full">
                {wordType}
              </span>
            )}
          </div>
          <div className="h-1.5 bg-gray-200 dark:bg-gray-800 rounded-full overflow-hidden">
            <div
              className="h-full bg-gradient-to-r from-brand-500 to-accent-500 rounded-full transition-all duration-300"
              style={{ width: `${progress * 100}%` }}
            />
          </div>
        </div>
      )}

      {/* 主内容 */}
      {loading ? (
        <div className="bg-gradient-to-br from-brand-500 to-accent-500 rounded-2xl p-8 animate-pulse">
          <div className="h-10 bg-white/20 rounded w-40 mb-4" />
          <div className="h-6 bg-white/20 rounded w-28 mb-3" />
          <div className="h-5 bg-white/20 rounded w-48 mb-6" />
          <div className="h-20 bg-white/10 rounded-xl" />
        </div>
      ) : words.length === 0 ? (
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-200 dark:border-gray-800 p-12 text-center">
          <div className="w-16 h-16 bg-gray-50 dark:bg-gray-800 rounded-full flex items-center justify-center mx-auto mb-4">
            <BookOpen size={32} className="text-gray-300 dark:text-gray-600" />
          </div>
          <p className="text-gray-500 dark:text-gray-400 font-medium mb-4">暂无单词数据</p>
          <button
            onClick={() => setShowSettings(true)}
            className="text-sm text-brand-600 hover:text-brand-700 font-medium"
          >
            调整设置试试
          </button>
        </div>
      ) : currentWord ? (
        <>
          {/* 单词卡片 */}
          <div
            onClick={() => navigate(`/daily-word/${currentWord.id}`)}
            className="bg-gradient-to-br from-brand-500 to-accent-500 rounded-2xl p-8 text-white cursor-pointer hover:shadow-xl hover:shadow-brand-500/20 transition-all group"
          >
            {/* 单词 + 发音 */}
            <div className="flex items-start justify-between mb-3">
              <h2 className="text-4xl font-black group-hover:scale-[1.02] transition-transform origin-left">
                {currentWord.word}
              </h2>
              <div className="flex gap-2">
                {currentWord.audioUrlUs && (
                  <button
                    onClick={(e) => { e.stopPropagation(); playAudio(currentWord.audioUrlUs); }}
                    className="flex items-center gap-1 px-2.5 py-1.5 bg-white/20 hover:bg-white/30 rounded-lg text-xs font-medium transition-colors"
                  >
                    <Volume2 size={14} /> 美
                  </button>
                )}
                {currentWord.audioUrlUk && (
                  <button
                    onClick={(e) => { e.stopPropagation(); playAudio(currentWord.audioUrlUk); }}
                    className="flex items-center gap-1 px-2.5 py-1.5 bg-white/20 hover:bg-white/30 rounded-lg text-xs font-medium transition-colors"
                  >
                    <Volume2 size={14} /> 英
                  </button>
                )}
              </div>
            </div>

            {/* 音标 */}
            <div className="flex gap-4 mb-4 text-white/80">
              {currentWord.pronunciationUs && (
                <span className="text-sm font-mono">美 {currentWord.pronunciationUs}</span>
              )}
              {currentWord.pronunciationUk && (
                <span className="text-sm font-mono">英 {currentWord.pronunciationUk}</span>
              )}
            </div>

            {/* 翻译 */}
            <p className="text-xl font-medium mb-6">{currentWord.translation}</p>

            {/* 例句 */}
            {currentWord.example && (
              <div className="bg-white/15 rounded-xl p-4 mb-4">
                <p className="text-sm italic leading-relaxed">{currentWord.example}</p>
                {currentWord.exampleTranslation && (
                  <p className="text-sm text-white/70 mt-2">{currentWord.exampleTranslation}</p>
                )}
              </div>
            )}

            {/* 底部 */}
            <div className="flex items-center justify-between">
              {currentWord.category && (
                <span className="px-3 py-1 bg-white/20 rounded-full text-xs font-medium">
                  {currentWord.category}
                </span>
              )}
              <span className="text-xs text-white/50 ml-auto">点击查看详情 →</span>
            </div>
          </div>

          {/* 底部操作栏 */}
          <div className="flex items-center justify-center gap-6">
            <button
              disabled={currentIndex === 0}
              onClick={() => setCurrentIndex((i) => i - 1)}
              className="flex items-center gap-2 px-5 py-3 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-700 disabled:opacity-40 disabled:cursor-not-allowed transition-all"
            >
              <ChevronLeft size={16} /> 上一个
            </button>
            <button
              onClick={(e) => handleAddToWordBook(currentWord, e)}
              className="flex items-center gap-2 px-5 py-3 rounded-xl text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 shadow-lg shadow-brand-600/20 transition-all active:scale-95"
            >
              <BookmarkPlus size={16} /> 生词本
            </button>
            <button
              disabled={currentIndex >= words.length - 1}
              onClick={() => setCurrentIndex((i) => i + 1)}
              className="flex items-center gap-2 px-5 py-3 rounded-xl text-sm font-medium text-gray-600 dark:text-gray-300 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-700 disabled:opacity-40 disabled:cursor-not-allowed transition-all"
            >
              下一个 <ChevronRight size={16} />
            </button>
          </div>
        </>
      ) : null}
    </div>
  );
};

/** 设置面板 */
const SettingsPanel: React.FC<{
  currentSize: number;
  currentType: string;
  onApply: (size: number, type: string) => void;
  onClose: () => void;
}> = ({ currentSize, currentType, onApply, onClose }) => {
  const [size, setSize] = useState(currentSize);
  const [type, setType] = useState(currentType);

  return (
    <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-200 dark:border-gray-800 shadow-sm p-5 space-y-4">
      <h3 className="text-sm font-bold text-gray-900 dark:text-white">学习设置</h3>

      {/* 每日数量 */}
      <div>
        <label className="text-xs font-medium text-gray-500 dark:text-gray-400 mb-2 block">每日数量</label>
        <div className="flex gap-2 flex-wrap">
          {SIZE_OPTIONS.map((s) => (
            <button
              key={s}
              onClick={() => setSize(s)}
              className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
                size === s
                  ? 'bg-brand-600 text-white'
                  : 'bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700'
              }`}
            >
              {s} 词
            </button>
          ))}
        </div>
      </div>

      {/* 分类 */}
      <div>
        <label className="text-xs font-medium text-gray-500 dark:text-gray-400 mb-2 block">单词分类</label>
        <div className="flex gap-2 flex-wrap">
          <button
            onClick={() => setType('')}
            className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
              !type
                ? 'bg-brand-600 text-white'
                : 'bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700'
            }`}
          >
            综合
          </button>
          {TYPE_OPTIONS.map((t) => (
            <button
              key={t}
              onClick={() => setType(t)}
              className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
                type === t
                  ? 'bg-brand-600 text-white'
                  : 'bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700'
              }`}
            >
              {t}
            </button>
          ))}
        </div>
      </div>

      {/* 操作按钮 */}
      <div className="flex justify-end gap-2 pt-2">
        <button
          onClick={onClose}
          className="px-4 py-2 text-sm text-gray-500 hover:text-gray-700 dark:hover:text-gray-300 transition-colors"
        >
          取消
        </button>
        <button
          onClick={() => onApply(size, type)}
          className="px-4 py-2 text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 rounded-xl transition-colors"
        >
          应用
        </button>
      </div>
    </div>
  );
};

export default DailyWordListPage;
