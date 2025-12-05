package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ChatGroupMemberPO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

/**
 * 群成员 Mapper
 */
@Mapper
public interface ChatGroupMemberMapper extends BaseMapper<ChatGroupMemberPO> {

    /**
     * 批量逻辑删除群成员
     */
    @Update("UPDATE chat_group_member SET is_delete = 1, update_time = CURRENT_TIMESTAMP WHERE group_id = #{groupId} AND is_delete = 0")
    int deleteByGroupId(@Param("groupId") Long groupId);
}
