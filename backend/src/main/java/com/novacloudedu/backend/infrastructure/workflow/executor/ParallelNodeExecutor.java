package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 并行执行节点执行器 — 多分支并行执行
 *
 * <h3>重要：本执行器是 Fallback，实际并行执行由引擎处理</h3>
 * <p>当引擎在 executeFromNode 中检测到 PARALLEL 节点时，会直接调用
 * {@code DefaultWorkflowEngine.executeParallelContainer()}，不会调用本执行器。
 * 本执行器仅在 PARALLEL 节点未被特殊处理时作为 fallback 返回配置标记。</p>
 *
 * <h3>引擎侧实际执行流程 (executeParallelContainer)</h3>
 * <pre>
 * 1. 读取 config.branches 数组，每个分支包含：
 *    - name: 分支名称
 *    - startNodeId: 分支入口节点 ID
 *    - resultVariable: 分支结果变量名
 *    - optional: 是否可选（失败不影响整体）
 * 2. 为每个分支创建独立的 WorkflowExecution 副本 (forkForBranch)
 *    - 变量快照独立，避免多线程竞态
 *    - nodeExecutionCount 共享父执行计数器，确保全局节点上限生效
 *    - parentExecution 引用父执行，使分支能感知取消/暂停
 * 3. 用 CompletableFuture + 线程池并行执行所有分支
 * 4. 等待策略 (waitStrategy)：
 *    - ALL:    等待所有分支完成
 *    - ANY:    任一分支完成即继续，取消其余分支
 *    - N_OF_M: 等待 N 个分支成功完成
 * 5. 合并策略 (mergeStrategy)：
 *    - OBJECT: 每个分支结果作为独立的 key-value
 *    - ARRAY:  所有分支结果组成数组
 *    - FIRST:  取第一个有结果的分支（按配置顺序）
 *    - LAST:   取最后一个有结果的分支（按配置顺序）
 * 6. failFast=true 时，非 optional 分支失败会立即抛异常
 * 7. 并行完成后走普通出边继续后续节点
 * </pre>
 *
 * <h3>边界条件处理</h3>
 * <ul>
 *   <li>branches 为空 / 所有 startNodeId 未设置 → 跳过并行，返回警告</li>
 *   <li>分支超时 → 标记分支执行状态为 CANCELLED，中断分支线程</li>
 *   <li>父执行取消/暂停 → 分支在下次 checkExecutionLimits 时自动终止</li>
 *   <li>无出边 → warn 日志，后续节点不执行</li>
 * </ul>
 */
@Slf4j
@Component
public class ParallelNodeExecutor implements NodeExecutor {

    @Override
    public NodeType getNodeType() {
        return NodeType.PARALLEL;
    }

    /**
     * Fallback 执行：仅在引擎未特殊处理 PARALLEL 节点时调用。
     * 返回配置标记（以 _ 前缀），不执行实际并行逻辑。
     */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig() != null ? node.getConfig() : Map.of();

        // 读取前端配置格式
        List<Map<String, Object>> branches = (List<Map<String, Object>>) config.get("branches");
        String waitStrategy = (String) config.getOrDefault("waitStrategy", "ALL");
        long timeout = getLong(config, "timeout", 60000L);
        boolean failFast = Boolean.TRUE.equals(config.get("failFast"));
        String mergeStrategy = (String) config.getOrDefault("mergeStrategy", "OBJECT");
        int requiredCount = getInt(config, "requiredCount", 1);

        log.info("并行节点配置: nodeId={}, branches={}, waitStrategy={}, timeout={}, failFast={}, mergeStrategy={}",
                node.getId(), branches != null ? branches.size() : 0, waitStrategy, timeout, failFast, mergeStrategy);

        // 实际并行执行由 Engine 处理；此处仅返回配置标记供 fallback 使用
        Map<String, Object> result = new HashMap<>();
        result.put("_parallelConfig", true);
        result.put("_waitStrategy", waitStrategy);
        result.put("_timeout", timeout);
        result.put("_failFast", failFast);
        result.put("_mergeStrategy", mergeStrategy);
        result.put("_requiredCount", requiredCount);
        return result;
    }

    @Override
    public void validate(WorkflowNode node) {
        // branches 可以不存在（使用出边作为分支）
    }

    private long getLong(Map<String, Object> config, String key, long defaultValue) {
        Object value = config.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) return ((Number) value).longValue();
        try { return Long.parseLong(String.valueOf(value)); } catch (NumberFormatException e) { return defaultValue; }
    }

    private int getInt(Map<String, Object> config, String key, int defaultValue) {
        Object value = config.get(key);
        if (value == null) return defaultValue;
        if (value instanceof Number) return ((Number) value).intValue();
        try { return Integer.parseInt(String.valueOf(value)); } catch (NumberFormatException e) { return defaultValue; }
    }
}
