package com.novacloudedu.backend.infrastructure.workflow.executor.code;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * 代码执行沙箱配置
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "workflow.code-sandbox")
public class CodeSandboxConfig {

    /**
     * Docker 宿主机地址（unix:///var/run/docker.sock 或 tcp://...）
     */
    private String dockerHost = "unix:///var/run/docker.sock";

    /**
     * Python 基础镜像
     */
    private String pythonImage = "python:3.11-slim";

    /**
     * 容器内存限制（字节），默认 256MB
     */
    private long memoryLimit = 256 * 1024 * 1024L;

    /**
     * 容器 CPU 核数限制
     */
    private long cpuCount = 1L;

    /**
     * 执行超时时间（秒）
     */
    private int timeoutSeconds = 30;

    /**
     * JS 执行超时时间（秒）
     */
    private int jsTimeoutSeconds = 10;

    /**
     * 是否禁用容器网络
     */
    private boolean networkDisabled = true;

    /**
     * 宿主机上缓存虚拟环境的根目录
     */
    private String venvCacheDir = "/opt/novacloudedu/venvs";

    /**
     * 宿主机上临时文件目录
     */
    private String tempDir = "/tmp/novacloudedu-sandbox";

    /**
     * 是否启用 Docker Python 执行（关闭时回退到进程执行）
     */
    private boolean dockerEnabled = true;
}
