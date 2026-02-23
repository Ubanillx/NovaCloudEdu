package com.novacloudedu.backend.interfaces.rest.video;

import com.novacloudedu.backend.annotation.AuthCheck;
import com.novacloudedu.backend.application.service.VideoPlayTokenService;
import com.novacloudedu.backend.common.BaseResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

/**
 * 视频播放令牌控制器
 * 为 Flutter App 提供一次性播放令牌，用于 HLS 密钥获取接口
 */
@RestController
@RequestMapping("/api/video")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "视频播放", description = "视频播放令牌管理")
public class VideoPlayTokenController {

    private final VideoPlayTokenService tokenService;

    /**
     * 获取视频播放令牌
     * 客户端播放加密HLS前调用此接口，获取一次性token
     * @param sectionId 小节ID
     * @param keyId 加密密钥ID
     * @param userId 当前用户ID
     * @return 一次性播放令牌
     */
    @GetMapping("/play-token")
    @AuthCheck
    @Operation(summary = "获取视频播放令牌",
               description = "获取一次性播放令牌，用于请求HLS解密密钥。令牌5分钟有效且只能使用一次。")
    public BaseResponse<String> getPlayToken(
            @RequestParam @Parameter(description = "小节ID") Long sectionId,
            @RequestParam @Parameter(description = "加密密钥ID") String keyId,
            @AuthenticationPrincipal Long userId) {
        
        if (userId == null) {
            return new BaseResponse<>(401, null, "请先登录");
        }
        
        if (keyId == null || keyId.isBlank()) {
            return new BaseResponse<>(400, null, "keyId不能为空");
        }
        
        String token = tokenService.generateToken(userId, keyId);
        log.debug("播放令牌已生成, userId={}, sectionId={}, keyId={}", userId, sectionId, keyId);
        
        return new BaseResponse<>(0, token, "success");
    }

    /**
     * 获取视频流访问令牌
     * Flutter 播放加密 HLS 前调用此接口获取一次性 stream token，
     * 然后将 token 拼入 URL：/api/video/hls/{sectionId}?token=xxx
     * @param sectionId 小节ID
     * @param userId 当前用户ID
     * @return 一次性流访问令牌
     */
    @GetMapping("/stream-token")
    @AuthCheck
    @Operation(summary = "获取视频流访问令牌",
               description = "获取一次性流访问令牌，用于 HLS m3u8 请求的 URL 认证。令牌5分钟有效且只能使用一次。")
    public BaseResponse<String> getStreamToken(
            @RequestParam @Parameter(description = "小节ID") Long sectionId,
            @AuthenticationPrincipal Long userId) {
        
        if (userId == null) {
            return new BaseResponse<>(401, null, "请先登录");
        }
        
        String token = tokenService.generateStreamToken(userId, sectionId);
        log.debug("流访问令牌已生成, userId={}, sectionId={}", userId, sectionId);
        
        return new BaseResponse<>(0, token, "success");
    }
}
