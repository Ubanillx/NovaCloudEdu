import React from 'react';
import { Loader2, Check, AlertCircle, Search, Paintbrush, Image, Wrench } from 'lucide-react';
import type { GeneratedSlide, SlideStatus } from '../../hooks/usePptGeneration';

interface SlideListPanelProps {
  slides: GeneratedSlide[];
  selectedIndex: number;
  onSelect: (index: number) => void;
  totalSlides: number;
  isGenerating: boolean;
}

/** 状态配置：图标 + 颜色 + 是否有动画 */
const statusConfig: Record<SlideStatus, {
  icon: React.ReactNode;
  bg: string;
  text: string;
  animate?: boolean;
}> = {
  pending:     { icon: null, bg: 'bg-gray-500/60', text: 'text-gray-300', animate: false },
  generating:  { icon: <Loader2 className="w-3 h-3 animate-spin" />, bg: 'bg-blue-500/80', text: 'text-blue-100', animate: true },
  designing:   { icon: <Paintbrush className="w-3 h-3" />, bg: 'bg-purple-500/80', text: 'text-purple-100', animate: true },
  rendering:   { icon: <Image className="w-3 h-3" />, bg: 'bg-cyan-500/80', text: 'text-cyan-100', animate: true },
  done:        { icon: <Check className="w-3 h-3" />, bg: 'bg-green-500/80', text: 'text-green-100' },
  evaluating:  { icon: <Search className="w-3 h-3" />, bg: 'bg-amber-500/80', text: 'text-amber-100', animate: true },
  repairing:   { icon: <Wrench className="w-3 h-3" />, bg: 'bg-orange-500/80', text: 'text-orange-100', animate: true },
  failed:      { icon: <AlertCircle className="w-3 h-3" />, bg: 'bg-red-500/80', text: 'text-red-100' },
};

export const SlideListPanel: React.FC<SlideListPanelProps> = ({
  slides,
  selectedIndex,
  onSelect,
  totalSlides,
  isGenerating,
}) => {
  return (
    <div className="w-full h-full overflow-y-auto custom-scrollbar space-y-2">
      {slides.map((slide, idx) => {
        const bgUrl = slide.previewImageUrl;
        const isSelected = idx === selectedIndex;
        const status = slide.status || (bgUrl ? 'done' : 'pending');
        const cfg = statusConfig[status] || statusConfig.pending;
        const isActive = status !== 'pending' && status !== 'done';

        return (
          <button
            key={idx}
            onClick={() => onSelect(idx)}
            className={`
              w-full rounded-xl overflow-hidden border-2 transition-all duration-300 group
              ${isSelected
                ? 'border-brand-500 shadow-lg shadow-brand-500/20'
                : isActive
                  ? 'border-blue-400/50 dark:border-blue-500/40'
                  : 'border-gray-100 dark:border-gray-800 hover:border-brand-300 dark:hover:border-brand-600'
              }
              ${slide.isNew ? 'animate-slideInRight' : ''}
            `}
          >
            <div className="relative aspect-video bg-gray-800 overflow-hidden">
              {bgUrl ? (
                <img src={bgUrl} alt={`第${idx + 1}页`} className="w-full h-full object-cover" />
              ) : (
                <div className={`w-full h-full ${
                  isActive
                    ? 'bg-gradient-to-br from-gray-700 to-gray-800 animate-pulse'
                    : 'bg-gradient-to-br from-gray-700 to-gray-900'
                }`} />
              )}
              {/* 页码 */}
              <div className="absolute bottom-1 left-1 text-[10px] text-white/70 bg-black/40 px-1 rounded">
                {idx + 1}
              </div>
              {/* 状态徽章 */}
              {status !== 'done' && (
                <div className={`absolute top-1 right-1 flex items-center gap-0.5 ${cfg.bg} ${cfg.text} px-1.5 py-0.5 rounded text-[9px] font-medium`}>
                  {cfg.icon}
                  <span>{slide.statusLabel || status}</span>
                </div>
              )}
              {/* 完成勾 */}
              {status === 'done' && bgUrl && (
                <div className="absolute top-1 right-1 bg-green-500/80 text-white rounded-full p-0.5">
                  <Check className="w-2.5 h-2.5" />
                </div>
              )}
            </div>
          </button>
        );
      })}

      {/* 兜底骨架：仅在没有占位符时显示 */}
      {isGenerating && slides.length === 0 && totalSlides > 0 && (
        <>
          {Array.from({ length: totalSlides }).map((_, i) => (
            <div
              key={`skeleton-${i}`}
              className="w-full rounded-xl overflow-hidden border-2 border-dashed border-gray-200 dark:border-gray-700"
            >
              <div className="aspect-video bg-gray-100 dark:bg-gray-800 animate-pulse" />
            </div>
          ))}
        </>
      )}
    </div>
  );
};
