import React, { useCallback, useState, useRef, useEffect } from 'react';
import { type NodeProps, NodeResizer } from '@xyflow/react';
import type { WorkflowNode } from '../types';

export const COMMENT_COLORS = [
  { label: '黄色', value: '#fef9c3', border: '#fde047', text: '#854d0e' },
  { label: '蓝色', value: '#dbeafe', border: '#93c5fd', text: '#1e40af' },
  { label: '绿色', value: '#dcfce7', border: '#86efac', text: '#166534' },
  { label: '紫色', value: '#f3e8ff', border: '#c4b5fd', text: '#5b21b6' },
  { label: '粉色', value: '#fce7f3', border: '#f9a8d4', text: '#9d174d' },
  { label: '灰色', value: '#f3f4f6', border: '#d1d5db', text: '#374151' },
];

const getColorSet = (color: string) =>
  COMMENT_COLORS.find((c) => c.value === color) || COMMENT_COLORS[0];

const CommentNode: React.FC<NodeProps<WorkflowNode>> = ({ data, selected, id }) => {
  const commentText = (data.config?.text as string) || '';
  const commentColor = (data.config?.color as string) || COMMENT_COLORS[0].value;

  const [editing, setEditing] = useState(false);
  const [text, setText] = useState(commentText);
  const textareaRef = useRef<HTMLTextAreaElement>(null);
  const colorSet = getColorSet(commentColor);

  useEffect(() => {
    setText((data.config?.text as string) || '');
  }, [data.config?.text]);

  useEffect(() => {
    if (editing && textareaRef.current) {
      textareaRef.current.focus();
      textareaRef.current.selectionStart = textareaRef.current.value.length;
    }
  }, [editing]);

  const handleBlur = useCallback(() => {
    setEditing(false);
    // 更新 store 中的 text
    const event = new CustomEvent('comment-update', { detail: { id, text } });
    window.dispatchEvent(event);
  }, [id, text]);

  const handleKeyDown = useCallback(
    (e: React.KeyboardEvent) => {
      if (e.key === 'Escape') {
        setEditing(false);
        handleBlur();
      }
      // 阻止 delete/backspace 传播到 ReactFlow
      e.stopPropagation();
    },
    [handleBlur]
  );

  return (
    <>
      <NodeResizer
        isVisible={selected}
        minWidth={120}
        minHeight={60}
        lineClassName="!border-transparent"
        handleClassName="!w-2.5 !h-2.5 !rounded-full !bg-brand-500 !border-2 !border-white"
      />
      <div
        className="w-full h-full rounded-lg shadow-sm transition-shadow duration-200 overflow-hidden"
        style={{
          backgroundColor: colorSet.value,
          border: `1.5px ${selected ? 'solid' : 'dashed'} ${colorSet.border}`,
          boxShadow: selected ? `0 0 0 2px ${colorSet.border}40` : undefined,
        }}
        onDoubleClick={() => setEditing(true)}
      >
        {/* 顶部拖拽条 */}
        <div
          className="flex items-center gap-1.5 px-3 py-1.5 cursor-move select-none"
          style={{ borderBottom: `1px dashed ${colorSet.border}` }}
        >
          <svg width="10" height="10" viewBox="0 0 10 10" fill="none">
            <rect x="1" y="1" width="3" height="3" rx="0.5" fill={colorSet.text} opacity="0.3" />
            <rect x="6" y="1" width="3" height="3" rx="0.5" fill={colorSet.text} opacity="0.3" />
            <rect x="1" y="6" width="3" height="3" rx="0.5" fill={colorSet.text} opacity="0.3" />
            <rect x="6" y="6" width="3" height="3" rx="0.5" fill={colorSet.text} opacity="0.3" />
          </svg>
          <span className="text-[10px] font-medium opacity-50" style={{ color: colorSet.text }}>
            注释
          </span>
        </div>

        {/* 内容区 */}
        <div className="p-3 h-[calc(100%-28px)]">
          {editing ? (
            <textarea
              ref={textareaRef}
              value={text}
              onChange={(e) => setText(e.target.value)}
              onBlur={handleBlur}
              onKeyDown={handleKeyDown}
              className="w-full h-full resize-none bg-transparent outline-none text-sm leading-relaxed placeholder-current/30"
              style={{ color: colorSet.text }}
              placeholder="输入注释内容..."
            />
          ) : (
            <div
              className="w-full h-full text-sm leading-relaxed whitespace-pre-wrap break-words overflow-hidden cursor-text"
              style={{ color: colorSet.text }}
              onClick={() => setEditing(true)}
            >
              {text || (
                <span className="opacity-40 italic">双击编辑注释...</span>
              )}
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default CommentNode;
