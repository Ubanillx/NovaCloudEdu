import React, { useCallback, useRef, useEffect, useState } from 'react';
import {
  ReactFlow,
  Background,
  MiniMap,
  type ReactFlowInstance,
  BackgroundVariant,
  Panel,
  SelectionMode,
} from '@xyflow/react';
import type { WorkflowNode as FlowNode, WorkflowEdge as FlowEdge } from './types';
import '@xyflow/react/dist/style.css';
import { useParams, useNavigate } from 'react-router-dom';
import { Save, ArrowLeft, Play, Loader2, X, Bug, ChevronDown, ChevronRight, CheckCircle2, XCircle, Clock, AlertTriangle, Undo2, Redo2, History, GitBranch, Zap, BookTemplate } from 'lucide-react';
import { apiClient, DefaultApi, Configuration } from '../../../api';
import { toast } from '../../../components/ui';
import type { WorkflowDefinition as ApiWorkflowDefinition } from '../../../api/generated/models';

import WorkflowNodeComponent from './nodes/WorkflowNodeComponent';
import LoopContainerNode, { LOOP_CONTAINER_W, LOOP_CONTAINER_H } from './nodes/LoopContainerNode';
import CommentNode from './nodes/CommentNode';
import { CanvasToolbar, type InteractionMode } from './components/CanvasToolbar';
import { NodeConfigPanel } from './components/NodeConfigPanel';
import { VersionHistoryPanel } from './components/VersionHistoryPanel';
import { TriggerManagerPanel } from './components/TriggerManagerPanel';
import { SaveAsTemplateModal } from './components/SaveAsTemplateModal';
import { useWorkflowStore } from './store/useWorkflowStore';
import { NodeType } from './types';
import { autoLayout } from './utils/autoLayout';

const api = new DefaultApi(new Configuration(), '', apiClient);
const nodeTypes = { workflowNode: WorkflowNodeComponent, loopContainer: LoopContainerNode, commentNode: CommentNode };

