import { create } from 'zustand';
import {
  type Connection,
  type NodeChange,
  type EdgeChange,
  applyNodeChanges,
  applyEdgeChanges,
  addEdge,
  type XYPosition,
} from '@xyflow/react';
import type { WorkflowNode, WorkflowEdge } from '../types';
import { NodeType, getNodeCategoryInfo } from '../types';
import { Package, MessageSquareText } from 'lucide-react';
import { LOOP_CONTAINER_W, LOOP_CONTAINER_H } from '../nodes/LoopContainerNode';

let nodeIdCounter = 0;
const genNodeId = () => `node_${Date.now()}_${++nodeIdCounter}`;

/**
 * 逻辑节点默认配置
 *
 * 各节点创建时需要合理的初始 config，以匹配后端 Executor 的默认值处理：
 * - CONDITION: 空 conditions 列表（后端回退到单条件模式，branch="false"）
 * - SWITCH: 空 switchVariable + 空 cases 列表（后端走 default 分支）
 * - PARALLEL: 空 branches + 默认策略（后端跳过并行，直接 pass-through）
 * - MERGE: "all" 模式 + 空 sources + 输出变量 "merged"（后端合并所有输入）
 * - LOOP: 在 addNode() 中单独处理，创建容器节点 + 内部 LOOP_START/LOOP_END
 *
 * 后端 validate() 仅在 config==null 时抛异常，空 Map {} 不会报错。
 * 但提供有意义的默认值可以改善前端编辑体验。
 *
 * === 序列化流程 (toDefinition / loadFromDefinition) ===
 * 保存时：
 * 1. 顶层节点直接序列化为 { id, type, name, config, position, ... }
 * 2. LOOP 容器节点额外收集 parentId == containerId 的子节点和内部边，
 *    嵌套到 node.children = { nodes: [...], edges: [...] }
 * 3. 容器的 width/height 也会保存，以便加载时恢复尺寸
 *
 * 加载时：
 * 1. 顶层节点还原为 ReactFlow 节点（LOOP → type="loopContainer"）
 * 2. LOOP 节点的 children.nodes 还原为子节点，设置 parentId + extent="parent"
 * 3. children.edges 还原为内部边，合并到全局 edges 中
 */
const getDefaultNodeConfig = (nodeType: NodeType): Record<string, unknown> => {
  switch (nodeType) {
    case NodeType.CONDITION: return { conditions: [] };
    case NodeType.SWITCH: return { switchVariable: '', cases: [] };
    case NodeType.PARALLEL: return { branches: [], waitStrategy: 'ALL', timeout: 60000, failFast: false, mergeStrategy: 'OBJECT' };
    case NodeType.MERGE: return { mode: 'all', sources: [], outputVariable: 'merged' };
    case NodeType.JSON_PARSE: return { parseMode: 'EXTRACT', inputVariable: '', extractions: [], outputVariable: 'parsedJson', errorStrategy: 'ERROR' };
    case NodeType.INTENT_RECOGNITION: return {
      model: '', inputVariable: '', outputVariable: 'intentResult',
      intents: [], confidenceThreshold: 0.6,
      temperature: 0.1, topP: 0.9, maxTokens: 500,
    };
    case NodeType.LLM: return {
      model: '', systemPrompt: '', userPromptTemplate: '',
      temperature: 0.7, topP: 0.9, maxTokens: 4096,
      inputMappings: [], outputVariable: 'llmOutput',
      knowledgeBaseIds: [], ragTopK: 5, ragThreshold: 0.5,
      enabledCapabilities: [],
      parseJsonOutput: false, jsonSchema: '',
      historyVariable: '', historyLimit: 10,
    };
    case NodeType.DATABASE_QUERY: return {
      sql: '', outputVariable: 'queryResult', maxRows: 100,
      selectedTable: '', paramMapping: {},
    };
    case NodeType.CODE: return {
      language: 'JAVASCRIPT',
      code: '',
      inputVariables: [],
      outputVariables: [],
      requirements: '',
    };
    default: return {};
  }
};
const genEdgeId = (source: string, target: string) => `edge_${source}_${target}_${Date.now()}`;

export type EdgeStyleType = 'default' | 'smoothstep' | 'straight';

const MAX_HISTORY = 50;

