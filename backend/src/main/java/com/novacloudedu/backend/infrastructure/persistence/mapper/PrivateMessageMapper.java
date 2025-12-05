package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PrivateMessagePO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 私聊消息数据库操作Mapper
 */
@Mapper
public interface PrivateMessageMapper extends BaseMapper<PrivateMessagePO> {

    /**
     * 批量标记消息为已读
     */
    @Update("<script>" +
            "UPDATE private_message SET is_read = 1 WHERE id IN " +
            "<foreach collection='ids' item='id' open='(' separator=',' close=')'>" +
            "#{id}" +
            "</foreach>" +
            "</script>")
    void markAsRead(@Param("ids") List<Long> ids);

    /**
     * 标记两用户之间的所有消息为已读
     */
    @Update("UPDATE private_message SET is_read = 1 " +
            "WHERE sender_id = #{senderId} AND receiver_id = #{receiverId} AND is_read = 0")
    void markAllAsReadBetweenUsers(@Param("senderId") Long senderId, @Param("receiverId") Long receiverId);
}
