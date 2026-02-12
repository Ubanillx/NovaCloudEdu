import React from 'react';
import { SlideListPanel } from './SlideListPanel';
import type { GeneratedSlide } from '../../hooks/usePptGeneration';

interface PptPreviewPanelProps {
  slides: GeneratedSlide[];
  selectedIndex: number;
  onSelectSlide: (index: number) => void;
  totalSlides: number;
  isGenerating: boolean;
}

const PptPreviewPanel: React.FC<PptPreviewPanelProps> = ({
  slides,
  selectedIndex,
  onSelectSlide,
  totalSlides,
  isGenerating,
}) => {
  return (
    <div className="h-full overflow-hidden p-4">
      <SlideListPanel
        slides={slides}
        selectedIndex={selectedIndex}
        onSelect={onSelectSlide}
        totalSlides={totalSlides}
        isGenerating={isGenerating}
      />
    </div>
  );
};

export default PptPreviewPanel;
