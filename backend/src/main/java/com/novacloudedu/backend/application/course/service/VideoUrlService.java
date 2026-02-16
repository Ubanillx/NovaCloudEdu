package com.novacloudedu.backend.application.course.service;

import com.novacloudedu.backend.domain.file.service.OssService;
import com.novacloudedu.backend.interfaces.rest.course.dto.SectionResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 视频/资源 URL 安全转换服务
 * 负责将原始 OSS URL 转为预签名 URL，以及根据权限过滤小节的敏感 URL
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class VideoUrlService {

    private final OssService ossService;

    private static final long PRESIGNED_EXPIRE_SECONDS = 3600; // 1小时

    /**
     * 将原始 OSS URL 转为预签名 URL（1小时有效）
     * 如果 rawUrl 为空则返回 null
     */
    public String toPresignedUrl(String rawUrl) {
        if (rawUrl == null || rawUrl.isBlank()) {
            return null;
        }
        try {
            return ossService.generatePresignedUrl(rawUrl, PRESIGNED_EXPIRE_SECONDS);
        } catch (Exception e) {
            log.warn("生成预签名URL失败, rawUrl={}, error={}", rawUrl, e.getMessage());
            return null;
        }
    }

    /**
     * 对 SectionResponse 应用预签名 URL 转换
     */
    public SectionResponse applyPresignedUrls(SectionResponse response) {
        if (response == null) {
            return null;
        }
        response.setVideoUrl(toPresignedUrl(response.getVideoUrl()));
        response.setResourceUrl(toPresignedUrl(response.getResourceUrl()));
        return response;
    }

    /**
     * 根据访问权限过滤小节 URL
     * 无权限时将 videoUrl 和 resourceUrl 设为 null
     */
    public SectionResponse filterByAccess(SectionResponse response, boolean hasAccess) {
        if (response == null) {
            return null;
        }
        if (!hasAccess && !Boolean.TRUE.equals(response.getIsFree())) {
            response.setVideoUrl(null);
            response.setResourceUrl(null);
            response.setHlsUrl(null);
        }
        return response;
    }
}
