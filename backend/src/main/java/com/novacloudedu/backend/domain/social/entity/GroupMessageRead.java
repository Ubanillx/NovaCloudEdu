package com.novacloudedu.backend.domain.social.entity;

import com.novacloudedu.backend.domain.social.valueobject.GroupMessageId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * 群消息已读记录实体
 */
@Getter
public class GroupMessageRead {

    private Long id;
    private GroupMessageId messageId;
    private UserId userId;
    private LocalDateTime readTime;

    private GroupMessageRead() {}

    /**
     * 创建已读记录
     */
    public static GroupMessageRead create(GroupMessageId messageId, UserId userId) {
        GroupMessageRead read = new GroupMessageRead();
        read.messageId = messageId;
        read.userId = userId;
        read.readTime = LocalDateTime.now();
        return read;
    }

    /**
     * 重建（从数据库恢复）
     */
    public static GroupMessageRead reconstruct(Long id, GroupMessageId messageId, 
                                               UserId userId, LocalDateTime readTime) {
        GroupMessageRead read = new GroupMessageRead();
        read.id = id;
        read.messageId = messageId;
        read.userId = userId;
        read.readTime = readTime;
        return read;
    }

    /**
     * 分配ID
     */
    public void assignId(Long id) {
        this.id = id;
    }
}
