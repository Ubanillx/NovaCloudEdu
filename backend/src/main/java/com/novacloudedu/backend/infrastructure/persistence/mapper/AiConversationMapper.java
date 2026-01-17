package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AiConversationPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * AI对话 Mapper
 */
@Mapper
public interface AiConversationMapper extends BaseMapper<AiConversationPO> {

    /**
     * 查找用户的对话列表
     */
    List<AiConversationPO> findByUserId(@Param("userId") Long userId, 
                                         @Param("offset") int offset, 
                                         @Param("limit") int limit);

    /**
     * 查找用户在某本书的对话列表
     */
    List<AiConversationPO> findByUserIdAndBookId(@Param("userId") Long userId, 
                                                  @Param("bookId") Long bookId,
                                                  @Param("offset") int offset, 
                                                  @Param("limit") int limit);

    /**
     * 查找特定类型的对话
     */
    List<AiConversationPO> findByUserIdAndType(@Param("userId") Long userId, 
                                                @Param("conversationType") String conversationType,
                                                @Param("offset") int offset, 
                                                @Param("limit") int limit);
}
