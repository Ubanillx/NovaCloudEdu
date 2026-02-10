import React, { useState, useRef, useEffect, useCallback } from 'react';
import { createPortal } from 'react-dom';
import {
  Plus, MousePointer2, Hand, MessageSquareText,
  ZoomIn, ZoomOut, Maximize2, Lock, LockOpen,
  Spline, LayoutGrid, Minus, MoreHorizontal, X,
} from 'lucide-react';
import { useReactFlow } from '@xyflow/react';
import { NODE_CATEGORIES, NodeType } from '../types';
import { useWorkflowStore, type EdgeStyleType } from '../store/useWorkflowStore';

export type InteractionMode = 'hand' | 'pointer';

interface CanvasToolbarProps {
  isLocked: boolean;
  onToggleLock: () => void;
  edgeType: EdgeStyleType;
  onToggleEdgeType: () => void;
  interactionMode: InteractionMode;
  onSetInteractionMode: (mode: InteractionMode) => void;
  onAddComment: () => void;
  onAutoLayout: () => void;
}

const SINGLETON_TYPES: string[] = [NodeType.START, NodeType.END];

export const CanvasToolbar: React.FC<CanvasToolbarProps> = ({
  isLocked,
  onToggleLock,
  edgeType,
  onToggleEdgeType,
  interactionMode,
  onSetInteractionMode,
  onAddComment,
  onAutoLayout,
}) => {
  const { zoomIn, zoomOut, fitView, getViewport } = useReactFlow();
  const [nodePickerOpen, setNodePickerOpen] = useState(false);
  const [moreOpen, setMoreOpen] = useState(false);
  const pickerBtnRef = useRef<HTMLButtonElement>(null);
  const moreBtnRef = useRef<HTMLButtonElement>(null);
  const pickerPanelRef = useRef<HTMLDivElement>(null);
  const morePanelRef = useRef<HTMLDivElement>(null);
  const nodes = useWorkflowStore((s) => s.nodes);
  const addNode = useWorkflowStore((s) => s.addNode);

  const isSingletonUsed = (type: string) =>
    SINGLETON_TYPES.includes(type) && nodes.some((n) => n.data.nodeType === type);

  // 点击外部关闭弹出面板（需要同时检查按钮和 portal 面板）
  useEffect(() => {
    const handler = (e: MouseEvent) => {
      const target = e.target as Node;
      if (nodePickerOpen && pickerBtnRef.current && !pickerBtnRef.current.contains(target) && pickerPanelRef.current && !pickerPanelRef.current.contains(target)) {
        setNodePickerOpen(false);
      }
      if (moreOpen && moreBtnRef.current && !moreBtnRef.current.contains(target) && morePanelRef.current && !morePanelRef.current.contains(target)) {
        setMoreOpen(false);
      }
    };
    document.addEventListener('mousedown', handler);
    return () => document.removeEventListener('mousedown', handler);
  }, [nodePickerOpen, moreOpen]);

  // 计算弹出面板位置
  const getPickerPos = useCallback(() => {
    if (!pickerBtnRef.current) return { left: 60, top: 80 };
    const rect = pickerBtnRef.current.getBoundingClientRect();
    const panelH = Math.min(520, window.innerHeight - 16);
    return {
      left: rect.right + 8,
      top: Math.max(8, Math.min(rect.top, window.innerHeight - panelH - 8)),
    };
  }, []);

  const getMorePos = useCallback(() => {
    if (!moreBtnRef.current) return { left: 60, bottom: 8 };
    const rect = moreBtnRef.current.getBoundingClientRect();
    return {
      left: rect.right + 8,
      bottom: Math.max(8, window.innerHeight - rect.bottom),
    };
  }, []);

  // 点击添加节点：在画布视口中心放置
  const handleAddNode = useCallback(
    (nodeType: NodeType) => {
      const { x, y, zoom } = getViewport();
      // 获取 ReactFlow 容器的尺寸来计算视口中心
      const flowEl = document.querySelector('.react-flow') as HTMLElement | null;
      const w = flowEl?.clientWidth ?? 800;
      const h = flowEl?.clientHeight ?? 600;
      const centerX = (-x + w / 2) / zoom;
      const centerY = (-y + h / 2) / zoom;
      const added = addNode(nodeType, { x: centerX - 80, y: centerY - 30 });
      if (!added) {
        const label = nodeType === 'START' ? '开始' : '结束';
        alert(`一个工作流只能有一个${label}节点`);
      }
      setNodePickerOpen(false);
    },
    [addNode, getViewport]
  );

  const btnBase =
    'relative flex items-center justify-center w-9 h-9 rounded-xl transition-all duration-150 text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/30 active:scale-90';

  const btnActive =
    'relative flex items-center justify-center w-9 h-9 rounded-xl transition-all duration-150 !text-brand-600 dark:!text-brand-400 !bg-brand-50 dark:!bg-brand-900/40';

  const divider = <div className="w-6 h-px bg-gray-200 dark:bg-gray-700 mx-auto" />;

  return (
    <div className="absolute left-3 top-1/2 -translate-y-1/2 z-20 flex flex-col items-center gap-1 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-2xl px-1 py-1.5 shadow-lg backdrop-blur-sm">
      {/* + 添加节点 */}
      <button
        ref={pickerBtnRef}
        onClick={() => { setNodePickerOpen(!nodePickerOpen); setMoreOpen(false); }}
        className={nodePickerOpen ? btnActive : btnBase}
        title="添加节点"
      >
        {nodePickerOpen ? <X size={17} /> : <Plus size={17} strokeWidth={2.5} />}
      </button>

      {/* 节点选择弹出面板 — Portal 到 body */}
      {nodePickerOpen && createPortal(
        <div
          ref={pickerPanelRef}
          className="fixed z-[9999] w-72 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-2xl overflow-hidden animate-in slide-in-from-left-2 duration-200"
          style={{ left: getPickerPos().left, top: getPickerPos().top, maxHeight: `min(520px, calc(100vh - 16px))` }}
        >
          <div className="px-4 py-3 border-b border-gray-100 dark:border-gray-800 flex-shrink-0">
            <p className="text-sm font-bold text-gray-900 dark:text-white">添加节点</p>
            <p className="text-[10px] text-gray-400 dark:text-gray-500 mt-0.5">点击添加到画布中心</p>
          </div>
          <div className="overflow-y-auto custom-scrollbar p-2 space-y-2" style={{ maxHeight: 'calc(min(520px, 100vh - 16px) - 56px)' }}>
            {NODE_CATEGORIES.map((cat) => (
              <div key={cat.label}>
                <p className={`text-[10px] font-bold uppercase tracking-wider px-2 py-1 ${cat.color}`}>
                  {cat.label}
                </p>
                <div className="grid grid-cols-2 gap-1 mt-1">
                  {cat.types.map((nt) => {
                    const disabled = isSingletonUsed(nt.type);
                    return (
                      <button
                        key={nt.type}
                        disabled={disabled}
                        onClick={() => handleAddNode(nt.type)}
                        className={`
                          flex items-center gap-2 px-2.5 py-2 rounded-xl text-left text-xs
                          border transition-all duration-150 group/item
                          ${disabled
                            ? 'bg-gray-50 dark:bg-gray-800/20 border-gray-100 dark:border-gray-800 opacity-40 cursor-not-allowed'
                            : 'bg-white dark:bg-gray-800/30 border-gray-100 dark:border-gray-800 hover:border-brand-300 dark:hover:border-brand-700 hover:bg-brand-50 dark:hover:bg-brand-900/20 cursor-pointer active:scale-95'
                          }
                        `}
                      >
                        <div className={`flex items-center justify-center w-6 h-6 rounded-lg ${cat.bgColor} ${cat.darkBgColor} flex-shrink-0`}>
                          <nt.icon size={12} className={cat.color} />
                        </div>
                        <span className={`font-medium truncate ${disabled ? 'text-gray-400' : 'text-gray-700 dark:text-gray-300'}`}>
                          {nt.label}
                        </span>
                      </button>
                    );
                  })}
                </div>
              </div>
            ))}
          </div>
        </div>,
        document.body
      )}

      {divider}

      {/* 指针模式 */}
      <button
        onClick={() => onSetInteractionMode('pointer')}
        className={interactionMode === 'pointer' ? btnActive : btnBase}
        title="选择模式（可框选多个节点）"
      >
        <MousePointer2 size={16} />
      </button>

      {/* 拖拽模式 */}
      <button
        onClick={() => onSetInteractionMode('hand')}
        className={interactionMode === 'hand' ? btnActive : btnBase}
        title="拖拽模式（拖拽画布平移）"
      >
        <Hand size={16} />
      </button>

      {divider}

      {/* 添加注释 */}
      <button
        onClick={onAddComment}
        className={btnBase}
        title="添加注释"
      >
        <MessageSquareText size={16} />
      </button>

      {divider}

      {/* 缩放控制 */}
      <button onClick={() => zoomIn({ duration: 200 })} className={btnBase} title="放大">
        <ZoomIn size={16} />
      </button>
      <button onClick={() => zoomOut({ duration: 200 })} className={btnBase} title="缩小">
        <ZoomOut size={16} />
      </button>
      <button onClick={() => fitView({ padding: 0.2, duration: 300 })} className={btnBase} title="适合画布">
        <Maximize2 size={16} />
      </button>

      {divider}

      {/* 更多选项 */}
      <button
        ref={moreBtnRef}
        onClick={() => { setMoreOpen(!moreOpen); setNodePickerOpen(false); }}
        className={moreOpen ? btnActive : btnBase}
        title="更多选项"
      >
        <MoreHorizontal size={16} />
      </button>

      {/* 更多选项弹出面板 — Portal 到 body */}
      {moreOpen && createPortal(
        <div
          ref={morePanelRef}
          className="fixed z-[9999] w-48 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl shadow-2xl overflow-hidden animate-in slide-in-from-left-2 duration-200"
          style={{ left: getMorePos().left, bottom: getMorePos().bottom }}
        >
          <div className="p-1">
            <button
              onClick={() => { onToggleEdgeType(); }}
              className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-xs text-gray-600 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors"
            >
              {edgeType === 'default' ? <Spline size={14} /> : edgeType === 'smoothstep' ? <LayoutGrid size={14} /> : <Minus size={14} />}
              <span>连线样式: {edgeType === 'default' ? '曲线' : edgeType === 'smoothstep' ? '折线' : '直线'}</span>
            </button>
            <button
              onClick={() => { onToggleLock(); }}
              className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-xs text-gray-600 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors"
            >
              {isLocked ? <Lock size={14} className="text-amber-500" /> : <LockOpen size={14} />}
              <span>{isLocked ? '解锁画布' : '锁定画布'}</span>
            </button>
            <button
              onClick={() => { onAutoLayout(); setMoreOpen(false); }}
              className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-xs text-gray-600 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors"
            >
              <LayoutGrid size={14} />
              <span>自动整理布局</span>
            </button>
          </div>
        </div>,
        document.body
      )}
    </div>
  );
};