interface HistorySnapshot {
  nodes: WorkflowNode[];
  edges: WorkflowEdge[];
}

interface WorkflowState {
  // 工作流元数据
  workflowId: string | null;
  workflowName: string;
  // 画布数据
  nodes: WorkflowNode[];
  edges: WorkflowEdge[];
  // 边样式
  edgeType: EdgeStyleType;
  // 选中节点
  selectedNodeId: string | null;
  // 脏标记
  isDirty: boolean;
  // Undo/Redo 历史
  _history: HistorySnapshot[];
  _historyIndex: number;
  _historyPaused: boolean;
  canUndo: boolean;
  canRedo: boolean;
  // 操作
  onNodesChange: (changes: NodeChange<WorkflowNode>[]) => void;
  onEdgesChange: (changes: EdgeChange<WorkflowEdge>[]) => void;
  onConnect: (connection: Connection) => void;
  addNode: (nodeType: NodeType, position: XYPosition) => boolean;
  addNodeToLoop: (nodeType: NodeType, relativePosition: XYPosition, parentId: string) => boolean;
  updateNodeConfig: (nodeId: string, config: Record<string, unknown>) => void;
  updateNodeLabel: (nodeId: string, label: string) => void;
  deleteNode: (nodeId: string) => void;
  selectNode: (nodeId: string | null) => void;
  setEdgeType: (type: EdgeStyleType) => void;
  // 序列化 / 反序列化
  loadFromDefinition: (definition: Record<string, unknown>, workflowId: string, name: string) => void;
  toDefinition: () => Record<string, unknown>;
  resetCanvas: () => void;
  setWorkflowMeta: (id: string | null, name: string) => void;
  markClean: () => void;
  addComment: (position: XYPosition) => void;
  updateCommentText: (nodeId: string, text: string) => void;
  undo: () => void;
  redo: () => void;
  pushHistory: () => void;
}

// 深拷贝快照（只拷贝节点和边的结构数据，icon 等引用保持共享）
const cloneSnapshot = (nodes: WorkflowNode[], edges: WorkflowEdge[]): HistorySnapshot => ({
  nodes: nodes.map((n) => ({ ...n, position: { ...n.position }, data: { ...n.data, config: { ...n.data.config } }, style: n.style ? { ...n.style } : undefined })),
  edges: edges.map((e) => ({ ...e })),
});

