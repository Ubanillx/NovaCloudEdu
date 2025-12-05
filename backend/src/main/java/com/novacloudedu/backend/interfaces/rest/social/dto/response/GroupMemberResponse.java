package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.novacloudedu.backend.domain.social.entity.ChatGroupMember;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群成员响应
 */
@Data
public class GroupMemberResponse {

    private Long id;
    private Long groupId;
    private int memberType;
    private Long userId;
    private Long aiRoleId;
    private int role;
    private String nickname;
    private boolean isMute;
    private LocalDateTime muteUntil;
    private LocalDateTime joinTime;

    // 可扩展：用户信息
    private String userName;
    private String userAvatar;

    public static GroupMemberResponse from(ChatGroupMember member) {
        GroupMemberResponse response = new GroupMemberResponse();
        response.setId(member.getId());
        response.setGroupId(member.getGroupId().value());
        response.setMemberType(member.getMemberType().getCode());
        if (member.getUserId() != null) {
            response.setUserId(member.getUserId().value());
        }
        response.setAiRoleId(member.getAiRoleId());
        response.setRole(member.getRole().getCode());
        response.setNickname(member.getNickname());
        response.setMute(member.isMuted());
        response.setMuteUntil(member.getMuteUntil());
        response.setJoinTime(member.getJoinTime());
        return response;
    }
}
