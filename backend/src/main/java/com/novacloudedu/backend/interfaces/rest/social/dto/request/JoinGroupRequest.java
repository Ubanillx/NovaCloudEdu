package com.novacloudedu.backend.interfaces.rest.social.dto.request;

import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 申请加入群请求
 */
@Data
public class JoinGroupRequest {

    @Size(max = 512, message = "申请消息最长512字符")
    private String message;
}
