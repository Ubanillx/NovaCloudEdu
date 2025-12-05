package com.novacloudedu.backend.interfaces.rest.social.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * 处理加入申请请求
 */
@Data
public class HandleJoinRequestDTO {

    @NotNull(message = "请指定是否通过")
    private Boolean approve;
}
