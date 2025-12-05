package com.novacloudedu.backend.interfaces.rest.announcement.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

/**
 * 更新公告请求
 */
public record UpdateAnnouncementRequest(
        @NotNull(message = "公告ID不能为空")
        Long id,
        
        @NotBlank(message = "公告标题不能为空")
        @Size(max = 256, message = "公告标题不能超过256个字符")
        String title,
        
        @NotBlank(message = "公告内容不能为空")
        String content,
        
        Integer sort,
        
        Integer status,
        
        LocalDateTime startTime,
        
        LocalDateTime endTime,
        
        String coverImage
) {
}
