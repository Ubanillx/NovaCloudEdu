import React from 'react';
import { ChevronLeft, ChevronRight } from 'lucide-react';
import type { ThemeVars } from './readerConstants';
import { floatingPanelStyle } from './readerConstants';

interface FloatingProgressBarProps {
  currentIndex: number;
  totalChapters: number;
  themeVars: ThemeVars;
  onGoChapter: (idx: number) => void;
}

const FloatingProgressBar: React.FC<FloatingProgressBarProps> = ({ currentIndex, totalChapters, themeVars, onGoChapter }) => {
  return (
    <div className="absolute bottom-8 left-1/2 -translate-x-1/2 z-20 animate-in slide-in-from-bottom-4 fade-in duration-500">
      <div
        className="flex items-center gap-4 px-4 py-2 rounded-2xl shadow-xl border ring-1 ring-black/5 dark:ring-white/10 transition-all hover:scale-[1.02]"
        style={{
          ...floatingPanelStyle(themeVars.bg, themeVars.border),
          boxShadow: '0 10px 40px -10px rgba(0,0,0,0.15)',
        }}
      >
        <button
          onClick={() => onGoChapter(currentIndex - 1)}
          disabled={currentIndex === 0}
          className="p-1.5 rounded-lg hover:bg-black/5 dark:hover:bg-white/10 transition-all disabled:opacity-20 flex items-center group"
          style={{ color: themeVars.accent }}
        >
          <ChevronLeft size={16} className="group-hover:-translate-x-0.5 transition-transform" />
        </button>

        <div className="flex flex-col items-center w-40 gap-1">
          <span className="text-[10px] font-bold tracking-wider uppercase opacity-30">
            进度 {currentIndex + 1} / {totalChapters}
          </span>
          <div className="w-full h-1 rounded-full bg-black/5 dark:bg-white/5 overflow-hidden">
            <div
              className="h-full transition-all duration-500 rounded-full"
              style={{
                width: `${((currentIndex + 1) / totalChapters) * 100}%`,
                background: themeVars.accent,
              }}
            />
          </div>
        </div>

        <button
          onClick={() => onGoChapter(currentIndex + 1)}
          disabled={currentIndex >= totalChapters - 1}
          className="p-1.5 rounded-lg hover:bg-black/5 dark:hover:bg-white/10 transition-all disabled:opacity-20 flex items-center group"
          style={{ color: themeVars.accent }}
        >
          <ChevronRight size={16} className="group-hover:translate-x-0.5 transition-transform" />
        </button>
      </div>
    </div>
  );
};

export default FloatingProgressBar;
