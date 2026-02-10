package com.novacloudedu.backend.infrastructure.workflow.executor.code;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.graalvm.polyglot.Context;
import org.graalvm.polyglot.HostAccess;
import org.graalvm.polyglot.Value;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.*;

/**
 * GraalJS JavaScript 沙箱执行服务
 * <p>
 * 使用 GraalVM Polyglot API 在 JVM 内安全执行用户 JavaScript 代码。
 * - 沙箱隔离：禁止 IO、网络、进程操作
 * - 超时控制：通过独立线程 + Future.get(timeout) 实现
 * - 数据交互：输入变量绑定到 JS 全局作用域，返回值解析为 Map
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class GraalJsExecutionService {

    private final CodeSandboxConfig config;
    private final ObjectMapper objectMapper;

    private final ExecutorService executor = Executors.newFixedThreadPool(
            Runtime.getRuntime().availableProcessors(),
            r -> {
                Thread t = new Thread(r, "graaljs-worker");
                t.setDaemon(true);
                return t;
            }
    );

    /**
     * 执行 JavaScript 代码
     *
     * @param code  用户 JS 代码，应返回一个对象（通过最后一个表达式或 main 函数）
     * @param input 输入变量 map，绑定到 JS 全局作用域
     * @return 执行结果 map
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(String code, Map<String, Object> input) {
        int timeoutSeconds = config.getJsTimeoutSeconds();

        Future<Map<String, Object>> future = executor.submit(() -> executeInContext(code, input));

        try {
            return future.get(timeoutSeconds, TimeUnit.SECONDS);
        } catch (TimeoutException e) {
            future.cancel(true);
            throw new RuntimeException("JavaScript 代码执行超时（" + timeoutSeconds + "秒）");
        } catch (ExecutionException e) {
            Throwable cause = e.getCause();
            if (cause instanceof RuntimeException) {
                throw (RuntimeException) cause;
            }
            throw new RuntimeException("JavaScript 执行失败: " + cause.getMessage(), cause);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new RuntimeException("JavaScript 执行被中断");
        }
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> executeInContext(String code, Map<String, Object> input) {
        try (Context context = Context.newBuilder("js")
                .allowHostAccess(HostAccess.SCOPED)
                .allowExperimentalOptions(true)
                .option("js.ecmascript-version", "2022")
                .option("engine.WarnInterpreterOnly", "false")
                .build()) {

            Value bindings = context.getBindings("js");

            // 将输入变量绑定到 JS 全局作用域
            for (Map.Entry<String, Object> entry : input.entrySet()) {
                try {
                    bindings.putMember(entry.getKey(), toJsValue(context, entry.getValue()));
                } catch (Exception e) {
                    log.warn("绑定变量失败: key={}, error={}", entry.getKey(), e.getMessage());
                }
            }

            // 注入 JSON 辅助函数
            context.eval("js", """
                    var __JSON_stringify = JSON.stringify;
                    var __JSON_parse = JSON.parse;
                    var console = {
                        log: function() {},
                        warn: function() {},
                        error: function() {},
                        info: function() {}
                    };
                    """);

            // 包装用户代码：支持 return 语句和 main 函数两种模式
            String wrappedCode = wrapUserCode(code);

            Value result = context.eval("js", wrappedCode);

            return convertResult(result);

        } catch (org.graalvm.polyglot.PolyglotException e) {
            if (e.isCancelled() || e.isInterrupted()) {
                throw new RuntimeException("JavaScript 执行超时或被中断");
            }
            throw new RuntimeException("JavaScript 执行错误: " + e.getMessage());
        }
    }

    /**
     * 包装用户代码，支持多种写法：
     * 1. function main(args) { ... } → 调用 main 并返回结果
     * 2. 直接代码（含 return）→ 包装在 IIFE 中
     * 3. 表达式 → 直接求值
     */
    private String wrapUserCode(String code) {
        String trimmed = code.trim();

        // 检测是否误用了 Python 代码
        if (trimmed.contains("def main(") || trimmed.contains("\"\"\"") || trimmed.startsWith("import ") || trimmed.startsWith("# ")) {
            if (trimmed.contains("def main(") || (trimmed.contains("\"\"\"") && trimmed.contains("args"))) {
                throw new RuntimeException("检测到 Python 代码，但当前语言设置为 JavaScript。请在节点配置中将语言切换为 Python。");
            }
        }

        // 模式1：用户定义了 main 函数
        if (trimmed.contains("function main")) {
            return trimmed + "\n; (typeof main === 'function' ? main(__input_vars__) : undefined);";
        }

        // 模式2：代码包含 return 语句 → 包装为 IIFE
        if (trimmed.contains("return ")) {
            return "(function() {\n" + trimmed + "\n})();";
        }

        // 模式3：直接表达式
        return trimmed;
    }

    /**
     * 将 Java 对象转换为 GraalJS 可接受的值
     */
    private Object toJsValue(Context context, Object value) {
        if (value == null) return null;
        if (value instanceof String || value instanceof Number || value instanceof Boolean) {
            return value;
        }
        // 复杂对象先序列化为 JSON，再在 JS 中解析
        try {
            String json = objectMapper.writeValueAsString(value);
            return context.eval("js", "__JSON_parse('" + escapeJs(json) + "')");
        } catch (Exception e) {
            return value.toString();
        }
    }

    /**
     * 将 GraalJS Value 转换为 Java Map
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> convertResult(Value result) {
        if (result == null || result.isNull()) {
            return new HashMap<>();
        }

        Object javaResult = valueToJava(result);

        if (javaResult instanceof Map) {
            return (Map<String, Object>) javaResult;
        }

        Map<String, Object> output = new HashMap<>();
        output.put("result", javaResult);
        return output;
    }

    /**
     * 递归将 GraalJS Value 转换为 Java 对象
     */
    private Object valueToJava(Value value) {
        if (value == null || value.isNull()) return null;
        if (value.isBoolean()) return value.asBoolean();
        if (value.isNumber()) {
            if (value.fitsInInt()) return value.asInt();
            if (value.fitsInLong()) return value.asLong();
            return value.asDouble();
        }
        if (value.isString()) return value.asString();

        if (value.hasArrayElements()) {
            List<Object> list = new ArrayList<>();
            for (long i = 0; i < value.getArraySize(); i++) {
                list.add(valueToJava(value.getArrayElement(i)));
            }
            return list;
        }

        if (value.hasMembers()) {
            Map<String, Object> map = new LinkedHashMap<>();
            for (String key : value.getMemberKeys()) {
                map.put(key, valueToJava(value.getMember(key)));
            }
            return map;
        }

        // fallback
        try {
            return value.as(Object.class);
        } catch (Exception e) {
            return value.toString();
        }
    }

    private static String escapeJs(String s) {
        return s.replace("\\", "\\\\")
                .replace("'", "\\'")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
