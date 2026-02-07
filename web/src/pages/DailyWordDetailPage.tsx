import React, { useState, useEffect, useCallback, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { ArrowLeft, Volume2, BookOpen, Calendar, BookmarkPlus, CheckCircle2, Languages, ArrowRightLeft, List, Link2, Info } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../api';
import type { DailyWordResponse } from '../api/generated/models';
import toast from '../components/ui/Toast';

const api = new DefaultApi(new Configuration(), '', apiClient);

const CACHE_PREFIX = 'nova_cache_';

const DIFFICULTY_OPTIONS = [
  { value: 1, label: '简单', color: 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 border-green-200 dark:border-green-800' },
  { value: 2, label: '中等', color: 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800' },
  { value: 3, label: '困难', color: 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800' },
];

// --- notes JSON 解析（对齐 app WordNotes 模型）---
interface WordPhrase { phrase: string; meaning?: string; }
interface RelatedWord { word: string; meaning?: string; }
interface WordNotes {
  englishDefinitions?: string[];
  synonyms?: string[];
  phrases?: WordPhrase[];
  relatedWords?: RelatedWord[];
}

function parseNotes(raw?: string): WordNotes | null {
  if (!raw) return null;
  try {
    const json = JSON.parse(raw);
    return {
      englishDefinitions: json.english_definitions ?? json.englishDefinitions,
      synonyms: json.synonyms,
      phrases: json.phrases?.map((p: { phrase?: string; meaning?: string }) => ({
        phrase: p.phrase ?? '',
        meaning: p.meaning,
      })),
      relatedWords: (json.related_words ?? json.relatedWords)?.map((r: { word?: string; meaning?: string }) => ({
        word: r.word ?? '',
        meaning: r.meaning,
      })),
    };
  } catch {
    return null;
  }
}

function notesHasContent(n: WordNotes | null): boolean {
  if (!n) return false;
  return !!(
    (n.englishDefinitions && n.englishDefinitions.length) ||
    (n.synonyms && n.synonyms.length) ||
    (n.phrases && n.phrases.length) ||
    (n.relatedWords && n.relatedWords.length)
  );
}

// --- 缓存 ---
function getCachedWord(id: string): DailyWordResponse | null {
  try {
    // 从今日单词缓存中查找
    const todayRaw = localStorage.getItem('nova_cache_today_words');
    if (todayRaw) {
      const entry = JSON.parse(todayRaw);
      const words: DailyWordResponse[] = entry.data;
      if (Array.isArray(words)) {
        const found = words.find((w) => String(w.id) === id);
        if (found) return found;
      }
    }
    // 从首页单词缓存查找
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key?.startsWith(CACHE_PREFIX + 'daily_words_')) {
        const raw = localStorage.getItem(key);
        if (!raw) continue;
        const entry = JSON.parse(raw);
        const words: DailyWordResponse[] = entry.data;
        if (Array.isArray(words)) {
          const found = words.find((w) => String(w.id) === id);
          if (found) return found;
        }
      }
    }
  } catch { /* ignore */ }
  return null;
}

function cacheWordDetail(word: DailyWordResponse): void {
  try {
    const key = `${CACHE_PREFIX}daily_word_detail_${word.id}`;
    localStorage.setItem(key, JSON.stringify({ data: word, timestamp: Date.now(), expiry: 60 * 60 * 1000 }));
  } catch { /* ignore */ }
}

function getCachedWordDetail(id: string): DailyWordResponse | null {
  try {
    const key = `${CACHE_PREFIX}daily_word_detail_${id}`;
    const raw = localStorage.getItem(key);
    if (!raw) return null;
    const entry = JSON.parse(raw);
    if (Date.now() > entry.timestamp + entry.expiry) {
      localStorage.removeItem(key);
      return null;
    }
    return entry.data;
  } catch { return null; }
}

const DailyWordDetailPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();

  const goBack = () => navigate(-1);
  const [word, setWord] = useState<DailyWordResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const audioRef = useRef<HTMLAudioElement | null>(null);

  const [isInWordBook, setIsInWordBook] = useState(false);
  const [isStudied, setIsStudied] = useState(false);
  const [actionLoading, setActionLoading] = useState(false);

  const handleAddToWordBook = async () => {
    if (!id || actionLoading || isInWordBook) return;
    setActionLoading(true);
    try {
      await api.addToWordBook({ wordId: id as unknown as number });
      setIsInWordBook(true);
      toast.success('已加入生词本');
    } catch { toast.error('操作失败'); }
    finally { setActionLoading(false); }
  };

  const handleStudyWord = async () => {
    if (!id || actionLoading || isStudied) return;
    setActionLoading(true);
    try {
      await api.studyWord({ wordId: id as unknown as number });
      setIsStudied(true);
      toast.success('已标记为已学');
    } catch { toast.error('操作失败'); }
    finally { setActionLoading(false); }
  };

  const fetchDetail = useCallback(async () => {
    if (!id) return;
    setLoading(true);
    setError(null);

    const cached = getCachedWordDetail(id) || getCachedWord(id);
    if (cached) {
      setWord(cached);
      setLoading(false);
      try {
        const response = await api.getDailyWord({ id: id as unknown as number });
        if (response.data.code === 0 && response.data.data) {
          setWord(response.data.data);
          cacheWordDetail(response.data.data);
        }
      } catch { /* 已有缓存，静默 */ }
      return;
    }

    try {
      const response = await api.getDailyWord({ id: id as unknown as number });
      if (response.data.code === 0 && response.data.data) {
        setWord(response.data.data);
        cacheWordDetail(response.data.data);
      } else {
        setError(response.data.message || '获取单词详情失败');
      }
    } catch {
      setError('网络错误，请稍后重试');
    } finally {
      setLoading(false);
    }
  }, [id]);

  useEffect(() => {
    fetchDetail();
  }, [fetchDetail]);

  const playAudio = (url?: string) => {
    if (!url) return;
    if (audioRef.current) audioRef.current.pause();
    audioRef.current = new Audio(url);
    audioRef.current.play().catch(() => {});
  };

  if (loading) {
    return (
      <div className="max-w-3xl mx-auto animate-pulse space-y-6">
        <div className="h-5 bg-gray-200 dark:bg-gray-800 rounded w-16" />
        <div className="bg-gradient-to-r from-brand-500 to-accent-500 rounded-2xl p-8">
          <div className="h-12 bg-white/20 rounded w-48 mb-4" />
          <div className="h-6 bg-white/20 rounded w-32 mb-3" />
          <div className="h-5 bg-white/20 rounded w-40" />
        </div>
        <div className="bg-white dark:bg-gray-900 rounded-xl p-6 space-y-4">
          <div className="h-5 bg-gray-200 dark:bg-gray-800 rounded w-24" />
          <div className="h-16 bg-gray-100 dark:bg-gray-800 rounded-xl" />
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="max-w-3xl mx-auto">
        <div className="bg-white dark:bg-gray-900 rounded-2xl border border-gray-200 dark:border-gray-800 p-12 text-center">
          <div className="w-16 h-16 bg-error-bg dark:bg-error/10 rounded-full flex items-center justify-center mx-auto mb-4">
            <BookOpen size={32} className="text-error" />
          </div>
          <h2 className="text-xl font-bold text-gray-900 dark:text-white mb-2">加载失败</h2>
          <p className="text-gray-500 dark:text-gray-400 mb-6">{error}</p>
          <div className="flex items-center justify-center gap-3">
            <button onClick={goBack} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 border border-gray-200 dark:border-gray-700 rounded-xl transition-colors">返回</button>
            <button onClick={fetchDetail} className="px-4 py-2 text-sm font-bold text-white bg-brand-600 hover:bg-brand-700 rounded-xl transition-colors">重试</button>
          </div>
        </div>
      </div>
    );
  }

  if (!word) return null;

  const difficultyOption = DIFFICULTY_OPTIONS.find((d) => d.value === word.difficulty);
  const notes = parseNotes(word.notes);
  const hasNotes = notesHasContent(notes);

  return (
    <div className="max-w-3xl mx-auto animate-in fade-in duration-500 space-y-5">
      {/* 返回 */}
      <button
        onClick={goBack}
        className="flex items-center gap-2 text-sm font-medium text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 transition-colors group"
      >
        <ArrowLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
        返回
      </button>

      {/* 顶部渐变卡片 */}
      <div className="bg-gradient-to-br from-brand-500 to-accent-500 rounded-2xl p-8 text-white">
        <h1 className="text-4xl md:text-5xl font-black mb-3">{word.word}</h1>

        {/* 音标 + 发音 */}
        <div className="flex flex-wrap items-center gap-5 mb-4">
          {word.pronunciationUs && (
            <div className="flex items-center gap-2">
              <span className="text-xs text-white/60">美</span>
              <span className="text-lg font-mono">{word.pronunciationUs}</span>
              {word.audioUrlUs && (
                <button onClick={() => playAudio(word.audioUrlUs)} className="p-1.5 bg-white/20 hover:bg-white/30 rounded-full transition-colors">
                  <Volume2 size={16} />
                </button>
              )}
            </div>
          )}
          {word.pronunciationUk && (
            <div className="flex items-center gap-2">
              <span className="text-xs text-white/60">英</span>
              <span className="text-lg font-mono">{word.pronunciationUk}</span>
              {word.audioUrlUk && (
                <button onClick={() => playAudio(word.audioUrlUk)} className="p-1.5 bg-white/20 hover:bg-white/30 rounded-full transition-colors">
                  <Volume2 size={16} />
                </button>
              )}
            </div>
          )}
        </div>

        {/* 翻译 */}
        <p className="text-xl text-white/90">{word.translation}</p>
      </div>

      {/* 例句卡片 */}
      {word.example && (
        <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm p-5">
          <div className="flex items-center gap-2 mb-3">
            <div className="w-8 h-8 bg-brand-50 dark:bg-brand-900/20 rounded-lg flex items-center justify-center">
              <span className="text-brand-600 dark:text-brand-400 text-lg">"</span>
            </div>
            <h3 className="text-sm font-bold text-gray-900 dark:text-white">例句</h3>
          </div>
          <p className="text-gray-800 dark:text-gray-200 italic leading-relaxed">{word.example}</p>
          {word.exampleTranslation && (
            <p className="text-sm text-gray-500 dark:text-gray-400 mt-2">{word.exampleTranslation}</p>
          )}
        </div>
      )}

      {/* 单词信息卡片 */}
      <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm p-5">
        <div className="flex items-center gap-2 mb-3">
          <div className="w-8 h-8 bg-blue-50 dark:bg-blue-900/20 rounded-lg flex items-center justify-center">
            <Info size={16} className="text-blue-500" />
          </div>
          <h3 className="text-sm font-bold text-gray-900 dark:text-white">单词信息</h3>
        </div>
        <div className="space-y-2.5">
          <div className="flex items-center justify-between text-sm">
            <span className="text-gray-500 dark:text-gray-400">分类</span>
            <span className="font-medium text-gray-900 dark:text-white">{word.category || '未分类'}</span>
          </div>
          <div className="flex items-center justify-between text-sm">
            <span className="text-gray-500 dark:text-gray-400">难度</span>
            <span className="font-medium text-gray-900 dark:text-white">{word.difficultyDesc || difficultyOption?.label || '未知'}</span>
          </div>
          {word.publishDate && (
            <div className="flex items-center justify-between text-sm">
              <span className="text-gray-500 dark:text-gray-400">发布日期</span>
              <span className="font-medium text-gray-900 dark:text-white flex items-center gap-1">
                <Calendar size={12} /> {word.publishDate}
              </span>
            </div>
          )}
        </div>
      </div>

      {/* notes 解析内容 */}
      {hasNotes && notes && (
        <>
          {/* 英文释义 */}
          {notes.englishDefinitions && notes.englishDefinitions.length > 0 && (
            <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm p-5">
              <div className="flex items-center gap-2 mb-3">
                <div className="w-8 h-8 bg-indigo-50 dark:bg-indigo-900/20 rounded-lg flex items-center justify-center">
                  <Languages size={16} className="text-indigo-500" />
                </div>
                <h3 className="text-sm font-bold text-gray-900 dark:text-white">英文释义</h3>
              </div>
              <ul className="space-y-2">
                {notes.englishDefinitions.map((def, i) => (
                  <li key={i} className="flex gap-2 text-sm text-gray-600 dark:text-gray-300 leading-relaxed">
                    <span className="text-gray-400 mt-0.5">•</span>
                    <span>{def}</span>
                  </li>
                ))}
              </ul>
            </div>
          )}

          {/* 同义词 */}
          {notes.synonyms && notes.synonyms.length > 0 && (
            <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm p-5">
              <div className="flex items-center gap-2 mb-3">
                <div className="w-8 h-8 bg-green-50 dark:bg-green-900/20 rounded-lg flex items-center justify-center">
                  <ArrowRightLeft size={16} className="text-green-500" />
                </div>
                <h3 className="text-sm font-bold text-gray-900 dark:text-white">同义词</h3>
              </div>
              <div className="flex flex-wrap gap-2">
                {notes.synonyms.map((syn, i) => (
                  <span key={i} className="px-3 py-1 bg-green-50 dark:bg-green-900/20 text-green-700 dark:text-green-400 rounded-full text-sm font-medium">
                    {syn}
                  </span>
                ))}
              </div>
            </div>
          )}

          {/* 常用短语 */}
          {notes.phrases && notes.phrases.length > 0 && (
            <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm p-5">
              <div className="flex items-center gap-2 mb-3">
                <div className="w-8 h-8 bg-brand-50 dark:bg-brand-900/20 rounded-lg flex items-center justify-center">
                  <List size={16} className="text-brand-500" />
                </div>
                <h3 className="text-sm font-bold text-gray-900 dark:text-white">常用短语</h3>
              </div>
              <div className="space-y-3">
                {notes.phrases.map((p, i) => (
                  <div key={i}>
                    <p className="text-sm font-semibold text-gray-800 dark:text-gray-200">{p.phrase}</p>
                    {p.meaning && (
                      <p className="text-xs text-gray-500 dark:text-gray-400 mt-0.5">{p.meaning}</p>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* 相关词汇 */}
          {notes.relatedWords && notes.relatedWords.length > 0 && (
            <div className="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 shadow-sm p-5">
              <div className="flex items-center gap-2 mb-3">
                <div className="w-8 h-8 bg-amber-50 dark:bg-amber-900/20 rounded-lg flex items-center justify-center">
                  <Link2 size={16} className="text-amber-500" />
                </div>
                <h3 className="text-sm font-bold text-gray-900 dark:text-white">相关词汇</h3>
              </div>
              <div className="space-y-2.5">
                {notes.relatedWords.map((rw, i) => (
                  <div key={i} className="flex items-start gap-3">
                    <span className="px-2.5 py-0.5 bg-amber-50 dark:bg-amber-900/20 text-amber-700 dark:text-amber-400 rounded-lg text-sm font-semibold whitespace-nowrap">
                      {rw.word}
                    </span>
                    {rw.meaning && (
                      <span className="text-sm text-gray-500 dark:text-gray-400">{rw.meaning}</span>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}
        </>
      )}

      {/* 操作按钮 */}
      <div className="flex items-center gap-3">
        <button
          onClick={handleAddToWordBook}
          disabled={actionLoading || isInWordBook}
          className={`flex-1 flex items-center justify-center gap-2 px-4 py-3 rounded-xl text-sm font-bold transition-all active:scale-95 ${
            isInWordBook
              ? 'bg-brand-50 dark:bg-brand-900/20 text-brand-600 dark:text-brand-400 border border-brand-200 dark:border-brand-800'
              : 'bg-brand-600 hover:bg-brand-700 text-white shadow-lg shadow-brand-600/20'
          }`}
        >
          <BookmarkPlus size={18} />
          {isInWordBook ? '已在生词本' : '加入生词本'}
        </button>
        <button
          onClick={handleStudyWord}
          disabled={actionLoading || isStudied}
          className={`flex-1 flex items-center justify-center gap-2 px-4 py-3 rounded-xl text-sm font-bold transition-all active:scale-95 ${
            isStudied
              ? 'bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 border border-green-200 dark:border-green-800'
              : 'bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 border border-gray-200 dark:border-gray-700'
          }`}
        >
          <CheckCircle2 size={18} />
          {isStudied ? '已学习' : '标记已学'}
        </button>
      </div>
    </div>
  );
};

export default DailyWordDetailPage;
