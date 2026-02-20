package com.novacloudedu.backend.interfaces.rest.internal;

import com.novacloudedu.backend.application.livestream.RtcApplicationService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * RTC 内部接口控制器（Go 微服务调用，无需JWT认证）
 */
@RestController
@RequestMapping("/api/internal/rtc")
@RequiredArgsConstructor
@Slf4j
public class RtcInternalController {

    private final RtcApplicationService rtcService;

    /**
     * 呼叫权限校验
     * Go rtc-service 在发起呼叫前调用此接口校验权限
     */
    @PostMapping("/check-permission")
    public ResponseEntity<Map<String, Object>> checkPermission(@RequestBody CheckPermissionRequest request) {
        log.debug("RTC check-permission: callerId={}, calleeId={}", request.getCallerId(), request.getCalleeId());
        RtcApplicationService.PermissionResult result = rtcService.checkCallPermission(
                request.getCallerId(), request.getCalleeId());
        return ResponseEntity.ok(Map.of(
                "allowed", result.allowed(),
                "reason", result.reason(),
                "callerName", result.callerName() != null ? result.callerName() : "",
                "callerAvatar", result.callerAvatar() != null ? result.callerAvatar() : ""
        ));
    }

    /**
     * 保存通话记录
     * Go rtc-service 通话结束后调用此接口保存记录
     */
    @PostMapping("/call-record")
    public ResponseEntity<Map<String, Object>> saveCallRecord(@RequestBody SaveCallRecordRequest request) {
        log.info("RTC save-call-record: callId={}, callerId={}, calleeId={}, status={}",
                request.getCallId(), request.getCallerId(), request.getCalleeId(), request.getStatus());
        Long recordId = rtcService.saveCallRecord(
                request.getCallId(),
                request.getCallerId(),
                request.getCalleeId(),
                request.getMediaType(),
                request.getStatus(),
                request.getMode(),
                request.getStartedAt(),
                request.getEndedAt(),
                request.getDuration()
        );
        return ResponseEntity.ok(Map.of("id", recordId));
    }

    @Data
    public static class CheckPermissionRequest {
        private Long callerId;
        private Long calleeId;
    }

    @Data
    public static class SaveCallRecordRequest {
        private String callId;
        private Long callerId;
        private Long calleeId;
        private String mediaType;
        private String status;
        private String mode;
        private LocalDateTime startedAt;
        private LocalDateTime endedAt;
        private Integer duration;
    }
}
