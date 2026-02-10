import React, { memo } from 'react';
import { Handle, Position, NodeResizer, type NodeProps } from '@xyflow/react';
import type { WorkflowNodeData } from '../types';
import { getNodeCategoryInfo } from '../types';
import { useWorkflowStore } from '../store/useWorkflowStore';

export const LOOP_CONTAINER_W = 520;
export const LOOP_CONTAINER_H = 300;
export const LOOP_CONTAINER_MIN_W = 360;
export const LOOP_CONTAINER_MIN_H = 200;

/**
 * 循环容器节点 — 可包含子节点的容器型 LOOP 节点。
 *
 * === 容器模型 ===
 * 在 ReactFlow 中作为父节点（type="loopContainer"），子节点通过 parentId 关联。
 * 容器提供 4 个 Handle：
 * - target "input"      (左侧 24px): 外部入边，接收上游数据
 * - source "output"     (右侧 24px): 外部出边，循环完成后连接后续节点
 * - source "loop-start" (内部左侧 55%): 连接循环体入口节点
 * - target "loop-end"   (内部右侧 55%): 接收循环体结束信号
 *
 * === 后端执行 (DefaultWorkflowEngine.executeLoopContainer) ===
 * 1. 通过 sourceHandle="loop-start" 的边找到循环体入口节点 ID
 * 2. 根据 loopType 进行迭代，每次迭代调用 executeFromNode(入口节点)
 * 3. 循环体内节点沿内部连线执行，走到 LOOP_END 或无出边时当次迭代结束
 * 4. 所有迭代完成后，引擎走 sourceHandle="output" 的边到后续节点
 *
 * === 序列化 (useWorkflowStore.toDefinition) ===
 * 保存时，容器节点的子节点和内部连线被嵌套到 node.children 中：
 * { nodes: [...子节点], edges: [...内部边] }
 * 加载时从 children 中还原子节点并设置 parentId。
 *
 * === 边界条件 ===
 * - 无子节点 → 显示空状态提示，后端走 Fallback 模式（LoopNodeExecutor）
 * - loop-start 未连接 → 后端跳过循环，返回空结果
 * - output 未连接 → 后端 warn，后续节点不执行
 * - 容器可调整大小（NodeResizer），最小 360×200
 */
