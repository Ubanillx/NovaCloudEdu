package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.AnnouncementReadPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 公告阅读记录Mapper
 */
@Mapper
public interface AnnouncementReadMapper extends BaseMapper<AnnouncementReadPO> {
}
