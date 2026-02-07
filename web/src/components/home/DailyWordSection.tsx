import React, { useCallback, useRef, useState, useEffect } from 'react';
import { Volume2, ChevronRight, ChevronLeft, BookOpen, Settings, X } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { apiClient, DefaultApi, Configuration } from '../../api';
import type { DailyWordResponse } from '../../api/generated/models';
import { useCache, clearCacheByPrefix } from '../../hooks/useCache';

const api = new DefaultApi(new Configuration(), '', apiClient);

const SETTINGS_KEY = 'nova_daily_word_settings';
const SIZE_OPTIONS = [5, 10, 15, 20, 30];
const CATEGORY_OPTIONS = [
  '小学三年级', '小学四年级', '小学五年级', '小学六年级',
  '初中七年级', '初中八年级', '初中九年级',
  '初中', '初中(乱序)', '外研社初中',
  '高中', '高中(乱序)', '北师高中',
  '四级', '四级(乱序)', '六级', '六级(乱序)',
  '考研', '考研(乱序)', '托福', '雅思', '雅思(乱序)', 'GRE',
];

interface WordSettings {
  size: number;
  type: string | null;
}

function loadSettings(): WordSettings {
  try {
    const raw = localStorage.getItem(SETTINGS_KEY);
    if (raw) return JSON.parse(raw);
  } catch { /* ignore */ }
  return { size: 10, type: null };
}

function saveSettings(settings: WordSettings) {
  localStorage.setItem(SETTINGS_KEY, JSON.stringify(settings));
}

