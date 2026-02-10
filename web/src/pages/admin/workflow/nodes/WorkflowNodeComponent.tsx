import React, { memo } from 'react';
import { Handle, Position, type NodeProps } from '@xyflow/react';
import type { WorkflowNodeData } from '../types';
import { NodeType, getNodeCategoryInfo } from '../types';
import { useWorkflowStore } from '../store/useWorkflowStore';

/**
 * 工作流节点组件 — 渲染单个节点的视觉表现和连接 Handle。
 *
 * === Handle 布局 ===
 * - 普通节点: 左侧 target Handle (输入) + 右侧 source Handle (输出)
 * - START 节点: 仅 source Handle (无输入)
 * - END 节点: 仅 target Handle (无输出)
 * - LOOP_START: 仅 source Handle (右侧, 连接循环体)
 * - LOOP_END: 仅 target Handle (左侧, 接收循环体结果)
 * - CONDITION/SWITCH: 默认 source Handle + id="false" 的额外 Handle (75% 高度)
 *
 * === 条件/多路分支路由与 Handle 映射 ===
 * 后端引擎通过 output.branch / output.matchedBranch 匹配 edge.sourceHandle 路由出边：
 *
 * 1. 单条件模式（CONDITION，conditions 列表为空，向后兼容）：
 *    - branch="true"  → 匹配默认 Handle（sourceHandle 为空）→ 上方出边
 *    - branch="false" → 匹配 id="false" Handle → 下方出边
 *    ✅ 两个 Handle 完整覆盖两种结果
 *
 * 2. 多条件模式（CONDITION，conditions 列表非空）：
 *    - 匹配时: branch=conditionName → 无精确匹配 Handle → fallback 到默认 Handle
 *    - 不匹配: branch="default" → 无精确匹配 → fallback 到默认 Handle
 *    ⚠ 所有输出均走默认 Handle，"false" Handle 不会被触发
 *
 * 3. SWITCH 节点：
 *    - Case 匹配: branch=caseName → fallback 到默认 Handle
 *    - 无匹配: branch="default" → fallback 到默认 Handle
 *    ⚠ 所有输出均走默认 Handle，"false" Handle 不会被触发
 *
 * 结论：当前 2-Handle 设计在多条件/Switch 模式下无法实现分支级别的视觉路由，
 * 所有分支共用默认出边。如需支持 N 路分支视觉路由，需动态生成 N 个 Handle
 * 并让用户为每个分支连线。这是一个已知的设计局限。
 */