export const WorkflowEditorPage: React.FC = () => {
  const { id: workflowId } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const reactFlowWrapper = useRef<HTMLDivElement>(null);
  const [rfInstance, setRfInstance] = useState<ReactFlowInstance<FlowNode, FlowEdge> | null>(null);
  const [saving, setSaving] = useState(false);
  const [loading, setLoading] = useState(true);
  const [executeModalOpen, setExecuteModalOpen] = useState(false);
  const [executeInputs, setExecuteInputs] = useState<Record<string, string>>({});
  const [executing, setExecuting] = useState(false);
  const [debugResult, setDebugResult] = useState<Record<string, unknown> | null>(null);
  const [debugOpen, setDebugOpen] = useState(false);
  const [expandedNodes, setExpandedNodes] = useState<Set<string>>(new Set());
  const [isLocked, setIsLocked] = useState(false);
  const [lastSavedAt, setLastSavedAt] = useState<Date | null>(null);
  const [interactionMode, setInteractionMode] = useState<InteractionMode>('hand');
  const [historyOpen, setHistoryOpen] = useState(false);
  const [historyList, setHistoryList] = useState<Array<Record<string, unknown>>>([]);
  const [historyLoading, setHistoryLoading] = useState(false);
  const [historyStats, setHistoryStats] = useState<Record<string, unknown> | null>(null);
  const [debugTab, setDebugTab] = useState<'nodes' | 'logs'>('nodes');
  const [executionLogs, setExecutionLogs] = useState<Array<Record<string, unknown>>>([]);
  const [logsLoading, setLogsLoading] = useState(false);
  const [logLevelFilter, setLogLevelFilter] = useState<string>('');
  const [versionPanelOpen, setVersionPanelOpen] = useState(false);
  const [triggerPanelOpen, setTriggerPanelOpen] = useState(false);
  const [templateModalOpen, setTemplateModalOpen] = useState(false);

  const {
    nodes, edges, selectedNodeId, isDirty, workflowName,
    onNodesChange, onEdgesChange, onConnect,
    addNode, addNodeToLoop, selectNode, loadFromDefinition, toDefinition, markClean,
    edgeType, setEdgeType,
    undo, redo, canUndo, canRedo, pushHistory,
  } = useWorkflowStore();
  const autoSaveRef = useRef<ReturnType<typeof setInterval> | null>(null);

  // 加载工作流数据
  useEffect(() => {
    if (!workflowId) { setLoading(false); return; }
    const load = async () => {
      try {
        // 使用 getById 的 definition JSON 字符串加载，
        // 它包含完整的 children / width / height 等信息（getDefinition 接口的 DTO 会丢弃这些字段）
        const infoResp = await api.getById({ id: workflowId as unknown as number });
        const name = infoResp.data.data?.name || '未命名工作流';
        const defJson = infoResp.data.data?.definition;
        console.log('[workflow-load] definition type:', typeof defJson, 'value:', defJson?.substring?.(0, 200));
        if (defJson && typeof defJson === 'string') {
          try {
            const defObj = JSON.parse(defJson) as Record<string, unknown>;
            // 调试：检查 LOOP 节点是否有 children
            const loopNodes = ((defObj.nodes as Array<Record<string, unknown>>) || []).filter((n) => n.type === 'LOOP');
            loopNodes.forEach((ln) => {
              console.log('[workflow-load] LOOP node:', ln.id, 'has children:', !!ln.children,
                'children.nodes:', (ln.children as Record<string, unknown>)?.nodes ? (((ln.children as Record<string, unknown>).nodes) as unknown[]).length : 0,
                'children.edges:', (ln.children as Record<string, unknown>)?.edges ? (((ln.children as Record<string, unknown>).edges) as unknown[]).length : 0,
              );
            });
            loadFromDefinition(defObj, workflowId, name);
          } catch (e) {
            console.error('[workflow-load] JSON parse failed:', e);
            loadFromDefinition({ version: '1.0', nodes: [], edges: [] }, workflowId, name);
          }
        } else {
          console.warn('[workflow-load] definition is not a string, falling back to empty');
          loadFromDefinition({ version: '1.0', nodes: [], edges: [] }, workflowId, name);
        }
      } catch (err) {
        console.error('加载工作流失败', err);
        toast.error('加载工作流失败');
        loadFromDefinition({ version: '1.0', nodes: [], edges: [] }, workflowId || '', '未命名');
      } finally {
        setLoading(false);
      }
    };
    load();
  }, [workflowId, loadFromDefinition]);

  /**
   * 保存前图结构校验
   *
   * === 校验项 ===
   * 1. START/END 节点存在性（START 缺失 → error，END 缺失 → warning）
   * 2. 孤立节点检测（排除 LOOP 子节点和注释节点）
   * 3. CONDITION/SWITCH 出边完整性（无出边 → error，单出边 → warning）
   * 4. LOOP 节点 loop-start/output 出边检查
   * 5. PARALLEL 节点分支配置和出边检查
   * 6. MERGE 节点入边检查（无入边 → warning）
   * 7. CONDITION/SWITCH 分支名称重复检测
   * 8. LOOP FOR_COUNT 循环次数校验
   * 9. START 无入边 / END 无出边
   * 10. SWITCH 节点 "false" Handle 出边无效检查
   *
   * === 与后端引擎路由的对应关系 ===
   * - CONDITION/SWITCH: 引擎用 output.branch/matchedBranch 匹配 edge.sourceHandle
   *   · 单条件模式: branch="true"/"false" → 默认Handle/"false"Handle ✓
   *   · 多条件/Switch: branch=name/"default" → 全部 fallback 到默认Handle
   *   · 完全无匹配边 → 引擎抛 IllegalStateException（工作流中断）
   * - LOOP: 引擎走 sourceHandle="output" 的边
   * - PARALLEL: 引擎走普通出边（非 loop-start/loop-end）
   * - 其他: 引擎走第一条满足条件的出边
   */
  const validateGraph = useCallback((): { errors: string[]; warnings: string[] } => {
    const errors: string[] = [];
    const warnings: string[] = [];

    // 1. START / END 节点存在性
    const hasStart = nodes.some((n) => n.data.nodeType === NodeType.START);
    const hasEnd = nodes.some((n) => n.data.nodeType === NodeType.END);
    if (!hasStart) errors.push('缺少"开始"节点，工作流无法执行');
    if (!hasEnd) warnings.push('缺少"结束"节点，工作流将在最后一个节点后自动结束');

    // 2. 孤立节点检测（排除 LOOP 子节点和注释节点）
    const connectedIds = new Set<string>();
    edges.forEach((e) => { connectedIds.add(e.source); connectedIds.add(e.target); });
    const topNodes = nodes.filter((n) => !n.parentId && n.type !== 'commentNode');
    const orphans = topNodes.filter((n) => !connectedIds.has(n.id) && n.data.nodeType !== NodeType.START);
    if (orphans.length > 0) {
      warnings.push(`存在 ${orphans.length} 个未连接的孤立节点（${orphans.map((n) => n.data.label).join('、')}），这些节点不会被执行`);
    }

    // 3. 条件/Switch 节点出边完整性
    const conditionNodes = nodes.filter((n) => n.data.nodeType === NodeType.CONDITION || n.data.nodeType === NodeType.SWITCH);
    for (const cn of conditionNodes) {
      const outEdges = edges.filter((e) => e.source === cn.id);
      if (outEdges.length === 0) {
        errors.push(`"${cn.data.label}" 没有连接任何出边，条件判断后流程会中断`);
      } else if (outEdges.length === 1 && cn.data.nodeType === NodeType.CONDITION) {
        warnings.push(`"${cn.data.label}" 只有一条出边，建议添加默认分支（false/default）避免条件不满足时流程中断`);
      }
    }

    // 4. LOOP 节点：应有 loop-start 出边连接循环体入口，且应有 output 出边连接后续节点
    const loopNodes = nodes.filter((n) => n.data.nodeType === NodeType.LOOP);
    for (const ln of loopNodes) {
      const outEdges = edges.filter((e) => e.source === ln.id);
      const hasLoopStart = outEdges.some((e) => e.sourceHandle === 'loop-start');
      const hasOutput = outEdges.some((e) => e.sourceHandle === 'output');
      if (!hasLoopStart) {
        warnings.push(`循环节点"${ln.data.label}" 没有连接循环体入口（loop-start），循环体不会执行`);
      }
      if (!hasOutput) {
        warnings.push(`循环节点"${ln.data.label}" 没有连接后续节点（output 出边），循环结束后流程会中断`);
      }
    }

    // 5. PARALLEL 节点：应配置有效分支或有出边连接后续节点
    const parallelNodes = nodes.filter((n) => n.data.nodeType === NodeType.PARALLEL);
    for (const pn of parallelNodes) {
      const cfg = pn.data.config;
      const branches = (cfg.branches as Array<{ startNodeId?: string }>) || [];
      const hasValidBranch = branches.some((b) => b.startNodeId && String(b.startNodeId).trim() !== '');
      if (branches.length === 0) {
        warnings.push(`并行节点"${pn.data.label}" 未配置任何分支，执行时将跳过并行逻辑直接通过`);
      } else if (!hasValidBranch) {
        warnings.push(`并行节点"${pn.data.label}" 所有分支均未选择入口节点，执行时将跳过并行逻辑`);
      }
      const outEdges = edges.filter((e) => e.source === pn.id);
      if (outEdges.length === 0) {
        warnings.push(`并行节点"${pn.data.label}" 没有连接后续节点，并行执行结束后流程会中断`);
      }
    }

    // 6. MERGE 节点：应有至少一条入边
    const mergeNodes = nodes.filter((n) => n.data.nodeType === NodeType.MERGE);
    for (const mn of mergeNodes) {
      const inEdges = edges.filter((e) => e.target === mn.id);
      if (inEdges.length === 0) {
        warnings.push(`合并节点"${mn.data.label}" 没有入边，无法收到上游分支数据`);
      }
    }

    // 7. 条件/Switch 节点：分支名称重复检测
    for (const cn of conditionNodes) {
      const nt = cn.data.nodeType;
      if (nt === NodeType.CONDITION) {
        const conds = (cn.data.config.conditions as Array<{ name: string }>) || [];
        const names = conds.map(c => c.name?.trim()).filter(Boolean);
        if (names.length > 1 && new Set(names).size < names.length) {
          warnings.push(`"${cn.data.label}" 存在重复的条件分支名称，可能导致后端路由不确定`);
        }
      }
      if (nt === NodeType.SWITCH) {
        const cases = (cn.data.config.cases as Array<{ name: string }>) || [];
        const names = cases.map(c => c.name?.trim()).filter(Boolean);
        if (names.length > 1 && new Set(names).size < names.length) {
          warnings.push(`"${cn.data.label}" 存在重复的 Case 名称，可能导致后端路由不确定`);
        }
      }
    }

    // 8. LOOP FOR_COUNT：循环次数校验
    for (const ln of loopNodes) {
      const cfg = ln.data.config;
      const lt = (cfg.loopType as string) || 'FOR_EACH';
      if ((lt === 'FOR_COUNT' || lt === 'TIMES') && typeof cfg.loopCount === 'number' && (cfg.loopCount as number) <= 0) {
        warnings.push(`循环节点"${ln.data.label}" 的循环次数为 ${cfg.loopCount as number}，循环体不会执行`);
      }
    }

    // 9. SWITCH 节点 "false" Handle 出边无效检查；多条件模式 CONDITION 同理
    for (const cn of conditionNodes) {
      const outEdges = edges.filter((e) => e.source === cn.id);
      const hasFalseEdge = outEdges.some((e) => e.sourceHandle === 'false');
      if (hasFalseEdge) {
        if (cn.data.nodeType === NodeType.SWITCH) {
          warnings.push(`"${cn.data.label}" 的下方出边(false Handle)在 Switch 节点上永远不会被触发，后端所有 Case（含 default）均走上方默认出边`);
        } else if (cn.data.nodeType === NodeType.CONDITION) {
          const conds = (cn.data.config.conditions as Array<{ name: string; conditionType?: string }>) || [];
          // 1 个 VARIABLE_COMPARE 条件会被序列化为单条件模式（true/false 路由），false Handle 有效，不需要警告
          const isMultiCondition = conds.length > 1 || (conds.length === 1 && conds[0]?.conditionType === 'EXPRESSION');
          if (isMultiCondition) {
            warnings.push(`"${cn.data.label}" 使用了多条件模式，下方出边(false Handle)不会被触发——多条件模式下所有分支（含 default）均走上方默认出边`);
          }
        }
      }
    }

    // 10. START 不应有入边，END 不应有出边
    const startNodes = nodes.filter((n) => n.data.nodeType === NodeType.START);
    const endNodes = nodes.filter((n) => n.data.nodeType === NodeType.END);
    for (const sn of startNodes) {
      if (edges.some((e) => e.target === sn.id)) warnings.push('"开始"节点不应有入边');
    }
    for (const en of endNodes) {
      if (edges.some((e) => e.source === en.id)) warnings.push('"结束"节点不应有出边');
    }

    return { errors, warnings };
  }, [nodes, edges]);

  // 保存工作流定义
  const handleSave = useCallback(async () => {
    if (!workflowId) return;

    // 执行保存前校验
    const { errors, warnings } = validateGraph();
    if (errors.length > 0) {
      toast.error(errors[0]);
      return;
    }
    if (warnings.length > 0) {
      warnings.forEach((w) => toast.warning?.(w) ?? console.warn('[校验警告]', w));
    }

    setSaving(true);
    try {
      const def = toDefinition();
      // 调试：检查保存时 LOOP 节点是否包含 children
      const defNodes = (def.nodes as Array<Record<string, unknown>>) || [];
      defNodes.filter((n) => n.type === 'LOOP').forEach((ln) => {
        const ch = ln.children as Record<string, unknown> | undefined;
        console.log('[workflow-save] LOOP node:', ln.id,
          'has children:', !!ch,
          'children.nodes:', ch?.nodes ? (ch.nodes as unknown[]).length : 0,
          'children.edges:', ch?.edges ? (ch.edges as unknown[]).length : 0,
        );
      });
      // 直接发送完整的 toDefinition() 输出，
      // 后端 WorkflowNode.java 已支持 children / width / height 字段
      const apiDef = def as unknown as ApiWorkflowDefinition;
      const resp = await api.updateDefinition({
        id: workflowId as unknown as number,
        updateWorkflowDefinitionRequest: { definition: apiDef },
      });
      if (resp.data.code === 0) {
        toast.success('保存成功');
        markClean();
        setLastSavedAt(new Date());
      } else {
        toast.error(resp.data.message || '保存失败');
      }
    } catch (err: unknown) {
      const msg = (err as { response?: { data?: { message?: string } } })?.response?.data?.message;
      toast.error(msg || '保存失败');
    } finally {
      setSaving(false);
    }
  }, [workflowId, validateGraph, toDefinition, markClean]);

  // Ctrl/Cmd + S / Ctrl+Z / Ctrl+Shift+Z
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if ((e.metaKey || e.ctrlKey) && e.key === 's') {
        e.preventDefault();
        handleSave();
      }
      if ((e.metaKey || e.ctrlKey) && e.key === 'z' && !e.shiftKey) {
        e.preventDefault();
        useWorkflowStore.getState().undo();
      }
      if ((e.metaKey || e.ctrlKey) && ((e.key === 'z' && e.shiftKey) || e.key === 'y')) {
        e.preventDefault();
        useWorkflowStore.getState().redo();
      }
    };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [handleSave]);

  // 每分钟自动保存
  useEffect(() => {
    autoSaveRef.current = setInterval(() => {
      const { isDirty: dirty, workflowId: wfId } = useWorkflowStore.getState();
      if (dirty && wfId) {
        handleSave();
      }
    }, 60_000);
    return () => { if (autoSaveRef.current) clearInterval(autoSaveRef.current); };
  }, [handleSave]);

  // 拖拽放置节点
  const onDrop = useCallback(
    (event: React.DragEvent) => {
      event.preventDefault();
      const nodeType = event.dataTransfer.getData('application/workflow-node-type') as NodeType;
      if (!nodeType || !rfInstance || !reactFlowWrapper.current) return;
      const bounds = reactFlowWrapper.current.getBoundingClientRect();
      const position = rfInstance.screenToFlowPosition({
        x: event.clientX - bounds.left,
        y: event.clientY - bounds.top,
      });

      // 检测是否拖入了循环容器内（使用实际容器尺寸）
      const loopContainer = nodes.find((n) => {
        if (n.type !== 'loopContainer') return false;
        const nx = n.position.x, ny = n.position.y;
        const nw = (n.measured?.width ?? (n.style?.width as number)) || LOOP_CONTAINER_W;
        const nh = (n.measured?.height ?? (n.style?.height as number)) || LOOP_CONTAINER_H;
        return position.x > nx && position.x < nx + nw && position.y > ny && position.y < ny + nh;
      });

      if (loopContainer) {
        // 不允许在循环内放 START/END/LOOP
        if (([NodeType.START, NodeType.END, NodeType.LOOP, NodeType.LOOP_START, NodeType.LOOP_END] as string[]).includes(nodeType)) {
          alert('不能在循环容器内添加此类型节点');
          return;
        }
        const relPos = { x: position.x - loopContainer.position.x, y: position.y - loopContainer.position.y };
        addNodeToLoop(nodeType, relPos, loopContainer.id);
      } else {
        const added = addNode(nodeType, position);
        if (!added) {
          const label = nodeType === 'START' ? '开始' : '结束';
          alert(`一个工作流只能有一个${label}节点`);
        }
      }
    },
    [rfInstance, addNode, addNodeToLoop, nodes]
  );

  const onDragOver = useCallback((event: React.DragEvent) => {
    event.preventDefault();
    event.dataTransfer.dropEffect = 'move';
  }, []);

  const onPaneClick = useCallback(() => { selectNode(null); }, [selectNode]);

  // 拖拽节点结束后记录历史
  const onNodeDragStop = useCallback(() => {
    pushHistory();
  }, [pushHistory]);

  // 添加注释节点
  const handleAddComment = useCallback(() => {
    if (!rfInstance) return;
    const { addComment } = useWorkflowStore.getState();
    // 在当前视口中心添加注释
    const { x, y, zoom } = rfInstance.getViewport();
    const wrapper = reactFlowWrapper.current;
    if (!wrapper) return;
    const bounds = wrapper.getBoundingClientRect();
    const centerX = (-x + bounds.width / 2) / zoom;
    const centerY = (-y + bounds.height / 2) / zoom;
    addComment({ x: centerX - 120, y: centerY - 70 });
  }, [rfInstance]);

  // 监听注释文本更新事件
  useEffect(() => {
    const handler = (e: Event) => {
      const { id, text } = (e as CustomEvent).detail;
      useWorkflowStore.getState().updateCommentText(id, text);
    };
    window.addEventListener('comment-update', handler);
    return () => window.removeEventListener('comment-update', handler);
  }, []);

  // 自动布局（排除注释节点）
  const handleAutoLayout = useCallback(() => {
    const workflowNodes = nodes.filter((n) => n.type !== 'commentNode');
    const commentNodes = nodes.filter((n) => n.type === 'commentNode');
    if (workflowNodes.length === 0) return;
    const { nodes: ln } = autoLayout(workflowNodes, edges);
    // 直接更新 nodes（保留 parentId / style / zIndex 等完整属性），注释节点保持原位
    useWorkflowStore.setState({ nodes: [...ln, ...commentNodes], isDirty: true });
    setTimeout(() => {
      rfInstance?.fitView({ padding: 0.2, duration: 300 });
    }, 50);
    toast.success('已自动整理布局');
  }, [nodes, edges, rfInstance]);

  // 获取 START 节点的输入参数定义
  const getStartInputParams = useCallback(() => {
    const startNode = nodes.find((n) => n.data.nodeType === NodeType.START);
    if (!startNode) return [];
    return (startNode.data.config.inputParameters as Array<{ name: string; type: string; description: string; required: boolean; defaultValue: string }>) || [];
  }, [nodes]);

  // 点击执行按钮
  const handleExecute = useCallback(() => {
    if (!workflowId) return;
    const params = getStartInputParams();
    if (params.length > 0) {
      // 有输入参数 → 弹窗让用户填写
      const defaults: Record<string, string> = {};
      params.forEach((p) => { defaults[p.name] = p.defaultValue || ''; });
      setExecuteInputs(defaults);
      setExecuteModalOpen(true);
    } else {
      // 无输入参数 → 直接执行
      doExecute({});
    }
  }, [workflowId, getStartInputParams]);

  // 实际执行工作流（执行前自动保存最新定义）
  const doExecute = useCallback(async (input: Record<string, unknown>) => {
    if (!workflowId) return;
    setExecuting(true);
    setExecuteModalOpen(false);
    setDebugResult(null);

    // 如果有未保存的更改，先保存
    if (isDirty) {
      try {
        const def = toDefinition();
        const apiDef = def as unknown as ApiWorkflowDefinition;
        const saveResp = await api.updateDefinition({
          id: workflowId as unknown as number,
          updateWorkflowDefinitionRequest: { definition: apiDef },
        });
        if (saveResp.data.code === 0) {
          markClean();
        } else {
          toast.error(saveResp.data.message || '自动保存失败，终止执行');
          setExecuting(false);
          return;
        }
      } catch (err: unknown) {
        const msg = (err as { response?: { data?: { message?: string } } })?.response?.data?.message;
        toast.error(msg || '自动保存失败，终止执行');
        setExecuting(false);
        return;
      }
    }

    const userId = String(JSON.parse(localStorage.getItem('user_info') || '{}')?.id ?? '');
    try {
      const resp = await api.execute({
        id: workflowId as unknown as number,
        executeWorkflowRequest: { userId: userId as unknown as number, input: input as { [key: string]: object } },
      });
      if (resp.data.code === 0) {
        const data = resp.data.data as unknown as Record<string, unknown>;
        const st = data?.status as string;
        if (st === 'FAILED') {
          toast.error('工作流执行失败：' + (data?.errorMessage || '未知错误'));
        } else {
          toast.success('执行成功');
        }
        setDebugResult(data);
        setDebugOpen(true);
        setExpandedNodes(new Set());
      } else {
        const code = resp.data.code as number;
        const prefix = code === 40000 ? '参数错误' : code === 40900 ? '状态冲突' : '执行失败';
        toast.error(prefix + '：' + (resp.data.message || '未知错误'));
      }
    } catch (err: unknown) {
      const msg = (err as { response?: { data?: { message?: string } } })?.response?.data?.message;
      toast.error(msg || '执行失败');
    } finally {
      setExecuting(false);
    }
  }, [workflowId, isDirty, toDefinition, markClean]);

  // 切换调试面板中节点展开/折叠，同时在画布上定位
  const toggleDebugNode = useCallback((nodeId: string) => {
    setExpandedNodes((prev) => {
      const next = new Set(prev);
      if (next.has(nodeId)) next.delete(nodeId);
      else next.add(nodeId);
      return next;
    });
    // 在画布上定位并高亮对应节点
    if (rfInstance) {
      const targetNode = nodes.find((n) => String(n.id) === String(nodeId));
      if (targetNode && targetNode.position) {
        const x = targetNode.position.x + (targetNode.measured?.width ?? 200) / 2;
        const y = targetNode.position.y + (targetNode.measured?.height ?? 100) / 2;
        rfInstance.setCenter(x, y, { zoom: 1.2, duration: 400 });
      }
      selectNode(nodeId);
    }
  }, [rfInstance, nodes, selectNode]);

  // 加载执行历史 + 统计
  const loadHistory = useCallback(async () => {
    if (!workflowId) return;
    setHistoryLoading(true);
    try {
      const [histResp, statsResp] = await Promise.all([
        api.listExecutions({ id: workflowId as unknown as number, page: 0, size: 20 }),
        api.getExecutionStatistics({ id: workflowId as unknown as number }),
      ]);
      if (histResp.data.code === 0 && histResp.data.data) {
        setHistoryList(histResp.data.data as unknown as Array<Record<string, unknown>>);
      }
      if (statsResp.data.code === 0 && statsResp.data.data) {
        setHistoryStats(statsResp.data.data as unknown as Record<string, unknown>);
      }
    } catch {
      toast.error('获取执行历史失败');
    } finally {
      setHistoryLoading(false);
    }
  }, [workflowId]);

  // 打开执行历史面板
  const handleOpenHistory = useCallback(() => {
    setHistoryOpen(true);
    loadHistory();
  }, [loadHistory]);

  // 查看某条历史记录的详细结果
  const viewHistoryDetail = useCallback((item: Record<string, unknown>) => {
    setDebugResult(item);
    setDebugOpen(true);
    setDebugTab('nodes');
    setExpandedNodes(new Set());
    setHistoryOpen(false);
  }, []);

  // 加载执行日志
  const loadExecutionLogs = useCallback(async (executionId: string, level?: string) => {
    setLogsLoading(true);
    try {
      const resp = await api.getExecutionLogs({
        executionId,
        ...(level ? { level } : {}),
      } as Parameters<typeof api.getExecutionLogs>[0]);
      if (resp.data.code === 0 && resp.data.data) {
        setExecutionLogs(resp.data.data as unknown as Array<Record<string, unknown>>);
      }
    } catch {
      toast.error('获取执行日志失败');
    } finally {
      setLogsLoading(false);
    }
  }, []);

  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-gray-50 dark:bg-gray-950 gap-3">
        <Loader2 className="animate-spin text-brand-500" size={32} />
        <p className="text-sm text-gray-400 dark:text-gray-500">加载工作流中...</p>
      </div>
    );
  }

  return (
    <div className="flex h-screen bg-gray-50 dark:bg-gray-950 overflow-hidden">
      {/* 画布区域（全宽） */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* 顶部工具栏 */}
        <div className="flex items-center justify-between px-4 py-2.5 bg-white dark:bg-gray-900 border-b border-gray-100 dark:border-gray-800 shadow-sm z-10 transition-colors duration-300">
          <div className="flex items-center gap-3">
            <button onClick={() => navigate('/admin/workflows')} className="p-2 text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/20 rounded-xl transition-all">
              <ArrowLeft size={18} />
            </button>
            <div>
              <h1 className="text-sm font-bold text-gray-900 dark:text-white">{workflowName || '工作流编辑器'}</h1>
              <p className={`text-xs ${isDirty ? 'text-amber-500 dark:text-amber-400' : 'text-gray-400 dark:text-gray-500'}`}>
                {isDirty ? '● 未保存的更改' : '已保存'}
                {lastSavedAt && <span className="ml-1.5 text-gray-400 dark:text-gray-500 font-normal">· 上次保存 {lastSavedAt.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit', second: '2-digit' })}</span>}
              </p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <button onClick={() => setTemplateModalOpen(true)} className="flex items-center gap-1.5 px-3 py-2 text-xs font-bold text-gray-600 dark:text-gray-400 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl transition-all active:scale-95" title="保存为模板">
              <BookTemplate size={15} />
            </button>
            <button onClick={() => setTriggerPanelOpen(true)} className="flex items-center gap-1.5 px-3 py-2 text-xs font-bold text-gray-600 dark:text-gray-400 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl transition-all active:scale-95" title="触发器管理">
              <Zap size={15} />
            </button>
            <button onClick={() => setVersionPanelOpen(true)} className="flex items-center gap-1.5 px-3 py-2 text-xs font-bold text-gray-600 dark:text-gray-400 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl transition-all active:scale-95" title="版本历史">
              <GitBranch size={15} />
            </button>
            <button onClick={handleOpenHistory} className="flex items-center gap-1.5 px-3 py-2 text-xs font-bold text-gray-600 dark:text-gray-400 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl transition-all active:scale-95" title="执行历史">
              <History size={15} />
            </button>
            <button onClick={handleExecute} disabled={executing} className="flex items-center gap-1.5 px-3 py-2 text-xs font-bold text-brand-600 dark:text-brand-400 bg-brand-50 dark:bg-brand-900/20 hover:bg-brand-100 dark:hover:bg-brand-900/30 border border-brand-200 dark:border-brand-800 rounded-xl transition-all active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed">
              {executing ? <Loader2 size={15} className="animate-spin" /> : <Play size={15} />}
              {executing ? '执行中...' : '执行'}
            </button>
            <button onClick={handleSave} disabled={saving || !isDirty} className="flex items-center gap-1.5 px-4 py-2 text-xs font-bold text-white bg-brand-600 hover:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed rounded-xl transition-all shadow-lg shadow-brand-600/20 active:scale-95">
              {saving ? <Loader2 size={15} className="animate-spin" /> : <Save size={15} />}
              {saving ? '保存中...' : '保存'}
            </button>
          </div>
        </div>

        {/* ReactFlow 画布 */}
        <div ref={reactFlowWrapper} className="flex-1 relative">
          <ReactFlow
            nodes={nodes}
            edges={edges}
            onNodesChange={onNodesChange}
            onEdgesChange={onEdgesChange}
            onConnect={onConnect}
            onInit={(instance) => setRfInstance(instance as ReactFlowInstance<FlowNode, FlowEdge>)}
            onDrop={onDrop}
            onDragOver={onDragOver}
            onPaneClick={onPaneClick}
            onNodeDragStop={onNodeDragStop}
            nodeTypes={nodeTypes}
            fitView
            snapToGrid
            snapGrid={[16, 16]}
            deleteKeyCode={['Backspace', 'Delete']}
            className="bg-gray-50 dark:bg-gray-950"
            panOnDrag={isLocked ? false : interactionMode === 'hand' ? [0, 1, 2] : [1, 2]}
            selectionOnDrag={!isLocked && interactionMode === 'pointer'}
            selectionMode={SelectionMode.Partial}
            zoomOnScroll={!isLocked}
            zoomOnDoubleClick={!isLocked}
            nodesDraggable={!isLocked}
            nodesConnectable={!isLocked}
            proOptions={{ hideAttribution: true }}
          >
            <Background variant={BackgroundVariant.Dots} gap={20} size={1} className="!bg-gray-50 dark:!bg-gray-950" color="#c9cdd4" />
            <MiniMap
              className="!bg-white dark:!bg-gray-900 !border-gray-100 dark:!border-gray-800 !shadow-sm"
              style={{ width: 140, height: 90 }}
              nodeColor={(n) => n.type === 'commentNode' ? '#fde047' : 'var(--color-brand-500, #6366f1)'}
              maskColor="rgba(0,0,0,0.08)"
            />
            <Panel position="bottom-left">
              <div className="flex items-center gap-1 bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 rounded-xl px-1 py-1 shadow-md backdrop-blur-sm">
                <button
                  onClick={undo}
                  disabled={!canUndo}
                  className="flex items-center justify-center w-8 h-8 rounded-lg transition-all duration-150 text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/30 active:scale-90 disabled:opacity-30 disabled:cursor-not-allowed disabled:hover:bg-transparent disabled:hover:text-gray-500"
                  title="撤销 (Ctrl+Z)"
                >
                  <Undo2 size={15} />
                </button>
                <button
                  onClick={redo}
                  disabled={!canRedo}
                  className="flex items-center justify-center w-8 h-8 rounded-lg transition-all duration-150 text-gray-500 dark:text-gray-400 hover:text-brand-600 dark:hover:text-brand-400 hover:bg-brand-50 dark:hover:bg-brand-900/30 active:scale-90 disabled:opacity-30 disabled:cursor-not-allowed disabled:hover:bg-transparent disabled:hover:text-gray-500"
                  title="重做 (Ctrl+Shift+Z)"
                >
                  <Redo2 size={15} />
                </button>
              </div>
            </Panel>
            <Panel position="bottom-center">
              <p className="text-xs text-gray-400 dark:text-gray-500 bg-white/80 dark:bg-gray-900/80 px-3 py-1.5 rounded-full backdrop-blur-sm border border-gray-100 dark:border-gray-800 shadow-sm">
                {nodes.filter((n) => n.type !== 'commentNode').length} 个节点 · {edges.length} 条连线
              </p>
            </Panel>
            {/* 浮动工具栏 */}
            <CanvasToolbar
              isLocked={isLocked}
              onToggleLock={() => setIsLocked((v) => !v)}
              edgeType={edgeType}
              onToggleEdgeType={() => setEdgeType(edgeType === 'default' ? 'smoothstep' : edgeType === 'smoothstep' ? 'straight' : 'default')}
              interactionMode={interactionMode}
              onSetInteractionMode={setInteractionMode}
              onAddComment={handleAddComment}
              onAutoLayout={handleAutoLayout}
            />
          </ReactFlow>
        </div>
      </div>

      {/* 右侧配置面板（注释节点不显示） */}
      {selectedNodeId && !nodes.find((n) => n.id === selectedNodeId && n.type === 'commentNode') && <NodeConfigPanel />}

      {/* 调试面板 */}
      {debugResult && (
        <div className={`fixed bottom-0 left-0 right-0 z-40 transition-all duration-300 ${debugOpen ? 'h-[45vh]' : 'h-10'}`}>
          {/* 标题栏 */}
          <button
            onClick={() => setDebugOpen(!debugOpen)}
            className="w-full flex items-center justify-between px-4 py-2 bg-gray-900 dark:bg-gray-950 text-white border-t border-gray-700 hover:bg-gray-800 transition-colors"
          >
            <div className="flex items-center gap-2">
              <Bug size={14} className="text-brand-400" />
              <span className="text-xs font-bold">调试结果</span>
              <span className={`px-1.5 py-0.5 text-[10px] font-bold rounded ${
                (debugResult.status as string) === 'COMPLETED' ? 'bg-emerald-500/20 text-emerald-400'
                : (debugResult.status as string) === 'FAILED' ? 'bg-red-500/20 text-red-400'
                : (debugResult.status as string) === 'PAUSED' ? 'bg-amber-500/20 text-amber-400'
                : (debugResult.status as string) === 'CANCELLED' ? 'bg-gray-500/20 text-gray-400'
                : (debugResult.status as string) === 'RUNNING' ? 'bg-blue-500/20 text-blue-400'
                : 'bg-gray-500/20 text-gray-400'
              }`}>
                {(debugResult.status as string) || 'UNKNOWN'}
              </span>
              <span className="text-[10px] text-gray-400">
                {(debugResult.durationMs as number) ?? 0}ms
                · {((debugResult.nodeExecutions as unknown[]) || []).length} 个节点
              </span>
            </div>
            <div className="flex items-center gap-2">
              <button onClick={(e) => { e.stopPropagation(); setDebugResult(null); setDebugOpen(false); }} className="p-1 text-gray-400 hover:text-white rounded transition-colors">
                <X size={14} />
              </button>
              {debugOpen ? <ChevronDown size={14} className="text-gray-400" /> : <ChevronRight size={14} className="text-gray-400" />}
            </div>
          </button>

          {/* Tab 栏 + 内容区 */}
          {debugOpen && (
            <div className="h-[calc(100%-40px)] flex flex-col bg-gray-950 text-gray-300">
              {/* Tab 切换 */}
              <div className="flex items-center gap-1 px-4 pt-2 pb-0 border-b border-gray-800">
                <button
                  onClick={() => setDebugTab('nodes')}
                  className={`px-3 py-1.5 text-xs font-bold rounded-t-lg transition-colors ${debugTab === 'nodes' ? 'bg-gray-800 text-white border-b-2 border-brand-500' : 'text-gray-500 hover:text-gray-300'}`}
                >
                  节点详情
                </button>
                <button
                  onClick={() => {
                    setDebugTab('logs');
                    if (debugResult.executionId) loadExecutionLogs(String(debugResult.executionId), logLevelFilter || undefined);
                  }}
                  className={`px-3 py-1.5 text-xs font-bold rounded-t-lg transition-colors ${debugTab === 'logs' ? 'bg-gray-800 text-white border-b-2 border-brand-500' : 'text-gray-500 hover:text-gray-300'}`}
                >
                  执行日志
                </button>
                {debugTab === 'logs' && (
                  <select
                    value={logLevelFilter}
                    onChange={(e) => {
                      setLogLevelFilter(e.target.value);
                      if (debugResult.executionId) loadExecutionLogs(String(debugResult.executionId), e.target.value || undefined);
                    }}
                    className="ml-auto text-[10px] px-2 py-1 bg-gray-800 border border-gray-700 rounded text-gray-300 focus:outline-none"
                  >
                    <option value="">全部级别</option>
                    <option value="DEBUG">DEBUG</option>
                    <option value="INFO">INFO</option>
                    <option value="WARN">WARN</option>
                    <option value="ERROR">ERROR</option>
                  </select>
                )}
              </div>

              {/* 节点详情 Tab */}
              {debugTab === 'nodes' && (
                <div className="flex-1 overflow-y-auto custom-scrollbar">
                  <div className="p-4 space-y-2">
                    {((debugResult.nodeExecutions as Array<Record<string, unknown>>) || []).map((ne, idx) => {
                      const neId = ne.nodeId as string;
                      const isExpanded = expandedNodes.has(neId);
                      const status = ne.status as string;
                      const StatusIcon = status === 'COMPLETED' ? CheckCircle2 : status === 'FAILED' ? XCircle : status === 'SKIPPED' ? AlertTriangle : Clock;
                      const statusColor = status === 'COMPLETED' ? 'text-emerald-400' : status === 'FAILED' ? 'text-red-400' : status === 'SKIPPED' ? 'text-amber-400' : 'text-gray-400';

                      return (
                        <div key={idx} className="rounded-lg border border-gray-800 overflow-hidden">
                          <button
                            onClick={() => toggleDebugNode(neId)}
                            className="w-full flex items-center gap-3 px-3 py-2 hover:bg-gray-800/50 transition-colors text-left"
                          >
                            <StatusIcon size={14} className={statusColor} />
                            <span className="text-xs font-bold text-white flex-shrink-0">{ne.nodeName as string || neId}</span>
                            <span className="text-[10px] text-gray-500 font-mono">{ne.nodeType as string}</span>
                            <span className="ml-auto text-[10px] text-gray-500">{(ne.durationMs as number) ?? 0}ms</span>
                            {!!ne.errorMessage && <span className="text-[10px] text-red-400 truncate max-w-40">{String(ne.errorMessage)}</span>}
                            {isExpanded ? <ChevronDown size={12} className="text-gray-500" /> : <ChevronRight size={12} className="text-gray-500" />}
                          </button>
                          {isExpanded && (
                            <div className="border-t border-gray-800 bg-gray-900/50">
                              <div className="grid grid-cols-2 divide-x divide-gray-800">
                                <div className="p-3">
                                  <p className="text-[10px] font-bold text-gray-400 mb-1.5 uppercase tracking-wider">Input</p>
                                  <pre className="text-[11px] text-gray-300 font-mono whitespace-pre-wrap break-all max-h-48 overflow-y-auto custom-scrollbar">
                                    {JSON.stringify(ne.input, null, 2)}
                                  </pre>
                                </div>
                                <div className="p-3">
                                  <p className="text-[10px] font-bold text-gray-400 mb-1.5 uppercase tracking-wider">Output</p>
                                  <pre className="text-[11px] text-emerald-300 font-mono whitespace-pre-wrap break-all max-h-48 overflow-y-auto custom-scrollbar">
                                    {JSON.stringify(ne.output, null, 2)}
                                  </pre>
                                </div>
                              </div>
                            </div>
                          )}
                        </div>
                      );
                    })}

                    {/* 错误信息 */}
                    {!!debugResult.errorMessage && (
                      <div className="rounded-lg border border-red-800/50 overflow-hidden">
                        <div className="px-3 py-2 bg-red-900/30">
                          <p className="text-xs font-bold text-red-400">错误信息 (errorMessage)</p>
                        </div>
                        <div className="p-3">
                          <pre className="text-[11px] text-red-300 font-mono whitespace-pre-wrap break-all max-h-32 overflow-y-auto custom-scrollbar">
                            {String(debugResult.errorMessage)}
                          </pre>
                        </div>
                      </div>
                    )}

                    {/* 最终输出 */}
                    <div className="rounded-lg border border-gray-800 overflow-hidden">
                      <div className="px-3 py-2 bg-gray-800/50">
                        <p className="text-xs font-bold text-brand-400">最终输出 (output)</p>
                      </div>
                      <div className="p-3">
                        <pre className="text-[11px] text-emerald-300 font-mono whitespace-pre-wrap break-all max-h-48 overflow-y-auto custom-scrollbar">
                          {JSON.stringify(debugResult.output, null, 2)}
                        </pre>
                      </div>
                    </div>

                    {/* 变量快照 */}
                    {Boolean(debugResult.variables) && Object.keys(debugResult.variables as Record<string, unknown>).length > 0 && (
                      <div className="rounded-lg border border-gray-800 overflow-hidden">
                        <div className="px-3 py-2 bg-gray-800/50">
                          <p className="text-xs font-bold text-cyan-400">运行时变量快照 (variables)</p>
                        </div>
                        <div className="p-3">
                          <pre className="text-[11px] text-cyan-300 font-mono whitespace-pre-wrap break-all max-h-48 overflow-y-auto custom-scrollbar">
                            {JSON.stringify(debugResult.variables, null, 2)}
                          </pre>
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              )}

              {/* 执行日志 Tab */}
              {debugTab === 'logs' && (
                <div className="flex-1 overflow-y-auto custom-scrollbar">
                  {logsLoading ? (
                    <div className="flex items-center justify-center py-12">
                      <Loader2 className="animate-spin text-brand-500" size={20} />
                      <span className="ml-2 text-xs text-gray-400">加载日志...</span>
                    </div>
                  ) : executionLogs.length === 0 ? (
                    <div className="flex flex-col items-center justify-center py-12 gap-2">
                      <p className="text-xs text-gray-500">暂无日志记录</p>
                    </div>
                  ) : (
                    <div className="p-2">
                      <table className="w-full text-[11px] font-mono">
                        <thead>
                          <tr className="text-gray-500 border-b border-gray-800">
                            <th className="text-left px-2 py-1.5 w-16">级别</th>
                            <th className="text-left px-2 py-1.5 w-28">节点</th>
                            <th className="text-left px-2 py-1.5">消息</th>
                            <th className="text-right px-2 py-1.5 w-16">耗时</th>
                          </tr>
                        </thead>
                        <tbody>
                          {executionLogs.map((logItem, idx) => {
                            const lvl = logItem.level as string;
                            const lvlColor = lvl === 'ERROR' ? 'text-red-400' : lvl === 'WARN' ? 'text-amber-400' : lvl === 'INFO' ? 'text-blue-400' : 'text-gray-500';
                            return (
                              <tr key={idx} className="border-b border-gray-800/50 hover:bg-gray-800/30">
                                <td className={`px-2 py-1.5 font-bold ${lvlColor}`}>{lvl}</td>
                                <td className="px-2 py-1.5 text-gray-400 truncate max-w-28">{logItem.nodeName as string || '-'}</td>
                                <td className="px-2 py-1.5 text-gray-300 break-all">{logItem.message as string}</td>
                                <td className="px-2 py-1.5 text-right text-gray-500">{(logItem.durationMs as number) ?? '-'}ms</td>
                              </tr>
                            );
                          })}
                        </tbody>
                      </table>
                    </div>
                  )}
                </div>
              )}
            </div>
          )}
        </div>
      )}

      {/* 执行参数弹窗 */}
      {executeModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50 backdrop-blur-sm" onClick={() => setExecuteModalOpen(false)} />
          <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 overflow-hidden animate-in zoom-in-95 duration-200">
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <h3 className="text-lg font-bold text-gray-900 dark:text-white">执行工作流</h3>
              <button onClick={() => setExecuteModalOpen(false)} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
                <X size={20} />
              </button>
            </div>
            <div className="p-6 space-y-4 max-h-[60vh] overflow-y-auto">
              <p className="text-sm text-gray-500 dark:text-gray-400">请填写开始节点定义的输入参数：</p>
              {getStartInputParams().map((param) => (
                <div key={param.name} className="space-y-1.5">
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">
                    {param.name}
                    {param.required && <span className="text-red-500 ml-0.5">*</span>}
                    {param.description && <span className="ml-2 text-xs text-gray-400 font-normal">{param.description}</span>}
                  </label>
                  {param.type === 'BOOLEAN' ? (
                    <select
                      value={executeInputs[param.name] || 'false'}
                      onChange={(e) => setExecuteInputs((prev) => ({ ...prev, [param.name]: e.target.value }))}
                      className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all cursor-pointer"
                    >
                      <option value="true">true</option>
                      <option value="false">false</option>
                    </select>
                  ) : (
                    <input
                      type={param.type === 'NUMBER' ? 'number' : 'text'}
                      value={executeInputs[param.name] || ''}
                      onChange={(e) => setExecuteInputs((prev) => ({ ...prev, [param.name]: e.target.value }))}
                      placeholder={`${param.type === 'OBJECT' || param.type === 'ARRAY' ? 'JSON format' : param.name}`}
                      className="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 rounded-xl text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 transition-all"
                    />
                  )}
                  <p className="text-xs text-gray-400">Type: {param.type}</p>
                </div>
              ))}
            </div>
            <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/50">
              <button onClick={() => setExecuteModalOpen(false)} className="px-4 py-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white transition-colors">
                取消
              </button>
              <button
                onClick={() => {
                  const input: Record<string, unknown> = {};
                  getStartInputParams().forEach((p) => {
                    const raw = executeInputs[p.name] || '';
                    if (!raw && !p.required) return;
                    switch (p.type) {
                      case 'NUMBER': input[p.name] = parseFloat(raw) || 0; break;
                      case 'BOOLEAN': input[p.name] = raw === 'true'; break;
                      case 'OBJECT': case 'ARRAY':
                        try { input[p.name] = JSON.parse(raw); } catch { input[p.name] = raw; }
                        break;
                      default: input[p.name] = raw;
                    }
                  });
                  doExecute(input);
                }}
                disabled={executing}
                className="px-6 py-2 bg-brand-600 text-white text-sm font-bold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/20 disabled:opacity-50 transition-all active:scale-95"
              >
                {executing ? '执行中...' : '执行'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* 版本历史面板 */}
      {workflowId && (
        <VersionHistoryPanel
          workflowId={workflowId}
          open={versionPanelOpen}
          onClose={() => setVersionPanelOpen(false)}
          onRollback={() => {
            // 回滚后重新加载工作流
            window.location.reload();
          }}
        />
      )}

      {/* 触发器管理面板 */}
      {workflowId && (
        <TriggerManagerPanel
          workflowId={workflowId}
          open={triggerPanelOpen}
          onClose={() => setTriggerPanelOpen(false)}
        />
      )}

      {/* 保存为模板弹窗 */}
      {workflowId && (
        <SaveAsTemplateModal
          workflowId={workflowId}
          workflowName={workflowName || ''}
          open={templateModalOpen}
          onClose={() => setTemplateModalOpen(false)}
        />
      )}

      {/* 执行历史抽屉 */}
      {historyOpen && (
        <div className="fixed inset-0 z-50 flex">
          <div className="absolute inset-0 bg-black/40 backdrop-blur-sm" onClick={() => setHistoryOpen(false)} />
          <div className="relative ml-auto w-full max-w-md bg-white dark:bg-gray-900 shadow-2xl flex flex-col animate-in slide-in-from-right duration-200">
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 dark:border-gray-800">
              <div className="flex items-center gap-2">
                <History size={18} className="text-brand-500" />
                <h3 className="text-lg font-bold text-gray-900 dark:text-white">执行历史</h3>
                {historyStats && <span className="text-xs text-gray-400">共 {historyStats.totalCount as number ?? 0} 次</span>}
              </div>
              <div className="flex items-center gap-1">
                <button onClick={loadHistory} disabled={historyLoading} className="p-2 text-gray-400 hover:text-brand-500 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors disabled:opacity-50" title="刷新">
                  <Loader2 size={16} className={historyLoading ? 'animate-spin' : ''} />
                </button>
                <button onClick={() => setHistoryOpen(false)} className="p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
                  <X size={20} />
                </button>
              </div>
            </div>
            {/* 统计摘要 */}
            {historyStats && !historyLoading && (
              <div className="grid grid-cols-4 gap-2 px-6 py-3 border-b border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/30">
                <div className="text-center">
                  <p className="text-lg font-bold text-gray-900 dark:text-white">{historyStats.totalCount as number ?? 0}</p>
                  <p className="text-[10px] text-gray-400">总执行</p>
                </div>
                <div className="text-center">
                  <p className="text-lg font-bold text-emerald-500">{historyStats.successCount as number ?? 0}</p>
                  <p className="text-[10px] text-gray-400">成功</p>
                </div>
                <div className="text-center">
                  <p className="text-lg font-bold text-red-500">{historyStats.failedCount as number ?? 0}</p>
                  <p className="text-[10px] text-gray-400">失败</p>
                </div>
                <div className="text-center">
                  <p className="text-lg font-bold text-brand-500">{Math.round(((historyStats.successRate as number) ?? 0) * 100)}%</p>
                  <p className="text-[10px] text-gray-400">成功率</p>
                </div>
              </div>
            )}
            <div className="flex-1 overflow-y-auto">
              {historyLoading ? (
                <div className="flex flex-col items-center justify-center py-20 gap-3">
                  <Loader2 className="animate-spin text-brand-500" size={24} />
                  <p className="text-sm text-gray-400">加载中...</p>
                </div>
              ) : historyList.length === 0 ? (
                <div className="flex flex-col items-center justify-center py-20 gap-2">
                  <History size={32} className="text-gray-300 dark:text-gray-600" />
                  <p className="text-sm text-gray-400 dark:text-gray-500">暂无执行记录</p>
                </div>
              ) : (
                <div className="divide-y divide-gray-100 dark:divide-gray-800">
                  {historyList.map((item, idx) => {
                    const st = item.status as string;
                    const StatusIcon = st === 'COMPLETED' ? CheckCircle2 : st === 'FAILED' ? XCircle : st === 'RUNNING' ? Loader2 : Clock;
                    const statusColor = st === 'COMPLETED' ? 'text-emerald-500' : st === 'FAILED' ? 'text-red-500' : st === 'RUNNING' ? 'text-blue-500' : 'text-gray-400';
                    const startTime = item.startTime ? new Date(item.startTime as string).toLocaleString('zh-CN') : '-';
                    return (
                      <button
                        key={idx}
                        onClick={() => viewHistoryDetail(item)}
                        className="w-full flex items-center gap-3 px-6 py-4 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors text-left"
                      >
                        <StatusIcon size={18} className={`${statusColor} flex-shrink-0 ${st === 'RUNNING' ? 'animate-spin' : ''}`} />
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2">
                            <span className="text-sm font-medium text-gray-900 dark:text-white truncate">
                              {String(item.executionId).substring(0, 12)}...
                            </span>
                            <span className={`px-1.5 py-0.5 text-[10px] font-bold rounded ${
                              st === 'COMPLETED' ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400'
                              : st === 'FAILED' ? 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400'
                              : 'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400'
                            }`}>
                              {st}
                            </span>
                          </div>
                          <div className="flex items-center gap-3 mt-0.5">
                            <span className="text-xs text-gray-400">{startTime}</span>
                            <span className="text-xs text-gray-400">{(item.durationMs as number) ?? 0}ms</span>
                            <span className="text-xs text-gray-400">v{item.workflowVersion as number ?? '-'}</span>
                          </div>
                          {!!item.errorMessage && (
                            <p className="text-xs text-red-400 mt-0.5 truncate">{String(item.errorMessage)}</p>
                          )}
                        </div>
                        <ChevronRight size={14} className="text-gray-300 dark:text-gray-600 flex-shrink-0" />
                      </button>
                    );
                  })}
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
