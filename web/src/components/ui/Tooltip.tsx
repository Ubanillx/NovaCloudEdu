import React, { useState, useRef, useCallback } from 'react';
import { createPortal } from 'react-dom';

interface TooltipProps {
  content: string;
  children: React.ReactNode;
  className?: string;
  maxWidth?: number;
  position?: 'top' | 'bottom' | 'left' | 'right';
}

export const Tooltip: React.FC<TooltipProps> = ({ 
  content, 
  children, 
  className = '',
  maxWidth = 400,
  position = 'bottom'
}) => {
  const [visible, setVisible] = useState(false);
  const [coords, setCoords] = useState({ x: 0, y: 0 });
  const triggerRef = useRef<HTMLDivElement>(null);
  const tooltipRef = useRef<HTMLDivElement>(null);

  const showTooltip = useCallback(() => {
    if (!triggerRef.current) return;
    
    const rect = triggerRef.current.getBoundingClientRect();
    let x = rect.left;
    let y = rect.bottom + 6;

    // 根据position调整位置
    if (position === 'top') {
      y = rect.top - 6;
    } else if (position === 'left') {
      x = rect.left - 6;
      y = rect.top + rect.height / 2;
    } else if (position === 'right') {
      x = rect.right + 6;
      y = rect.top + rect.height / 2;
    }

    setCoords({ x, y });
    setVisible(true);
  }, [position]);

  const hideTooltip = useCallback(() => {
    setVisible(false);
  }, []);

  // 计算tooltip最终位置，确保不超出视口
  const getTooltipStyle = (): React.CSSProperties => {
    const style: React.CSSProperties = {
      position: 'fixed',
      zIndex: 2147483647,
      maxWidth,
      opacity: visible ? 1 : 0,
      visibility: visible ? 'visible' : 'hidden',
      transition: 'opacity 0.15s ease, visibility 0.15s ease',
      pointerEvents: 'none',
    };

    if (position === 'bottom') {
      style.left = coords.x;
      style.top = coords.y;
      style.transform = 'translateY(0)';
    } else if (position === 'top') {
      style.left = coords.x;
      style.top = coords.y;
      style.transform = 'translateY(-100%)';
    } else if (position === 'left') {
      style.left = coords.x;
      style.top = coords.y;
      style.transform = 'translate(-100%, -50%)';
    } else if (position === 'right') {
      style.left = coords.x;
      style.top = coords.y;
      style.transform = 'translateY(-50%)';
    }

    return style;
  };

  if (!content) {
    return <>{children}</>;
  }

  return (
    <>
      <div
        ref={triggerRef}
        onMouseEnter={showTooltip}
        onMouseLeave={hideTooltip}
        className={className}
        style={{ display: 'inline-block', maxWidth: '100%' }}
      >
        {children}
      </div>
      {visible && typeof document !== 'undefined' && createPortal(
        <div
          ref={tooltipRef}
          style={getTooltipStyle()}
          className="px-3 py-2 text-sm text-white bg-gray-900/95 dark:bg-white/95 dark:text-gray-900 rounded-lg shadow-lg whitespace-pre-wrap break-words"
        >
          {content}
        </div>,
        document.body
      )}
    </>
  );
};

// 简化版：用于表格单元格的截断文本
interface TruncateWithTooltipProps {
  text: string;
  maxWidth?: number | string;
  className?: string;
}

export const TruncateWithTooltip: React.FC<TruncateWithTooltipProps> = ({
  text,
  maxWidth = 200,
  className = ''
}) => {
  const [showTooltip, setShowTooltip] = useState(false);
  const [tooltipPos, setTooltipPos] = useState({ x: 0, y: 0 });
  const textRef = useRef<HTMLSpanElement>(null);

  const handleMouseEnter = () => {
    const el = textRef.current;
    // 只有当文本被截断时才显示tooltip
    if (el && el.scrollWidth > el.clientWidth) {
      const rect = el.getBoundingClientRect();
      setTooltipPos({ x: rect.left, y: rect.bottom + 6 });
      setShowTooltip(true);
    }
  };

  const handleMouseLeave = () => {
    setShowTooltip(false);
  };

  return (
    <>
      <span
        ref={textRef}
        onMouseEnter={handleMouseEnter}
        onMouseLeave={handleMouseLeave}
        className={`block truncate ${className}`}
        style={{ maxWidth: typeof maxWidth === 'number' ? `${maxWidth}px` : maxWidth }}
      >
        {text}
      </span>
      {showTooltip && (
        <div
          style={{
            position: 'fixed',
            left: tooltipPos.x,
            top: tooltipPos.y,
            zIndex: 9999,
            maxWidth: 400,
            pointerEvents: 'none',
          }}
          className="px-3 py-2 text-sm text-white bg-gray-900/95 dark:bg-white/95 dark:text-gray-900 rounded-lg shadow-lg whitespace-pre-wrap break-words animate-in fade-in zoom-in-95 duration-150"
        >
          {text}
        </div>
      )}
    </>
  );
};
