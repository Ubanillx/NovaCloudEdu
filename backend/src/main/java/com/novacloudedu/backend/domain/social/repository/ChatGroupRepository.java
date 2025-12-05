package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.ChatGroup;
import com.novacloudedu.backend.domain.social.valueobject.GroupId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 群聊仓储接口
 */
public interface ChatGroupRepository {

    /**
     * 保存群聊
     */
    ChatGroup save(ChatGroup group);

    /**
     * 更新群聊
     */
    void update(ChatGroup group);

    /**
     * 根据ID查找群聊
     */
    Optional<ChatGroup> findById(GroupId id);

    /**
     * 根据群主ID查找群列表
     */
    List<ChatGroup> findByOwnerId(UserId ownerId);

    /**
     * 分页获取群列表
     */
    GroupPage findAll(int pageNum, int pageSize);

    /**
     * 根据名称模糊搜索群
     */
    GroupPage searchByName(String keyword, int pageNum, int pageSize);

    /**
     * 删除群聊（逻辑删除）
     */
    void delete(GroupId id);

    /**
     * 群分页结果
     */
    record GroupPage(List<ChatGroup> groups, long total, int pageNum, int pageSize) {
        public int getTotalPages() {
            return (int) Math.ceil((double) total / pageSize);
        }
    }
}
