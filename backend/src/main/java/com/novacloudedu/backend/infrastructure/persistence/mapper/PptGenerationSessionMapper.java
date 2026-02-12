package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PptGenerationSessionPO;
import org.apache.ibatis.annotations.Mapper;

/**
 * PPT生成会话Mapper
 */
@Mapper
public interface PptGenerationSessionMapper extends BaseMapper<PptGenerationSessionPO> {
}
