package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.LiveRoomMessagePO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 直播间消息 Mapper
 */
@Mapper
public interface LiveRoomMessageMapper extends BaseMapper<LiveRoomMessagePO> {
}
