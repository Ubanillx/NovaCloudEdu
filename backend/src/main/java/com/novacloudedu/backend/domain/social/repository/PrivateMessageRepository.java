package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.PrivateMessage;
import com.novacloudedu.backend.domain.social.valueobject.MessageId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 私聊消息仓储接口
 */
public interface PrivateMessageRepository {

    /**
     * 保存消息
     */
    PrivateMessage save(PrivateMessage message);

    /**
     * 根据ID查找消息
     */
    Optional<PrivateMessage> findById(MessageId id);

    /**
     * 查询两用户之间的消息历史（分页）
     */
    MessagePage findBetweenUsers(UserId userId1, UserId userId2, int page, int size);

    /**
     * 查询两用户之间的消息历史（基于消息ID游标）
     */
    List<PrivateMessage> findBetweenUsersBefore(UserId userId1, UserId userId2, MessageId beforeId, int limit);

    /**
     * 标记消息为已读
     */
    void markAsRead(List<MessageId> messageIds);

    /**
     * 标记两用户之间所有消息为已读
     */
    void markAllAsReadBetweenUsers(UserId senderId, UserId receiverId);

    /**
     * 获取未读消息数量
     */
    int countUnreadMessages(UserId receiverId, UserId senderId);

    /**
     * 消息分页结果
     */
    record MessagePage(List<PrivateMessage> messages, long total, int page, int size) {
        public int totalPages() {
            return (int) Math.ceil((double) total / size);
        }

        public boolean hasMore() {
            return page < totalPages();
        }
    }
}
