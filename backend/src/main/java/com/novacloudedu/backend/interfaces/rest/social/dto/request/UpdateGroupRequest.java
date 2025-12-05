package com.novacloudedu.backend.interfaces.rest.social.dto.request;

import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 更新群信息请求
 */
@Data
public class UpdateGroupRequest {

    @Size(max = 128, message = "群名称最长128字符")
    private String groupName;

    @Size(max = 512, message = "群描述最长512字符")
    private String description;

    @Size(max = 1024, message = "头像URL最长1024字符")
    private String avatar;
}
