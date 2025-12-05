package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.GroupRole;
import com.novacloudedu.backend.domain.social.valueobject.MemberType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 群成员实体
 */
@Getter
public class ChatGroupMember {

    private Long id;
    private GroupId groupId;
    private MemberType memberType;
    private UserId userId;
    private Long aiRoleId;
    private GroupRole role;
    private String nickname;
    private boolean isMute;
    private LocalDateTime muteUntil;
    private LocalDateTime joinTime;
    private LocalDateTime updateTime;
    private boolean isDelete;

    private ChatGroupMember() {}

    /**
     * 创建普通用户成员
     */
    public static ChatGroupMember createUserMember(GroupId groupId, UserId userId, GroupRole role) {
        ChatGroupMember member = new ChatGroupMember();
        member.groupId = groupId;
        member.memberType = MemberType.USER;
        member.userId = userId;
        member.role = role;
        member.isMute = false;
        member.isDelete = false;
        member.joinTime = LocalDateTime.now();
        member.updateTime = LocalDateTime.now();
        return member;
    }

    /**
     * 创建AI角色成员
     */
    public static ChatGroupMember createAiMember(GroupId groupId, Long aiRoleId) {
        ChatGroupMember member = new ChatGroupMember();
        member.groupId = groupId;
        member.memberType = MemberType.AI_ROLE;
        member.aiRoleId = aiRoleId;
        member.role = GroupRole.MEMBER;
        member.isMute = false;
        member.isDelete = false;
        member.joinTime = LocalDateTime.now();
        member.updateTime = LocalDateTime.now();
        return member;
    }

    /**
     * 重建成员（从数据库恢复）
     */
    public static ChatGroupMember reconstruct(Long id, GroupId groupId, MemberType memberType,
                                              UserId userId, Long aiRoleId, GroupRole role,
                                              String nickname, boolean isMute, LocalDateTime muteUntil,
                                              LocalDateTime joinTime, LocalDateTime updateTime, boolean isDelete) {
        ChatGroupMember member = new ChatGroupMember();
        member.id = id;
        member.groupId = groupId;
        member.memberType = memberType;
        member.userId = userId;
        member.aiRoleId = aiRoleId;
        member.role = role;
        member.nickname = nickname;
        member.isMute = isMute;
        member.muteUntil = muteUntil;
        member.joinTime = joinTime;
        member.updateTime = updateTime;
        member.isDelete = isDelete;
        return member;
    }

    /**
     * 分配ID
     */
    public void assignId(Long id) {
        this.id = id;
    }

    /**
     * 设置群昵称
     */
    public void setNickname(String nickname) {
        this.nickname = nickname;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 设置角色
     */
    public void setRole(GroupRole role) {
        this.role = role;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 禁言
     */
    public void mute(LocalDateTime until) {
        this.isMute = true;
        this.muteUntil = until;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 解除禁言
     */
    public void unmute() {
        this.isMute = false;
        this.muteUntil = null;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 退出群
     */
    public void leave() {
        this.isDelete = true;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 是否是管理员或群主
     */
    public boolean isAdminOrOwner() {
        return role == GroupRole.ADMIN || role == GroupRole.OWNER;
    }

    /**
     * 是否是群主
     */
    public boolean isOwner() {
        return role == GroupRole.OWNER;
    }

    /**
     * 检查是否被禁言中
     */
    public boolean isMuted() {
        if (!isMute) {
            return false;
        }
        if (muteUntil == null) {
            return true;
        }
        return LocalDateTime.now().isBefore(muteUntil);
    }
}
