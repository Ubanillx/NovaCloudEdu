package com.novacloudedu.backend.domain.book.repository;

import com.novacloudedu.backend.domain.book.entity.AiConversation;
import com.novacloudedu.backend.domain.book.valueobject.AiConversationId;
import com.novacloudedu.backend.domain.book.valueobject.BookId;
import com.novacloudedu.backend.domain.book.valueobject.ConversationType;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

/**
 * AI对话仓储接口
 */
public interface AiConversationRepository {

    /**
     * 保存对话
     */
    AiConversation save(AiConversation conversation);

    /**
     * 根据ID查找对话
     */
    Optional<AiConversation> findById(AiConversationId id);

    /**
     * 查找用户的对话列表
     */
    List<AiConversation> findByUserId(UserId userId, int page, int size);

    /**
     * 查找用户在某本书的对话列表
     */
    List<AiConversation> findByUserIdAndBookId(UserId userId, BookId bookId, int page, int size);

    /**
     * 查找特定类型的对话
     */
    List<AiConversation> findByUserIdAndType(UserId userId, ConversationType type, int page, int size);

    /**
     * 删除对话
     */
    void delete(AiConversationId id);
}
