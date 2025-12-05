package com.novacloudedu.backend.interfaces.rest.social.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;

/**
 * 处理好友申请请求
 */
@Schema(description = "处理好友申请请求")
public record HandleFriendRequestDTO(
        @Schema(description = "好友申请ID", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotNull(message = "申请ID不能为空")
        Long requestId,

        @Schema(description = "是否接受：true-接受，false-拒绝", requiredMode = Schema.RequiredMode.REQUIRED)
        @NotNull(message = "请指定是否接受")
        Boolean accept
) {
}
