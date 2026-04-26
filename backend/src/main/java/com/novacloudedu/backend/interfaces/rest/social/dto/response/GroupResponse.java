package com.novacloudedu.backend.interfaces.rest.social.dto.response;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 群信息响应
 */
@Data
public class GroupResponse {

    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    private Long id;
    private String groupNumber; // 群号
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
    private Long lastMessageSenderId;
    private String lastMessageSenderName;
    private String lastMessage;
    private String lastMessageType;
    private LocalDateTime lastMessageTime;
    private int unreadCount;
    private LocalDateTime createTime;

    public static GroupResponse from(ChatGroup group) {
        GroupResponse response = new GroupResponse();
        response.setId(group.getId().value());
        response.setGroupNumber(group.getGroupNumber());
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
        response.setAnnouncement(normalizeAnnouncement(group.getAnnouncement()));
        response.setAnnouncementTime(group.getAnnouncementTime());
        response.setCreateTime(group.getCreateTime());
        return response;
    }

    private static String normalizeAnnouncement(String announcement) {
        if (announcement == null) {
            return null;
        }
        String trimmed = announcement.trim();
        if (trimmed.length() >= 2 && trimmed.startsWith("\"") && trimmed.endsWith("\"")) {
            try {
                return OBJECT_MAPPER.readValue(trimmed, String.class);
            } catch (JsonProcessingException ignored) {
                return trimmed.substring(1, trimmed.length() - 1);
            }
        }
        return announcement;
    }
}
