import React, { useState } from 'react';
import { Menu, Bookmark, Trash2 } from 'lucide-react';
import type { ChapterDTO, ReadingBookmarkDTO } from '../../api/generated/models';
import type { ThemeVars } from './readerConstants';
import { floatingPanelStyle } from './readerConstants';

interface ReaderSidebarProps {
  chapters: ChapterDTO[];
  currentIndex: number;
  themeVars: ThemeVars;
  onGoChapter: (idx: number) => void;
  bookmarks?: ReadingBookmarkDTO[];
  onDeleteBookmark?: (bookmarkId: number) => void;
}

type SidebarTab = 'chapters' | 'bookmarks';

const ReaderSidebar: React.FC<ReaderSidebarProps> = ({ chapters, currentIndex, themeVars, onGoChapter, bookmarks = [], onDeleteBookmark }) => {
  const [tab, setTab] = useState<SidebarTab>('chapters');

  return (
    <div
      className="absolute top-20 left-8 bottom-8 w-64 z-30 shadow-2xl animate-in fade-in duration-200 rounded-2xl border flex flex-col overflow-hidden ring-1 ring-black/5 dark:ring-white/10"
      style={floatingPanelStyle(themeVars.bg, themeVars.border)}
    >
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* Tab 头 */}
        <div className="border-b transition-all duration-200" style={{ background: themeVars.bg, borderColor: themeVars.border }}>
          <div className="flex px-3 pt-3 pb-0 gap-1">
            {([
              { key: 'chapters' as SidebarTab, label: '目录', icon: <Menu size={14} />, count: chapters.length },
              { key: 'bookmarks' as SidebarTab, label: '书签', icon: <Bookmark size={14} />, count: bookmarks.length },
            ]).map(t => (
              <button
                key={t.key}
                onClick={() => setTab(t.key)}
                className="flex items-center gap-1.5 px-3 py-2 rounded-t-lg text-xs font-bold transition-all"
                style={{
                  color: tab === t.key ? themeVars.accent : themeVars.muted,
                  background: tab === t.key ? `${themeVars.accent}08` : 'transparent',
                  borderBottom: tab === t.key ? `2px solid ${themeVars.accent}` : '2px solid transparent',
                }}
              >
                {t.icon}
                {t.label}
                <span className="text-[10px] font-bold px-1.5 py-0.5 rounded-md bg-black/5 dark:bg-white/5 opacity-50">
                  {t.count}
                </span>
              </button>
            ))}
          </div>
        </div>

        {/* Tab 内容 */}
        {tab === 'chapters' && (
          <div className="flex-1 overflow-y-auto custom-scrollbar p-3 space-y-1">
            {chapters.map((ch, idx) => {
              const isActive = idx === currentIndex;
              return (
                <button
                  key={String(ch.id ?? idx)}
                  onClick={() => onGoChapter(idx)}
                  className="w-full text-left px-3 py-2.5 rounded-xl text-[13px] transition-all relative group flex items-start gap-3 border border-transparent hover:bg-black/5 dark:hover:bg-white/5"
                  style={{
                    background: isActive ? `${themeVars.accent}08` : 'transparent',
                    color: isActive ? themeVars.accent : themeVars.text,
                    borderColor: isActive ? `${themeVars.accent}20` : 'transparent',
                    fontWeight: isActive ? 600 : 400,
                  }}
                >
                  <span className="flex-shrink-0 w-5 text-[10px] font-mono mt-0.5 opacity-30 group-hover:opacity-60">
                    {String(idx + 1).padStart(2, '0')}
                  </span>
                  <span className="truncate flex-1 opacity-90 group-hover:opacity-100">
                    {ch.title || `第 ${(ch.chapterIndex ?? idx) + 1} 章`}
                  </span>
                  {isActive && (
                    <div className="absolute right-2 top-1/2 -translate-y-1/2 w-1 h-1 rounded-full bg-current" />
                  )}
                </button>
              );
            })}
          </div>
        )}

        {tab === 'bookmarks' && (
          <div className="flex-1 overflow-y-auto custom-scrollbar p-3 space-y-1">
            {bookmarks.length === 0 ? (
              <div className="flex flex-col items-center justify-center py-12 gap-3" style={{ color: themeVars.muted }}>
                <Bookmark size={32} className="opacity-20" />
                <p className="text-xs opacity-50">暂无书签</p>
                <p className="text-[10px] opacity-30">点击顶栏书签图标添加</p>
              </div>
            ) : (
              bookmarks.map(bm => {
                const isActive = bm.chapterIndex === (chapters[currentIndex]?.chapterIndex ?? currentIndex);
                return (
                  <div
                    key={String(bm.id)}
                    className="w-full text-left px-3 py-2.5 rounded-xl text-[13px] transition-all relative group flex items-start gap-3 border border-transparent hover:bg-black/5 dark:hover:bg-white/5"
                    style={{
                      background: isActive ? `${themeVars.accent}08` : 'transparent',
                      borderColor: isActive ? `${themeVars.accent}20` : 'transparent',
                    }}
                  >
                    <Bookmark size={14} className="flex-shrink-0 mt-0.5 text-amber-500" fill="currentColor" />
                    <button
                      onClick={() => {
                        const targetIdx = chapters.findIndex(ch => ch.chapterIndex === bm.chapterIndex);
                        if (targetIdx >= 0) onGoChapter(targetIdx);
                      }}
                      className="truncate flex-1 text-left opacity-90 group-hover:opacity-100"
                      style={{ color: isActive ? themeVars.accent : themeVars.text, fontWeight: isActive ? 600 : 400 }}
                    >
                      {bm.bookmarkTitle || `第 ${(bm.chapterIndex ?? 0) + 1} 章`}
                    </button>
                    {onDeleteBookmark && (
                      <button
                        onClick={() => onDeleteBookmark(bm.id as unknown as number)}
                        className="flex-shrink-0 opacity-0 group-hover:opacity-60 hover:!opacity-100 transition-opacity p-0.5 rounded hover:bg-red-500/10 text-red-500"
                        title="删除书签"
                      >
                        <Trash2 size={12} />
                      </button>
                    )}
                  </div>
                );
              })
            )}
          </div>
        )}
      </div>
    </div>
  );
};

export default ReaderSidebar;
