package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.novacloudedu.backend.domain.social.entity.GroupJoinRequest;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群申请响应
 */
@Data
public class JoinRequestResponse {

    private Long id;
    private Long groupId;
    private Long userId;
    private String message;
    private int status;
    private Long handlerId;
    private LocalDateTime handleTime;
    private LocalDateTime createTime;

    // 可扩展：用户信息
    private String userName;
    private String userAvatar;

    public static JoinRequestResponse from(GroupJoinRequest request) {
        JoinRequestResponse response = new JoinRequestResponse();
        response.setId(request.getId());
        response.setGroupId(request.getGroupId().value());
        response.setUserId(request.getUserId().value());
        response.setMessage(request.getMessage());
        response.setStatus(request.getStatus().getCode());
        if (request.getHandlerId() != null) {
            response.setHandlerId(request.getHandlerId().value());
        }
        response.setHandleTime(request.getHandleTime());
        response.setCreateTime(request.getCreateTime());
        return response;
    }
}
