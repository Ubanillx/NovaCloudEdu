package com.novacloudedu.backend.interfaces.rest.video;

import com.novacloudedu.backend.application.course.service.VideoPlayTokenService;
import com.novacloudedu.backend.domain.course.service.VideoEncryptionKeyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

/**
 * 视频加密密钥分发控制器
 * HLS 播放器加载 m3u8 后，会根据 #EXT-X-KEY URI 请求此接口获取 AES-128 解密密钥
 * 此接口无需 JWT 认证（播放器无法附加 Header），通过一次性 Token 验证身份
 */
@RestController
@RequestMapping("/api/video")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "视频密钥", description = "视频加密密钥分发接口")
public class VideoKeyController {

    private final VideoEncryptionKeyService keyService;
    private final VideoPlayTokenService tokenService;

    @GetMapping("/key")
    @Operation(summary = "获取视频解密密钥（HLS播放器自动调用）")
    public void getKey(
            @RequestParam @Parameter(description = "密钥ID") String keyId,
            @RequestParam(required = false) @Parameter(description = "一次性播放令牌（可选）") String token,
            HttpServletResponse response) throws IOException {

        // 1. 如果提供了 token 则验证（向后兼容）；无 token 时依赖 keyId 的不可猜测性
        if (token != null && !token.isBlank()) {
            if (!tokenService.validateAndConsume(token, keyId)) {
                log.warn("密钥请求被拒绝: token无效或已过期, keyId={}", keyId);
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        }

        // 2. 从 Redis 获取 AES-128 密钥
        byte[] key = keyService.getKey(keyId);
        if (key == null) {
            log.error("密钥不存在, keyId={}", keyId);
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 3. 返回二进制密钥流
        response.setContentType("application/octet-stream");
        response.setContentLength(key.length);
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.getOutputStream().write(key);
        response.getOutputStream().flush();

        log.debug("密钥已分发, keyId={}", keyId);
    }
}
