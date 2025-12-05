package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群信息响应
 */
@Data
public class GroupResponse {

    private Long id;
    private String groupName;
    private String avatar;
    private String description;
    private Long ownerId;
    private Long classId;
    private int maxMembers;
    private int memberCount;
    private int inviteMode;
    private int joinMode;
    private boolean isMute;
    private String announcement;
    private LocalDateTime announcementTime;
    private LocalDateTime createTime;

    public static GroupResponse from(ChatGroup group) {
        GroupResponse response = new GroupResponse();
        response.setId(group.getId().value());
        response.setGroupName(group.getGroupName());
        response.setAvatar(group.getAvatar());
        response.setDescription(group.getDescription());
        response.setOwnerId(group.getOwnerId().value());
        response.setClassId(group.getClassId());
        response.setMaxMembers(group.getMaxMembers());
        response.setMemberCount(group.getMemberCount());
        response.setInviteMode(group.getInviteMode().getCode());
        response.setJoinMode(group.getJoinMode().getCode());
        response.setMute(group.isMute());
        response.setAnnouncement(group.getAnnouncement());
        response.setAnnouncementTime(group.getAnnouncementTime());
        response.setCreateTime(group.getCreateTime());
        return response;
    }
}
