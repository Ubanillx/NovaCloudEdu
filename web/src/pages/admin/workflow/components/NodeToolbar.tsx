import React, { useState } from 'react';
import { ChevronDown, ChevronRight, GripVertical } from 'lucide-react';
import { NODE_CATEGORIES, NodeType } from '../types';
import { useWorkflowStore } from '../store/useWorkflowStore';

interface NodeToolbarProps {
  className?: string;
}

const SINGLETON_TYPES: string[] = [NodeType.START, NodeType.END];

export const NodeToolbar: React.FC<NodeToolbarProps> = ({ className = '' }) => {
  const nodes = useWorkflowStore((s) => s.nodes);
  const [expandedCats, setExpandedCats] = useState<Set<string>>(
    new Set(NODE_CATEGORIES.map((c) => c.label))
  );

  // 检查单例节点是否已存在
  const isSingletonUsed = (type: string) =>
    SINGLETON_TYPES.includes(type) && nodes.some((n) => n.data.nodeType === type);

  const toggleCat = (label: string) => {
    setExpandedCats((prev) => {
      const next = new Set(prev);
      if (next.has(label)) next.delete(label);
      else next.add(label);
      return next;
    });
  };

  const onDragStart = (e: React.DragEvent, nodeType: NodeType) => {
    e.dataTransfer.setData('application/workflow-node-type', nodeType);
    e.dataTransfer.effectAllowed = 'move';
  };

  return (
    <div className={`w-60 bg-white dark:bg-gray-900 border-r border-gray-100 dark:border-gray-800 flex flex-col h-full overflow-hidden shadow-sm transition-colors duration-300 ${className}`}>
      <div className="px-4 py-3.5 border-b border-gray-100 dark:border-gray-800">
        <h3 className="text-sm font-bold text-gray-900 dark:text-white">节点面板</h3>
        <p className="text-xs text-gray-400 dark:text-gray-500 mt-0.5">拖拽节点到画布</p>
      </div>
      <div className="flex-1 overflow-y-auto custom-scrollbar p-2 space-y-1">
        {NODE_CATEGORIES.map((cat) => {
          const isOpen = expandedCats.has(cat.label);
          return (
            <div key={cat.label}>
              <button
                onClick={() => toggleCat(cat.label)}
                className="w-full flex items-center gap-2 px-2 py-2 rounded-xl text-xs font-bold text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-all duration-200"
              >
                {isOpen ? <ChevronDown size={14} /> : <ChevronRight size={14} />}
                <span className={cat.color}>{cat.label}</span>
                <span className="ml-auto text-gray-300 dark:text-gray-600">{cat.types.length}</span>
              </button>
              {isOpen && (
                <div className="space-y-0.5 ml-1 mb-1">
                  {cat.types.map((nt) => {
                    const disabled = isSingletonUsed(nt.type);
                    return (
                      <div
                        key={nt.type}
                        draggable={!disabled}
                        onDragStart={(e) => !disabled && onDragStart(e, nt.type)}
                        className={`
                          flex items-center gap-2.5 px-3 py-2.5 rounded-xl
                          border transition-all duration-200 text-sm select-none group/card
                          ${disabled
                            ? 'bg-gray-50 dark:bg-gray-800/20 border-gray-100 dark:border-gray-800 opacity-50 cursor-not-allowed'
                            : 'bg-white dark:bg-gray-800/50 border-gray-200 dark:border-gray-700 cursor-grab active:cursor-grabbing hover:border-brand-300 dark:hover:border-brand-700 hover:shadow-md hover:-translate-y-0.5'
                          }
                        `}
                      >
                        <GripVertical size={12} className={`flex-shrink-0 transition-colors ${disabled ? 'text-gray-200 dark:text-gray-700' : 'text-gray-300 dark:text-gray-600 group-hover/card:text-brand-400'}`} />
                        <div className={`flex items-center justify-center w-7 h-7 rounded-lg ${cat.bgColor} ${cat.darkBgColor}`}>
                          <nt.icon size={14} className={cat.color} />
                        </div>
                        <span className={`font-medium text-xs truncate ${disabled ? 'text-gray-400 dark:text-gray-600' : 'text-gray-700 dark:text-gray-300'}`}>{nt.label}</span>
                        {disabled && <span className="ml-auto text-[9px] text-gray-400 dark:text-gray-600 font-medium">已添加</span>}
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          );
        })}
      </div>
      <div className="px-4 py-3 border-t border-gray-100 dark:border-gray-800">
        <p className="text-[10px] text-gray-300 dark:text-gray-600 text-center">⌘S 保存 · Delete 删除节点</p>
      </div>
    </div>
  );
};
