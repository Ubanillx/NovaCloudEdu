package com.novacloudedu.backend.interfaces.rest.livestream;

import com.novacloudedu.backend.application.livestream.LivestreamApplicationService;
import com.novacloudedu.backend.interfaces.rest.livestream.dto.SrsCallbackRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * SRS 回调控制器（内部接口，无需JWT认证）
 * SRS 在推流/停流/观众加入/观众离开时通过 HTTP 回调通知此接口
 */
@RestController
@RequestMapping("/api/internal/srs")
@RequiredArgsConstructor
@Slf4j
public class SrsCallbackController {

    private final LivestreamApplicationService livestreamService;

    /**
     * 推流鉴权回调
     * SRS 收到 RTMP 推流时调用，返回 200 允许，非 200 拒绝
     */
    @PostMapping("/on_publish")
    public ResponseEntity<Integer> onPublish(@RequestBody SrsCallbackRequest request) {
        log.info("SRS on_publish: app={}, stream={}, ip={}", request.getApp(), request.getStream(), request.getIp());
        boolean allowed = livestreamService.onPublish(request.getStream());
        if (allowed) {
            return ResponseEntity.ok(0);
        } else {
            log.warn("SRS on_publish 拒绝: stream={}", request.getStream());
            return ResponseEntity.status(403).body(1);
        }
    }

    /**
     * 推流结束回调
     */
    @PostMapping("/on_unpublish")
    public ResponseEntity<Integer> onUnpublish(@RequestBody SrsCallbackRequest request) {
        log.info("SRS on_unpublish: app={}, stream={}", request.getApp(), request.getStream());
        livestreamService.onUnpublish(request.getStream());
        return ResponseEntity.ok(0);
    }

    /**
     * 观众加入回调
     */
    @PostMapping("/on_play")
    public ResponseEntity<Integer> onPlay(@RequestBody SrsCallbackRequest request) {
        log.debug("SRS on_play: app={}, stream={}, clientId={}", request.getApp(), request.getStream(), request.getClientId());
        livestreamService.onPlay(request.getStream());
        return ResponseEntity.ok(0);
    }

    /**
     * 观众离开回调
     */
    @PostMapping("/on_stop")
    public ResponseEntity<Integer> onStop(@RequestBody SrsCallbackRequest request) {
        log.debug("SRS on_stop: app={}, stream={}, clientId={}", request.getApp(), request.getStream(), request.getClientId());
        livestreamService.onStop(request.getStream());
        return ResponseEntity.ok(0);
    }
}
