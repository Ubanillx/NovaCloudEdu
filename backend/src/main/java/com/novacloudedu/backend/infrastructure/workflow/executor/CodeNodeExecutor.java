package com.novacloudedu.backend.infrastructure.workflow.executor;

import com.novacloudedu.backend.domain.ai.entity.WorkflowExecution;
import com.novacloudedu.backend.domain.ai.service.NodeExecutor;
import com.novacloudedu.backend.domain.ai.valueobject.NodeType;
import com.novacloudedu.backend.domain.ai.valueobject.WorkflowNode;
import com.novacloudedu.backend.infrastructure.workflow.executor.code.DockerPythonExecutionService;
import com.novacloudedu.backend.infrastructure.workflow.executor.code.GraalJsExecutionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * 代码执行节点执行器（支持 JavaScript + Python）
 * <p>
 * === 配置项 (node.config) ===
 * - language:        "JAVASCRIPT" | "PYTHON"（不区分大小写）
 * - code:            用户代码
 *   · JS:  代码可直接 return 对象，或定义 function main(args){...}
 *   · Python: 必须定义 def main(args): ... ，args 为输入变量字典，返回值作为输出
 * - inputVariables:  输入变量映射列表 [{ name: "varName", source: "upstreamVar" }]
 *                    如果为空，则将全部上游变量注入
 * - outputVariables: 输出变量声明列表 [{ name: "varName", type: "string" }]
 *                    如果为空，脚本返回的所有 key 都写入上下文
 * - requirements:    Python 依赖 (requirements.txt 内容)，仅 Python 生效
 * - timeout:         执行超时秒数（覆盖全局默认值）
 * <p>
 * === 执行流程 ===
 * 1. 解析配置，构建输入变量 Map（inputVariables 映射 or 全量注入）
 * 2. 根据 language 委托到 GraalJsExecutionService 或 DockerPythonExecutionService
 * 3. 对脚本返回值按 outputVariables 过滤/重命名，写入工作流上下文
 * <p>
 * === 输出 ===
 * - 脚本返回的 Map 中的所有键值（受 outputVariables 过滤）
 * - _language: 执行语言
 * - _executionTime: 执行耗时(ms)
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class CodeNodeExecutor implements NodeExecutor {

    private final GraalJsExecutionService jsExecutor;
    private final DockerPythonExecutionService pythonExecutor;

    @Override
    public NodeType getNodeType() {
        return NodeType.CODE;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(WorkflowNode node, Map<String, Object> input, WorkflowExecution context) {
        Map<String, Object> config = node.getConfig();

        String code = (String) config.getOrDefault("code", "");
        String language = ((String) config.getOrDefault("language", "JAVASCRIPT")).toUpperCase();

        if (code == null || code.isBlank()) {
            log.warn("代码节点[{}]: 代码为空", node.getName());
            return new HashMap<>();
        }

        log.info("代码节点执行: name={}, language={}, codeLength={}", node.getName(), language, code.length());

        // 1. 构建输入变量
        Map<String, Object> scriptInput = buildScriptInput(config, input);

        // 2. 执行代码
        long startTime = System.currentTimeMillis();
        Map<String, Object> rawOutput;

        try {
            rawOutput = switch (language) {
                case "JAVASCRIPT", "JS" -> jsExecutor.execute(code, scriptInput);
                case "PYTHON", "PY" -> {
                    if (!pythonExecutor.isAvailable()) {
                        throw new IllegalStateException("Python 执行环境不可用（Docker 未启动或未配置）");
                    }
                    String requirements = (String) config.getOrDefault("requirements", "");
                    yield pythonExecutor.execute(code, scriptInput, requirements);
                }
                default -> throw new UnsupportedOperationException("不支持的编程语言: " + language);
            };
        } catch (Exception e) {
            log.error("代码执行失败: node={}, language={}", node.getName(), language, e);
            throw new RuntimeException("代码执行失败 [" + language + "]: " + e.getMessage(), e);
        }

        long executionTime = System.currentTimeMillis() - startTime;
        log.info("代码节点执行完成: name={}, language={}, 耗时={}ms, 输出keys={}",
                node.getName(), language, executionTime,
                rawOutput != null ? rawOutput.keySet() : "null");

        // 3. 处理输出变量
        Map<String, Object> output = buildOutput(config, rawOutput);
        output.put("_language", language);
        output.put("_executionTime", executionTime);

        return output;
    }

    @Override
    public void validate(WorkflowNode node) {
        Map<String, Object> config = node.getConfig();
        if (config == null) {
            throw new IllegalArgumentException("代码节点缺少配置");
        }
        String code = (String) config.get("code");
        if (code == null || code.isBlank()) {
            throw new IllegalArgumentException("代码节点缺少 code 配置");
        }
        String language = (String) config.getOrDefault("language", "JAVASCRIPT");
        if (!Set.of("JAVASCRIPT", "JS", "PYTHON", "PY").contains(language.toUpperCase())) {
            throw new IllegalArgumentException("不支持的编程语言: " + language);
        }
    }

    /**
     * 构建脚本输入变量
     * <p>
     * 如果配置了 inputVariables 映射，只注入映射中指定的变量（支持重命名）；
     * 否则注入所有上游变量。
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> buildScriptInput(Map<String, Object> config, Map<String, Object> allInput) {
        Object inputVarsObj = config.get("inputVariables");
        if (inputVarsObj instanceof List<?> inputVarsList && !inputVarsList.isEmpty()) {
            Map<String, Object> mapped = new HashMap<>();
            for (Object item : inputVarsList) {
                if (item instanceof Map<?, ?> varDef) {
                    String name = (String) varDef.get("name");       // 脚本内变量名
                    String source = (String) varDef.get("source");   // 上游变量名
                    if (name != null && !name.isBlank() && source != null && !source.isBlank()) {
                        Object value = resolveVariable(source, allInput);
                        mapped.put(name, value);
                    }
                }
            }
            return mapped;
        }

        // 未配置映射 → 全量注入（过滤内部变量）
        Map<String, Object> filtered = new HashMap<>();
        for (Map.Entry<String, Object> entry : allInput.entrySet()) {
            if (!entry.getKey().startsWith("_")) {
                filtered.put(entry.getKey(), entry.getValue());
            }
        }
        return filtered;
    }

    /**
     * 解析变量值，支持点号路径（如 "http_1.jsonBody.data"）
     */
    @SuppressWarnings("unchecked")
    private Object resolveVariable(String path, Map<String, Object> variables) {
        if (!path.contains(".")) {
            return variables.get(path);
        }

        String[] parts = path.split("\\.", 2);
        Object current = variables.get(parts[0]);
        if (current instanceof Map && parts.length > 1) {
            return resolveNestedPath(parts[1], (Map<String, Object>) current);
        }
        // 尝试整个 path 作为 key
        if (variables.containsKey(path)) {
            return variables.get(path);
        }
        return current;
    }

    @SuppressWarnings("unchecked")
    private Object resolveNestedPath(String path, Map<String, Object> map) {
        String[] parts = path.split("\\.", 2);
        Object value = map.get(parts[0]);
        if (parts.length == 1 || value == null) {
            return value;
        }
        if (value instanceof Map) {
            return resolveNestedPath(parts[1], (Map<String, Object>) value);
        }
        return value;
    }

    /**
     * 构建输出变量
     * <p>
     * 如果配置了 outputVariables，只输出声明的变量；否则输出脚本返回的所有键值。
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> buildOutput(Map<String, Object> config, Map<String, Object> rawOutput) {
        if (rawOutput == null) {
            rawOutput = new HashMap<>();
        }

        Object outputVarsObj = config.get("outputVariables");
        if (outputVarsObj instanceof List<?> outputVarsList && !outputVarsList.isEmpty()) {
            Map<String, Object> output = new HashMap<>();
            for (Object item : outputVarsList) {
                if (item instanceof Map<?, ?> varDef) {
                    String name = (String) varDef.get("name");
                    if (name != null && !name.isBlank()) {
                        output.put(name, rawOutput.get(name));
                    }
                }
            }
            return output;
        }

        // 未配置 → 全量输出
        return new HashMap<>(rawOutput);
    }
}
