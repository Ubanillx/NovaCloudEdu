package com.novacloudedu.backend.infrastructure.workflow.executor.code;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.api.async.ResultCallback;
import com.github.dockerjava.api.command.CreateContainerResponse;
import com.github.dockerjava.api.command.WaitContainerResultCallback;
import com.github.dockerjava.api.model.*;
import com.github.dockerjava.core.DefaultDockerClientConfig;
import com.github.dockerjava.core.DockerClientConfig;
import com.github.dockerjava.core.DockerClientImpl;
import com.github.dockerjava.zerodep.ZerodepDockerHttpClient;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Docker 沙箱 Python 代码执行服务
 * <p>
 * 通过 Docker 容器隔离执行用户提交的 Python 代码，实现：
 * - 资源隔离（CPU、内存、网络限制）
 * - JSON 数据交互（input.json → solution.py → output.json）
 * - MD5 缓存依赖管理（requirements.txt → venv_{md5}）
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class DockerPythonExecutionService {

    private final CodeSandboxConfig config;
    private final ObjectMapper objectMapper;

    private DockerClient dockerClient;

    /**
     * entrypoint.py 包装器 — 容器启动入口
     */
    private static final String ENTRYPOINT_PY = """
            import json, importlib, sys, traceback
            
            def run():
                with open('/app/input.json', 'r', encoding='utf-8') as f:
                    args = json.load(f)
                try:
                    sys.path.append('/app')
                    user_mod = importlib.import_module('solution')
                    result = user_mod.main(args)
                    output = {"success": True, "data": result}
                except Exception as e:
                    output = {"success": False, "error": str(e), "traceback": traceback.format_exc()}
                with open('/app/output.json', 'w', encoding='utf-8') as f:
                    json.dump(output, f, ensure_ascii=False, default=str)
            
            if __name__ == "__main__":
                run()
            """;

    @PostConstruct
    public void init() {
        log.info("╔══════════════════════════════════════════════════════╗");
        log.info("║       Docker Python 沙箱执行服务 - 初始化开始        ║");
        log.info("╚══════════════════════════════════════════════════════╝");
        log.info("[Docker-Python] 配置: enabled={}, host={}, image={}",
                config.isDockerEnabled(), config.getDockerHost(), config.getPythonImage());
        log.info("[Docker-Python] 资源限制: memory={}MB, cpu={}, timeout={}s, network={}",
                config.getMemoryLimit() / 1024 / 1024, config.getCpuCount(),
                config.getTimeoutSeconds(), config.isNetworkDisabled() ? "禁用" : "启用");
        log.info("[Docker-Python] 目录: venvCache={}, temp={}",
                config.getVenvCacheDir(), config.getTempDir());

        if (!config.isDockerEnabled()) {
            log.warn("[Docker-Python] ⚠ Docker Python 执行服务已禁用 (docker-enabled=false)");
            log.warn("[Docker-Python] Python 代码节点将不可用，如需启用请设置 workflow.code-sandbox.docker-enabled=true");
            return;
        }

        try {
            // 1. 创建 Docker 客户端
            log.info("[Docker-Python] 正在连接 Docker 守护进程: {}", config.getDockerHost());
            DockerClientConfig clientConfig = DefaultDockerClientConfig.createDefaultConfigBuilder()
                    .withDockerHost(config.getDockerHost())
                    .build();

            ZerodepDockerHttpClient httpClient = new ZerodepDockerHttpClient.Builder()
                    .dockerHost(clientConfig.getDockerHost())
                    .maxConnections(10)
                    .connectionTimeout(Duration.ofSeconds(10))
                    .responseTimeout(Duration.ofSeconds(30))
                    .build();

            dockerClient = DockerClientImpl.getInstance(clientConfig, httpClient);

            // 2. Ping 测试连接
            dockerClient.pingCmd().exec();
            log.info("[Docker-Python] ✓ Docker 守护进程连接成功");

            // 3. 获取 Docker 版本信息
            try {
                var info = dockerClient.infoCmd().exec();
                log.info("[Docker-Python] Docker 版本: {}, 操作系统: {}, 容器数: {}",
                        info.getServerVersion(), info.getOperatingSystem(), info.getContainers());
            } catch (Exception e) {
                log.debug("[Docker-Python] 获取 Docker 信息失败（不影响使用）: {}", e.getMessage());
            }

            // 4. 检查 Python 镜像是否存在，不存在则拉取
            ensurePythonImage();

            // 5. 确保缓存目录存在
            Files.createDirectories(Path.of(config.getVenvCacheDir()));
            Files.createDirectories(Path.of(config.getTempDir()));
            log.info("[Docker-Python] ✓ 缓存目录已就绪");

            log.info("╔══════════════════════════════════════════════════════╗");
            log.info("║    Docker Python 沙箱执行服务 - 初始化成功 ✓         ║");
            log.info("╚══════════════════════════════════════════════════════╝");

        } catch (Exception e) {
            log.error("╔══════════════════════════════════════════════════════╗");
            log.error("║    Docker Python 沙箱执行服务 - 初始化失败 ✗         ║");
            log.error("╚══════════════════════════════════════════════════════╝");
            log.error("[Docker-Python] 初始化失败原因: {}", e.getMessage());
            log.error("[Docker-Python] 请检查:");
            log.error("[Docker-Python]   1. Docker Desktop 是否已启动");
            log.error("[Docker-Python]   2. Docker socket 路径是否正确: {}", config.getDockerHost());
            log.error("[Docker-Python]   3. 当前用户是否有 Docker 访问权限");
            log.error("[Docker-Python] Python 代码节点将不可用，JavaScript 代码节点不受影响");
            dockerClient = null;
        }
    }

    /**
     * 确保 Python 镜像存在，不存在则自动拉取
     */
    private void ensurePythonImage() {
        String image = config.getPythonImage();
        try {
            dockerClient.inspectImageCmd(image).exec();
            log.info("[Docker-Python] ✓ Python 镜像已存在: {}", image);
        } catch (Exception e) {
            log.info("[Docker-Python] Python 镜像 {} 不存在，正在拉取（首次可能需要几分钟）...", image);
            try {
                dockerClient.pullImageCmd(image)
                        .start()
                        .awaitCompletion(5, TimeUnit.MINUTES);
                log.info("[Docker-Python] ✓ Python 镜像拉取完成: {}", image);
            } catch (Exception pullEx) {
                log.warn("[Docker-Python] ⚠ Python 镜像拉取失败: {}（首次执行 Python 代码时将再次尝试）", pullEx.getMessage());
            }
        }
    }

    @PreDestroy
    public void destroy() {
        if (dockerClient != null) {
            try {
                dockerClient.close();
            } catch (IOException e) {
                log.warn("关闭 Docker 客户端失败", e);
            }
        }
    }

    public boolean isAvailable() {
        return dockerClient != null;
    }

    /**
     * 执行 Python 代码
     *
     * @param code         用户 Python 代码（需包含 def main(args) 函数）
     * @param input        输入变量 map，序列化为 input.json 传入容器
     * @param requirements pip 依赖列表（requirements.txt 内容），可为空
     * @return 执行结果 map
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> execute(String code, Map<String, Object> input, String requirements) {
        if (dockerClient == null) {
            throw new IllegalStateException("Docker 客户端未初始化，Python 代码执行不可用。请确保 Docker 已安装并启动。");
        }

        Path tempDir = null;
        String containerId = null;
        try {
            // 1. 创建临时工作目录
            tempDir = Files.createTempDirectory(Path.of(config.getTempDir()), "py_");
            log.debug("Python 执行临时目录: {}", tempDir);

            // 2. 写入 entrypoint.py
            Files.writeString(tempDir.resolve("entrypoint.py"), ENTRYPOINT_PY);

            // 3. 写入用户代码 solution.py
            Files.writeString(tempDir.resolve("solution.py"), code);

            // 4. 写入输入数据 input.json
            Files.writeString(tempDir.resolve("input.json"), objectMapper.writeValueAsString(input));

            // 5. 处理依赖
            String venvPath = null;
            if (requirements != null && !requirements.isBlank()) {
                venvPath = ensureDependencies(requirements);
            }

            // 6. 构建容器
            HostConfig hostConfig = buildHostConfig(tempDir.toString(), venvPath);

            String[] envVars = venvPath != null
                    ? new String[]{"PYTHONPATH=/venv/lib/python3.11/site-packages:/venv/lib/python3/site-packages"}
                    : new String[]{};

            CreateContainerResponse container = dockerClient.createContainerCmd(config.getPythonImage())
                    .withHostConfig(hostConfig)
                    .withEnv(envVars)
                    .withCmd("python3", "/app/entrypoint.py")
                    .withWorkingDir("/app")
                    .exec();

            containerId = container.getId();
            log.debug("创建 Python 容器: {}", containerId);

            // 7. 启动容器
            dockerClient.startContainerCmd(containerId).exec();

            // 8. 等待执行完成（带超时）
            WaitContainerResultCallback waitCallback = new WaitContainerResultCallback();
            dockerClient.waitContainerCmd(containerId).exec(waitCallback);

            boolean completed = waitCallback.awaitCompletion(config.getTimeoutSeconds(), TimeUnit.SECONDS);
            if (!completed) {
                // 超时 → 强制停止
                try {
                    dockerClient.stopContainerCmd(containerId).withTimeout(2).exec();
                } catch (Exception ignored) {
                }
                throw new RuntimeException("Python 代码执行超时（" + config.getTimeoutSeconds() + "秒）");
            }

            // 9. 收集容器日志（用于调试）
            StringBuilder containerLogs = new StringBuilder();
            dockerClient.logContainerCmd(containerId)
                    .withStdOut(true)
                    .withStdErr(true)
                    .exec(new ResultCallback.Adapter<Frame>() {
                        @Override
                        public void onNext(Frame frame) {
                            containerLogs.append(new String(frame.getPayload(), StandardCharsets.UTF_8));
                        }
                    }).awaitCompletion(5, TimeUnit.SECONDS);

            if (!containerLogs.isEmpty()) {
                log.debug("Python 容器日志:\n{}", containerLogs);
            }

            // 10. 读取输出
            Path outputFile = tempDir.resolve("output.json");
            if (!Files.exists(outputFile)) {
                throw new RuntimeException("Python 代码未生成输出文件。容器日志:\n" + containerLogs);
            }

            String outputJson = Files.readString(outputFile);
            Map<String, Object> output = objectMapper.readValue(outputJson, Map.class);

            if (Boolean.TRUE.equals(output.get("success"))) {
                Object data = output.get("data");
                if (data instanceof Map) {
                    return (Map<String, Object>) data;
                } else {
                    Map<String, Object> result = new HashMap<>();
                    result.put("result", data);
                    return result;
                }
            } else {
                String error = (String) output.getOrDefault("error", "未知错误");
                String tb = (String) output.get("traceback");
                throw new RuntimeException("Python 执行错误: " + error + (tb != null ? "\n" + tb : ""));
            }

        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException("Python 代码执行失败: " + e.getMessage(), e);
        } finally {
            // 清理容器
            if (containerId != null) {
                try {
                    dockerClient.removeContainerCmd(containerId).withForce(true).exec();
                } catch (Exception e) {
                    log.warn("清理 Python 容器失败: {}", e.getMessage());
                }
            }
            // 清理临时目录
            if (tempDir != null) {
                cleanupDir(tempDir);
            }
        }
    }

    /**
     * 构建容器 HostConfig：挂载卷、资源限制
     */
    private HostConfig buildHostConfig(String workDir, String venvPath) {
        HostConfig hostConfig = HostConfig.newHostConfig()
                .withBinds(new Bind(workDir, new Volume("/app")))
                .withMemory(config.getMemoryLimit())
                .withCpuCount(config.getCpuCount())
                .withNetworkMode(config.isNetworkDisabled() ? "none" : "bridge")
                .withReadonlyRootfs(false);

        if (venvPath != null) {
            hostConfig = hostConfig.withBinds(
                    new Bind(workDir, new Volume("/app")),
                    new Bind(venvPath, new Volume("/venv"), AccessMode.ro)
            );
        }

        return hostConfig;
    }

    /**
     * MD5 缓存依赖管理：根据 requirements.txt 内容的 MD5 确定缓存目录
     */
    private String ensureDependencies(String requirements) {
        try {
            String md5 = md5Hex(requirements);
            String venvPath = config.getVenvCacheDir() + "/venv_" + md5;

            if (Files.exists(Path.of(venvPath))) {
                log.debug("命中依赖缓存: {}", venvPath);
                return venvPath;
            }

            log.info("构建 Python 依赖缓存: md5={}", md5);

            // 创建目录
            Files.createDirectories(Path.of(venvPath, "lib"));

            // 创建临时 requirements.txt
            Path reqFile = Files.createTempFile(Path.of(config.getTempDir()), "req_", ".txt");
            Files.writeString(reqFile, requirements);

            // 启动构建容器安装依赖
            HostConfig hostConfig = HostConfig.newHostConfig()
                    .withBinds(
                            new Bind(reqFile.toString(), new Volume("/tmp/requirements.txt"), AccessMode.ro),
                            new Bind(venvPath, new Volume("/venv"))
                    )
                    .withMemory(512 * 1024 * 1024L)
                    .withNetworkMode("bridge"); // 安装依赖需要网络

            CreateContainerResponse container = dockerClient.createContainerCmd(config.getPythonImage())
                    .withHostConfig(hostConfig)
                    .withCmd("pip", "install", "--target=/venv/lib/python3.11/site-packages",
                            "-r", "/tmp/requirements.txt", "--no-cache-dir")
                    .exec();

            String cid = container.getId();
            dockerClient.startContainerCmd(cid).exec();

            WaitContainerResultCallback callback = new WaitContainerResultCallback();
            dockerClient.waitContainerCmd(cid).exec(callback);
            boolean done = callback.awaitCompletion(120, TimeUnit.SECONDS); // 依赖安装最多等 2 分钟

            // 清理
            dockerClient.removeContainerCmd(cid).withForce(true).exec();
            Files.deleteIfExists(reqFile);

            if (!done) {
                log.warn("依赖安装超时，删除缓存目录: {}", venvPath);
                cleanupDir(Path.of(venvPath));
                throw new RuntimeException("Python 依赖安装超时");
            }

            log.info("依赖缓存构建完成: {}", venvPath);
            return venvPath;

        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException("Python 依赖安装失败: " + e.getMessage(), e);
        }
    }

    private static String md5Hex(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("MD5 计算失败", e);
        }
    }

    private void cleanupDir(Path dir) {
        try {
            if (Files.exists(dir)) {
                Files.walk(dir)
                        .sorted(java.util.Comparator.reverseOrder())
                        .forEach(p -> {
                            try { Files.deleteIfExists(p); } catch (IOException ignored) {}
                        });
            }
        } catch (IOException e) {
            log.warn("清理临时目录失败: {}", dir, e);
        }
    }
}
