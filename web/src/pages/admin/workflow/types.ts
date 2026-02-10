import type { Node, Edge } from '@xyflow/react';
import type { LucideIcon } from 'lucide-react';
import {
  Play, Bot, Crosshair, Tag,
  GitBranch, ToggleLeft, Repeat, Zap, Merge,
  PenLine, BookOpenCheck, Braces, FileCode, Code,
  Globe, Database, FolderOpen, Save,
  Square, CirclePlay, CircleStop,
} from 'lucide-react';

// 与后端 NodeType 枚举对齐
export const NodeType = {
  // 触发节点
  START: 'START',
  WEBHOOK: 'WEBHOOK',
  SCHEDULE: 'SCHEDULE',
  // AI节点
  LLM: 'LLM',
  KNOWLEDGE_RETRIEVAL: 'KNOWLEDGE_RETRIEVAL',
  TEXT_EMBEDDING: 'TEXT_EMBEDDING',
  INTENT_RECOGNITION: 'INTENT_RECOGNITION',
  ENTITY_EXTRACTION: 'ENTITY_EXTRACTION',
  // 逻辑节点
  CONDITION: 'CONDITION',
  SWITCH: 'SWITCH',
  LOOP: 'LOOP',
  LOOP_START: 'LOOP_START',
  LOOP_END: 'LOOP_END',
  PARALLEL: 'PARALLEL',
  MERGE: 'MERGE',
  // 数据处理节点
  VARIABLE_SET: 'VARIABLE_SET',
  VARIABLE_GET: 'VARIABLE_GET',
  JSON_PARSE: 'JSON_PARSE',
  TEMPLATE: 'TEMPLATE',
  CODE: 'CODE',
  // 集成节点
  HTTP_REQUEST: 'HTTP_REQUEST',
  DATABASE_QUERY: 'DATABASE_QUERY',
  FILE_READ: 'FILE_READ',
  FILE_WRITE: 'FILE_WRITE',
  // 输出节点
  RESPONSE: 'RESPONSE',
  END: 'END',
} as const;

export type NodeType = typeof NodeType[keyof typeof NodeType];

export interface NodeCategory {
  label: string;
  color: string;
  bgColor: string;
  borderColor: string;
  darkBgColor: string;
  darkBorderColor: string;
  types: { type: NodeType; label: string; icon: LucideIcon }[];
}

export const NODE_CATEGORIES: NodeCategory[] = [
  {
    label: '触发',
    color: 'text-emerald-600',
    bgColor: 'bg-emerald-50',
    borderColor: 'border-emerald-200',
    darkBgColor: 'dark:bg-emerald-900/20',
    darkBorderColor: 'dark:border-emerald-800',
    types: [
      { type: NodeType.START, label: '开始', icon: Play },
    ],
  },
  {
    label: 'AI',
    color: 'text-violet-600',
    bgColor: 'bg-violet-50',
    borderColor: 'border-violet-200',
    darkBgColor: 'dark:bg-violet-900/20',
    darkBorderColor: 'dark:border-violet-800',
    types: [
      { type: NodeType.LLM, label: 'LLM 模型', icon: Bot },
      { type: NodeType.INTENT_RECOGNITION, label: '意图识别', icon: Crosshair },
      { type: NodeType.ENTITY_EXTRACTION, label: '实体抽取', icon: Tag },
    ],
  },
  {
    label: '逻辑',
    color: 'text-amber-600',
    bgColor: 'bg-amber-50',
    borderColor: 'border-amber-200',
    darkBgColor: 'dark:bg-amber-900/20',
    darkBorderColor: 'dark:border-amber-800',
    types: [
      { type: NodeType.CONDITION, label: '条件分支', icon: GitBranch },
      { type: NodeType.SWITCH, label: '多路分支', icon: ToggleLeft },
      { type: NodeType.LOOP, label: '循环', icon: Repeat },
      { type: NodeType.PARALLEL, label: '并行', icon: Zap },
      { type: NodeType.MERGE, label: '合并', icon: Merge },
    ],
  },
  {
    label: '数据处理',
    color: 'text-blue-600',
    bgColor: 'bg-blue-50',
    borderColor: 'border-blue-200',
    darkBgColor: 'dark:bg-blue-900/20',
    darkBorderColor: 'dark:border-blue-800',
    types: [
      { type: NodeType.VARIABLE_SET, label: '设置变量', icon: PenLine },
      { type: NodeType.VARIABLE_GET, label: '获取变量', icon: BookOpenCheck },
      { type: NodeType.JSON_PARSE, label: 'JSON 解析', icon: Braces },
      { type: NodeType.TEMPLATE, label: '模板渲染', icon: FileCode },
      { type: NodeType.CODE, label: '代码执行', icon: Code },
    ],
  },
  {
    label: '集成',
    color: 'text-cyan-600',
    bgColor: 'bg-cyan-50',
    borderColor: 'border-cyan-200',
    darkBgColor: 'dark:bg-cyan-900/20',
    darkBorderColor: 'dark:border-cyan-800',
    types: [
      { type: NodeType.HTTP_REQUEST, label: 'HTTP 请求', icon: Globe },
      { type: NodeType.DATABASE_QUERY, label: '数据库查询', icon: Database },
      { type: NodeType.FILE_READ, label: '文件读取', icon: FolderOpen },
      { type: NodeType.FILE_WRITE, label: '文件写入', icon: Save },
    ],
  },
  {
    label: '输出',
    color: 'text-rose-600',
    bgColor: 'bg-rose-50',
    borderColor: 'border-rose-200',
    darkBgColor: 'dark:bg-rose-900/20',
    darkBorderColor: 'dark:border-rose-800',
    types: [
      { type: NodeType.END, label: '结束', icon: Square },
    ],
  },
];

// 根据 NodeType 获取分类信息
// 循环内部节点（不在工具栏展示，仅内部使用）
const LOOP_INTERNAL_NODES: Record<string, { type: NodeType; label: string; icon: LucideIcon }> = {
  [NodeType.LOOP_START]: { type: NodeType.LOOP_START, label: '循环开始', icon: CirclePlay },
  [NodeType.LOOP_END]:   { type: NodeType.LOOP_END,   label: '循环结束', icon: CircleStop },
};

export function getNodeCategoryInfo(nodeType: NodeType) {
  // 先查循环内部节点
  const internal = LOOP_INTERNAL_NODES[nodeType];
  if (internal) {
    const loopCat = NODE_CATEGORIES.find((c) => c.types.some((t) => t.type === NodeType.LOOP));
    return { ...internal, category: loopCat! };
  }
  for (const cat of NODE_CATEGORIES) {
    const found = cat.types.find((t) => t.type === nodeType);
    if (found) {
      return { ...found, category: cat };
    }
  }
  return null;
}

// 自定义节点数据
export interface WorkflowNodeData {
  nodeType: NodeType;
  label: string;
  icon: LucideIcon;
  config: Record<string, unknown>;
  [key: string]: unknown;
}

export type WorkflowNode = Node<WorkflowNodeData>;
export type WorkflowEdge = Edge;
