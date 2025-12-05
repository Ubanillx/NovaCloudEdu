package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.GroupMessageRead;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.GroupMessageId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 群消息已读记录仓储接口
 */
public interface GroupMessageReadRepository {

    /**
     * 保存已读记录
     */
    GroupMessageRead save(GroupMessageRead read);

    /**
     * 批量保存已读记录
     */
    void saveAll(List<GroupMessageRead> reads);

    /**
     * 查找用户对某消息的已读记录
     */
    Optional<GroupMessageRead> findByMessageIdAndUserId(GroupMessageId messageId, UserId userId);

    /**
     * 检查用户是否已读某消息
     */
    boolean hasRead(GroupMessageId messageId, UserId userId);

    /**
     * 获取消息的已读用户列表
     */
    List<GroupMessageRead> findByMessageId(GroupMessageId messageId);

    /**
     * 统计消息已读人数
     */
    int countByMessageId(GroupMessageId messageId);

    /**
     * 获取用户在群中的未读消息数量
     */
    int countUnreadMessages(GroupId groupId, UserId userId);

    /**
     * 标记群中所有消息为已读（到某个消息ID为止）
     */
    void markAllAsRead(GroupId groupId, UserId userId, GroupMessageId upToMessageId);
}
