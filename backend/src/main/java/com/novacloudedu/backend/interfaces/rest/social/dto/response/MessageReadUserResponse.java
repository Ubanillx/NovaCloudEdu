package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 消息已读用户响应 DTO
 */
@Data
public class MessageReadUserResponse {

    private Long userId;
    private String userName;
    private String userAvatar;
    private LocalDateTime readTime;
}
