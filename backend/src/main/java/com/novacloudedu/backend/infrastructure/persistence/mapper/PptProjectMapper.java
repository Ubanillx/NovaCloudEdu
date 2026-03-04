package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PptProjectPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * PPT项目 Mapper
 */
@Mapper
public interface PptProjectMapper extends BaseMapper<PptProjectPO> {
}
