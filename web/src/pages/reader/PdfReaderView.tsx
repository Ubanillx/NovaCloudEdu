import React, { useState, useRef, useCallback } from 'react';
import { Document, Page, pdfjs } from 'react-pdf';
import 'react-pdf/dist/Page/AnnotationLayer.css';
import 'react-pdf/dist/Page/TextLayer.css';
import {
  ArrowLeft, ChevronLeft, ChevronRight, ZoomIn, ZoomOut,
  Maximize, Loader2, AlertCircle,
} from 'lucide-react';
import type { ThemeVars } from './readerConstants';

pdfjs.GlobalWorkerOptions.workerSrc = new URL(
  'pdfjs-dist/build/pdf.worker.min.mjs',
  import.meta.url,
).toString();

interface PdfReaderViewProps {
  pdfUrl: string;
  themeVars: ThemeVars;
  title?: string;
  onBack: () => void;
}

const ZOOM_STEP = 0.15;
const ZOOM_MIN = 0.5;
const ZOOM_MAX = 3.0;

const PdfReaderView: React.FC<PdfReaderViewProps> = ({ pdfUrl, themeVars, title, onBack }) => {
  const [numPages, setNumPages] = useState<number>(0);
  const [pageNumber, setPageNumber] = useState<number>(1);
  const [scale, setScale] = useState<number>(1.0);
  const [pdfLoading, setPdfLoading] = useState(true);
  const [pdfError, setPdfError] = useState<string | null>(null);
  const [pageInputValue, setPageInputValue] = useState('1');
  const containerRef = useRef<HTMLDivElement>(null);

  const onDocumentLoadSuccess = useCallback(({ numPages: total }: { numPages: number }) => {
    setNumPages(total);
    setPdfLoading(false);
    setPdfError(null);
  }, []);

  const onDocumentLoadError = useCallback((error: Error) => {
    setPdfLoading(false);
    setPdfError(error.message || 'PDF 加载失败');
  }, []);

  const goPage = useCallback((page: number) => {
    const p = Math.max(1, Math.min(numPages, page));
    setPageNumber(p);
    setPageInputValue(String(p));
    containerRef.current?.scrollTo({ top: 0, behavior: 'smooth' });
  }, [numPages]);

  const handlePageInputBlur = useCallback(() => {
    const n = parseInt(pageInputValue, 10);
    if (!isNaN(n) && n >= 1 && n <= numPages) {
      goPage(n);
    } else {
      setPageInputValue(String(pageNumber));
    }
  }, [pageInputValue, numPages, pageNumber, goPage]);

  const handlePageInputKeyDown = useCallback((e: React.KeyboardEvent) => {
    if (e.key === 'Enter') handlePageInputBlur();
  }, [handlePageInputBlur]);

  const zoomIn = useCallback(() => setScale(s => Math.min(ZOOM_MAX, +(s + ZOOM_STEP).toFixed(2))), []);
  const zoomOut = useCallback(() => setScale(s => Math.max(ZOOM_MIN, +(s - ZOOM_STEP).toFixed(2))), []);
  const zoomFit = useCallback(() => setScale(1.0), []);

  const btnClass = 'p-2 rounded-xl transition-all hover:scale-[1.02] hover:bg-black/5 dark:hover:bg-white/5 disabled:opacity-30 disabled:cursor-not-allowed disabled:hover:bg-transparent';

  return (
    <div className="h-screen flex flex-col overflow-hidden" style={{ background: themeVars.bg, color: themeVars.text }}>

      {/* ━━━━━ 顶部工具栏 ━━━━━ */}
      <div
        className="flex-shrink-0 flex items-center justify-between px-4 h-14 border-b gap-2"
        style={{ background: themeVars.sidebar, borderColor: themeVars.border }}
      >
        {/* 左：返回 + 书名 */}
        <div className="flex items-center gap-2 min-w-0 flex-shrink">
          <button onClick={onBack} className={btnClass} title="返回">
            <ArrowLeft size={18} />
          </button>
          <span className="text-[13px] font-bold truncate max-w-[200px] opacity-90">{title}</span>
        </div>

        {/* 中：翻页 */}
        <div className="flex items-center gap-1">
          <button onClick={() => goPage(pageNumber - 1)} disabled={pageNumber <= 1} className={btnClass} title="上一页">
            <ChevronLeft size={18} />
          </button>
          <div className="flex items-center gap-1 text-xs font-medium" style={{ color: themeVars.muted }}>
            <input
              value={pageInputValue}
              onChange={e => setPageInputValue(e.target.value)}
              onBlur={handlePageInputBlur}
              onKeyDown={handlePageInputKeyDown}
              className="w-10 text-center rounded-lg border px-1 py-1 text-xs font-bold outline-none focus:ring-2 focus:ring-brand-500/30"
              style={{ background: themeVars.bg, borderColor: themeVars.border, color: themeVars.text }}
            />
            <span>/</span>
            <span className="font-bold">{numPages}</span>
          </div>
          <button onClick={() => goPage(pageNumber + 1)} disabled={pageNumber >= numPages} className={btnClass} title="下一页">
            <ChevronRight size={18} />
          </button>
        </div>

        {/* 右：缩放 */}
        <div className="flex items-center gap-1">
          <button onClick={zoomOut} disabled={scale <= ZOOM_MIN} className={btnClass} title="缩小">
            <ZoomOut size={16} />
          </button>
          <button
            onClick={zoomFit}
            className="px-2 py-1 rounded-lg text-[11px] font-bold transition-all hover:bg-black/5 dark:hover:bg-white/5 hover:scale-[1.02]"
            style={{ color: themeVars.muted }}
            title="重置缩放"
          >
            {Math.round(scale * 100)}%
          </button>
          <button onClick={zoomIn} disabled={scale >= ZOOM_MAX} className={btnClass} title="放大">
            <ZoomIn size={16} />
          </button>
          <div className="w-px h-5 mx-1 opacity-20" style={{ background: themeVars.text }} />
          <button
            onClick={() => {
              if (containerRef.current) {
                const containerWidth = containerRef.current.clientWidth - 80;
                setScale(containerWidth / 612);
              }
            }}
            className={btnClass}
            title="适应宽度"
          >
            <Maximize size={16} />
          </button>
        </div>
      </div>

      {/* ━━━━━ PDF 内容区 ━━━━━ */}
      <div
        ref={containerRef}
        className="flex-1 overflow-auto custom-scrollbar"
        style={{ background: themeVars.bg }}
      >
        {pdfError ? (
          <div className="flex flex-col items-center justify-center h-full gap-4">
            <AlertCircle size={48} className="opacity-30" />
            <p className="text-sm font-medium" style={{ color: themeVars.muted }}>PDF 加载失败: {pdfError}</p>
            <button
              onClick={onBack}
              className="px-4 py-2 rounded-xl text-white text-sm font-bold"
              style={{ background: themeVars.accent }}
            >
              返回
            </button>
          </div>
        ) : (
          <div className="flex justify-center py-6">
            <Document
              file={pdfUrl}
              onLoadSuccess={onDocumentLoadSuccess}
              onLoadError={onDocumentLoadError}
              loading={
                <div className="flex flex-col items-center justify-center py-32 gap-4">
                  <Loader2 size={40} className="animate-spin" style={{ color: themeVars.accent }} />
                  <span className="text-sm font-medium animate-pulse" style={{ color: themeVars.muted }}>
                    正在加载 PDF...
                  </span>
                </div>
              }
            >
              {!pdfLoading && (
                <div className="pdf-page-wrapper">
                  <Page
                    pageNumber={pageNumber}
                    scale={scale}
                    loading={
                      <div className="flex items-center justify-center py-20">
                        <Loader2 size={24} className="animate-spin" style={{ color: themeVars.accent }} />
                      </div>
                    }
                  />
                </div>
              )}
            </Document>
          </div>
        )}
      </div>

      {/* ━━━━━ 底部快捷键提示 ━━━━━ */}
      {!pdfError && numPages > 0 && (
        <div
          className="flex-shrink-0 flex items-center justify-center px-4 py-2 border-t text-[11px] gap-4"
          style={{ background: themeVars.sidebar, borderColor: themeVars.border, color: themeVars.muted }}
        >
          <span>第 <b style={{ color: themeVars.text }}>{pageNumber}</b> / {numPages} 页</span>
          <span className="opacity-40">|</span>
          <span>缩放 {Math.round(scale * 100)}%</span>
        </div>
      )}
    </div>
  );
};

export default PdfReaderView;
