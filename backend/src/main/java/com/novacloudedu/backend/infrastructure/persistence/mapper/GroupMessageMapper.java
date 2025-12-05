package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.GroupMessagePO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 群消息 Mapper
 */
@Mapper
public interface GroupMessageMapper extends BaseMapper<GroupMessagePO> {

    /**
     * 获取某消息之前的消息列表（游标分页）
     */
    @Select("SELECT * FROM group_message WHERE group_id = #{groupId} AND id < #{beforeId} AND is_delete = 0 ORDER BY id DESC LIMIT #{limit}")
    List<GroupMessagePO> findBeforeMessage(@Param("groupId") Long groupId, 
                                           @Param("beforeId") Long beforeId, 
                                           @Param("limit") int limit);
}
