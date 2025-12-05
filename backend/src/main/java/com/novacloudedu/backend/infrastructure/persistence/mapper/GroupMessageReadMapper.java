package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.GroupMessageReadPO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 群消息已读记录 Mapper
 */
@Mapper
public interface GroupMessageReadMapper extends BaseMapper<GroupMessageReadPO> {

    /**
     * 统计用户在群中的未读消息数
     */
    @Select("SELECT COUNT(*) FROM group_message gm " +
            "WHERE gm.group_id = #{groupId} AND gm.is_delete = 0 " +
            "AND NOT EXISTS (SELECT 1 FROM group_message_read gmr WHERE gmr.message_id = gm.id AND gmr.user_id = #{userId})")
    int countUnreadMessages(@Param("groupId") Long groupId, @Param("userId") Long userId);

    /**
     * 批量插入已读记录（标记已读）
     */
    @Insert("INSERT INTO group_message_read (message_id, user_id, read_time) " +
            "SELECT gm.id, #{userId}, CURRENT_TIMESTAMP FROM group_message gm " +
            "WHERE gm.group_id = #{groupId} AND gm.id <= #{upToMessageId} AND gm.is_delete = 0 " +
            "AND NOT EXISTS (SELECT 1 FROM group_message_read gmr WHERE gmr.message_id = gm.id AND gmr.user_id = #{userId})")
    int markAllAsRead(@Param("groupId") Long groupId, @Param("userId") Long userId, @Param("upToMessageId") Long upToMessageId);
}