const LoopContainerNode: React.FC<NodeProps> = ({ id, data, selected }) => {
  const nodeData = data as unknown as WorkflowNodeData;
  const catInfo = getNodeCategoryInfo(nodeData.nodeType);
  const cat = catInfo?.category;
  const selectNode = useWorkflowStore((s) => s.selectNode);
  const nodes = useWorkflowStore((s) => s.nodes);

  const childCount = nodes.filter((n) => n.parentId === id).length;
  const loopType = (nodeData.config?.loopType as string) || 'FOR_EACH';
  const loopLabel = loopType === 'FOR_EACH' || loopType === 'FOREACH' ? '迭代'
    : loopType === 'FOR_COUNT' || loopType === 'TIMES' ? '循环'
    : '条件循环';

  const borderClass = selected
    ? 'ring-2 ring-brand-500/30 border-brand-400 dark:border-brand-500 shadow-lg shadow-brand-500/10'
    : 'border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-700 hover:shadow-md';

  return (
    <div
      onClick={(e) => { e.stopPropagation(); selectNode(id); }}
      className={`
        flex flex-col w-full h-full
        rounded-2xl border transition-all duration-200
        cursor-pointer select-none
        bg-amber-50/40 dark:bg-amber-950/20 backdrop-blur-sm
        ${borderClass}
      `}
    >
      {/* 可拖拽调整大小 */}
      <NodeResizer
        minWidth={LOOP_CONTAINER_MIN_W}
        minHeight={LOOP_CONTAINER_MIN_H}
        isVisible={!!selected}
        lineClassName="!border-amber-400"
        handleClassName="!w-2.5 !h-2.5 !bg-amber-400 !border-2 !border-white dark:!border-gray-900 !rounded-md"
      />

      {/* 外部 Input Handle（左侧顶部） */}
      <Handle type="target" position={Position.Left} id="input"
        className="!w-3.5 !h-3.5 !bg-gray-300 dark:!bg-gray-600 !border-2 !border-white dark:!border-gray-900 hover:!bg-brand-500 hover:!scale-125 transition-all"
        style={{ top: 24 }}
      />
      {/* 外部 Output Handle（右侧顶部） */}
      <Handle type="source" position={Position.Right} id="output"
        className="!w-3.5 !h-3.5 !bg-brand-400 dark:!bg-brand-500 !border-2 !border-white dark:!border-gray-900 hover:!bg-brand-600 hover:!scale-125 transition-all"
        style={{ top: 24 }}
      />

      {/* 内部 loop-start Handle (source)  —— 固定在容器左侧内部，覆盖 ReactFlow 默认 transform */}
      <Handle type="source" position={Position.Right} id="loop-start"
        className="!w-4 !h-4 !bg-brand-400/80 !border-2 !border-white dark:!border-gray-900 !rounded-full hover:!scale-150 transition-all"
        style={{ position: 'absolute', top: '55%', left: 38, right: 'auto', transform: 'translate(0, -50%)', zIndex: 50 }}
      />
      {/* 内部 loop-end Handle (target)  —— 固定在容器右侧内部，覆盖 ReactFlow 默认 transform */}
      <Handle type="target" position={Position.Left} id="loop-end"
        className="!w-4 !h-4 !bg-amber-400/80 !border-2 !border-white dark:!border-gray-900 !rounded-full hover:!scale-150 transition-all"
        style={{ position: 'absolute', top: '55%', right: 38, left: 'auto', transform: 'translate(0, -50%)', zIndex: 50 }}
      />

      {/* 头部 */}
      <div className={`flex-none flex items-center gap-2 px-4 py-2 rounded-t-[14px] ${cat?.bgColor || 'bg-amber-50'} ${cat?.darkBgColor || 'dark:bg-amber-900/30'} border-b ${cat?.borderColor || 'border-amber-200'} ${cat?.darkBorderColor || 'dark:border-amber-800/50'}`}>
        <div className="flex items-center justify-center w-6 h-6 rounded-lg bg-white/60 dark:bg-gray-900/40">
          {React.createElement(nodeData.icon, { size: 14, className: cat?.color || 'text-amber-600' })}
        </div>
        <span className={`text-xs font-bold ${cat?.color || 'text-amber-600 dark:text-amber-400'}`}>{nodeData.label}</span>
        <span className="text-[10px] px-1.5 py-0.5 rounded bg-amber-100 dark:bg-amber-900/40 text-amber-600 dark:text-amber-400 font-medium">
          {loopLabel}
        </span>
        <span className="text-[10px] text-gray-400 ml-auto">
          {childCount > 0 ? `${childCount} 个子节点` : ''}
        </span>
      </div>

      {/* 内部区域 */}
      <div className="flex-1 relative min-h-0 overflow-visible">
        {/* 循环开始标记 - 固定左侧居中 */}
        <div className="absolute left-3 top-1/2 -translate-y-1/2 z-10 flex flex-col items-center gap-0.5 pointer-events-none">
          <div className="w-9 h-9 rounded-full bg-brand-500 dark:bg-brand-600 flex items-center justify-center shadow-lg shadow-brand-500/30">
            <div className="w-2.5 h-2.5 rounded-full bg-white" />
          </div>
          <span className="text-[10px] text-brand-500 dark:text-brand-400 font-semibold leading-none">开始</span>
        </div>

        {/* 循环结束标记 - 固定右侧居中 */}
        <div className="absolute right-3 top-1/2 -translate-y-1/2 z-10 flex flex-col items-center gap-0.5 pointer-events-none">
          <div className="w-9 h-9 rounded-full bg-amber-500 dark:bg-amber-600 flex items-center justify-center shadow-lg shadow-amber-500/30">
            <div className="w-2.5 h-2.5 rounded-sm bg-white" />
          </div>
          <span className="text-[10px] text-amber-500 dark:text-amber-400 font-semibold leading-none">结束</span>
        </div>

        {/* 空状态提示 */}
        {childCount === 0 && (
          <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
            <span className="text-xs text-gray-400 dark:text-gray-500 bg-amber-50/80 dark:bg-amber-950/50 px-3 py-1.5 rounded-lg border border-dashed border-gray-300 dark:border-gray-600">
              从工具栏拖入节点，连接开始与结束
            </span>
          </div>
        )}
      </div>
    </div>
  );
};

export default memo(LoopContainerNode);