export const DailyWordSection: React.FC = () => {
  const navigate = useNavigate();
  const [currentIndex, setCurrentIndex] = useState(0);
  const [showSettings, setShowSettings] = useState(false);
  const [settings, setSettings] = useState<WordSettings>(loadSettings);
  const [tempSettings, setTempSettings] = useState<WordSettings>(settings);
  const audioRef = useRef<HTMLAudioElement | null>(null);

  const todayKey = new Date().toISOString().split('T')[0];
  const cacheKey = `daily_words_${todayKey}_${settings.size}_${settings.type || 'all'}`;

  const fetcher = useCallback(async () => {
    const response = await api.getTodayWords({
      size: settings.size,
      type: settings.type || undefined,
    });
    if (response.data.code === 0 && response.data.data) {
      return response.data.data as DailyWordResponse[];
    }
    return [];
  }, [settings.size, settings.type]);

  const { data: words, loading } = useCache<DailyWordResponse[]>({
    cacheKey,
    fetcher,
    expiryMs: 60 * 60 * 1000,
  });

  const currentWord = words && words.length > 0 ? words[currentIndex] : null;

  const handlePrev = () => {
    if (words && currentIndex > 0) setCurrentIndex((i) => i - 1);
  };

  const handleNext = () => {
    if (words && currentIndex < words.length - 1) setCurrentIndex((i) => i + 1);
  };

  const playAudio = (url?: string) => {
    if (!url) return;
    if (audioRef.current) audioRef.current.pause();
    audioRef.current = new Audio(url);
    audioRef.current.play().catch(() => {});
  };

  const applySettings = () => {
    saveSettings(tempSettings);
    setSettings(tempSettings);
    setCurrentIndex(0);
    setShowSettings(false);
    clearCacheByPrefix('daily_words_');
  };

  useEffect(() => {
    if (showSettings) setTempSettings(settings);
  }, [showSettings, settings]);

  if (loading) {
    return (
      <div className="bg-white dark:bg-gray-900 p-6 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm relative overflow-hidden">
        <div className="animate-pulse space-y-3">
          <div className="h-3 bg-gray-200 dark:bg-gray-800 rounded w-16" />
          <div className="h-8 bg-gray-200 dark:bg-gray-800 rounded w-32" />
          <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-24" />
          <div className="h-4 bg-gray-200 dark:bg-gray-800 rounded w-40" />
          <div className="h-16 bg-gray-100 dark:bg-gray-800 rounded-lg" />
        </div>
      </div>
    );
  }

  if (!currentWord) {
    return null;
  }

  const progress = words ? (currentIndex + 1) / words.length : 0;

  return (
    <div className="bg-white dark:bg-gray-900 p-6 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm relative overflow-hidden">
      <div className="absolute top-0 right-0 p-4 opacity-5">
        <BookOpen className="w-24 h-24 text-brand-600 dark:text-brand-400" />
      </div>

      {/* Header */}
      <div className="flex items-center justify-between mb-2">
        <h3 className="text-xs font-semibold text-brand-600 dark:text-brand-400 uppercase tracking-wider">每日单词</h3>
        <div className="flex items-center gap-2">
          {settings.type && (
            <span className="text-[10px] bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 px-1.5 py-0.5 rounded">{settings.type}</span>
          )}
          <button
            onClick={() => setShowSettings(true)}
            className="p-1 text-gray-400 dark:text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 transition-colors"
            title="设置"
          >
            <Settings size={14} />
          </button>
        </div>
      </div>

      {/* Progress */}
      {words && words.length > 1 && (
        <div className="mb-3">
          <div className="flex items-center justify-between text-[10px] text-gray-400 dark:text-gray-500 mb-1">
            <span>{currentIndex + 1} / {words.length}</span>
          </div>
          <div className="h-1 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
            <div
              className="h-full bg-brand-500 rounded-full transition-all duration-300"
              style={{ width: `${progress * 100}%` }}
            />
          </div>
        </div>
      )}

      {/* Word */}
      <button
        onClick={() => navigate(`/daily-word/${currentWord.id}`)}
        className="text-left w-full hover:opacity-90 transition-opacity"
      >
        <h2 className="text-2xl font-bold mb-1 text-gray-900 dark:text-white">{currentWord.word}</h2>
      </button>

      {/* Pronunciation */}
      <div className="flex items-center gap-3 text-sm text-gray-500 dark:text-gray-400 font-mono mb-3">
        {currentWord.pronunciationUs && (
          <div className="flex items-center gap-1">
            <span className="text-xs text-gray-400 dark:text-gray-500">美</span>
            <span>{currentWord.pronunciationUs}</span>
            {currentWord.audioUrlUs && (
              <button
                onClick={() => playAudio(currentWord.audioUrlUs)}
                className="p-0.5 hover:bg-gray-100 dark:hover:bg-gray-800 rounded transition-colors text-brand-500"
              >
                <Volume2 size={14} />
              </button>
            )}
          </div>
        )}
        {currentWord.pronunciationUk && (
          <div className="flex items-center gap-1">
            <span className="text-xs text-gray-400 dark:text-gray-500">英</span>
            <span>{currentWord.pronunciationUk}</span>
            {currentWord.audioUrlUk && (
              <button
                onClick={() => playAudio(currentWord.audioUrlUk)}
                className="p-0.5 hover:bg-gray-100 dark:hover:bg-gray-800 rounded transition-colors text-brand-500"
              >
                <Volume2 size={14} />
              </button>
            )}
          </div>
        )}
      </div>

      {/* Translation */}
      <p className="text-gray-600 dark:text-gray-300 text-sm mb-3">{currentWord.translation}</p>

      {/* Example */}
      {currentWord.example && (
        <div className="bg-brand-50 dark:bg-brand-900/10 p-3 rounded-lg mb-3">
          <p className="text-xs text-gray-700 dark:text-gray-300 italic">"{currentWord.example}"</p>
          {currentWord.exampleTranslation && (
            <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">{currentWord.exampleTranslation}</p>
          )}
        </div>
      )}

      {/* Footer Actions - 上一个/下一个 */}
      <div className="flex items-center justify-between mt-2">
        <div className="flex items-center gap-2">
          {words && words.length > 1 && (
            <>
              <button
                onClick={handlePrev}
                disabled={currentIndex === 0}
                className="p-1 text-gray-400 dark:text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
              >
                <ChevronLeft size={16} />
              </button>
              <button
                onClick={handleNext}
                disabled={currentIndex === (words.length - 1)}
                className="p-1 text-gray-400 dark:text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
              >
                <ChevronRight size={16} />
              </button>
            </>
          )}
        </div>
        <button
          onClick={() => navigate('/daily-words')}
          className="text-xs text-gray-400 dark:text-gray-500 hover:text-brand-600 dark:hover:text-brand-400 flex items-center gap-1 transition-colors"
        >
          查看更多
          <ChevronRight size={14} />
        </button>
      </div>

      {/* Settings Panel */}
      {showSettings && (
        <div className="absolute inset-0 bg-gray-900/95 backdrop-blur-sm rounded-xl z-10 p-5 flex flex-col animate-in fade-in duration-200">
          <div className="flex items-center justify-between mb-4">
            <h4 className="text-sm font-bold">单词设置</h4>
            <button onClick={() => setShowSettings(false)} className="text-white/60 hover:text-white">
              <X size={16} />
            </button>
          </div>

          {/* 数量选择 */}
          <div className="mb-4">
            <label className="text-xs text-white/60 mb-2 block">每日数量</label>
            <div className="flex flex-wrap gap-1.5">
              {SIZE_OPTIONS.map((s) => (
                <button
                  key={s}
                  onClick={() => setTempSettings((prev) => ({ ...prev, size: s }))}
                  className={`px-2.5 py-1 text-xs rounded-lg transition-colors ${
                    tempSettings.size === s
                      ? 'bg-white text-brand-700 font-bold'
                      : 'bg-white/15 hover:bg-white/25'
                  }`}
                >
                  {s}个
                </button>
              ))}
            </div>
          </div>

          {/* 分类选择 */}
          <div className="flex-1 min-h-0 mb-4">
            <label className="text-xs text-white/60 mb-2 block">词汇分类</label>
            <div className="flex flex-wrap gap-1.5 max-h-32 overflow-y-auto pr-1">
              <button
                onClick={() => setTempSettings((prev) => ({ ...prev, type: null }))}
                className={`px-2.5 py-1 text-xs rounded-lg transition-colors ${
                  !tempSettings.type
                    ? 'bg-white text-brand-700 font-bold'
                    : 'bg-white/15 hover:bg-white/25'
                }`}
              >
                随机
              </button>
              {CATEGORY_OPTIONS.map((c) => (
                <button
                  key={c}
                  onClick={() => setTempSettings((prev) => ({ ...prev, type: c }))}
                  className={`px-2.5 py-1 text-xs rounded-lg transition-colors ${
                    tempSettings.type === c
                      ? 'bg-white text-brand-700 font-bold'
                      : 'bg-white/15 hover:bg-white/25'
                  }`}
                >
                  {c}
                </button>
              ))}
            </div>
          </div>

          {/* 应用 */}
          <button
            onClick={applySettings}
            className="w-full py-2 bg-white text-brand-700 font-bold text-sm rounded-lg hover:bg-white/90 transition-colors"
          >
            应用设置
          </button>
        </div>
      )}
    </div>
  );
};
