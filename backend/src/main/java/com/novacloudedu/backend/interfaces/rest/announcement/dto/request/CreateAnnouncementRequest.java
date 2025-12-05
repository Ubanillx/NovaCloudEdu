package com.novacloudedu.backend.interfaces.rest.announcement.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

/**
 * 创建公告请求
 */
public record CreateAnnouncementRequest(
        @NotBlank(message = "公告标题不能为空")
        @Size(max = 256, message = "公告标题不能超过256个字符")
        String title,
        
        @NotBlank(message = "公告内容不能为空")
        String content,
        
        Integer sort,
        
        LocalDateTime startTime,
        
        LocalDateTime endTime,
        
        String coverImage
) {
}
