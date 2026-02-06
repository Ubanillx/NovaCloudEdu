package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.ScraperSourceConfigPO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ScraperSourceConfigMapper extends BaseMapper<ScraperSourceConfigPO> {
}
