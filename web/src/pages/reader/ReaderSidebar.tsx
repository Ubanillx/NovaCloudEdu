import React from 'react';
import { Menu } from 'lucide-react';
import type { ChapterDTO } from '../../api/generated/models';
import type { ThemeVars } from './readerConstants';
import { floatingPanelStyle } from './readerConstants';

interface ReaderSidebarProps {
  chapters: ChapterDTO[];
  currentIndex: number;
  themeVars: ThemeVars;
  onGoChapter: (idx: number) => void;
}

const ReaderSidebar: React.FC<ReaderSidebarProps> = ({ chapters, currentIndex, themeVars, onGoChapter }) => {
  return (
    <div
      className="absolute top-20 left-8 bottom-8 w-64 z-30 shadow-2xl animate-in slide-in-from-left-4 fade-in duration-300 rounded-2xl border flex flex-col overflow-hidden ring-1 ring-black/5 dark:ring-white/10"
      style={floatingPanelStyle(themeVars.bg, themeVars.border)}
    >
      <div className="flex-1 flex flex-col overflow-hidden">
        <div
          className="flex items-center justify-between px-6 py-4 border-b transition-all duration-200"
          style={{ background: themeVars.bg, borderColor: themeVars.border }}
        >
          <h2 className="text-sm font-bold flex items-center gap-2 opacity-90">
            <Menu size={16} className="text-brand-500" />
            目录
          </h2>
          <span className="text-[10px] font-bold px-2 py-0.5 rounded-md bg-black/5 dark:bg-white/5 uppercase tracking-wider opacity-50">
            {chapters.length}
          </span>
        </div>
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
      </div>
    </div>
  );
};

export default ReaderSidebar;
