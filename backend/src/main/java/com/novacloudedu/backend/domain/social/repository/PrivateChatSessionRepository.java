package com.novacloudedu.backend.domain.social.repository;

import com.novacloudedu.backend.domain.social.entity.PrivateChatSession;
import com.novacloudedu.backend.domain.social.valueobject.SessionId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * 私聊会话仓储接口
 */
public interface PrivateChatSessionRepository {

    /**
     * 保存会话
     */
    PrivateChatSession save(PrivateChatSession session);

    /**
     * 根据ID查找会话
     */
    Optional<PrivateChatSession> findById(SessionId id);

    /**
     * 根据两个用户查找会话
     */
    Optional<PrivateChatSession> findByUsers(UserId userId1, UserId userId2);

    /**
     * 获取或创建会话
     */
    PrivateChatSession getOrCreate(UserId userId1, UserId userId2);

    /**
     * 查询用户的所有会话列表（按最后消息时间倒序）
     */
    List<PrivateChatSession> findByUserId(UserId userId);

    /**
     * 更新会话
     */
    void update(PrivateChatSession session);

    /**
     * 删除会话
     */
    void delete(SessionId id);
}
