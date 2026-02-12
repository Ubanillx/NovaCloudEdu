package com.novacloudedu.backend.infrastructure.persistence.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.novacloudedu.backend.infrastructure.persistence.po.PptTemplatePO;
import org.apache.ibatis.annotations.Mapper;

/**
 * PPT模板Mapper
 */
@Mapper
public interface PptTemplateMapper extends BaseMapper<PptTemplatePO> {
}
