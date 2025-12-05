package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.InviteMode;
import com.novacloudedu.backend.domain.social.valueobject.JoinMode;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 群聊实体
 */
@Getter
public class ChatGroup {

    private GroupId id;
    private String groupName;
    private String avatar;
    private String description;
    private UserId ownerId;
    private Long classId;
    private int maxMembers;
    private int memberCount;
    private InviteMode inviteMode;
    private JoinMode joinMode;
    private boolean isMute;
    private String announcement;
    private LocalDateTime announcementTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private boolean isDelete;

    private ChatGroup() {}

    /**
     * 创建群聊
     */
    public static ChatGroup create(String groupName, UserId ownerId) {
        ChatGroup group = new ChatGroup();
        group.groupName = groupName;
        group.ownerId = ownerId;
        group.maxMembers = 200;
        group.memberCount = 1;
        group.inviteMode = InviteMode.ALL;
        group.joinMode = JoinMode.FREE;
        group.isMute = false;
        group.isDelete = false;
        group.createTime = LocalDateTime.now();
        group.updateTime = LocalDateTime.now();
        return group;
    }

    /**
     * 重建群聊（从数据库恢复）
     */
    public static ChatGroup reconstruct(GroupId id, String groupName, String avatar, String description,
                                        UserId ownerId, Long classId, int maxMembers, int memberCount,
                                        InviteMode inviteMode, JoinMode joinMode, boolean isMute,
                                        String announcement, LocalDateTime announcementTime,
                                        LocalDateTime createTime, LocalDateTime updateTime, boolean isDelete) {
        ChatGroup group = new ChatGroup();
        group.id = id;
        group.groupName = groupName;
        group.avatar = avatar;
        group.description = description;
        group.ownerId = ownerId;
        group.classId = classId;
        group.maxMembers = maxMembers;
        group.memberCount = memberCount;
        group.inviteMode = inviteMode;
        group.joinMode = joinMode;
        group.isMute = isMute;
        group.announcement = announcement;
        group.announcementTime = announcementTime;
        group.createTime = createTime;
        group.updateTime = updateTime;
        group.isDelete = isDelete;
        return group;
    }

    /**
     * 分配ID
     */
    public void assignId(GroupId id) {
        this.id = id;
    }

    /**
     * 更新群信息
     */
    public void updateInfo(String groupName, String avatar, String description) {
        if (groupName != null && !groupName.isBlank()) {
            this.groupName = groupName;
        }
        this.avatar = avatar;
        this.description = description;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 设置加入模式
     */
    public void setJoinMode(JoinMode joinMode) {
        this.joinMode = joinMode;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 设置邀请模式
     */
    public void setInviteMode(InviteMode inviteMode) {
        this.inviteMode = inviteMode;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 设置全员禁言
     */
    public void setMute(boolean mute) {
        this.isMute = mute;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 发布公告
     */
    public void publishAnnouncement(String announcement) {
        this.announcement = announcement;
        this.announcementTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 增加成员数
     */
    public void incrementMemberCount() {
        this.memberCount++;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 减少成员数
     */
    public void decrementMemberCount() {
        if (this.memberCount > 0) {
            this.memberCount--;
        }
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 转让群主
     */
    public void transferOwnership(UserId newOwnerId) {
        this.ownerId = newOwnerId;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 解散群
     */
    public void dissolve() {
        this.isDelete = true;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 检查是否已满
     */
    public boolean isFull() {
        return memberCount >= maxMembers;
    }

    /**
     * 检查是否是群主
     */
    public boolean isOwner(UserId userId) {
        return this.ownerId.equals(userId);
    }
}
