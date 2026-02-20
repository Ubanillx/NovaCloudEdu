package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.LiveRoomPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 直播间 Mapper
 */
@Mapper
public interface LiveRoomMapper extends BaseMapper<LiveRoomPO> {
}
