package com.novacloudedu.backend.interfaces.rest.social.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 创建群请求
 */
@Data
public class CreateGroupRequest {

    @NotBlank(message = "群名称不能为空")
    @Size(max = 128, message = "群名称最长128字符")
    private String groupName;

    @Size(max = 512, message = "群描述最长512字符")
    private String description;

    @Size(max = 1024, message = "头像URL最长1024字符")
    private String avatar;

    /**
     * 加入方式：0-自由加入，1-需审批，2-禁止加入
     */
    private Integer joinMode;

    /**
     * 邀请权限：0-所有成员可邀请，1-仅管理员可邀请
     */
    private Integer inviteMode;

    @Size(max = 512, message = "群公告最长512字符")
    private String announcement;
}
