package com.novacloudedu.backend.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.env.EnvironmentPostProcessor;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MapPropertySource;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 自动加载项目根目录下 docker/.env 文件中的环境变量到 Spring Environment。
 * <p>
 * 加载优先级最低（order=最后），即：
 * <ul>
 *   <li>系统环境变量 > .env 文件</li>
 *   <li>application-{profile}.yml > application.yml > .env 文件</li>
 * </ul>
 * .env 文件仅作为本地开发的便捷兜底，不会覆盖已有的环境变量或 yml 配置。
 * <p>
 * 搜索路径（按优先级）：
 * <ol>
 *   <li>{user.dir}/docker/.env</li>
 *   <li>{user.dir}/../docker/.env</li>
 *   <li>{user.dir}/.env</li>
 * </ol>
 */
public class DotenvEnvironmentPostProcessor implements EnvironmentPostProcessor {

    private static final String PROPERTY_SOURCE_NAME = "dotenvProperties";

    @Override
    public void postProcessEnvironment(ConfigurableEnvironment environment, SpringApplication application) {
        Path envFile = findEnvFile();
        if (envFile == null) {
            return;
        }

        Map<String, Object> envVars = parseEnvFile(envFile);
        if (envVars.isEmpty()) {
            return;
        }

        // addLast = 最低优先级，不覆盖系统环境变量和 yml 配置
        // 但足以为 application.yml 中的 ${ENV_VAR:default} 占位符提供值
        environment.getPropertySources().addLast(new MapPropertySource(PROPERTY_SOURCE_NAME, envVars));
    }

    private Path findEnvFile() {
        String userDir = System.getProperty("user.dir", ".");
        Path[] candidates = {
                Paths.get(userDir, "docker", ".env"),
                Paths.get(userDir, "..", "docker", ".env"),
                Paths.get(userDir, ".env"),
        };
        for (Path candidate : candidates) {
            Path normalized = candidate.normalize();
            if (Files.isRegularFile(normalized)) {
                return normalized;
            }
        }
        return null;
    }

    private Map<String, Object> parseEnvFile(Path envFile) {
        Map<String, Object> result = new LinkedHashMap<>();
        try (BufferedReader reader = Files.newBufferedReader(envFile, StandardCharsets.UTF_8)) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                // 跳过空行和注释
                if (line.isEmpty() || line.startsWith("#")) {
                    continue;
                }
                int eqIndex = line.indexOf('=');
                if (eqIndex <= 0) {
                    continue;
                }
                String key = line.substring(0, eqIndex).trim();
                String value = line.substring(eqIndex + 1).trim();
                // 去除可选的引号包裹
                if (value.length() >= 2
                        && ((value.startsWith("\"") && value.endsWith("\""))
                        || (value.startsWith("'") && value.endsWith("'")))) {
                    value = value.substring(1, value.length() - 1);
                }
                result.put(key, value);
            }
        } catch (IOException e) {
            // .env 文件读取失败不阻断启动
        }
        return result;
    }
}
