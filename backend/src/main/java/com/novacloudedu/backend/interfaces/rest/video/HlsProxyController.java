package com.novacloudedu.backend.interfaces.rest.video;

import com.novacloudedu.backend.application.service.HlsProxyService;
import com.novacloudedu.backend.application.service.VideoPlayTokenService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * HLS 视频流代理控制器
 * 为 Flutter App 提供带 Token 验证的 m3u8 播放链接
 * 
 * 注意：此接口不使用 JWT 认证，改用 URL 中的一次性 stream token 验证身份
 * 因为原生视频播放器（ExoPlayer/AVPlayer）无法携带自定义 HTTP Header
 */
@RestController
@RequestMapping("/api/video")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "视频播放", description = "HLS视频流代理")
public class HlsProxyController {

    private final HlsProxyService hlsProxyService;
    private final VideoPlayTokenService tokenService;

    /**
     * 获取带 Token 的 HLS m3u8 播放内容
     * 
     * 播放流程：
     * 1. Flutter 先通过 JWT 认证的 /api/video/stream-token 接口获取一次性 stream token
     * 2. Flutter 将 token 拼入 URL：/api/video/hls/{sectionId}?token=xxx
     * 3. 将此 URL 传给原生视频播放器
     * 4. 后端验证 token 后返回修改过的 m3u8（key URI 中已嵌入密钥 token）
     * 
     * @param sectionId 小节ID
     * @param token 一次性流访问令牌（通过 /api/video/stream-token 获取）
     * @param response HTTP响应
     */
    @GetMapping("/hls/{sectionId}")
    @Operation(summary = "获取HLS播放流（Token-in-URL认证）",
               description = """
                   通过 URL 中的一次性 token 验证身份，返回修改后的 m3u8 内容。
                   原生视频播放器无法携带 HTTP Header，因此使用 token-in-URL 方式认证。
                   客户端需先调用 /api/video/stream-token 获取 token。
                   """)
    public void getHlsStream(
            @PathVariable @Parameter(description = "小节ID") Long sectionId,
            @RequestParam @Parameter(description = "一次性流访问令牌") String token,
            HttpServletRequest request,
            HttpServletResponse response) throws IOException {

        // 1. 验证 stream token（一次性消费），获取 userId
        Long userId = tokenService.validateStreamToken(token, sectionId);
        if (userId == null) {
            log.warn("HLS流请求被拒绝: token无效或已过期, sectionId={}", sectionId);
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("token无效或已过期");
            return;
        }

        // 2. 获取带 key-token 的 m3u8 内容
        String requestBaseUrl = resolveRequestBaseUrl(request);
        String m3u8Content = hlsProxyService.getM3u8Stream(sectionId, userId, requestBaseUrl);

        if (m3u8Content == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("视频不存在或暂不可用");
            return;
        }

        // 3. 返回 m3u8 内容
        response.setContentType("application/vnd.apple.mpegurl");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        byte[] bytes = m3u8Content.getBytes(StandardCharsets.UTF_8);
        response.setContentLength(bytes.length);
        response.getOutputStream().write(bytes);
        response.getOutputStream().flush();

        log.debug("HLS流已分发, sectionId={}, userId={}", sectionId, userId);
    }

    private String resolveRequestBaseUrl(HttpServletRequest request) {
        String forwardedProto = request.getHeader("X-Forwarded-Proto");
        String forwardedHost = request.getHeader("X-Forwarded-Host");

        String scheme = (forwardedProto != null && !forwardedProto.isBlank())
                ? forwardedProto.split(",")[0].trim()
                : request.getScheme();

        if (forwardedHost != null && !forwardedHost.isBlank()) {
            return scheme + "://" + forwardedHost.split(",")[0].trim();
        }

        int port = request.getServerPort();
        boolean defaultPort = ("http".equalsIgnoreCase(scheme) && port == 80)
                || ("https".equalsIgnoreCase(scheme) && port == 443);
        String host = request.getServerName();
        return defaultPort ? (scheme + "://" + host) : (scheme + "://" + host + ":" + port);
    }
}