export const useWorkflowStore = create<WorkflowState>((set, get) => ({
  workflowId: null,
  workflowName: '',
  nodes: [],
  edges: [],
  edgeType: 'default',
  selectedNodeId: null,
  isDirty: false,
  _history: [],
  _historyIndex: -1,
  _historyPaused: false,
  canUndo: false,
  canRedo: false,

  pushHistory: () => {
    const { nodes, edges, _history, _historyIndex, _historyPaused } = get();
    if (_historyPaused) return;
    const snap = cloneSnapshot(nodes, edges);
    // 截断 redo 分支
    const newHistory = _history.slice(0, _historyIndex + 1);
    newHistory.push(snap);
    // 限制最大长度
    if (newHistory.length > MAX_HISTORY) newHistory.shift();
    const newIndex = newHistory.length - 1;
    set({ _history: newHistory, _historyIndex: newIndex, canUndo: newIndex > 0, canRedo: false });
  },

  undo: () => {
    const { _history, _historyIndex } = get();
    if (_historyIndex <= 0) return;
    const newIndex = _historyIndex - 1;
    const snap = _history[newIndex];
    set({
      nodes: snap.nodes.map((n) => ({ ...n, position: { ...n.position }, data: { ...n.data, config: { ...n.data.config } } })),
      edges: snap.edges.map((e) => ({ ...e })),
      _historyIndex: newIndex,
      canUndo: newIndex > 0,
      canRedo: true,
      isDirty: true,
      selectedNodeId: null,
    });
  },

  redo: () => {
    const { _history, _historyIndex } = get();
    if (_historyIndex >= _history.length - 1) return;
    const newIndex = _historyIndex + 1;
    const snap = _history[newIndex];
    set({
      nodes: snap.nodes.map((n) => ({ ...n, position: { ...n.position }, data: { ...n.data, config: { ...n.data.config } } })),
      edges: snap.edges.map((e) => ({ ...e })),
      _historyIndex: newIndex,
      canUndo: true,
      canRedo: newIndex < _history.length - 1,
      isDirty: true,
      selectedNodeId: null,
    });
  },

  onNodesChange: (changes) => {
    set((state) => ({
      nodes: applyNodeChanges(changes, state.nodes),
      isDirty: true,
    }));
  },

  onEdgesChange: (changes) => {
    set((state) => ({
      edges: applyEdgeChanges(changes, state.edges),
      isDirty: true,
    }));
  },

  onConnect: (connection) => {
    // 自环检查：禁止节点连接自己
    if (connection.source === connection.target) {
      console.warn('[onConnect] 禁止自环连线:', connection.source);
      return;
    }
    const { edges: currentEdges, nodes: currentNodes } = get();

    // 重复连线检查：同 source+sourceHandle → target+targetHandle 不允许重复
    const duplicate = currentEdges.some(
      (e) =>
        e.source === connection.source &&
        e.target === connection.target &&
        (e.sourceHandle ?? null) === (connection.sourceHandle ?? null) &&
        (e.targetHandle ?? null) === (connection.targetHandle ?? null)
    );
    if (duplicate) {
      console.warn('[onConnect] 禁止重复连线:', connection.source, '->', connection.target);
      return;
    }

    // ===== 出边数量限制：每个 sourceHandle 只能连一条出边 =====
    // 所有节点类型都适用此规则（普通节点只有 1 个默认 Handle，分支节点每个分类/条件 Handle 各限 1 条）
    const existingFromHandle = currentEdges.filter(
      (e) => e.source === connection.source &&
        (e.sourceHandle ?? null) === (connection.sourceHandle ?? null)
    );
    if (existingFromHandle.length > 0) {
      console.warn('[onConnect] 该 Handle 已有出边，替换旧连线:', connection.source, connection.sourceHandle);
      // 移除旧边，替换为新边（让用户可以重新连线而不需要先删除）
      const oldEdgeIds = new Set(existingFromHandle.map((e) => e.id));
      get().pushHistory();
      set((state) => ({
        edges: addEdge(
          { ...connection, id: genEdgeId(connection.source, connection.target), type: state.edgeType, animated: true },
          state.edges.filter((e) => !oldEdgeIds.has(e.id))
        ),
        isDirty: true,
      }));
      return;
    }

    // ===== 入边数量限制：每个 target 节点只允许 1 条入边（分支汇合除外） =====
    const targetNode = currentNodes.find((n) => n.id === connection.target);
    const targetType = targetNode?.data?.nodeType;
    // MERGE 节点允许多条入边，其他节点限制 1 条
    if (targetType !== NodeType.MERGE) {
      const existingToTarget = currentEdges.filter(
        (e) => e.target === connection.target &&
          (e.targetHandle ?? null) === (connection.targetHandle ?? null)
      );
      if (existingToTarget.length > 0) {
        console.warn('[onConnect] 目标节点已有入边，替换旧连线:', connection.target);
        const oldEdgeIds = new Set(existingToTarget.map((e) => e.id));
        get().pushHistory();
        set((state) => ({
          edges: addEdge(
            { ...connection, id: genEdgeId(connection.source, connection.target), type: state.edgeType, animated: true },
            state.edges.filter((e) => !oldEdgeIds.has(e.id))
          ),
          isDirty: true,
        }));
        return;
      }
    }

    get().pushHistory();
    set((state) => ({
      edges: addEdge(
        { ...connection, id: genEdgeId(connection.source, connection.target), type: state.edgeType, animated: true },
        state.edges
      ),
      isDirty: true,
    }));
  },

  addNode: (nodeType, position) => {
    // START / END 节点唯一性校验
    const SINGLETON_TYPES: string[] = [NodeType.START, NodeType.END];
    if (SINGLETON_TYPES.includes(nodeType)) {
      const exists = get().nodes.some((n) => n.data.nodeType === nodeType);
      if (exists) return false;
    }

    const info = getNodeCategoryInfo(nodeType);

    // LOOP 节点 → 创建容器节点（开始/结束已内嵌为容器 Handle）
    if (nodeType === NodeType.LOOP) {
      const containerNode: WorkflowNode = {
        id: genNodeId(),
        type: 'loopContainer',
        position,
        zIndex: -1,
        style: { width: LOOP_CONTAINER_W, height: LOOP_CONTAINER_H },
        data: {
          nodeType,
          label: info?.label || '循环',
          icon: info?.icon || Package,
          config: { loopType: 'FOR_EACH', iterableVariable: '', itemVariable: 'item', indexVariable: 'index', maxIterations: 100, resultVariable: 'loopResults' },
        },
      };
      get().pushHistory();
      set((state) => ({ nodes: [...state.nodes, containerNode], isDirty: true }));
      return true;
    }

    const newNode: WorkflowNode = {
      id: genNodeId(),
      type: 'workflowNode',
      position,
      data: {
        nodeType,
        label: info?.label || nodeType,
        icon: info?.icon || Package,
        config: getDefaultNodeConfig(nodeType),
      },
    };
    get().pushHistory();
    set((state) => ({
      nodes: [...state.nodes, newNode],
      isDirty: true,
    }));
    return true;
  },

  addNodeToLoop: (nodeType, relativePosition, parentId) => {
    const info = getNodeCategoryInfo(nodeType);
    const newNode: WorkflowNode = {
      id: genNodeId(),
      type: 'workflowNode',
      position: relativePosition,
      parentId,
      extent: 'parent',
      data: {
        nodeType,
        label: info?.label || nodeType,
        icon: info?.icon || Package,
        config: {},
      },
    };
    get().pushHistory();
    set((state) => ({ nodes: [...state.nodes, newNode], isDirty: true }));
    return true;
  },

  updateNodeConfig: (nodeId, config) => {
    set((state) => ({
      nodes: state.nodes.map((n) =>
        n.id === nodeId ? { ...n, data: { ...n.data, config: { ...n.data.config, ...config } } } : n
      ),
      isDirty: true,
    }));
  },

  updateNodeLabel: (nodeId, label) => {
    set((state) => ({
      nodes: state.nodes.map((n) =>
        n.id === nodeId ? { ...n, data: { ...n.data, label } } : n
      ),
      isDirty: true,
    }));
  },

  deleteNode: (nodeId) => {
    get().pushHistory();
    set((state) => {
      // 如果删除循环容器，级联删除所有子节点
      const childIds = new Set(state.nodes.filter((n) => n.parentId === nodeId).map((n) => n.id));
      const allDeletedIds = new Set([nodeId, ...childIds]);
      return {
        nodes: state.nodes.filter((n) => !allDeletedIds.has(n.id)),
        edges: state.edges.filter((e) => !allDeletedIds.has(e.source) && !allDeletedIds.has(e.target)),
        selectedNodeId: allDeletedIds.has(state.selectedNodeId || '') ? null : state.selectedNodeId,
        isDirty: true,
      };
    });
  },

  selectNode: (nodeId) => {
    set({ selectedNodeId: nodeId });
  },

  setEdgeType: (type) => {
    set((state) => ({
      edgeType: type,
      edges: state.edges.map((e) => ({ ...e, type })),
    }));
  },

  loadFromDefinition: (definition, workflowId, name) => {
    const currentEdgeType = get().edgeType;
    const rawNodes = (definition.nodes as Array<Record<string, unknown>>) || [];
    const rawEdges = (definition.edges as Array<Record<string, unknown>>) || [];

    const nodes: WorkflowNode[] = [];
    const edges: WorkflowEdge[] = [];

    // —— 去重：后端 flattenChildren() 会把子节点/内部边展平到主列表，
    // 但 LOOP 节点的 children 属性仍保留，导致数据重复。
    // 先收集所有 LOOP children 中的节点/边 ID，在主列表中跳过它们。 ——
    const childNodeIds = new Set<string>();
    const childEdgeIds = new Set<string>();
    for (const n of rawNodes) {
      if ((n.type as string) === NodeType.LOOP && n.children) {
        const ch = n.children as { nodes?: Array<Record<string, unknown>>; edges?: Array<Record<string, unknown>> };
        if (ch.nodes) ch.nodes.forEach((cn) => childNodeIds.add(cn.id as string));
        if (ch.edges) ch.edges.forEach((ce) => { if (ce.id) childEdgeIds.add(ce.id as string); });
      }
    }

    for (const n of rawNodes) {
      const nid = n.id as string;
      // 跳过被 flattenChildren 展平到主列表的子节点（会从 children 中还原）
      if (childNodeIds.has(nid)) continue;

      const nt = (n.type as string) || NodeType.START;
      const info = getNodeCategoryInfo(nt as NodeType);
      const pos = n.position as { x?: number; y?: number } | undefined;
      const isLoop = nt === NodeType.LOOP;

      // CONDITION 节点：单条件格式（variable/operator/value）→ 还原为 conditions 数组供 UI 使用
      let nodeConfig = (n.config as Record<string, unknown>) || {};
      if (nt === NodeType.CONDITION) {
        const conds = (nodeConfig.conditions as Array<unknown>) || [];
        if (conds.length === 0 && nodeConfig.variable) {
          nodeConfig = { ...nodeConfig, conditions: [{ name: '条件 1', conditionType: 'VARIABLE_COMPARE', variable: nodeConfig.variable, operator: nodeConfig.operator || '==', compareValue: nodeConfig.value || '', expression: '' }] };
        }
      }

      nodes.push({
        id: nid,
        type: isLoop ? 'loopContainer' : 'workflowNode',
        position: { x: pos?.x ?? 0, y: pos?.y ?? 0 },
        ...(isLoop ? {
        zIndex: -1,
        style: {
          width: (n.width as number) ?? (n.style as Record<string, unknown>)?.width ?? LOOP_CONTAINER_W,
          height: (n.height as number) ?? (n.style as Record<string, unknown>)?.height ?? LOOP_CONTAINER_H,
        },
      } : {}),
        data: {
          nodeType: nt as NodeType,
          label: (n.name as string) || info?.label || nt,
          icon: info?.icon || Package,
          config: nodeConfig,
        },
      });

      // 循环容器：还原子节点和内部边
      if (isLoop && n.children) {
        const ch = n.children as { nodes?: Array<Record<string, unknown>>; edges?: Array<Record<string, unknown>> };
        if (ch.nodes) {
          for (const cn of ch.nodes) {
            const cnt = (cn.type as string) || NodeType.LLM;
            const cinfo = getNodeCategoryInfo(cnt as NodeType);
            const cpos = cn.position as { x?: number; y?: number } | undefined;
            nodes.push({
              id: cn.id as string,
              type: 'workflowNode',
              position: { x: cpos?.x ?? 80, y: cpos?.y ?? 60 },
              parentId: nid,
              extent: 'parent',
              data: {
                nodeType: cnt as NodeType,
                label: (cn.name as string) || cinfo?.label || cnt,
                icon: cinfo?.icon || Package,
                config: (cn.config as Record<string, unknown>) || {},
              },
            });
          }
        }
        if (ch.edges) {
          for (const ce of ch.edges) {
            edges.push({
              id: (ce.id as string) || genEdgeId(ce.sourceNodeId as string, ce.targetNodeId as string),
              source: (ce.sourceNodeId as string) || '',
              target: (ce.targetNodeId as string) || '',
              sourceHandle: (ce.sourceHandle as string) || undefined,
              targetHandle: (ce.targetHandle as string) || undefined,
              type: currentEdgeType,
              animated: true,
            });
          }
        }
      }
    }

    // 顶层边（跳过已在 children 中还原的内部边）
    for (const e of rawEdges) {
      const eid = (e.id as string) || genEdgeId(e.sourceNodeId as string, e.targetNodeId as string);
      if (childEdgeIds.has(eid)) continue;
      edges.push({
        id: eid,
        source: (e.sourceNodeId as string) || '',
        target: (e.targetNodeId as string) || '',
        sourceHandle: (e.sourceHandle as string) || undefined,
        targetHandle: (e.targetHandle as string) || undefined,
        type: currentEdgeType,
        animated: true,
        label: (e.label as string) || undefined,
      });
    }

    // 恢复注释节点
    const rawComments = (definition.comments as Array<Record<string, unknown>>) || [];
    for (const c of rawComments) {
      const pos = c.position as { x?: number; y?: number } | undefined;
      nodes.push({
        id: (c.id as string) || `comment_${Date.now()}_${++nodeIdCounter}`,
        type: 'commentNode',
        position: { x: pos?.x ?? 0, y: pos?.y ?? 0 },
        style: { width: (c.width as number) ?? 240, height: (c.height as number) ?? 140 },
        data: {
          nodeType: '__COMMENT__' as NodeType,
          label: '注释',
          icon: Package,
          config: { text: (c.text as string) || '', color: (c.color as string) || '#fef9c3' },
        },
      });
    }

    // 初始化历史（加载后的初始快照）
    const initSnap = cloneSnapshot(nodes, edges);
    set({ nodes, edges, workflowId, workflowName: name, selectedNodeId: null, isDirty: false, _history: [initSnap], _historyIndex: 0, canUndo: false, canRedo: false });
  },

  toDefinition: () => {
    const { nodes, edges } = get();

    // 调试：打印 store 中所有节点和边的概况
    console.log('[toDefinition] total nodes:', nodes.length, 'total edges:', edges.length);
    nodes.forEach((n) => {
      console.log('[toDefinition] node:', n.id, 'type:', n.type, 'nodeType:', n.data.nodeType, 'parentId:', n.parentId ?? '(none)');
    });
    edges.forEach((e) => {
      console.log('[toDefinition] edge:', e.id, 'src:', e.source, 'srcH:', e.sourceHandle, '→ tgt:', e.target, 'tgtH:', e.targetHandle);
    });

    // 注释节点单独序列化，不参与工作流执行
    const commentNodes = nodes.filter((n) => n.type === 'commentNode');
    const workflowNodes = nodes.filter((n) => n.type !== 'commentNode');

    // 区分顶层节点和子节点
    // 1) 显式子节点：parentId 已设置
    const childNodesByParent = new Map<string, WorkflowNode[]>();
    for (const n of workflowNodes) {
      if (n.parentId) {
        if (!childNodesByParent.has(n.parentId)) childNodesByParent.set(n.parentId, []);
        childNodesByParent.get(n.parentId)!.push(n);
      }
    }
    // 2) 隐式子节点：没有 parentId，但通过 loop-start/loop-end 句柄连接到 LOOP 容器
    const loopNodes = workflowNodes.filter((n) => n.data.nodeType === NodeType.LOOP);
    for (const loop of loopNodes) {
      if (!childNodesByParent.has(loop.id)) childNodesByParent.set(loop.id, []);
      const existingChildIds = new Set(childNodesByParent.get(loop.id)!.map((c) => c.id));
      edges.forEach((e) => {
        // loop-start → target：target 是隐式子节点
        if (e.source === loop.id && e.sourceHandle === 'loop-start') {
          const tgt = workflowNodes.find((nd) => nd.id === e.target);
          if (tgt && !existingChildIds.has(tgt.id)) {
            childNodesByParent.get(loop.id)!.push(tgt);
            existingChildIds.add(tgt.id);
          }
        }
        // source → loop-end：source 是隐式子节点
        if (e.target === loop.id && e.targetHandle === 'loop-end') {
          const src = workflowNodes.find((nd) => nd.id === e.source);
          if (src && !existingChildIds.has(src.id)) {
            childNodesByParent.get(loop.id)!.push(src);
            existingChildIds.add(src.id);
          }
        }
      });
    }
    // 收集所有子节点 ID（包括隐式）
    const allChildIds = new Set<string>();
    childNodesByParent.forEach((children) => children.forEach((c) => allChildIds.add(c.id)));
    const topNodes = workflowNodes.filter((n) => !n.parentId && !allChildIds.has(n.id));

    const serNode = (n: WorkflowNode, parentPos?: { x: number; y: number }): Record<string, unknown> => {
      // 如果是隐式子节点（无 parentId 但被识别为子节点），将绝对坐标转为相对坐标
      const posX = parentPos && !n.parentId ? n.position.x - parentPos.x : n.position.x;
      const posY = parentPos && !n.parentId ? n.position.y - parentPos.y : n.position.y;
      // CONDITION 节点：1 个 VARIABLE_COMPARE 条件 → 单条件格式（后端走 true/false 路由，false Handle 生效）
      let nodeConfig = n.data.config;
      if (n.data.nodeType === NodeType.CONDITION) {
        const conds = (nodeConfig.conditions as Array<Record<string, unknown>>) || [];
        if (conds.length === 1 && (conds[0]?.conditionType ?? 'VARIABLE_COMPARE') === 'VARIABLE_COMPARE') {
          const c = conds[0];
          nodeConfig = { ...nodeConfig, conditions: [], variable: c.variable, operator: c.operator, value: c.compareValue };
        }
      }
      const base: Record<string, unknown> = {
        id: n.id,
        type: n.data.nodeType,
        name: n.data.label,
        position: { x: Math.round(posX), y: Math.round(posY) },
        config: nodeConfig,
      };
      // 保存容器尺寸
      if (n.style?.width || n.style?.height) {
        base.width = n.style.width;
        base.height = n.style.height;
      }
      return base;
    };

    return {
      version: '1.0',
      nodes: topNodes.map((n) => {
        const base = serNode(n);
        // 循环容器：嵌套子节点和内部边
        if (n.data.nodeType === NodeType.LOOP) {
          const children = childNodesByParent.get(n.id) || [];
          const childIds = new Set(children.map((c) => c.id));
          const internalEdges = edges.filter(
            (e) =>
              (childIds.has(e.source) && childIds.has(e.target)) ||
              (e.source === n.id && e.sourceHandle === 'loop-start' && childIds.has(e.target)) ||
              (childIds.has(e.source) && e.target === n.id && e.targetHandle === 'loop-end')
          );
          base.children = {
            nodes: children.map((c) => serNode(c, n.position)),
            edges: internalEdges.map((e) => ({
              id: e.id,
              sourceNodeId: e.source,
              targetNodeId: e.target,
              sourceHandle: e.sourceHandle || null,
              targetHandle: e.targetHandle || null,
              label: e.label || null,
            })),
          };
        }
        return base;
      }),
      edges: edges
        .filter((e) => {
          // 排除内部边（已嵌套在循环节点里）
          if (allChildIds.has(e.source) && allChildIds.has(e.target)) return false;
          // 排除 loop-start → child 的边
          // 排除注释节点相关的边
          const commentIds = new Set(commentNodes.map((c) => c.id));
          if (commentIds.has(e.source) || commentIds.has(e.target)) return false;
          const srcNode = workflowNodes.find((nd) => nd.id === e.source);
          if (srcNode?.data.nodeType === NodeType.LOOP && e.sourceHandle === 'loop-start') return false;
          // 排除 child → loop-end 的边
          const tgtNode = workflowNodes.find((nd) => nd.id === e.target);
          if (tgtNode?.data.nodeType === NodeType.LOOP && e.targetHandle === 'loop-end') return false;
          return true;
        })
        .map((e) => ({
          id: e.id,
          sourceNodeId: e.source,
          targetNodeId: e.target,
          sourceHandle: e.sourceHandle || null,
          targetHandle: e.targetHandle || null,
          label: e.label || null,
        })),
      comments: commentNodes.map((c) => ({
        id: c.id,
        position: { x: Math.round(c.position.x), y: Math.round(c.position.y) },
        width: c.style?.width ?? 240,
        height: c.style?.height ?? 140,
        text: (c.data.config.text as string) || '',
        color: (c.data.config.color as string) || '#fef9c3',
      })),
      variables: {},
      settings: { maxExecutionTimeMs: 60000, enableLogging: true, logLevel: 'INFO', enableDebug: false },
    };
  },

  resetCanvas: () => {
    set({ nodes: [], edges: [], selectedNodeId: null, isDirty: false, workflowId: null, workflowName: '' });
  },

  setWorkflowMeta: (id, name) => {
    set({ workflowId: id, workflowName: name });
  },

  markClean: () => {
    set({ isDirty: false });
  },

  addComment: (position) => {
    const newNode: WorkflowNode = {
      id: `comment_${Date.now()}_${++nodeIdCounter}`,
      type: 'commentNode',
      position,
      style: { width: 240, height: 140 },
      data: {
        nodeType: '__COMMENT__' as NodeType,
        label: '注释',
        icon: MessageSquareText,
        config: { text: '', color: '#fef9c3' },
      },
    };
    get().pushHistory();
    set((state) => ({ nodes: [...state.nodes, newNode], isDirty: true }));
  },

  updateCommentText: (nodeId, text) => {
    set((state) => ({
      nodes: state.nodes.map((n) =>
        n.id === nodeId ? { ...n, data: { ...n.data, config: { ...n.data.config, text } } } : n
      ),
      isDirty: true,
    }));
  },
}));