const WorkflowNodeComponent: React.FC<NodeProps> = ({ id, data, selected }) => {
  const nodeData = data as unknown as WorkflowNodeData;
  const selectNode = useWorkflowStore((s) => s.selectNode);
  const catInfo = getNodeCategoryInfo(nodeData.nodeType);
  const cat = catInfo?.category;

  const isStart = nodeData.nodeType === NodeType.START;
  const isEnd = nodeData.nodeType === NodeType.END;
  const isLoopStart = nodeData.nodeType === NodeType.LOOP_START;
  const isLoopEnd = nodeData.nodeType === NodeType.LOOP_END;

  const handleClick = () => {
    selectNode(id);
  };

  // ===== 循环开始节点：蓝色小圆 =====
  if (isLoopStart) {
    return (
      <div onClick={handleClick} className="relative flex items-center gap-2 cursor-pointer select-none group">
        <div className={`w-9 h-9 rounded-full flex items-center justify-center shadow-lg transition-all
          bg-brand-500 dark:bg-brand-600 ${selected ? 'ring-2 ring-brand-400/60 scale-110' : 'group-hover:scale-105'}
          shadow-brand-500/30`}>
          <div className="w-2.5 h-2.5 rounded-full bg-white" />
        </div>
        <span className="text-[10px] text-gray-400 dark:text-gray-500 font-medium whitespace-nowrap">开始</span>
        <Handle type="source" position={Position.Right}
          className="!w-3 !h-3 !bg-brand-400 !border-2 !border-white dark:!border-gray-900 hover:!scale-150 transition-all" />
      </div>
    );
  }

  // ===== 循环结束节点：橙色小圆 =====
  if (isLoopEnd) {
    return (
      <div onClick={handleClick} className="relative flex items-center gap-2 cursor-pointer select-none group">
        <Handle type="target" position={Position.Left}
          className="!w-3 !h-3 !bg-amber-400 !border-2 !border-white dark:!border-gray-900 hover:!scale-150 transition-all" />
        <span className="text-[10px] text-gray-400 dark:text-gray-500 font-medium whitespace-nowrap">结束</span>
        <div className={`w-9 h-9 rounded-full flex items-center justify-center shadow-lg transition-all
          bg-amber-500 dark:bg-amber-600 ${selected ? 'ring-2 ring-amber-400/60 scale-110' : 'group-hover:scale-105'}
          shadow-amber-500/30`}>
          <div className="w-2.5 h-2.5 rounded-sm bg-white" />
        </div>
      </div>
    );
  }

  // ===== 意图识别节点：显示分类列表 + 每个分类独立 Handle =====
  const isIntentRecognition = nodeData.nodeType === NodeType.INTENT_RECOGNITION;
  const intentItems: Array<{ name: string; description?: string }> = isIntentRecognition
    ? ((nodeData.config?.intents as Array<{ name: string; description?: string }>) || [])
    : [];

  // ===== 普通节点 =====
  const borderClass = selected
    ? 'ring-2 ring-brand-500/30 border-brand-400 dark:border-brand-500 shadow-lg shadow-brand-500/10'
    : 'border-gray-200 dark:border-gray-700 hover:border-brand-300 dark:hover:border-brand-700 hover:shadow-md';

  return (
    <div
      onClick={handleClick}
      className={`
        relative bg-white dark:bg-gray-900 rounded-2xl border shadow-sm
        min-w-[200px] max-w-[280px] transition-all duration-200
        cursor-pointer select-none
        ${borderClass}
      `}
    >
      {/* 输入 Handle */}
      {!isStart && (
        <Handle
          type="target"
          position={Position.Left}
          className="!w-3.5 !h-3.5 !bg-gray-300 dark:!bg-gray-600 !border-2 !border-white dark:!border-gray-900 hover:!bg-brand-500 hover:!scale-125 transition-all"
        />
      )}

      {/* 节点头部 */}
      <div className={`flex items-center gap-2.5 px-4 py-2.5 rounded-t-2xl ${cat?.bgColor || 'bg-gray-50'} ${cat?.darkBgColor || 'dark:bg-gray-800/50'} border-b ${cat?.borderColor || 'border-gray-100'} ${cat?.darkBorderColor || 'dark:border-gray-800'}`}>
        <div className={`flex items-center justify-center w-7 h-7 rounded-lg bg-white/60 dark:bg-gray-900/40`}>
          {React.createElement(nodeData.icon, { size: 15, className: cat?.color || 'text-gray-500' })}
        </div>
        <div className="flex-1 min-w-0">
          <p className={`text-xs font-bold uppercase tracking-wider ${cat?.color || 'text-gray-500'}`}>
            {catInfo?.category?.label || '节点'}
          </p>
        </div>
      </div>

      {/* 节点内容 */}
      <div className="px-4 py-3">
        <p className="text-sm font-bold text-gray-900 dark:text-white truncate">{nodeData.label}</p>

        {/* 意图识别节点：显示分类列表 */}
        {isIntentRecognition ? (
          <div className="mt-2 space-y-1">
            {intentItems.length === 0 ? (
              <p className="text-[10px] text-gray-400 italic">未配置分类</p>
            ) : (
              intentItems.map((intent, idx) => (
                <div key={idx} className="flex items-center gap-2 relative group/intent">
                  <span className="text-[10px] font-medium text-gray-600 dark:text-gray-300 truncate flex-1 py-1 px-2 bg-violet-50 dark:bg-violet-900/20 rounded-lg border border-violet-100 dark:border-violet-800/40">
                    {intent.name || `分类 ${idx + 1}`}
                  </span>
                  {/* 每个分类对应的 Handle（右侧，绝对定位） */}
                  <Handle
                    type="source"
                    position={Position.Right}
                    id={intent.name || `intent_${idx}`}
                    style={{ top: 'auto', position: 'absolute', right: '-22px' }}
                    className="!w-3 !h-3 !bg-violet-400 dark:!bg-violet-500 !border-2 !border-white dark:!border-gray-900 hover:!bg-violet-600 hover:!scale-150 transition-all"
                  />
                </div>
              ))
            )}
            {/* default 兜底分类 Handle */}
            <div className="flex items-center gap-2 relative">
              <span className="text-[10px] font-medium text-gray-400 dark:text-gray-500 truncate flex-1 py-1 px-2 bg-gray-50 dark:bg-gray-800/40 rounded-lg border border-dashed border-gray-200 dark:border-gray-700">
                default
              </span>
              <Handle
                type="source"
                position={Position.Right}
                id="default"
                style={{ top: 'auto', position: 'absolute', right: '-22px' }}
                className="!w-3 !h-3 !bg-gray-400 dark:!bg-gray-500 !border-2 !border-white dark:!border-gray-900 hover:!bg-gray-600 hover:!scale-150 transition-all"
              />
            </div>
          </div>
        ) : (
          /* 普通节点：配置项数量 */
          nodeData.config && Object.keys(nodeData.config).length > 0 && (
            <p className="text-xs text-gray-400 dark:text-gray-500 mt-1 truncate flex items-center gap-1">
              <span className="inline-block w-1.5 h-1.5 rounded-full bg-brand-400"></span>
              {Object.keys(nodeData.config).length} 个配置项
            </p>
          )
        )}
      </div>

      {/* 输出 Handle（意图识别节点用分类 Handle 替代，不渲染默认 Handle） */}
      {!isEnd && !isIntentRecognition && (
        <Handle
          type="source"
          position={Position.Right}
          className="!w-3.5 !h-3.5 !bg-brand-400 dark:!bg-brand-500 !border-2 !border-white dark:!border-gray-900 hover:!bg-brand-600 hover:!scale-125 transition-all"
        />
      )}

      {/* 条件分支：多个输出 Handle */}
      {(nodeData.nodeType === NodeType.CONDITION || nodeData.nodeType === NodeType.SWITCH) && (
        <Handle
          type="source"
          position={Position.Right}
          id="false"
          style={{ top: '75%' }}
          className="!w-3.5 !h-3.5 !bg-amber-400 dark:!bg-amber-500 !border-2 !border-white dark:!border-gray-900 hover:!bg-amber-600 hover:!scale-125 transition-all"
        />
      )}
    </div>
  );
};

export default memo(WorkflowNodeComponent);
