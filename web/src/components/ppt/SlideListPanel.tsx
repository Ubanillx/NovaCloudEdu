import React from 'react';
import type { GeneratedSlide } from '../../hooks/usePptGeneration';

interface SlideListPanelProps {
  slides: GeneratedSlide[];
  selectedIndex: number;
  onSelect: (index: number) => void;
  totalSlides: number;
  isGenerating: boolean;
}

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

        return (
          <button
            key={idx}
            onClick={() => onSelect(idx)}
            className={`
              w-full rounded-xl overflow-hidden border-2 transition-all duration-300 group
              ${isSelected
                ? 'border-brand-500 shadow-lg shadow-brand-500/20'
                : 'border-gray-100 dark:border-gray-800 hover:border-brand-300 dark:hover:border-brand-600'
              }
              ${slide.isNew ? 'animate-slideInRight' : ''}
            `}
          >
            {/* 缩略图：后端渲染图片 */}
            <div className="relative aspect-video bg-gray-800 overflow-hidden">
              {bgUrl ? (
                <img src={bgUrl} alt={`第${idx + 1}页`} className="w-full h-full object-cover" />
              ) : (
                <div className="w-full h-full bg-gradient-to-br from-gray-600 to-gray-800" />
              )}
              {/* 页码 */}
              <div className="absolute bottom-1 left-1 text-[10px] text-white/70 bg-black/40 px-1 rounded">
                {idx + 1}
              </div>
            </div>
          </button>
        );
      })}

      {/* 生成中的骨架 */}
      {isGenerating && slides.length < totalSlides && (
        <>
          {/* 当前生成中 */}
          <div className="w-full rounded-xl overflow-hidden border-2 border-dashed border-brand-300 dark:border-brand-600">
            <div className="aspect-video animate-shimmer rounded" />
            <div className="text-center text-[10px] text-brand-500 py-0.5">生成中...</div>
          </div>
          {/* 待生成占位 */}
          {Array.from({ length: Math.max(0, totalSlides - slides.length - 1) }).map((_, i) => (
            <div
              key={`placeholder-${i}`}
              className="w-full rounded-xl overflow-hidden border-2 border-dashed border-gray-100 dark:border-gray-800"
            >
              <div className="aspect-video bg-gray-100 dark:bg-gray-800" />
            </div>
          ))}
        </>
      )}
    </div>
  );
};
