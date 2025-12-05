package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.GroupMessage;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.social.valueobject.GroupMessageId;

import java.util.List;
import java.util.Optional;

/**
 * 群消息仓储接口
 */
public interface GroupMessageRepository {

    /**
     * 保存消息
     */
    GroupMessage save(GroupMessage message);

    /**
     * 根据ID查找
     */
    Optional<GroupMessage> findById(GroupMessageId id);

    /**
     * 分页获取群消息（按时间倒序）
     */
    MessagePage findByGroupId(GroupId groupId, int pageNum, int pageSize);

    /**
     * 游标分页获取群消息（获取某消息之前的消息）
     */
    List<GroupMessage> findByGroupIdBeforeMessage(GroupId groupId, GroupMessageId beforeId, int limit);

    /**
     * 获取群最新消息
     */
    List<GroupMessage> findLatestByGroupId(GroupId groupId, int limit);

    /**
     * 删除消息（逻辑删除）
     */
    void delete(GroupMessageId id);

    /**
     * 消息分页结果
     */
    record MessagePage(List<GroupMessage> messages, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
