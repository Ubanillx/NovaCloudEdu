import dagre from 'dagre';
import type { WorkflowNode, WorkflowEdge } from '../types';
import { LOOP_CONTAINER_W, LOOP_CONTAINER_H, LOOP_CONTAINER_MIN_W, LOOP_CONTAINER_MIN_H } from '../nodes/LoopContainerNode';

const DEFAULT_NODE_W = 220;
const DEFAULT_NODE_H = 80;
const DEFAULT_TOP_NODE_W = 240;
const DEFAULT_TOP_NODE_H = 100;
const CONTAINER_PAD_LEFT = 70;   // 给左侧「开始」圆圈留空间
const CONTAINER_PAD_RIGHT = 70;  // 给右侧「结束」圆圈留空间
const CONTAINER_PAD_TOP = 50;    // 头部高度
const CONTAINER_PAD_BOTTOM = 20;

/** 获取节点实际尺寸（优先使用 measured，再回退到 style，最后用默认值） */
function nodeDims(node: WorkflowNode, defW: number, defH: number) {
  return {
    w: node.measured?.width || (node.style?.width as number) || defW,
    h: node.measured?.height || (node.style?.height as number) || defH,
  };
}

export function autoLayout(nodes: WorkflowNode[], edges: WorkflowEdge[]) {
  // —— 按父节点分组 ——
  const topNodes = nodes.filter((n) => !n.parentId);
  const childrenByParent = new Map<string, WorkflowNode[]>();
  const childIds = new Set<string>();
  for (const n of nodes) {
    if (n.parentId) {
      childIds.add(n.id);
      if (!childrenByParent.has(n.parentId)) childrenByParent.set(n.parentId, []);
      childrenByParent.get(n.parentId)!.push(n);
    }
  }

  // —— 1. 先对每个循环容器的子节点做内部 dagre 布局 ——
  const childPositions = new Map<string, { x: number; y: number }>();
  const containerSizes = new Map<string, { w: number; h: number }>();

  for (const [parentId, children] of childrenByParent) {
    const parent = topNodes.find((n) => n.id === parentId);
    if (!parent || parent.type !== 'loopContainer') continue;

    // 收集内部边：child↔child + container(loop-start)→child + child→container(loop-end)
    const childIdSet = new Set(children.map((c) => c.id));
    const internalEdges = edges.filter(
      (e) =>
        (childIdSet.has(e.source) && childIdSet.has(e.target)) ||
        (e.source === parentId && e.sourceHandle === 'loop-start' && childIdSet.has(e.target)) ||
        (childIdSet.has(e.source) && e.target === parentId && e.targetHandle === 'loop-end')
    );

    const sg = new dagre.graphlib.Graph();
    sg.setDefaultEdgeLabel(() => ({}));
    sg.setGraph({ rankdir: 'LR', nodesep: 40, ranksep: 80 });

    // 加一个虚拟 start 和 end 节点代表 loop-start / loop-end handle
    sg.setNode('__loop_start__', { width: 1, height: 1 });
    sg.setNode('__loop_end__', { width: 1, height: 1 });

    // 使用子节点的实际尺寸（优先 measured）
    const childDims = new Map<string, { w: number; h: number }>();
    children.forEach((c) => {
      const dim = nodeDims(c, DEFAULT_NODE_W, DEFAULT_NODE_H);
      childDims.set(c.id, dim);
      sg.setNode(c.id, { width: dim.w, height: dim.h });
    });

    for (const e of internalEdges) {
      const src = e.source === parentId ? '__loop_start__' : e.source;
      const tgt = e.target === parentId ? '__loop_end__' : e.target;
      if (sg.hasNode(src) && sg.hasNode(tgt)) sg.setEdge(src, tgt);
    }

    dagre.layout(sg);

    // 收集子节点位置（排除虚拟节点），使用实际尺寸计算边界
    let minX = Infinity, minY = Infinity, maxX = -Infinity, maxY = -Infinity;
    for (const c of children) {
      const pos = sg.node(c.id);
      if (!pos) continue;
      const dim = childDims.get(c.id)!;
      const cx = pos.x - dim.w / 2;
      const cy = pos.y - dim.h / 2;
      minX = Math.min(minX, cx);
      minY = Math.min(minY, cy);
      maxX = Math.max(maxX, cx + dim.w);
      maxY = Math.max(maxY, cy + dim.h);
    }

    // 把子节点平移到容器内部（加上 padding）
    const offsetX = CONTAINER_PAD_LEFT - minX;
    const offsetY = CONTAINER_PAD_TOP - minY;
    for (const c of children) {
      const pos = sg.node(c.id);
      if (!pos) continue;
      const dim = childDims.get(c.id)!;
      childPositions.set(c.id, {
        x: pos.x - dim.w / 2 + offsetX,
        y: pos.y - dim.h / 2 + offsetY,
      });
    }

    // 计算容器需要的最小尺寸（不保留旧的过大尺寸，让布局真正"整理"）
    const contentW = maxX - minX;
    const contentH = maxY - minY;
    const neededW = contentW + CONTAINER_PAD_LEFT + CONTAINER_PAD_RIGHT;
    const neededH = contentH + CONTAINER_PAD_TOP + CONTAINER_PAD_BOTTOM;
    containerSizes.set(parentId, {
      w: Math.max(neededW, LOOP_CONTAINER_MIN_W),
      h: Math.max(neededH, LOOP_CONTAINER_MIN_H),
    });
  }

  // 没有子节点的循环容器也需要有尺寸
  for (const node of topNodes) {
    if (node.type === 'loopContainer' && !containerSizes.has(node.id)) {
      containerSizes.set(node.id, { w: LOOP_CONTAINER_W, h: LOOP_CONTAINER_H });
    }
  }

  // —— 2. 顶层 dagre 布局 ——
  const g = new dagre.graphlib.Graph();
  g.setDefaultEdgeLabel(() => ({}));
  g.setGraph({ rankdir: 'LR', nodesep: 60, ranksep: 120 });

  topNodes.forEach((node) => {
    const isLoop = node.type === 'loopContainer';
    if (isLoop) {
      const size = containerSizes.get(node.id)!;
      g.setNode(node.id, { width: size.w, height: size.h });
    } else {
      const dim = nodeDims(node, DEFAULT_TOP_NODE_W, DEFAULT_TOP_NODE_H);
      g.setNode(node.id, { width: dim.w, height: dim.h });
    }
  });

  edges.forEach((edge) => {
    if (childIds.has(edge.source) && childIds.has(edge.target)) return;
    if (edge.sourceHandle === 'loop-start' || edge.targetHandle === 'loop-end') return;
    if (g.hasNode(edge.source) && g.hasNode(edge.target)) {
      g.setEdge(edge.source, edge.target);
    }
  });

  dagre.layout(g);

  // —— 3. 组装最终节点位置 ——
  const layoutedNodes = nodes.map((node) => {
    // 子节点：使用内部布局计算的位置
    if (node.parentId) {
      const pos = childPositions.get(node.id);
      if (pos) return { ...node, position: { x: pos.x, y: pos.y } };
      return node;
    }
    // 顶层节点
    const pos = g.node(node.id);
    if (!pos) return node;
    const isLoop = node.type === 'loopContainer';
    const size = containerSizes.get(node.id);

    if (isLoop && size) {
      // 关键修复：同步更新 measured 为新尺寸，
      // 防止 React Flow 用旧的 measured 做 extent:'parent' 钳制，
      // 导致子节点被限制在旧容器边界内而跑到视觉之外
      return {
        ...node,
        position: { x: pos.x - size.w / 2, y: pos.y - size.h / 2 },
        style: { ...node.style, width: size.w, height: size.h },
        measured: { width: size.w, height: size.h },
      };
    }

    const dim = nodeDims(node, DEFAULT_TOP_NODE_W, DEFAULT_TOP_NODE_H);
    return {
      ...node,
      position: { x: pos.x - dim.w / 2, y: pos.y - dim.h / 2 },
    };
  });

  return { nodes: layoutedNodes, edges };
}
