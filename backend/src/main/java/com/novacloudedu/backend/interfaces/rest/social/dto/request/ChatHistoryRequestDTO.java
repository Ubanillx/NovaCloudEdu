package com.novacloudedu.backend.interfaces.rest.social.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 聊天历史请求 DTO
 */
@Data
public class ChatHistoryRequestDTO {

    /**
     * 聊天对方用户ID
     */
    @NotNull(message = "对方用户ID不能为空")
    private Long partnerId;

    /**
     * 页码，从1开始
     */
    @Min(value = 1, message = "页码最小为1")
    private Integer page = 1;

    /**
     * 每页数量
     */
    @Min(value = 1, message = "每页数量最小为1")
    @Max(value = 100, message = "每页数量最大为100")
    private Integer size = 20;

    /**
     * 游标分页：获取此消息ID之前的消息
     */
    private Long beforeMessageId;
}
